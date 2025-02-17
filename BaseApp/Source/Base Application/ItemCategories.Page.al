page 5730 "Item Categories"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Item Categories';
    CardPageID = "Item Category Card";
    InsertAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Item Category";
    SourceTableView = SORTING("Presentation Order");
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = Indentation;
                IndentationControls = "Code";
                ShowAsTree = true;
                ShowCaption = false;
                field("Code"; Code)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the code for the item category.';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                        CurrPage.ItemAttributesFactbox.PAGE.LoadCategoryAttributesData(Code);
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a description of the item category.';
                }
            }
        }
        area(factboxes)
        {
            part(ItemAttributesFactbox; "Item Attributes Factbox")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Attributes';
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Recalculate)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Recalculate';
                Image = Hierarchy;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Update the tree of item categories based on recent changes.';

                trigger OnAction()
                begin
                    ItemCategoryManagement.UpdatePresentationOrder();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        StyleTxt := GetStyleText;
        CurrPage.ItemAttributesFactbox.PAGE.LoadCategoryAttributesData(Code);
    end;

    trigger OnAfterGetRecord()
    begin
        StyleTxt := GetStyleText;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        StyleTxt := GetStyleText;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        StyleTxt := GetStyleText;
    end;

    trigger OnOpenPage()
    begin
        ItemCategoryManagement.CheckPresentationOrder();
    end;

    var
        ItemCategoryManagement: Codeunit "Item Category Management";
        StyleTxt: Text;

    procedure GetSelectionFilter(): Text
    var
        ItemCategory: Record "Item Category";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SetSelectionFilter(ItemCategory);
        exit(SelectionFilterManagement.GetSelectionFilterForItemCategory(ItemCategory));
    end;

    procedure SetSelection(var ItemCategory: Record "Item Category")
    begin
        CurrPage.SetSelectionFilter(ItemCategory);
    end;
}

