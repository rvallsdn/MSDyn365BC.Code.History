page 639 "IC Outbox Purchase Lines"
{
    Caption = 'Lines';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "IC Outbox Purchase Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("IC Partner Ref. Type"; "IC Partner Ref. Type")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the item or account in your IC partner''s company that corresponds to the item or account on the line.';
                }
                field("IC Partner Reference"; "IC Partner Reference")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the IC partner. If the line is being sent to one of your intercompany partners, this field is used together with the IC Partner Ref. Type field to indicate the item or account in your partner''s company that corresponds to the line.';
                }
                field("IC Item Reference No."; "IC Item Reference No.")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the IC item reference. If the line is being sent to one of your intercompany partners, this field is used together with the IC Partner Ref. Type field to indicate the item reference in your partner''s company that corresponds to the line.';
                }
                field(Description; Description)
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies a description of the entry. The description depends on what you chose in the Type field. If you did not choose Blank, the program will fill in the field when you enter something in the No. field.';
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the number of units of the item that will be specified on the line.';
                }
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the cost of one unit of the item or resource on the line.';
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the net amount, including VAT, for this line.';
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the number of the related job.';
                    Visible = false;
                }
                field("Drop Shipment"; "Drop Shipment")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies if your vendor ships the items directly to your customer.';
                    Visible = false;
                }
                field("VAT Base Amount"; "VAT Base Amount")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the amount that serves as a base for calculating the Amount Including VAT field.';
                    Visible = false;
                }
                field("Line Amount"; "Line Amount")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the net amount, excluding any invoice discount amount, that must be paid for products on the line.';
                    Visible = false;
                }
                field("Promised Receipt Date"; "Promised Receipt Date")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        ShowDimensions();
                    end;
                }
            }
        }
    }
}

