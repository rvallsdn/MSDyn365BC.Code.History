page 6651 "Posted Return Shipment Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Return Shipment Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Type)
                {
                    ApplicationArea = PurchReturnOrder;
                    ToolTip = 'Specifies the line type.';
                }
                field("No."; "No.")
                {
                    ApplicationArea = PurchReturnOrder;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
#if not CLEAN17
                field("Cross-Reference No."; "Cross-Reference No.")
                {
                    ApplicationArea = PurchReturnOrder;
                    ToolTip = 'Specifies the cross-referenced item number. If you enter a cross reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the cross-reference number on a sales or purchase document.';
                    Visible = false;
                    ObsoleteReason = 'Cross-Reference replaced by Item Reference feature.';
                    ObsoleteState = Pending;
                    ObsoleteTag = '17.0';
                }
#endif
                field("Item Reference No."; "Item Reference No.")
                {
                    AccessByPermission = tabledata "Item Reference" = R;
                    ApplicationArea = Suite, ItemReferences;
                    ToolTip = 'Specifies the referenced item number.';
                }
                field("Variant Code"; "Variant Code")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the variant of the item on the line.';
                    Visible = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = PurchReturnOrder;
                    ToolTip = 'Specifies a description of the shipment that was returned to vendor, that was posted';
                }
                field("Return Reason Code"; "Return Reason Code")
                {
                    ApplicationArea = PurchReturnOrder;
                    ToolTip = 'Specifies the code explaining why the item was returned.';
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = PurchReturnOrder;
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                }
                field("Bin Code"; "Bin Code")
                {
                    ApplicationArea = PurchReturnOrder;
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                    Visible = false;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = PurchReturnOrder;
                    BlankZero = true;
                    ToolTip = 'Specifies the number of units of the item, general ledger account, or item charge on the line.';
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = PurchReturnOrder;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    ApplicationArea = PurchReturnOrder;
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
                    Visible = false;
                }
                field("Direct Unit Cost"; "Direct Unit Cost")
                {
                    ApplicationArea = PurchReturnOrder;
                    BlankZero = true;
                    ToolTip = 'Specifies the cost of one unit of the selected item or resource.';
                }
                field("Quantity Invoiced"; "Quantity Invoiced")
                {
                    ApplicationArea = PurchReturnOrder;
                    ToolTip = 'Specifies how many units of the item on the line have been posted as invoiced.';
                }
                field("Return Qty. Shipped Not Invd."; "Return Qty. Shipped Not Invd.")
                {
                    ApplicationArea = PurchReturnOrder;
                    Editable = false;
                    ToolTip = 'Specifies the quantity from the line that has been posted as shipped but that has not yet been posted as invoiced.';
                    Visible = false;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = PurchReturnOrder;
                    ToolTip = 'Specifies the number of the related job.';
                    Visible = false;
                }
                field("Prod. Order No."; "Prod. Order No.")
                {
                    ApplicationArea = PurchReturnOrder;
                    ToolTip = 'Specifies the number of the related production order.';
                    Visible = false;
                }
                field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                {
                    ApplicationArea = PurchReturnOrder;
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied to.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field(Correction; Correction)
                {
                    ApplicationArea = PurchReturnOrder;
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the entry as a corrective entry. You can use the field if you need to post a corrective entry to an account.';
                    Visible = false;
                }
                field("Gross Weight"; "Gross Weight")
                {
                    Caption = 'Unit Gross Weight';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the gross weight of one unit of the item. In the purchase statistics window, the gross weight on the line is included in the total gross weight of all the lines for the particular purchase document.';
                    Visible = false;
                }
                field("Net Weight"; "Net Weight")
                {
                    Caption = 'Unit Net Weight';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the net weight of one unit of the item. In the purchase statistics window, the net weight on the line is included in the total net weight of all the lines for the particular purchase document.';
                    Visible = false;
                }
                field("Unit Volume"; "Unit Volume")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the volume of one unit of the item. In the purchase statistics window, the volume of one unit of the item on the line is included in the total volume of all the lines for the particular purchase document.';
                    Visible = false;
                }
                field("Units per Parcel"; "Units per Parcel")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of units per parcel of the item. In the purchase statistics window, the number of units per parcel on the line helps to determine the total number of units for all the lines for the particular purchase document.';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("&Undo Return Shipment")
                {
                    ApplicationArea = PurchReturnOrder;
                    Caption = '&Undo Return Shipment';
                    Image = UndoShipment;
                    ToolTip = 'Undo the quantity posting made with the return shipment. A corrective line is inserted in the posted document, and the Return Qty. Shipped and Return Shpd. Not Invd. fields on the return order are set to zero.';

                    trigger OnAction()
                    begin
                        UndoReturnShipment;
                    end;
                }
            }
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
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        ShowDimensions();
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = PurchReturnOrder;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';

                    trigger OnAction()
                    begin
                        ShowLineComments();
                    end;
                }
                action(DocumentLineTracking)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Document &Line Tracking';
                    Image = Navigate;
                    ToolTip = 'View related open, posted, or archived documents or document lines.';

                    trigger OnAction()
                    begin
                        ShowDocumentLineTracking();
                    end;
                }
                action(ItemTrackingEntries)
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ToolTip = 'View serial or lot numbers that are assigned to items.';

                    trigger OnAction()
                    begin
                        ShowItemTrackingLines;
                    end;
                }
                action(ItemCreditMemoLines)
                {
                    ApplicationArea = PurchReturnOrder;
                    Caption = 'Item Credit Memo &Lines';
                    Image = CreditMemo;
                    ToolTip = 'View the related credit memo lines.';

                    trigger OnAction()
                    begin
                        PageShowItemPurchCrMemoLines;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
    end;

    local procedure UndoReturnShipment()
    var
        ReturnShptLine: Record "Return Shipment Line";
    begin
        ReturnShptLine.Copy(Rec);
        CurrPage.SetSelectionFilter(ReturnShptLine);
        CODEUNIT.Run(CODEUNIT::"Undo Return Shipment Line", ReturnShptLine);
    end;

    local procedure PageShowItemPurchCrMemoLines()
    begin
        TestField(Type, Type::Item);
        ShowItemPurchCrMemoLines;
    end;

    procedure ShowDocumentLineTracking()
    var
        DocumentLineTracking: Page "Document Line Tracking";
    begin
        Clear(DocumentLineTracking);
        DocumentLineTracking.SetDoc(13, "Document No.", "Line No.", "Return Order No.", "Return Order Line No.", '', 0);
        DocumentLineTracking.RunModal;
    end;
}

