page 1117 "Cost Budget per Period"
{
    Caption = 'Cost Budget per Period';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = ListPlus;
    SourceTable = "Cost Type";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CostCenterFilter; CostCenterFilter)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Center Filter';
                    TableRelation = "Cost Center";
                    ToolTip = 'Specifies the cost center that you want to work on. You should enter either a cost center, or a cost object, but not both.';

                    trigger OnValidate()
                    begin
                        UpdateMatrixSubform();
                    end;
                }
                field(CostObjectFilter; CostObjectFilter)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Object Filter';
                    TableRelation = "Cost Object";
                    ToolTip = 'Specifies the cost object that you want to work on. You should enter either a cost center, or a cost object, but not both.';

                    trigger OnValidate()
                    begin
                        UpdateMatrixSubform();
                    end;
                }
                field(BudgetFilter; BudgetFilter)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Budget Filter';
                    TableRelation = "Cost Budget Name";
                    ToolTip = 'Specifies the budget name that you want to work on.';

                    trigger OnValidate()
                    begin
                        UpdateMatrixSubform();
                    end;
                }
                field(PeriodType; PeriodType)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'View by';
                    ToolTip = 'Specifies by which period amounts are displayed.';

                    trigger OnValidate()
                    begin
                        SetMatrixColumns("Matrix Page Step Type"::Initial);
                        UpdateMatrixSubform();
                    end;
                }
                field(AmountType; AmountType)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'View as';
                    ToolTip = 'Specifies how amounts are displayed. Net Change: The net change in the balance for the selected period. Balance at Date: The balance as of the last day in the selected period.';

                    trigger OnValidate()
                    begin
                        UpdateMatrixSubform();
                    end;
                }
                field(RoundingFactor; RoundingFactor)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Rounding Factor';
                    ToolTip = 'Specifies the factor that is used to round the amounts in the columns.';

                    trigger OnValidate()
                    begin
                        UpdateMatrixSubform();
                    end;
                }
            }
            part(MatrixForm; "Cost Budget per Period Matrix")
            {
                ApplicationArea = CostAccounting;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Budge&t")
            {
                Caption = 'Budge&t';
                Image = LedgerBudget;
                action("By Cost &Center")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'By Cost &Center';
                    Image = CostCenter;
                    RunObject = Page "Cost Budget by Cost Center";
                    RunPageOnRec = true;
                    ToolTip = 'View a summary of the amount budgeted for each cost center in different time periods.';
                }
                action("By Cost &Object")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'By Cost &Object';
                    Image = Cost;
                    RunObject = Page "Cost Budget by Cost Object";
                    RunPageOnRec = true;
                    ToolTip = 'View a summary of the amount budgeted for each cost object in different time periods.';
                }
                separator(Action5)
                {
                }
                action("Budget / Movement")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Budget / Movement';
                    Image = CostBudget;
                    RunObject = Page "Cost Type Balance/Budget";
                    RunPageOnRec = true;
                    ToolTip = 'View a summary of the net changes and the budgeted amounts for different time periods for the cost type that you select in the chart of cost types.';
                }
            }
        }
        area(processing)
        {
            action(PreviousSet)
            {
                ApplicationArea = CostAccounting;
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the previous set of data.';

                trigger OnAction()
                begin
                    GenerateColumnCaptions("Matrix Page Step Type"::Previous);
                    UpdateMatrixSubform();
                end;
            }
            action(PreviousColumn)
            {
                ApplicationArea = CostAccounting;
                Caption = 'Previous Column';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the previous column.';

                trigger OnAction()
                begin
                    GenerateColumnCaptions("Matrix Page Step Type"::PreviousColumn);
                    UpdateMatrixSubform();
                end;
            }
            action(NextColumn)
            {
                ApplicationArea = CostAccounting;
                Caption = 'Next Column';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the next column.';

                trigger OnAction()
                begin
                    GenerateColumnCaptions("Matrix Page Step Type"::NextColumn);
                    UpdateMatrixSubform();
                end;
            }
            action(NextSet)
            {
                ApplicationArea = CostAccounting;
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the next set of data.';

                trigger OnAction()
                begin
                    GenerateColumnCaptions("Matrix Page Step Type"::Next);
                    UpdateMatrixSubform();
                end;
            }
            separator(Action27)
            {
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Copy Cost Budget to Cost Budget")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Copy Cost Budget to Cost Budget';
                    Image = CopyCostBudget;
                    RunObject = Report "Copy Cost Budget";
                    ToolTip = 'Copy cost budget amounts within a budget or from budget to budget. You can copy a budget several times and enter a factor to increase or reduce the budget amounts.';
                }
                action("Copy G/L Budget to Cost Budget")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Copy G/L Budget to Cost Budget';
                    Image = CopyGLtoCostBudget;
                    RunObject = Report "Copy G/L Budget to Cost Acctg.";
                    ToolTip = 'Copy general ledger budget figures to the cost accounting budget. You can also enter budgets for the cost centers and cost objects in the general ledger.';
                }
                action("Copy Cost Budget to G/L Budget")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Copy Cost Budget to G/L Budget';
                    Image = CopyCosttoGLBudget;
                    RunObject = Report "Copy Cost Acctg. Budget to G/L";
                    ToolTip = 'Copy selected cost budget entries into the general ledger. Multiplication factors and multiple copies with date offsets are also possible.';
                }
                action(ExportToExcel)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Export To Excel';
                    Image = ExportToExcel;
                    ToolTip = 'Export all or part of the budget to Excel for further analysis. If you make changes in Excel, you can import the budget afterwards.';

                    trigger OnAction()
                    var
                        CostBudgetEntry: Record "Cost Budget Entry";
                        ExportCostBudgetToExcel: Report "Export Cost Budget to Excel";
                    begin
                        CostBudgetEntry.SetFilter("Budget Name", BudgetFilter);
                        CostBudgetEntry.SetFilter("Cost Center Code", CostCenterFilter);
                        CostBudgetEntry.SetFilter("Cost Object Code", CostObjectFilter);
                        ExportCostBudgetToExcel.SetRoundingFactor(RoundingFactor);
                        ExportCostBudgetToExcel.SetTableView(CostBudgetEntry);
                        ExportCostBudgetToExcel.Run;
                    end;
                }
                action(ImportFromExcel)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Import From Excel';
                    Image = ImportExcel;
                    ToolTip = 'Import a budget that you exported to Excel earlier.';

                    trigger OnAction()
                    var
                        CostBudgetEntry: Record "Cost Budget Entry";
                        ImportCostBudgetFromExcel: Report "Import Cost Budget from Excel";
                    begin
                        CostBudgetEntry.SetFilter("Budget Name", BudgetFilter);
                        ImportCostBudgetFromExcel.SetGLBudgetName(CostBudgetEntry.GetRangeMin("Budget Name"));
                        ImportCostBudgetFromExcel.RunModal;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetMatrixColumns("Matrix Page Step Type"::Initial);
        BudgetFilter := GetFilter("Budget Filter");
        GenerateColumnCaptions("Matrix Page Step Type"::Initial);
        UpdateMatrixSubform();
    end;

    var
        MatrixRecords: array[32] of Record Date;
        CostCenterFilter: Text;
        CostObjectFilter: Text;
        BudgetFilter: Text;
        MatrixColumnCaptions: array[32] of Text[80];
        ColumnSet: Text[80];
        PKFirstRecInCurrSet: Text[80];
        PeriodType: Enum "Analysis Period Type";
        AmountType: Enum "Analysis Amount Type";
        RoundingFactor: Enum "Analysis Rounding Factor";
        CurrSetLength: Integer;

#if not CLEAN19
    [Obsolete('Replaced by SetmatrixColumns().', '19.0')]
    procedure SetColumns(SetType: Option First,Previous,Same,Next,PreviousColumn,NextColumn)
    begin
        SetMatrixColumns("Matrix Page Step Type".FromInteger(SetType));
    end;
#endif

    local procedure SetMatrixColumns(StepType: Enum "Matrix Page Step Type")
    var
        MatrixMgt: Codeunit "Matrix Management";
    begin
        MatrixMgt.GeneratePeriodMatrixData(
            StepType.AsInteger(), 12, false, PeriodType, '',
            PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, MatrixRecords);
    end;

    local procedure UpdateMatrixSubform()
    begin
        CurrPage.MatrixForm.PAGE.LoadMatrix(
            MatrixColumnCaptions, MatrixRecords, CurrSetLength, CostCenterFilter,
            CostObjectFilter, BudgetFilter, RoundingFactor, AmountType);
    end;

    local procedure GenerateColumnCaptions(StepType: Enum "Matrix Page Step Type")
    var
        MatrixMgt: Codeunit "Matrix Management";
    begin
        Clear(MatrixColumnCaptions);
        CurrSetLength := 12;

        MatrixMgt.GeneratePeriodMatrixData(
          StepType.AsInteger(), CurrSetLength, false, PeriodType, '',
          PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, MatrixRecords);
    end;
}

