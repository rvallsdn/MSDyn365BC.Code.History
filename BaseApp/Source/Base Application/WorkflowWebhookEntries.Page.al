page 830 "Workflow Webhook Entries"
{
    ApplicationArea = Suite;
    Caption = 'Flow Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Workflow Webhook Entry";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Ascending);
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(RecordIDText; RecordIDText)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Record';
                    ToolTip = 'Specifies the record that is involved in the workflow. ';
                }
                field("Date-Time Initiated"; "Date-Time Initiated")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date and time of the workflow entries.';
                }
                field("Initiated By User ID"; "Initiated By User ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the User ID which has initiated the workflow.';

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation("Initiated By User ID");
                    end;
                }
                field(Response; Response)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the affected workflow response.';
                }
                field("Last Modified By User ID"; "Last Modified By User ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the user who last modified the workflow entry.';

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation("Last Modified By User ID");
                    end;
                }
                field("Last Date-Time Modified"; "Last Date-Time Modified")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies when the workflow entry was last modified.';
                }
                field(NotificationStatusText; NotificationStatusText)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Notification Status';
                    ToolTip = 'Specifies status of workflow webhook notification';
                }
                field(NotificationErrorText; NotificationErrorText)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Notification Error';
                    ToolTip = 'Specifies error occurred while sending workflow webhook notification.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(CancelRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Re&quest';
                Enabled = CanCancel;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Cancel the request.';

                trigger OnAction()
                var
                    WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
                begin
                    WorkflowWebhookManagement.Cancel(Rec);
                end;
            }
            action(Resubmit)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Resubmit';
                Enabled = CanResendNotification;
                Image = Restore;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Resubmit';

                trigger OnAction()
                var
                    WorkflowStepInstance: Record "Workflow Step Instance";
                    WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
                begin
                    WorkflowStepInstance.SetLoadFields("Workflow Code");
                    WorkflowStepInstance.SetRange(ID, Rec."Workflow Step Instance ID");

                    if WorkflowStepInstance.FindFirst then
                        WorkflowWebhookManagement.SendWebhookNotificaton(WorkflowStepInstance);
                end;
            }
            action(Refresh)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Refresh';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Refresh the page.';

                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
            action("Record")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Record';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Open the document, journal line, or card that the Power Automate flow entry is for.';

                trigger OnAction()
                begin
                    ShowRecord;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        WorkflowWebhookNotification: Record "Workflow Webhook Notification";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
    begin
        RecordIDText := Format("Record ID", 0, 1);
        CanCancel := WorkflowWebhookManagement.CanCancel(Rec);
        if FindWorkflowWebhookNotification("Workflow Step Instance ID", WorkflowWebhookNotification) then begin
            NotificationStatusText := Format(WorkflowWebhookNotification.Status);
            NotificationErrorText := WorkflowWebhookNotification."Error Message";
            CanResendNotification := WorkflowWebhookNotification.Status = WorkflowWebhookNotification.Status::Failed;
        end else begin
            Clear(NotificationStatusText);
            Clear(NotificationErrorText);
            CanResendNotification := false;
        end;
    end;

    trigger OnOpenPage()
    begin
        if not ShowAllResponses then
            SetFilter(Response, Format(Response::Pending));
    end;

    var
        CanCancel: Boolean;
        RecordIDText: Text;
        NotificationStatusText: Text;
        NotificationErrorText: Text;
        CanResendNotification: Boolean;
        ShowAllResponses: Boolean;

    local procedure FindWorkflowWebhookNotification(WorkflowStepInstanceID: Guid; var WorkflowWebhookNotification: Record "Workflow Webhook Notification"): Boolean
    begin
        WorkflowWebhookNotification.SetRange("Workflow Step Instance ID", WorkflowStepInstanceID);
        exit(WorkflowWebhookNotification.FindFirst);
    end;

    procedure Setfilters(RecordIDValue: RecordID)
    begin
        SetRange("Record ID", RecordIDValue);
        ShowAllResponses := true;
    end;
}

