page 5736 "Item References"
{
    Caption = 'Item References';
    DataCaptionFields = "Reference Type No.";
    Editable = true;
    PageType = List;
    SourceTable = "Item Reference";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Reference No."; "Reference No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the referenced item number. If you enter a reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the reference number on a sales or purchase document.';
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number on the item card from which you opened the Item Reference Entries window.';
                }
                field("Variant Code"; "Variant Code")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the variant of the item on the line.';
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a description of the item that is linked to this reference.';
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies an additional description of the item that is linked to this reference.';
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(Processing)
        {
#if not CLEAN19
            action(CopyItemCrossReferences)
            {
                ApplicationArea = Suite, ItemReferences;
                Caption = 'Copy Item Cross References';
                Image = CopySerialNo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "Copy Item Cross References";
                ToolTip = 'Copy Item Cross Reference table records that do not exist in Item Reference table.';
                ObsoleteState = Pending;
                ObsoleteTag = '19.0';
                ObsoleteReason = 'Will be removed along with Item Cross Reference table.';
            }
#endif
        }
    }
}

