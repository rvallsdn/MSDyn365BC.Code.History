page 9060 "SO Processor Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Sales Cue";

    layout
    {
        area(content)
        {
            cuegroup("For Release")
            {
                Caption = 'For Release';
                field("Sales Quotes - Open"; "Sales Quotes - Open")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Sales Quotes";
                    ToolTip = 'Specifies the number of sales quotes that are not yet converted to invoices or orders.';
                }
                field("Sales Orders - Open"; "Sales Orders - Open")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Specifies the number of sales orders that are not fully posted.';
                }

                actions
                {
                    action("New Sales Quote")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Sales Quote';
                        RunObject = Page "Sales Quote";
                        RunPageMode = Create;
                        ToolTip = 'Offer items or services to a customer.';
                    }
                    action("New Sales Order")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Sales Order';
                        RunObject = Page "Sales Order";
                        RunPageMode = Create;
                        ToolTip = 'Create a new sales order for items or services that require partial posting.';
                    }
                }
            }
            cuegroup("Sales Orders Released Not Shipped")
            {
                Caption = 'Sales Orders Released Not Shipped';
                field(ReadyToShip; ReadyToShip)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ready To Ship';
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Specifies the number of sales documents that are ready to ship.';

                    trigger OnDrillDown()
                    begin
                        ShowOrders(FieldNo("Ready to Ship"));
                    end;
                }
                field(PartiallyShipped; PartiallyShipped)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Partially Shipped';
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Specifies the number of sales documents that are partially shipped.';

                    trigger OnDrillDown()
                    begin
                        ShowOrders(FieldNo("Partially Shipped"));
                    end;
                }
                field(DelayedOrders; DelayedOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delayed';
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Specifies the number of sales documents where your delivery is delayed.';

                    trigger OnDrillDown()
                    begin
                        ShowOrders(FieldNo(Delayed));
                    end;
                }
                field("Average Days Delayed"; AverageDaysDelayed)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Average Days Delayed';
                    DecimalPlaces = 0 : 1;
                    Image = Calendar;
                    ToolTip = 'Specifies the number of days that your order deliveries are delayed on average.';
                }

                actions
                {
                    action(Navigate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Find entries...';
                        RunObject = Page Navigate;
                        ShortCutKey = 'Shift+Ctrl+I';
                        ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';
                    }
                }
            }
            cuegroup(Returns)
            {
                Caption = 'Returns';
                field("Sales Return Orders - Open"; "Sales Return Orders - Open")
                {
                    ApplicationArea = SalesReturnOrder;
                    DrillDownPageID = "Sales Return Order List";
                    ToolTip = 'Specifies the number of sales return orders documents that are displayed in the Sales Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Sales Credit Memos - Open"; "Sales Credit Memos - Open")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Sales Credit Memos";
                    ToolTip = 'Specifies the number of sales credit memos that are not yet posted.';
                }

                actions
                {
                    action("New Sales Return Order")
                    {
                        ApplicationArea = SalesReturnOrder;
                        Caption = 'New Sales Return Order';
                        RunObject = Page "Sales Return Order";
                        RunPageMode = Create;
                        ToolTip = 'Process a return or refund that requires inventory handling by creating a new sales return order.';
                    }
                    action("New Sales Credit Memo")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Sales Credit Memo';
                        RunObject = Page "Sales Credit Memo";
                        RunPageMode = Create;
                        ToolTip = 'Process a return or refund by creating a new sales credit memo.';
                    }
                }
            }
            cuegroup("Document Exchange Service")
            {
                Caption = 'Document Exchange Service';
                Visible = ShowDocumentsPendingDodExchService;
                field("Sales Inv. - Pending Doc.Exch."; "Sales Inv. - Pending Doc.Exch.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies sales invoices that await sending to the customer through the document exchange service.';
                    Visible = ShowDocumentsPendingDodExchService;
                }
                field("Sales CrM. - Pending Doc.Exch."; "Sales CrM. - Pending Doc.Exch.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies sales credit memos that await sending to the customer through the document exchange service.';
                    Visible = ShowDocumentsPendingDodExchService;
                }
            }
            cuegroup("My User Tasks")
            {
                Caption = 'My User Tasks';
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'Replaced with User Tasks Activities part';
                ObsoleteTag = '17.0';
                field("UserTaskManagement.GetMyPendingUserTasksCount"; UserTaskManagement.GetMyPendingUserTasksCount)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending User Tasks';
                    Image = Checklist;
                    ToolTip = 'Specifies the number of pending tasks that are assigned to you or to a group that you are a member of.';
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced with User Tasks Activities part';
                    ObsoleteTag = '17.0';

                    trigger OnDrillDown()
                    var
                        UserTaskList: Page "User Task List";
                    begin
                        UserTaskList.SetPageToShowMyPendingUserTasks;
                        UserTaskList.Run;
                    end;
                }
            }
            usercontrol(SATAsyncLoader; SatisfactionSurveyAsync)
            {
                ApplicationArea = Basic, Suite;
                trigger ResponseReceived(Status: Integer; Response: Text)
                var
                    SatisfactionSurveyMgt: Codeunit "Satisfaction Survey Mgt.";
                begin
                    SatisfactionSurveyMgt.TryShowSurvey(Status, Response);
                end;

                trigger ControlAddInReady();
                begin
                    IsAddInReady := true;
                    CheckIfSurveyEnabled();
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        RoleCenterNotificationMgt: Codeunit "Role Center Notification Mgt.";
        TaskParameters: Dictionary of [Text, Text];
    begin
        RoleCenterNotificationMgt.HideEvaluationNotificationAfterStartingTrial();

        TaskParameters.Add('View', Rec.GetView());
        CurrPage.EnqueueBackgroundTask(CalcTaskId, Codeunit::"SO Activities Calculate", TaskParameters, 120000, PageBackgroundTaskErrorLevel::Warning);
    end;

    trigger OnAfterGetRecord()
    var
        DocExchServiceSetup: Record "Doc. Exch. Service Setup";
    begin
        ShowDocumentsPendingDodExchService := false;
        if DocExchServiceSetup.Get() then
            ShowDocumentsPendingDodExchService := DocExchServiceSetup.Enabled;
    end;

    trigger OnOpenPage()
    var
        RoleCenterNotificationMgt: Codeunit "Role Center Notification Mgt.";
        ConfPersonalizationMgt: Codeunit "Conf./Personalization Mgt.";
    begin
        Reset;
        if not Get then begin
            Init;
            Insert;
        end;

        SetRespCenterFilter;
        SetRange("Date Filter", 0D, WorkDate());
        SetFilter("Date Filter2", '>=%1', WorkDate);
        SetRange("User ID Filter", UserId);

        RoleCenterNotificationMgt.ShowNotifications;
        ConfPersonalizationMgt.RaiseOnOpenRoleCenterEvent;

        if PageNotifier.IsAvailable then begin
            PageNotifier := PageNotifier.Create;
            PageNotifier.NotifyPageReady;
        end;
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    var
        SOActivitiesCalculate: Codeunit "SO Activities Calculate";
    begin
        if TaskId <> CalcTaskId then
            exit;

        SOActivitiesCalculate.EvaluateResults(Results, Rec);

        ReadyToShip := Rec."Ready to Ship";
        AverageDaysDelayed := Rec."Average Days Delayed";
        DelayedOrders := Rec.Delayed;
        PartiallyShipped := Rec."Partially Shipped";

        CurrPage.Update();
    end;

    var
        CuesAndKpis: Codeunit "Cues And KPIs";
        UserTaskManagement: Codeunit "User Task Management";
        [RunOnClient]
        [WithEvents]
        PageNotifier: DotNet PageNotifier;
        AverageDaysDelayed: Decimal;
        ReadyToShip: Integer;
        PartiallyShipped: Integer;
        DelayedOrders: Integer;
        CalcTaskId: Integer;
        ShowDocumentsPendingDodExchService: Boolean;
        IsAddInReady: Boolean;
        IsPageReady: Boolean;

    trigger PageNotifier::PageReady()
    begin
        IsPageReady := true;
        CheckIfSurveyEnabled();
    end;

    local procedure CheckIfSurveyEnabled()
    var
        SatisfactionSurveyMgt: Codeunit "Satisfaction Survey Mgt.";
        CheckUrl: Text;
    begin
        if not IsAddInReady then
            exit;
        if not IsPageReady then
            exit;
        if not SatisfactionSurveyMgt.DeactivateSurvey() then
            exit;
        if not SatisfactionSurveyMgt.TryGetCheckUrl(CheckUrl) then
            exit;
        CurrPage.SATAsyncLoader.SendRequest(CheckUrl, SatisfactionSurveyMgt.GetRequestTimeoutAsync());
    end;
}

