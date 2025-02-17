// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

/// <summary>
/// Page to view suggested addresses.
/// </summary>
page 8944 "Email Address Lookup"
{
    PageType = List;
    SourceTable = "Email Address Lookup";
    Caption = 'Suggested Email Addresses';
    UsageCategory = None;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Extensible = true;
    PromotedActionCategories = 'New,Process,Report,Full Address Lists';

    layout
    {
        area(Content)
        {
            group(EntityGroup)
            {
                ShowCaption = false;

                field("Type of entity"; EntityType)
                {
                    ApplicationArea = All;
                    Caption = 'Select entity';
                    ToolTip = 'Select type of entity to show';

                    trigger OnValidate()
                    begin
                        UpdateRecords();
                    end;
                }
            }

            repeater(GroupName)
            {
                field("Email Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail Address.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Name.';
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                    ToolTip = 'Company.';
                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(Users)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;
                Caption = 'Users';
                ToolTip = 'Add addresses from Users.';
                Image = Employee;

                trigger OnAction()
                begin
                    LookupFullAddressList(EntityType::User);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        UserHelpNotification: Notification;
    begin
        FullAddressLookup := false;
        if Rec.IsEmpty() then begin
            UserHelpNotification.Message := UserHelpNotificationTxt;
            UserHelpNotification.Send();
        end;
        UpdateRecords();
    end;

    procedure WasFullAddressLookup(): Boolean
    begin
        exit(FullAddressLookup);
    end;

    internal procedure SetEntityType(EmailAddressEntity: enum "Email Address Entity")
    begin
        EntityType := EmailAddressEntity;
    end;

    protected procedure LookupFullAddressList(Entity: Enum "Email Address Entity")
    var
        Addresses: Record "Email Address Lookup";
        EmailAddressLookup: Codeunit "Email Address Lookup Impl";
    begin
        if EmailAddressLookup.LookupEmailAddress(Entity, Addresses) then begin
            Clear(Rec);
            Addresses.FindSet();
            repeat
                if (not Rec.Get(Addresses."E-Mail Address", Addresses.Name, Addresses."Entity type")) then begin
                    Rec.TransferFields(Addresses);
                    Rec.Insert();
                    Rec.Mark(true);
                end;
            until Addresses.Next() = 0;
            FullAddressLookup := true;
            CurrPage.Close();
        end;
    end;

    internal procedure UpdateRecords()
    begin
        Rec.SetFilter("Entity type", Format(EntityType));
        CurrPage.Update();
    end;

    procedure GetSelectedSuggestions(var EmailAddress: Record "Email Address Lookup")
    begin
        if FullAddressLookup then
            Rec.MarkedOnly(true)
        else
            CurrPage.SetSelectionFilter(Rec);

        if not Rec.FindSet() then
            exit;

        repeat
            EmailAddress.TransferFields(Rec);
            EmailAddress.Insert();
        until Rec.Next() = 0;
    end;

    procedure AddSuggestions(var EmailAddress: Record "Email Address Lookup")
    begin
        if EmailAddress.FindSet() then
            repeat
                Rec.Copy(EmailAddress);
                Rec.Insert();
            until EmailAddress.Next() = 0;

        // Sort list
        Rec.SetCurrentKey(Company, Name);
        Rec.SetAscending(Company, true);
    end;

    protected var
        [InDataSet]
        EntityType: enum "Email Address Entity";

    var
        FullAddressLookup: Boolean;
        UserHelpNotificationTxt: Label 'No address suggestions were found. Click the menu action "Full Address Lists" to search for more email addresses.';
}