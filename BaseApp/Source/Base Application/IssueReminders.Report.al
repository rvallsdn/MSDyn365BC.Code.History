report 190 "Issue Reminders"
{
    Caption = 'Issue Reminders';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Check Reminder Header"; "Reminder Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Reminder';

            trigger OnAfterGetRecord()
            begin
                if "E-Invoice" then
                    PEPPOLValidation.CheckReminder("No.");
            end;
        }
        dataitem("Reminder Header"; "Reminder Header")
        {
            DataItemTableView = SORTING("No.");

            trigger OnAfterGetRecord()
            begin
                RecordNo := RecordNo + 1;
                Clear(ReminderIssue);
                ReminderIssue.Set("Reminder Header", ReplacePostingDate, PostingDateReq);
                if NoOfRecords = 1 then begin
                    ReminderIssue.Run;
                    Mark := false;
                end else begin
                    NewDateTime := CurrentDateTime;
                    if (NewDateTime - OldDateTime > 100) or (NewDateTime < OldDateTime) then begin
                        NewProgress := Round(RecordNo / NoOfRecords * 100, 1);
                        if NewProgress <> OldProgress then begin
                            Window.Update(1, NewProgress * 100);
                            OldProgress := NewProgress;
                        end;
                        OldDateTime := CurrentDateTime;
                    end;
                    Commit;
                    Mark := not ReminderIssue.Run;
                end;

                if PrintDoc <> PrintDoc::" " then begin
                    ReminderIssue.GetIssuedReminder(IssuedReminderHeader);
                    TempIssuedReminderHeader := IssuedReminderHeader;
                    TempIssuedReminderHeader.Insert;
                end;
            end;

            trigger OnPostDataItem()
            var
                IssuedReminderHeaderPrint: Record "Issued Reminder Header";
                ConfirmManagement: Codeunit "Confirm Management";
                IsHandled: Boolean;
            begin
                Window.Close;
                Commit;
                if PrintDoc <> PrintDoc::" " then
                    if TempIssuedReminderHeader.FindSet then
                        repeat
                            IssuedReminderHeaderPrint := TempIssuedReminderHeader;
                            IsHandled := false;
                            OnBeforePrintIssuedReminderHeader(IssuedReminderHeaderPrint, IsHandled);
                            if not IsHandled then begin
                                IssuedReminderHeaderPrint.SetRecFilter;
                                IssuedReminderHeaderPrint.PrintRecords(false, PrintDoc = PrintDoc::Email, HideDialog);
                            end;
                        until TempIssuedReminderHeader.Next = 0;
                MarkedOnly := true;
                if FindFirst then
                    if ConfirmManagement.GetResponse(ShowNotIssuedQst, true) then
                        PAGE.RunModal(0, "Reminder Header");
            end;

            trigger OnPreDataItem()
            begin
                SetView("Check Reminder Header".GetView);
                CopyFilters("Check Reminder Header");
                if ReplacePostingDate and (PostingDateReq = 0D) then
                    Error(EnterPostingDateErr);
                NoOfRecords := Count;
                if NoOfRecords = 1 then
                    Window.Open(IssuingReminderMsg)
                else begin
                    Window.Open(IssuingRemindersMsg);
                    OldDateTime := CurrentDateTime;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintDoc; PrintDoc)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Print';
                        Enabled = NOT IsOfficeAddin;
                        ToolTip = 'Specifies it you want to print or email the reminders when they are issued.';
                    }
                    field(ReplacePostingDate; ReplacePostingDate)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Replace Posting Date';
                        ToolTip = 'Specifies if you want to replace the reminders'' posting date with the date entered in the field below.';
                    }
                    field(PostingDateReq; PostingDateReq)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Posting Date';
                        ToolTip = 'Specifies the posting date. If you place a check mark in the check box above, the program will use this date on all reminders when you post.';
                    }
                    field(HideEmailDialog; HideDialog)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Hide Email Dialog';
                        ToolTip = 'Specifies if you want to hide email dialog.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    var
        OfficeMgt: Codeunit "Office Management";
    begin
        IsOfficeAddin := OfficeMgt.IsAvailable;
        if IsOfficeAddin then
            PrintDoc := 2;
    end;

    var
        EnterPostingDateErr: Label 'Enter the posting date.';
        IssuingReminderMsg: Label 'Issuing reminder...';
        IssuingRemindersMsg: Label 'Issuing reminders @1@@@@@@@@@@@@@';
        ShowNotIssuedQst: Label 'It was not possible to issue some of the selected reminders.\Do you want to see these reminders?';
        IssuedReminderHeader: Record "Issued Reminder Header";
        TempIssuedReminderHeader: Record "Issued Reminder Header" temporary;
        ReminderIssue: Codeunit "Reminder-Issue";
        PEPPOLValidation: Codeunit "PEPPOL Validation";
        Window: Dialog;
        NoOfRecords: Integer;
        RecordNo: Integer;
        NewProgress: Integer;
        OldProgress: Integer;
        NewDateTime: DateTime;
        OldDateTime: DateTime;
        PostingDateReq: Date;
        ReplacePostingDate: Boolean;
        PrintDoc: Option " ",Print,Email;
        HideDialog: Boolean;
        [InDataSet]
        IsOfficeAddin: Boolean;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePrintIssuedReminderHeader(var IssuedReminderHeader: Record "Issued Reminder Header"; var IsHandled: Boolean)
    begin
    end;
}

