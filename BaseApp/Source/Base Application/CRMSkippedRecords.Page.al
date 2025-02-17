page 5333 "CRM Skipped Records"
{
    AccessByPermission = TableData "CRM Integration Record" = R;
    ApplicationArea = Suite;
    Caption = 'Coupled Data Synchronization Errors';
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Synchronization,Broken Couplings';
    SourceTable = "CRM Synch. Conflict Buffer";
    SourceTableTemporary = true;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; "Table ID")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the ID of the table that holds the record.';
                }
                field("Table Name"; "Table Name")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the table that holds the record.';
                }
                field(Description; Description)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the description of the table that holds the record.';

                    trigger OnDrillDown()
                    begin
                        CRMSynchHelper.ShowPage("Record ID");
                    end;
                }
                field("Record Exists"; "Record Exists")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies if the coupled record exists in Business Central.';
                }
                field("Int. Description"; "Int. Description")
                {
                    ApplicationArea = Suite;
                    Caption = 'Coupled To';
                    ToolTip = 'Specifies the coupled entity in Dynamics 365 Sales ';

                    trigger OnDrillDown()
                    begin
                        CRMSynchHelper.ShowPage("Int. Record ID");
                    end;
                }
                field("Int. Record Exists"; "Int. Record Exists")
                {
                    ApplicationArea = Suite;
                    Caption = 'Coupled Record Exists';
                    ToolTip = 'Specifies if a coupled entity exists in Dynamics 365 Sales';
                }
                field("Error Message"; "Error Message")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies why the record was could not be synchronized.';
                }
                field("Failed On"; "Failed On")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies when the synchronization failed.';
                }
#if not CLEAN19                
                field("Deleted On"; "Deleted On")
                {
                    Visible = false;
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies when the record was deleted.';
                    ObsoleteState = Pending;
                    ObsoleteTag = '19.0';
                    ObsoleteReason = 'The underlying table field is obsolete and will be removed.';
                }
#endif
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Restore)
            {
                AccessByPermission = TableData "CRM Integration Record" = IM;
                ApplicationArea = Suite;
                Caption = 'Retry';
                Enabled = AreRecordsExist AND ShowRetryOrSync;
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Restore selected records so they can be synchronized.';

                trigger OnAction()
                var
                    CRMIntegrationRecord: Record "CRM Integration Record";
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                begin
                    SetCurrentSelectionFilter(CRMIntegrationRecord);
                    CRMIntegrationManagement.UpdateSkippedNow(CRMIntegrationRecord);
                    Refresh(CRMIntegrationRecord);
                end;
            }
            action(RestoreAll)
            {
                AccessByPermission = TableData "CRM Integration Record" = IM;
                ApplicationArea = Suite;
                Caption = 'Retry All';
                Enabled = true;
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Restore all records so they can be synchronized.';

                trigger OnAction()
                var
                    CRMIntegrationRecord: Record "CRM Integration Record";
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                begin
                    if IsEmpty() then
                        exit;
                    CRMIntegrationManagement.UpdateAllSkippedNow();
                    Refresh(CRMIntegrationRecord);
                    Session.LogMessage('0000CUG', UserRetriedAllTxt, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', CategoryTok);
                end;
            }
            action(CRMSynchronizeNow)
            {
                ApplicationArea = Suite;
                Caption = 'Synchronize';
                Enabled = AreRecordsExist AND ShowRetryOrSync;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Send or get updated data to or from Dynamics 365 Sales.';

                trigger OnAction()
                var
                    CRMIntegrationRecord: Record "CRM Integration Record";
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                begin
                    SetCurrentSelectionFilter(CRMIntegrationRecord);
                    CRMIntegrationManagement.UpdateSkippedNow(CRMIntegrationRecord, true);
                    Refresh(CRMIntegrationRecord);
                    CRMIntegrationManagement.UpdateMultipleNow(CRMIntegrationRecord);
                    Refresh(CRMIntegrationRecord);
                end;
            }
            action(ShowLog)
            {
                ApplicationArea = Suite;
                Caption = 'Synchronization Log';
                Enabled = AreRecordsExist AND "Record Exists";
                Image = Log;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                ToolTip = 'View integration synchronization jobs for the skipped record.';

                trigger OnAction()
                var
                    CRMIntegrationRecord: Record "CRM Integration Record";
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    RecId: RecordId;
                begin
                    CRMIntegrationRecord."Table ID" := "Table ID";
                    CRMIntegrationRecord."Integration ID" := "Integration ID";
                    CRMIntegrationRecord.FindRecordId(RecId);
                    CRMIntegrationManagement.ShowLog(RecId);
                end;
            }
            action(ManageCRMCoupling)
            {
                ApplicationArea = Suite;
                Caption = 'Set Up Coupling';
                Enabled = AreRecordsExist AND "Record Exists";
                Image = LinkAccount;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                ToolTip = 'Create or modify the coupling to a Dynamics 365 Sales entity.';

                trigger OnAction()
                var
                    CRMIntegrationRecord: Record "CRM Integration Record";
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    RecId: RecordId;
                begin
                    CRMIntegrationRecord."Table ID" := "Table ID";
                    CRMIntegrationRecord."Integration ID" := "Integration ID";
                    CRMIntegrationRecord.FindRecordId(RecId);
                    if CRMIntegrationRecord.FindByRecordID(RecId) then
                        if CRMIntegrationManagement.DefineCoupling(RecId) then begin
                            CRMIntegrationRecord.SetRecFilter;
                            Refresh(CRMIntegrationRecord);
                        end;
                end;
            }
            action(ShowUncouplingLog)
            {
                ApplicationArea = Suite;
                Caption = 'Uncoupling Log';
                Visible = CRMIntegrationEnabled or CDSIntegrationEnabled;
                Image = Log;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'View the status of jobs for uncoupling records, for example, in integrations with Dynamics 365 Sales or Dataverse. The jobs were run either from the job queue, or manually, in Business Central.';

                trigger OnAction()
                var
                    IntegrationSynchJob: Record "Integration Synch. Job";
                begin
                    IntegrationSynchJob.SetCurrentKey("Start Date/Time", ID);
                    IntegrationSynchJob.Ascending := false;
                    IntegrationSynchJob.SetRange(Type, IntegrationSynchJob.Type::Uncoupling);
                    if IntegrationSynchJob.FindFirst() then;
                    Page.Run(PAGE::"Integration Synch. Job List", IntegrationSynchJob);
                end;
            }
            action(DeleteCRMCoupling)
            {
                AccessByPermission = TableData "CRM Integration Record" = D;
                ApplicationArea = Suite;
                Caption = 'Delete Couplings';
                Enabled = AreRecordsExist;
                Image = UnLinkAccount;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                ToolTip = 'Delete couplings between the selected Business Central records and Dynamics 365 Sales entities.';

                trigger OnAction()
                var
                    TempCRMSynchConflictBuffer: Record "CRM Synch. Conflict Buffer" temporary;
                begin
                    TempCRMSynchConflictBuffer.Copy(Rec, true);
                    CurrPage.SetSelectionFilter(TempCRMSynchConflictBuffer);
                    TempCRMSynchConflictBuffer.DeleteCouplings();
                    AreRecordsExist := false;
                end;
            }
            action(FindMore)
            {
                AccessByPermission = TableData "CRM Integration Record" = IM;
                ApplicationArea = Suite;
                Caption = 'Find for Deleted';
                Enabled = true;
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Find couplings that were broken when one or more entities were deleted in Business Central. This might take several minutes.';

                trigger OnAction()
                begin
                    if not Confirm(FindMoreQst) then
                        exit;
                    CRMIntegrationManagement.MarkLocalDeletedAsSkipped();
                    Reload();
                end;
            }
            action(RestoreDeletedRec)
            {
                ApplicationArea = Suite;
                Caption = 'Restore Records';
                Enabled = AreRecordsExist AND ShowRestoreOrDelete;
                Image = CreateMovement;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Restore the deleted coupled entity in Dynamics 365 Sales. A synchronization job is run to achieve this.';

                trigger OnAction()
                var
                    TempCRMSynchConflictBuffer: Record "CRM Synch. Conflict Buffer" temporary;
                begin
                    TempCRMSynchConflictBuffer.Copy(Rec, true);
                    CurrPage.SetSelectionFilter(TempCRMSynchConflictBuffer);
                    TempCRMSynchConflictBuffer.RestoreDeletedRecords;
                end;
            }
            action(DeleteCoupledRec)
            {
                ApplicationArea = Suite;
                Caption = 'Delete Records';
                Enabled = AreRecordsExist AND ShowRestoreOrDelete;
                Image = CancelLine;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Delete the coupled entity in Dynamics 365 Sales.';

                trigger OnAction()
                var
                    TempCRMSynchConflictBuffer: Record "CRM Synch. Conflict Buffer" temporary;
                begin
                    TempCRMSynchConflictBuffer.Copy(Rec, true);
                    CurrPage.SetSelectionFilter(TempCRMSynchConflictBuffer);
                    TempCRMSynchConflictBuffer.DeleteCoupledRecords;
                end;
            }
            action(LoadMoreErrors)
            {
                ApplicationArea = Suite;
                Caption = 'Load More Errors';
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Reload the error list.';

                trigger OnAction()
                begin
                    Reload();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        TempCRMSynchConflictBuffer: Record "CRM Synch. Conflict Buffer" temporary;
    begin
        AreRecordsExist := true;
        IsOneOfRecordsDeleted := IsOneRecordDeleted;
        DoBothOfRecordsExist := DoBothRecordsExist;

        TempCRMSynchConflictBuffer.Copy(Rec, true);
        CurrPage.SetSelectionFilter(TempCRMSynchConflictBuffer);
        if TempCRMSynchConflictBuffer.Count() > 1 then begin
            if ShowRestoreOrDelete then
                if DoBothOfRecordsExist then
                    ShowRestoreOrDelete := false;
            if ShowRetryOrSync then
                if IsOneOfRecordsDeleted then
                    ShowRetryOrSync := false;
        end else begin
            ShowRestoreOrDelete := IsOneOfRecordsDeleted;
            ShowRetryOrSync := DoBothOfRecordsExist
        end;
    end;

    trigger OnOpenPage()
    begin
        LoadData('');
    end;

    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        CRMSynchHelper: Codeunit "CRM Synch. Helper";
        TooManyErrorsNotification: Notification;
        CRMIntegrationEnabled: Boolean;
        CDSIntegrationEnabled: Boolean;
        AreRecordsExist: Boolean;
        IsOneOfRecordsDeleted: Boolean;
        DoBothOfRecordsExist: Boolean;
        ShowRestoreOrDelete: Boolean;
        ShowRetryOrSync: Boolean;
        SetOutside: Boolean;
        TooManyErrorsNotificationTxt: Label 'Only 100 coupled record synchronization errors are loaded. When you have resolved them, choose the Load More Errors action to load more.';
        CategoryTok: Label 'AL Dataverse Integration', Locked = true;
        UserRetriedAllTxt: Label 'User invoked the Retry All function to set the Skipped flag to false on all records.', Locked = true;
        FindMoreQst: Label 'Do you want to find couplings that were broken after one or more entities were deleted in Business Central?';

    local procedure LoadData(TableIdFilter: Text);
    begin
        Reset;
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        CDSIntegrationEnabled := CRMIntegrationManagement.IsCDSIntegrationEnabled();
        if not SetOutside and (CRMIntegrationEnabled or CDSIntegrationEnabled) then
            CollectSkippedCRMIntegrationRecords(TableIdFilter);
    end;

    local procedure CollectSkippedCRMIntegrationRecords(TableIdFilter: Text)
    var
        CRMIntegrationRecord: Record "CRM Integration Record";
    begin
        if TableIdFilter <> '' then
            CRMIntegrationRecord.SetFilter("Table ID", TableIdFilter);
        CRMIntegrationRecord.SetRange(Skipped, true);
        SetRecords(CRMIntegrationRecord);
    end;

    local procedure SetCurrentSelectionFilter(var CRMIntegrationRecord: Record "CRM Integration Record")
    var
        TempCRMSynchConflictBuffer: Record "CRM Synch. Conflict Buffer" temporary;
    begin
        TempCRMSynchConflictBuffer.Copy(Rec, true);
        CurrPage.SetSelectionFilter(TempCRMSynchConflictBuffer);
        TempCRMSynchConflictBuffer.SetSelectionFilter(CRMIntegrationRecord);
    end;

    procedure SetRecords(var CRMIntegrationRecord: Record "CRM Integration Record")
    var
        cnt: Integer;
    begin
        cnt := Fill(CRMIntegrationRecord);
        SetOutside := true;
        if cnt >= 100 then begin
            TooManyErrorsNotification.Id(GetTooManyErrorsNotificationId());
            TooManyErrorsNotification.Message(TooManyErrorsNotificationTxt);
            TooManyErrorsNotification.Send();
        end;
    end;

    local procedure GetTooManyErrorsNotificationId(): Guid;
    begin
        exit('2d60b73e-8879-40b8-a16d-1edffad711cd');
    end;

    local procedure Refresh(var CRMIntegrationRecord: Record "CRM Integration Record")
    begin
        UpdateSourceTable(CRMIntegrationRecord);
        AreRecordsExist := false;
    end;

    local procedure Reload()
    var
        CurrView: Text;
        TableIdFilter: Text;
    begin
        if TooManyErrorsNotification.Recall() then;
        SetOutside := False;

        CurrView := Rec.GetView();
        TableIdFilter := Rec.GetFilter("Table ID");

        LoadData(TableIdFilter);
        Rec.SetView(CurrView);
        CurrPage.Update();
    end;
}

