﻿codeunit 312 "Cust-Check Cr. Limit"
{
    Permissions = TableData "My Notifications" = rimd;

    trigger OnRun()
    begin
    end;

    var
        InstructionMgt: Codeunit "Instruction Mgt.";
        NotificationLifecycleMgt: Codeunit "Notification Lifecycle Mgt.";
        CustCheckCreditLimit: Page "Check Credit Limit";
        InstructionTypeTxt: Label 'Check Cr. Limit';
        GetDetailsTxt: Label 'Show details';
        CreditLimitNotificationMsg: Label 'The customer''s credit limit has been exceeded.';
        CreditLimitNotificationDescriptionTxt: Label 'Show warning when a sales document will exceed the customer''s credit limit.';
        OverdueBalanceNotificationMsg: Label 'This customer has an overdue balance.';
        OverdueBalanceNotificationDescriptionTxt: Label 'Show warning when a sales document is for a customer with an overdue balance.';

    procedure GenJnlLineCheck(GenJnlLine: Record "Gen. Journal Line")
    var
        SalesHeader: Record "Sales Header";
        AdditionalContextId: Guid;
    begin
        if not GuiAllowed then
            exit;

        if not SalesHeader.Get(GenJnlLine."Document Type", GenJnlLine."Document No.") then
            SalesHeader.Init();
        OnNewCheckRemoveCustomerNotifications(SalesHeader.RecordId, true);

        if CustCheckCreditLimit.GenJnlLineShowWarningAndGetCause(GenJnlLine, AdditionalContextId) then
            CreateAndSendNotification(SalesHeader.RecordId, AdditionalContextId, '');
    end;

    procedure SalesHeaderCheck(var SalesHeader: Record "Sales Header") CreditLimitExceeded: Boolean
    var
        AdditionalContextId: Guid;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeSalesHeaderCheck(SalesHeader, IsHandled);
        if IsHandled then
            exit;

        if GuiAllowed then begin
            OnNewCheckRemoveCustomerNotifications(SalesHeader.RecordId, true);

            if not CustCheckCreditLimit.SalesHeaderShowWarningAndGetCause(SalesHeader, AdditionalContextId) then
                SalesHeader.CustomerCreditLimitNotExceeded()
            else begin
                CreditLimitExceeded := true;

                if InstructionMgt.IsEnabled(GetInstructionType(Format(SalesHeader."Document Type"), SalesHeader."No.")) then
                    CreateAndSendNotification(SalesHeader.RecordId, AdditionalContextId, '');

                SalesHeader.CustomerCreditLimitExceeded(CustCheckCreditLimit.GetNotificationId());
            end;
        end;
    end;

    procedure SalesLineCheck(SalesLine: Record "Sales Line") CreditLimitExceeded: Boolean
    var
        SalesHeader: Record "Sales Header";
        AdditionalContextId: Guid;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeSalesLineCheck(SalesLine, IsHandled);
        if IsHandled then
            exit;

        if not SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then
            SalesHeader.Init();

        if GuiAllowed then
            OnNewCheckRemoveCustomerNotifications(SalesHeader.RecordId, false);

        if not CustCheckCreditLimit.SalesLineShowWarningAndGetCause(SalesLine, AdditionalContextId) then
            SalesHeader.CustomerCreditLimitNotExceeded()
        else begin
            CreditLimitExceeded := true;

            if GuiAllowed then
                if InstructionMgt.IsEnabled(GetInstructionType(Format(SalesLine."Document Type"), SalesLine."Document No.")) then
                    CreateAndSendNotification(SalesHeader.RecordId, AdditionalContextId, '');

            SalesHeader.CustomerCreditLimitExceeded(CustCheckCreditLimit.GetNotificationId());
        end;
    end;

    procedure ServiceHeaderCheck(ServiceHeader: Record "Service Header")
    var
        AdditionalContextId: Guid;
    begin
        if not GuiAllowed then
            exit;

        OnNewCheckRemoveCustomerNotifications(ServiceHeader.RecordId, true);

        if CustCheckCreditLimit.ServiceHeaderShowWarningAndGetCause(ServiceHeader, AdditionalContextId) then
            CreateAndSendNotification(ServiceHeader.RecordId, AdditionalContextId, '');
    end;

    procedure ServiceLineCheck(ServiceLine: Record "Service Line")
    var
        ServiceHeader: Record "Service Header";
        AdditionalContextId: Guid;
    begin
        if not GuiAllowed then
            exit;

        if not ServiceHeader.Get(ServiceLine."Document Type", ServiceLine."Document No.") then
            ServiceHeader.Init();
        OnNewCheckRemoveCustomerNotifications(ServiceHeader.RecordId, false);

        if CustCheckCreditLimit.ServiceLineShowWarningAndGetCause(ServiceLine, AdditionalContextId) then
            CreateAndSendNotification(ServiceHeader.RecordId, AdditionalContextId, '');
    end;

    procedure ServiceContractHeaderCheck(ServiceContractHeader: Record "Service Contract Header")
    var
        AdditionalContextId: Guid;
    begin
        if not GuiAllowed then
            exit;

        OnNewCheckRemoveCustomerNotifications(ServiceContractHeader.RecordId, true);

        if CustCheckCreditLimit.ServiceContractHeaderShowWarningAndGetCause(ServiceContractHeader, AdditionalContextId) then
            CreateAndSendNotification(ServiceContractHeader.RecordId, AdditionalContextId, '');
    end;

    procedure GetInstructionType(DocumentType: Code[30]; DocumentNumber: Code[20]): Code[50]
    begin
        exit(CopyStr(StrSubstNo('%1 %2 %3', DocumentType, DocumentNumber, InstructionTypeTxt), 1, 50));
    end;

    procedure BlanketSalesOrderToOrderCheck(SalesOrderHeader: Record "Sales Header")
    var
        AdditionalContextId: Guid;
    begin
        if not GuiAllowed then
            exit;

        OnNewCheckRemoveCustomerNotifications(SalesOrderHeader.RecordId, true);

        if CustCheckCreditLimit.SalesHeaderShowWarningAndGetCause(SalesOrderHeader, AdditionalContextId) then
            CreateAndSendNotification(SalesOrderHeader.RecordId, AdditionalContextId, '');
    end;

    procedure ShowNotificationDetails(CreditLimitNotification: Notification)
    var
        CreditLimitNotificationPage: Page "Credit Limit Notification";
    begin
        CreditLimitNotificationPage.SetHeading(CreditLimitNotification.Message);
        CreditLimitNotificationPage.InitializeFromNotificationVar(CreditLimitNotification);
        CreditLimitNotificationPage.RunModal;
    end;

    local procedure CreateAndSendNotification(RecordId: RecordID; AdditionalContextId: Guid; Heading: Text[250])
    var
        NotificationToSend: Notification;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCreateAndSendNotification(RecordId, AdditionalContextId, Heading, NotificationToSend, IsHandled, CustCheckCreditLimit);
        if IsHandled then
            exit;

        if AdditionalContextId = GetBothNotificationsId then begin
            CreateAndSendNotification(RecordId, GetCreditLimitNotificationId, CustCheckCreditLimit.GetHeading);
            CreateAndSendNotification(RecordId, GetOverdueBalanceNotificationId, CustCheckCreditLimit.GetSecondHeading);
            exit;
        end;

        if Heading = '' then
            Heading := CustCheckCreditLimit.GetHeading;

        case Heading of
            CreditLimitNotificationMsg:
                NotificationToSend.Id(GetCreditLimitNotificationId);
            OverdueBalanceNotificationMsg:
                NotificationToSend.Id(GetOverdueBalanceNotificationId);
            else
                NotificationToSend.Id(CreateGuid);
        end;

        NotificationToSend.Message(Heading);
        NotificationToSend.Scope(NOTIFICATIONSCOPE::LocalScope);
        NotificationToSend.AddAction(GetDetailsTxt, CODEUNIT::"Cust-Check Cr. Limit", 'ShowNotificationDetails');
        CustCheckCreditLimit.PopulateDataOnNotification(NotificationToSend);
        NotificationLifecycleMgt.SendNotificationWithAdditionalContext(NotificationToSend, RecordId, AdditionalContextId);
    end;

    procedure GetCreditLimitNotificationId(): Guid
    begin
        exit('C80FEEDA-802C-4879-B826-34A10FB77087');
    end;

    procedure GetOverdueBalanceNotificationId(): Guid
    begin
        exit('EC8348CB-07C1-499A-9B70-B3B081A33C99');
    end;

    procedure GetBothNotificationsId(): Guid
    begin
        exit('EC8348CB-07C1-499A-9B70-B3B081A33D00');
    end;

    procedure IsCreditLimitNotificationEnabled(Customer: Record Customer): Boolean
    var
        MyNotifications: Record "My Notifications";
    begin
        exit(MyNotifications.IsEnabledForRecord(GetCreditLimitNotificationId, Customer));
    end;

    procedure IsOverdueBalanceNotificationEnabled(Customer: Record Customer): Boolean
    var
        MyNotifications: Record "My Notifications";
    begin
        exit(MyNotifications.IsEnabledForRecord(GetOverdueBalanceNotificationId, Customer));
    end;

    [EventSubscriber(ObjectType::Page, Page::"My Notifications", 'OnInitializingNotificationWithDefaultState', '', false, false)]
    local procedure OnInitializingNotificationWithDefaultState()
    var
        MyNotifications: Record "My Notifications";
    begin
        MyNotifications.InsertDefaultWithTableNum(GetCreditLimitNotificationId,
          CreditLimitNotificationMsg,
          CreditLimitNotificationDescriptionTxt,
          DATABASE::Customer);
        MyNotifications.InsertDefaultWithTableNum(GetOverdueBalanceNotificationId,
          OverdueBalanceNotificationMsg,
          OverdueBalanceNotificationDescriptionTxt,
          DATABASE::Customer);
    end;

    [IntegrationEvent(false, false)]
    procedure OnNewCheckRemoveCustomerNotifications(RecId: RecordID; RecallCreditOverdueNotif: Boolean)
    begin
    end;

    procedure GetCreditLimitNotificationMsg(): Text
    begin
        exit(CreditLimitNotificationMsg);
    end;

    procedure GetOverdueBalanceNotificationMsg(): Text
    begin
        exit(OverdueBalanceNotificationMsg);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSalesHeaderCheck(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeCreateAndSendNotification(RecordId: RecordID; AdditionalContextId: Guid; Heading: Text[250]; NotificationToSend: Notification; var IsHandled: Boolean; var CustCheckCreditLimit: Page "Check Credit Limit");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSalesLineCheck(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
    end;
}

