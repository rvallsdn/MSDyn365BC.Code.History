page 9249 "Analysis by Dimensions Matrix"
{
    Caption = 'Analysis by Dimensions Matrix';
    DataCaptionExpression = AnalysisViewCode;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Dimension Code Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = Indentation;
                IndentationControls = Name;
                ShowCaption = false;
                field("Code"; Code)
                {
                    ApplicationArea = Dimensions;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ToolTip = 'Specifies the code of the record.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookUpCode(AnalysisByDimParameters."Line Dim Option", LineDimCode, Code);
                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = Dimensions;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ToolTip = 'Specifies the name of the record.';
                }
                field(TotalAmount; +Amount)
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    Caption = 'Total Amount';
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ToolTip = 'Specifies the total amount for the amount type that you select in the Show field in the Options FastTab.';

                    trigger OnDrillDown()
                    begin
                        DrillDown(false);
                    end;
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[1];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field1Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(1);
                        DrillDown(true);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[2];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field2Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(2);
                        DrillDown(true);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[3];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field3Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(3);
                        DrillDown(true);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[4];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field4Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(4);
                        DrillDown(true);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[5];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field5Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(5);
                        DrillDown(true);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[6];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field6Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(6);
                        DrillDown(true);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[7];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field7Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(7);
                        DrillDown(true);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[8];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field8Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(8);
                        DrillDown(true);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[9];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field9Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(9);
                        DrillDown(true);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[10];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field10Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(10);
                        DrillDown(true);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[11];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field11Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(11);
                        DrillDown(true);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[12];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field12Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(12);
                        DrillDown(true);
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[13];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field13Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(13);
                        DrillDown(true);
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[14];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field14Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(14);
                        DrillDown(true);
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[15];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field15Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(15);
                        DrillDown(true);
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[16];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field16Visible;

                    trigger OnAssistEdit()
                    begin
                        MATRIX_UpdateMatrixRecord(16);
                        DrillDown(true);
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[17];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field17Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(17);
                        DrillDown(true);
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[18];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field18Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(18);
                        DrillDown(true);
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[19];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field19Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(19);
                        DrillDown(true);
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[20];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field20Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(20);
                        DrillDown(true);
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[21];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field21Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(21);
                        DrillDown(true);
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[22];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field22Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(22);
                        DrillDown(true);
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[23];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field23Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(23);
                        DrillDown(true);
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[24];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field24Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(24);
                        DrillDown(true);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[25];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field25Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(25);
                        DrillDown(true);
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[26];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field26Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(26);
                        DrillDown(true);
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[27];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field27Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(27);
                        DrillDown(true);
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[28];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field28Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(28);
                        DrillDown(true);
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[29];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field29Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(29);
                        DrillDown(true);
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[30];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field30Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(30);
                        DrillDown(true);
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[31];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field31Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(31);
                        DrillDown(true);
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    ApplicationArea = Dimensions;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaptions[32];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field32Visible;

                    trigger OnDrillDown()
                    begin
                        MATRIX_UpdateMatrixRecord(32);
                        DrillDown(true);
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Actions")
            {
                Caption = '&Actions';
                Image = "Action";
                action(ExportToExcel)
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Export to Excel';
                    Image = ExportToExcel;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Export the information in the analysis report to Excel.';

                    trigger OnAction()
                    var
                        AnalysisViewEntry: Record "Analysis View Entry";
                        AnalysisViewToExcel: Codeunit "Export Analysis View";
                    begin
                        SetCommonFilters(AnalysisViewEntry);
                        AnalysisViewEntry.Find('-');
                        AnalysisViewToExcel.ExportData(AnalysisViewEntry, AnalysisByDimParameters);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        MATRIX_CurrentColumnOrdinal: Integer;
        MATRIX_Steps: Integer;
    begin
        Amount := MatrixMgt.RoundAmount(CalcAmount(false), AnalysisByDimParameters."Rounding Factor");

        MATRIX_CurrentColumnOrdinal := 0;
        if MATRIX_PrimKeyFirstCol <> '' then
            MatrixRecord.SetPosition(MATRIX_PrimKeyFirstCol);
        if MATRIX_OnFindRecord('=><') then begin
            MATRIX_CurrentColumnOrdinal := 1;

            repeat
                MATRIX_ColumnOrdinal := MATRIX_CurrentColumnOrdinal;
                MATRIX_OnAfterGetRecord;
                MATRIX_Steps := MATRIX_OnNextRecord(1);
                MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + MATRIX_Steps;
            until (MATRIX_CurrentColumnOrdinal - MATRIX_Steps = MATRIX_NoOfMatrixColumns) or (MATRIX_Steps = 0);
            if MATRIX_CurrentColumnOrdinal <> 1 then
                MATRIX_OnNextRecord(1 - MATRIX_CurrentColumnOrdinal);
        end;

        SetVisible;
        FormatLine;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        exit(FindRec(AnalysisByDimParameters."Line Dim Option", Rec, Which));
    end;

    trigger OnInit()
    begin
        Field32Visible := true;
        Field31Visible := true;
        Field30Visible := true;
        Field29Visible := true;
        Field28Visible := true;
        Field27Visible := true;
        Field26Visible := true;
        Field25Visible := true;
        Field24Visible := true;
        Field23Visible := true;
        Field22Visible := true;
        Field21Visible := true;
        Field20Visible := true;
        Field19Visible := true;
        Field18Visible := true;
        Field17Visible := true;
        Field16Visible := true;
        Field15Visible := true;
        Field14Visible := true;
        Field13Visible := true;
        Field12Visible := true;
        Field11Visible := true;
        Field10Visible := true;
        Field9Visible := true;
        Field8Visible := true;
        Field7Visible := true;
        Field6Visible := true;
        Field5Visible := true;
        Field4Visible := true;
        Field3Visible := true;
        Field2Visible := true;
        Field1Visible := true;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        exit(NextRec(AnalysisByDimParameters."Line Dim Option", Rec, Steps));
    end;

    trigger OnOpenPage()
    var
        CashFlowForecast: Record "Cash Flow Forecast";
        GLAcc: Record "G/L Account";
    begin
        MATRIX_NoOfMatrixColumns := ArrayLen(MATRIX_CellData);

        ValidateAnalysisViewCode;

        InitRec(Rec, AnalysisByDimParameters."Line Dim Option");
        InitRec(MatrixRecord, AnalysisByDimParameters."Column Dim Option");

        if (LineDimCode = '') and (ColumnDimCode = '') then begin
            if GLAccountSource then
                LineDimCode := GLAcc.TableCaption
            else
                LineDimCode := CashFlowForecast.TableCaption;
            ColumnDimCode := Text000;
        end;

        CalculateClosingDateFilter;

        SetVisible;
        if AnalysisByDimParameters."Line Dim Option" = AnalysisByDimParameters."Line Dim Option"::Period then
            Code := '';
    end;

    var
        Text000: Label 'Period';
        Text002: Label 'You have not yet defined an analysis view.';
        MatrixRecord: Record "Dimension Code Buffer" temporary;
        GLSetup: Record "General Ledger Setup";
        AnalysisView: Record "Analysis View";
        AnalysisViewEntry: Record "Analysis View Entry";
        AnalysisViewBudgetEntry: Record "Analysis View Budget Entry";
        AVBreakdownBuffer: Record "Dimension Code Amount Buffer" temporary;
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        PeriodOption: Record Date;
        MatrixMgt: Codeunit "Matrix Management";
        AnalysisViewCode: Code[10];
        LineDimCode: Text[30];
        ColumnDimCode: Text[30];
        ExcludeClosingDateFilter: Text;
        MATRIX_CellData: array[32] of Decimal;
        MATRIX_PrimKeyFirstCol: Text[1024];
        MatrixAmount: Decimal;
        CurrExchDate: Date;
        MATRIX_ColumnOrdinal: Integer;
        MATRIX_NoOfMatrixColumns: Integer;
        ColumnCaptions: array[32] of Text[250];
        RoundingFactorFormatString: Text;
        GLAccountSource: Boolean;
        [InDataSet]
        Field1Visible: Boolean;
        [InDataSet]
        Field2Visible: Boolean;
        [InDataSet]
        Field3Visible: Boolean;
        [InDataSet]
        Field4Visible: Boolean;
        [InDataSet]
        Field5Visible: Boolean;
        [InDataSet]
        Field6Visible: Boolean;
        [InDataSet]
        Field7Visible: Boolean;
        [InDataSet]
        Field8Visible: Boolean;
        [InDataSet]
        Field9Visible: Boolean;
        [InDataSet]
        Field10Visible: Boolean;
        [InDataSet]
        Field11Visible: Boolean;
        [InDataSet]
        Field12Visible: Boolean;
        [InDataSet]
        Field13Visible: Boolean;
        [InDataSet]
        Field14Visible: Boolean;
        [InDataSet]
        Field15Visible: Boolean;
        [InDataSet]
        Field16Visible: Boolean;
        [InDataSet]
        Field17Visible: Boolean;
        [InDataSet]
        Field18Visible: Boolean;
        [InDataSet]
        Field19Visible: Boolean;
        [InDataSet]
        Field20Visible: Boolean;
        [InDataSet]
        Field21Visible: Boolean;
        [InDataSet]
        Field22Visible: Boolean;
        [InDataSet]
        Field23Visible: Boolean;
        [InDataSet]
        Field24Visible: Boolean;
        [InDataSet]
        Field25Visible: Boolean;
        [InDataSet]
        Field26Visible: Boolean;
        [InDataSet]
        Field27Visible: Boolean;
        [InDataSet]
        Field28Visible: Boolean;
        [InDataSet]
        Field29Visible: Boolean;
        [InDataSet]
        Field30Visible: Boolean;
        [InDataSet]
        Field31Visible: Boolean;
        [InDataSet]
        Field32Visible: Boolean;
        Text003: Label 'Unsupported Account Source %1.';
        Emphasize: Boolean;

    protected var
        AnalysisByDimParameters: Record "Analysis by Dim. Parameters" temporary;

    local procedure InitRec(var DimCodeBuf: Record "Dimension Code Buffer"; DimOption: Option "G/L Account",Period,"Business Unit","Dimension 1","Dimension 2","Dimension 3","Dimension 4","Cash Flow Account","Cash Flow Forecast")
    var
        GLAccount: Record "G/L Account";
        CashFlowAccount: Record "Cash Flow Account";
        BusinessUnit: Record "Business Unit";
        CashFlowForecast: Record "Cash Flow Forecast";
    begin
        case DimOption of
            DimOption::"G/L Account":
                begin
                    if AnalysisByDimParameters."Account Filter" <> '' then
                        GLAccount.SetFilter("No.", AnalysisByDimParameters."Account Filter");
                    if GLAccount.FindSet then
                        repeat
                            CopyGLAccToBuf(GLAccount, DimCodeBuf);
                        until GLAccount.Next() = 0;
                end;
            DimOption::"Cash Flow Account":
                begin
                    if AnalysisByDimParameters."Account Filter" <> '' then
                        CashFlowAccount.SetFilter("No.", AnalysisByDimParameters."Account Filter");
                    if CashFlowAccount.FindSet then
                        repeat
                            CopyCFAccToBuf(CashFlowAccount, DimCodeBuf);
                        until CashFlowAccount.Next() = 0;
                end;
            DimOption::Period:
                begin
                    PeriodOption.SetRange("Period Type", AnalysisByDimParameters."Period Type");
                    if AnalysisByDimParameters."Date Filter" <> '' then begin
                        PeriodOption.FilterGroup(2);
                        PeriodOption.SetFilter("Period Start", AnalysisByDimParameters."Date Filter");
                        PeriodOption.FilterGroup(0);
                    end;
                end;
            DimOption::"Business Unit":
                begin
                    if AnalysisByDimParameters."Bus. Unit Filter" <> '' then
                        BusinessUnit.SetFilter(Code, AnalysisByDimParameters."Bus. Unit Filter");
                    if BusinessUnit.FindSet then
                        repeat
                            CopyBusUnitToBuf(BusinessUnit, DimCodeBuf);
                        until BusinessUnit.Next() = 0;
                end;
            DimOption::"Cash Flow Forecast":
                begin
                    if AnalysisByDimParameters."Cash Flow Forecast Filter" <> '' then
                        CashFlowForecast.SetFilter("No.", AnalysisByDimParameters."Cash Flow Forecast Filter");
                    if CashFlowForecast.FindSet then
                        repeat
                            CopyCashFlowToBuf(CashFlowForecast, DimCodeBuf);
                        until CashFlowForecast.Next() = 0;
                end;
            DimOption::"Dimension 1":
                InitDimValue(
                  DimCodeBuf, AnalysisView."Dimension 1 Code", AnalysisByDimParameters."Dimension 1 Filter");
            DimOption::"Dimension 2":
                InitDimValue(
                  DimCodeBuf, AnalysisView."Dimension 2 Code", AnalysisByDimParameters."Dimension 2 Filter");
            DimOption::"Dimension 3":
                InitDimValue(
                  DimCodeBuf, AnalysisView."Dimension 3 Code", AnalysisByDimParameters."Dimension 3 Filter");
            DimOption::"Dimension 4":
                InitDimValue(
                  DimCodeBuf, AnalysisView."Dimension 4 Code", AnalysisByDimParameters."Dimension 4 Filter");
            else
                OnInitRecOnCaseElse(DimOption, DimCodeBuf, AnalysisView);
        end;
        if FindFirst then;
    end;

    local procedure FindRec(DimOption: Option "G/L Account",Period,"Business Unit","Dimension 1","Dimension 2","Dimension 3","Dimension 4","Cash Flow Account","Cash Flow Forecast"; var DimCodeBuf: Record "Dimension Code Buffer"; Which: Text[250]): Boolean
    begin
        case DimOption of
            DimOption::"G/L Account",
          DimOption::"Cash Flow Account",
          DimOption::"Business Unit",
          DimOption::"Cash Flow Forecast",
          DimOption::"Dimension 1",
          DimOption::"Dimension 2",
          DimOption::"Dimension 3",
          DimOption::"Dimension 4":
                exit(DimCodeBuf.Find(Which));
            DimOption::Period:
                // Make specifial length of Which parameter in order to find PeriodPageMgt.FindDate procedure
                exit(FindPeriod(DimCodeBuf, CopyStr(Which, 1, 3)));
        end;
    end;

    local procedure NextRec(DimOption: Option "G/L Account",Period,"Business Unit","Dimension 1","Dimension 2","Dimension 3","Dimension 4","Cash Flow Account","Cash Flow Forecast"; var DimCodeBuf: Record "Dimension Code Buffer"; Steps: Integer): Integer
    begin
        case DimOption of
            DimOption::"G/L Account",
          DimOption::"Cash Flow Account",
          DimOption::"Business Unit",
          DimOption::"Cash Flow Forecast",
          DimOption::"Dimension 1",
          DimOption::"Dimension 2",
          DimOption::"Dimension 3",
          DimOption::"Dimension 4":
                exit(DimCodeBuf.Next(Steps));
            DimOption::Period:
                exit(NextPeriod(DimCodeBuf, Steps));
        end;
    end;

    local procedure CopyGLAccToBuf(var TheGLAcc: Record "G/L Account"; var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin
        with TheDimCodeBuf do begin
            Init;
            Code := TheGLAcc."No.";
            Name := TheGLAcc.Name;
            Totaling := TheGLAcc.Totaling;
            Indentation := TheGLAcc.Indentation;
            "Show in Bold" := TheGLAcc."Account Type" <> TheGLAcc."Account Type"::Posting;
            Insert;
        end;
    end;

    local procedure CopyCFAccToBuf(var TheCFAcc: Record "Cash Flow Account"; var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin
        with TheDimCodeBuf do begin
            Init;
            Code := TheCFAcc."No.";
            Name := TheCFAcc.Name;
            Totaling := TheCFAcc.Totaling;
            Indentation := TheCFAcc.Indentation;
            "Show in Bold" := TheCFAcc."Account Type" <> TheCFAcc."Account Type"::Entry;
            Insert;
        end;
    end;

    local procedure CopyPeriodToBuf(var ThePeriod: Record Date; var TheDimCodeBuf: Record "Dimension Code Buffer")
    var
        Period2: Record Date;
    begin
        with TheDimCodeBuf do begin
            Init;
            Code := Format(ThePeriod."Period Start");
            "Period Start" := ThePeriod."Period Start";
            if AnalysisByDimParameters."Closing Entries" = AnalysisByDimParameters."Closing Entries"::Include then
                "Period End" := ClosingDate(ThePeriod."Period End")
            else
                "Period End" := ThePeriod."Period End";
            if AnalysisByDimParameters."Date Filter" <> '' then begin
                Period2.SetFilter("Period End", AnalysisByDimParameters."Date Filter");
                if Period2.GetRangeMax("Period End") < "Period End" then
                    "Period End" := Period2.GetRangeMax("Period End");
            end;
            Name := ThePeriod."Period Name";
            if Insert() then;
        end;
    end;

    local procedure CopyBusUnitToBuf(var TheBusUnit: Record "Business Unit"; var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin
        with TheDimCodeBuf do begin
            Init;
            Code := TheBusUnit.Code;
            Name := TheBusUnit.Name;
            Insert;
        end;
    end;

    local procedure CopyCashFlowToBuf(var TheCashFlowForecast: Record "Cash Flow Forecast"; var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin
        with TheDimCodeBuf do begin
            Init;
            Code := TheCashFlowForecast."No.";
            Name := TheCashFlowForecast.Description;
            Insert;
        end;
    end;

    local procedure CopyDimValueToBuf(var TheDimVal: Record "Dimension Value"; var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin
        with TheDimCodeBuf do begin
            Init;
            Code := TheDimVal.Code;
            Name := TheDimVal.Name;
            Totaling := TheDimVal.Totaling;
            Indentation := TheDimVal.Indentation;
            "Show in Bold" :=
              TheDimVal."Dimension Value Type" <> TheDimVal."Dimension Value Type"::Standard;
            Insert;
        end;
    end;

    local procedure CalculateClosingDateFilter()
    var
        AccountingPeriod: Record "Accounting Period";
        FirstRec: Boolean;
    begin
        if AnalysisByDimParameters."Closing Entries" = AnalysisByDimParameters."Closing Entries"::Include then
            ExcludeClosingDateFilter := ''
        else begin
            AccountingPeriod.SetCurrentKey("New Fiscal Year");
            AccountingPeriod.SetRange("New Fiscal Year", true);
            FirstRec := true;
            if AccountingPeriod.Find('-') then
                repeat
                    if FirstRec then
                        ExcludeClosingDateFilter :=
                          StrSubstNo('<>%1', ClosingDate(AccountingPeriod."Starting Date" - 1))
                    else
                        ExcludeClosingDateFilter :=
                          ExcludeClosingDateFilter + StrSubstNo('&<>%1', ClosingDate(AccountingPeriod."Starting Date" - 1));
                    FirstRec := false;
                until AccountingPeriod.Next() = 0;
        end;
    end;

    local procedure LookUpCode(DimOption: Option "G/L Account",Period,"Business Unit","Dimension 1","Dimension 2","Dimension 3","Dimension 4","Cash Flow Account","Cash Flow Forecast"; DimCode: Text[30]; "Code": Text[30])
    var
        GLAcc: Record "G/L Account";
        BusUnit: Record "Business Unit";
        CFAccount: Record "Cash Flow Account";
        CashFlowForecast: Record "Cash Flow Forecast";
        DimVal: Record "Dimension Value";
    begin
        case DimOption of
            DimOption::"G/L Account":
                begin
                    GLAcc.Get(Code);
                    PAGE.RunModal(PAGE::"G/L Account List", GLAcc);
                end;
            DimOption::Period:
                ;
            DimOption::"Business Unit":
                begin
                    BusUnit.Get(Code);
                    PAGE.RunModal(PAGE::"Business Unit List", BusUnit);
                end;
            DimOption::"Cash Flow Account":
                begin
                    CFAccount.Get(Code);
                    PAGE.RunModal(PAGE::"Cash Flow Account List", CFAccount);
                end;
            DimOption::"Cash Flow Forecast":
                begin
                    CashFlowForecast.Get(Code);
                    PAGE.RunModal(PAGE::"Cash Flow Forecast List", CashFlowForecast);
                end;
            DimOption::"Dimension 1", DimOption::"Dimension 2",
            DimOption::"Dimension 3", DimOption::"Dimension 4":
                begin
                    DimVal.SetRange("Dimension Code", DimCode);
                    DimVal.Get(DimCode, Code);

                    PAGE.RunModal(PAGE::"Dimension Value List", DimVal);
                end;
            else
                OnLookUpCodeOnCaseElse(DimOption, Code);
        end;
    end;

    local procedure SetCommonFilters(var TheAnalysisViewEntry: Record "Analysis View Entry")
    var
        DateFilter2: Text;
    begin
        with TheAnalysisViewEntry do begin
            if AnalysisByDimParameters."Date Filter" = '' then
                DateFilter2 := ExcludeClosingDateFilter
            else begin
                if AnalysisByDimParameters."Amount Type" = AnalysisByDimParameters."Amount Type"::"Net Change" then begin
                    DateFilter2 := AnalysisByDimParameters."Date Filter";
                end else begin
                    SetFilter("Posting Date", AnalysisByDimParameters."Date Filter");
                    DateFilter2 := StrSubstNo('..%1', GetRangeMax("Posting Date"));
                end;
                if ExcludeClosingDateFilter <> '' then
                    DateFilter2 := StrSubstNo('%1 & %2', DateFilter2, ExcludeClosingDateFilter);
            end;
            Reset;

            SetRange("Analysis View Code", AnalysisView.Code);
            if AnalysisByDimParameters."Bus. Unit Filter" <> '' then
                SetFilter("Business Unit Code", AnalysisByDimParameters."Bus. Unit Filter");
            if AnalysisByDimParameters."Cash Flow Forecast Filter" <> '' then
                SetFilter("Cash Flow Forecast No.", AnalysisByDimParameters."Cash Flow Forecast Filter");

            if AnalysisByDimParameters."Account Filter" <> '' then
                SetFilter("Account No.", AnalysisByDimParameters."Account Filter");

            SetRange("Account Source", AnalysisView."Account Source");

            SetFilter("Posting Date", DateFilter2);
            if AnalysisByDimParameters."Dimension 1 Filter" <> '' then
                SetFilter("Dimension 1 Value Code", GetDimValueTotaling(AnalysisByDimParameters."Dimension 1 Filter", AnalysisView."Dimension 1 Code"));
            if AnalysisByDimParameters."Dimension 2 Filter" <> '' then
                SetFilter("Dimension 2 Value Code", GetDimValueTotaling(AnalysisByDimParameters."Dimension 2 Filter", AnalysisView."Dimension 2 Code"));
            if AnalysisByDimParameters."Dimension 3 Filter" <> '' then
                SetFilter("Dimension 3 Value Code", GetDimValueTotaling(AnalysisByDimParameters."Dimension 3 Filter", AnalysisView."Dimension 3 Code"));
            if AnalysisByDimParameters."Dimension 4 Filter" <> '' then
                SetFilter("Dimension 4 Value Code", GetDimValueTotaling(AnalysisByDimParameters."Dimension 4 Filter", AnalysisView."Dimension 4 Code"));
        end;

        OnAfterSetCommonFilters(TheAnalysisViewEntry, AnalysisByDimParameters);
    end;

    local procedure SetDimFilters(var TheAnalysisViewEntry: Record "Analysis View Entry"; LineOrColumn: Option Line,Column)
    var
        DimCodeBuf: Record "Dimension Code Buffer";
        DimOption: Option "G/L Account",Period,"Business Unit","Dimension 1","Dimension 2","Dimension 3","Dimension 4","Cash Flow Account","Cash Flow Forecast";
    begin
        if LineOrColumn = LineOrColumn::Line then begin
            DimCodeBuf := Rec;
            DimOption := AnalysisByDimParameters."Line Dim Option";
        end else begin
            DimCodeBuf := MatrixRecord;
            DimOption := AnalysisByDimParameters."Column Dim Option";
        end;
        case DimOption of
            DimOption::"G/L Account",
          DimOption::"Cash Flow Account":
                if DimCodeBuf.Totaling = '' then
                    TheAnalysisViewEntry.SetRange("Account No.", DimCodeBuf.Code)
                else
                    TheAnalysisViewEntry.SetFilter("Account No.", DimCodeBuf.Totaling);
            DimOption::Period:
                begin
                    if AnalysisByDimParameters."Amount Type" = AnalysisByDimParameters."Amount Type"::"Net Change" then
                        TheAnalysisViewEntry.SetRange(
                          "Posting Date", DimCodeBuf."Period Start", DimCodeBuf."Period End")
                    else
                        TheAnalysisViewEntry.SetRange("Posting Date", 0D, DimCodeBuf."Period End");
                    if (AnalysisByDimParameters."Closing Entries" = AnalysisByDimParameters."Closing Entries"::Exclude) and (ExcludeClosingDateFilter <> '') then
                        TheAnalysisViewEntry.SetFilter(
                          "Posting Date", TheAnalysisViewEntry.GetFilter("Posting Date") +
                          '&' + ExcludeClosingDateFilter);
                end;
            DimOption::"Business Unit":
                TheAnalysisViewEntry.SetRange("Business Unit Code", DimCodeBuf.Code);
            DimOption::"Cash Flow Forecast":
                TheAnalysisViewEntry.SetRange("Cash Flow Forecast No.", DimCodeBuf.Code);
            DimOption::"Dimension 1":
                if DimCodeBuf.Totaling = '' then
                    TheAnalysisViewEntry.SetRange("Dimension 1 Value Code", DimCodeBuf.Code)
                else
                    TheAnalysisViewEntry.SetFilter("Dimension 1 Value Code", DimCodeBuf.Totaling);
            DimOption::"Dimension 2":
                if DimCodeBuf.Totaling = '' then
                    TheAnalysisViewEntry.SetRange("Dimension 2 Value Code", DimCodeBuf.Code)
                else
                    TheAnalysisViewEntry.SetFilter("Dimension 2 Value Code", DimCodeBuf.Totaling);
            DimOption::"Dimension 3":
                if DimCodeBuf.Totaling = '' then
                    TheAnalysisViewEntry.SetRange("Dimension 3 Value Code", DimCodeBuf.Code)
                else
                    TheAnalysisViewEntry.SetFilter("Dimension 3 Value Code", DimCodeBuf.Totaling);
            DimOption::"Dimension 4":
                if DimCodeBuf.Totaling = '' then
                    TheAnalysisViewEntry.SetRange("Dimension 4 Value Code", DimCodeBuf.Code)
                else
                    TheAnalysisViewEntry.SetFilter("Dimension 4 Value Code", DimCodeBuf.Totaling);
        end;

        OnAfterSetDimFilters(TheAnalysisViewEntry, AnalysisView, DimOption, DimCodeBuf);
    end;

    local procedure SetCommonBudgetFilters(var TheAnalysisViewBudgetEntry: Record "Analysis View Budget Entry")
    begin
        with TheAnalysisViewBudgetEntry do begin
            Reset;
            SetRange("Analysis View Code", AnalysisView.Code);
            if AnalysisByDimParameters."Bus. Unit Filter" <> '' then
                SetFilter("Business Unit Code", AnalysisByDimParameters."Bus. Unit Filter");
            if AnalysisByDimParameters."Budget Filter" <> '' then
                SetFilter("Budget Name", AnalysisByDimParameters."Budget Filter");
            if AnalysisByDimParameters."Account Filter" <> '' then
                SetFilter("G/L Account No.", AnalysisByDimParameters."Account Filter");
            if AnalysisByDimParameters."Date Filter" <> '' then
                SetFilter("Posting Date", AnalysisByDimParameters."Date Filter");
            if AnalysisByDimParameters."Dimension 1 Filter" <> '' then
                SetFilter("Dimension 1 Value Code", GetDimValueTotaling(AnalysisByDimParameters."Dimension 1 Filter", AnalysisView."Dimension 1 Code"));
            if AnalysisByDimParameters."Dimension 2 Filter" <> '' then
                SetFilter("Dimension 2 Value Code", GetDimValueTotaling(AnalysisByDimParameters."Dimension 2 Filter", AnalysisView."Dimension 2 Code"));
            if AnalysisByDimParameters."Dimension 3 Filter" <> '' then
                SetFilter("Dimension 3 Value Code", GetDimValueTotaling(AnalysisByDimParameters."Dimension 3 Filter", AnalysisView."Dimension 3 Code"));
            if AnalysisByDimParameters."Dimension 4 Filter" <> '' then
                SetFilter("Dimension 4 Value Code", GetDimValueTotaling(AnalysisByDimParameters."Dimension 4 Filter", AnalysisView."Dimension 4 Code"));
        end;

        OnAfterSetCommonBudgetFilters(TheAnalysisViewBudgetEntry, AnalysisByDimParameters);
    end;

    local procedure SetDimBudgetFilters(var TheAnalysisViewBudgetEntry: Record "Analysis View Budget Entry"; LineOrColumn: Option Line,Column)
    var
        DimCodeBuf: Record "Dimension Code Buffer";
        DimOption: Option "G/L Account",Period,"Business Unit","Dimension 1","Dimension 2","Dimension 3","Dimension 4","Cash Flow Account",CashFlow;
    begin
        if LineOrColumn = LineOrColumn::Line then begin
            DimCodeBuf := Rec;
            DimOption := AnalysisByDimParameters."Line Dim Option";
        end else begin
            DimCodeBuf := MatrixRecord;
            DimOption := AnalysisByDimParameters."Column Dim Option";
        end;
        case DimOption of
            DimOption::"G/L Account":
                if DimCodeBuf.Totaling = '' then
                    TheAnalysisViewBudgetEntry.SetRange("G/L Account No.", DimCodeBuf.Code)
                else
                    TheAnalysisViewBudgetEntry.SetFilter("G/L Account No.", DimCodeBuf.Totaling);
            DimOption::Period:
                if AnalysisByDimParameters."Amount Type" = AnalysisByDimParameters."Amount Type"::"Net Change" then
                    TheAnalysisViewBudgetEntry.SetRange(
                      "Posting Date", DimCodeBuf."Period Start", DimCodeBuf."Period End")
                else
                    TheAnalysisViewBudgetEntry.SetRange("Posting Date", 0D, DimCodeBuf."Period End");
            DimOption::"Business Unit":
                TheAnalysisViewBudgetEntry.SetRange("Business Unit Code", DimCodeBuf.Code);
            DimOption::"Dimension 1":
                if DimCodeBuf.Totaling = '' then
                    TheAnalysisViewBudgetEntry.SetRange("Dimension 1 Value Code", DimCodeBuf.Code)
                else
                    TheAnalysisViewBudgetEntry.SetFilter("Dimension 1 Value Code", DimCodeBuf.Totaling);
            DimOption::"Dimension 2":
                if DimCodeBuf.Totaling = '' then
                    TheAnalysisViewBudgetEntry.SetRange("Dimension 2 Value Code", DimCodeBuf.Code)
                else
                    TheAnalysisViewBudgetEntry.SetFilter("Dimension 2 Value Code", DimCodeBuf.Totaling);
            DimOption::"Dimension 3":
                if DimCodeBuf.Totaling = '' then
                    TheAnalysisViewBudgetEntry.SetRange("Dimension 3 Value Code", DimCodeBuf.Code)
                else
                    TheAnalysisViewBudgetEntry.SetFilter("Dimension 3 Value Code", DimCodeBuf.Totaling);
            DimOption::"Dimension 4":
                if DimCodeBuf.Totaling = '' then
                    TheAnalysisViewBudgetEntry.SetRange("Dimension 4 Value Code", DimCodeBuf.Code)
                else
                    TheAnalysisViewBudgetEntry.SetFilter("Dimension 4 Value Code", DimCodeBuf.Totaling);
        end;

        OnAfterSetDimBudgetFilters(TheAnalysisViewBudgetEntry, AnalysisView, DimOption, DimCodeBuf);
    end;

    local procedure DrillDown(SetColFilter: Boolean)
    begin
        if AnalysisByDimParameters."Show Actual/Budgets" = AnalysisByDimParameters."Show Actual/Budgets"::"Actual Amounts" then begin
            SetCommonFilters(AnalysisViewEntry);
            SetDimFilters(AnalysisViewEntry, 0);
            if SetColFilter then
                SetDimFilters(AnalysisViewEntry, 1);
            PAGE.Run(PAGE::"Analysis View Entries", AnalysisViewEntry);
        end;
        if AnalysisByDimParameters."Show Actual/Budgets" = AnalysisByDimParameters."Show Actual/Budgets"::"Budgeted Amounts" then begin
            SetCommonBudgetFilters(AnalysisViewBudgetEntry);
            SetDimBudgetFilters(AnalysisViewBudgetEntry, 0);
            if SetColFilter then
                SetDimBudgetFilters(AnalysisViewBudgetEntry, 1);
            PAGE.Run(PAGE::"Analysis View Budget Entries", AnalysisViewBudgetEntry);
        end;
    end;

    local procedure ValidateAnalysisViewCode()
    begin
        AnalysisView.Code := AnalysisViewCode;
        if not AnalysisView.Find('=<>') then
            Error(Text002);
        AnalysisViewCode := AnalysisView.Code;

        case AnalysisView."Account Source" of
            AnalysisView."Account Source"::"G/L Account":
                GLAccountSource := true;
            AnalysisView."Account Source"::"Cash Flow Account":
                GLAccountSource := false;
            else
                Error(Text003, AnalysisView."Account Source");
        end;
    end;

    local procedure CalcAmount(SetColFilter: Boolean): Decimal
    var
        Amount: Decimal;
        ColumnCode: Code[20];
    begin
        if SetColFilter then
            ColumnCode := MatrixRecord.Code
        else
            ColumnCode := '';
        if AVBreakdownBuffer.Get(Code, ColumnCode) then
            exit(AVBreakdownBuffer.Amount);
        case AnalysisByDimParameters."Show Actual/Budgets" of
            AnalysisByDimParameters."Show Actual/Budgets"::"Actual Amounts":
                Amount := CalcActualAmount(SetColFilter);
            AnalysisByDimParameters."Show Actual/Budgets"::"Budgeted Amounts":
                Amount := CalcBudgAmount(SetColFilter);
            AnalysisByDimParameters."Show Actual/Budgets"::Variance:
                Amount := CalcActualAmount(SetColFilter) - CalcBudgAmount(SetColFilter);
            AnalysisByDimParameters."Show Actual/Budgets"::"Variance%":
                begin
                    Amount := CalcBudgAmount(SetColFilter);
                    if Amount <> 0 then
                        Amount := Round(100 * (CalcActualAmount(SetColFilter) - Amount) / Amount);
                end;
            AnalysisByDimParameters."Show Actual/Budgets"::"Index%":
                begin
                    Amount := CalcBudgAmount(SetColFilter);
                    if Amount <> 0 then
                        Amount := Round(100 * CalcActualAmount(SetColFilter) / Amount);
                end;
        end;
        if AnalysisByDimParameters."Show Opposite Sign" then
            Amount := -Amount;
        AVBreakdownBuffer."Line Code" := Code;
        AVBreakdownBuffer."Column Code" := ColumnCode;
        AVBreakdownBuffer.Amount := Amount;
        AVBreakdownBuffer.Insert();
        exit(Amount);
    end;

    local procedure CalcActualAmount(SetColFilter: Boolean): Decimal
    var
        Amount: Decimal;
    begin
        AnalysisViewEntry.Reset();
        SetCommonFilters(AnalysisViewEntry);
        SetDimFilters(AnalysisViewEntry, 0);
        if SetColFilter then
            SetDimFilters(AnalysisViewEntry, 1);
        if AnalysisByDimParameters."Show In Add. Currency" then
            case AnalysisByDimParameters."Show Amount Field" of
                AnalysisByDimParameters."Show Amount Field"::Amount:
                    begin
                        AnalysisViewEntry.CalcSums("Add.-Curr. Amount");
                        Amount := AnalysisViewEntry."Add.-Curr. Amount";
                    end;
                AnalysisByDimParameters."Show Amount Field"::"Debit Amount":
                    begin
                        AnalysisViewEntry.CalcSums("Add.-Curr. Debit Amount");
                        Amount := AnalysisViewEntry."Add.-Curr. Debit Amount";
                    end;
                AnalysisByDimParameters."Show Amount Field"::"Credit Amount":
                    begin
                        AnalysisViewEntry.CalcSums("Add.-Curr. Credit Amount");
                        Amount := AnalysisViewEntry."Add.-Curr. Credit Amount";
                    end;
            end
        else
            case AnalysisByDimParameters."Show Amount Field" of
                AnalysisByDimParameters."Show Amount Field"::Amount:
                    begin
                        AnalysisViewEntry.CalcSums(Amount);
                        Amount := AnalysisViewEntry.Amount;
                    end;
                AnalysisByDimParameters."Show Amount Field"::"Debit Amount":
                    begin
                        AnalysisViewEntry.CalcSums("Debit Amount");
                        Amount := AnalysisViewEntry."Debit Amount";
                    end;
                AnalysisByDimParameters."Show Amount Field"::"Credit Amount":
                    begin
                        AnalysisViewEntry.CalcSums("Credit Amount");
                        Amount := AnalysisViewEntry."Credit Amount";
                    end;
            end;

        OnAfterCalcActualAmount(AnalysisViewEntry, AnalysisByDimParameters, Amount);

        exit(Amount);
    end;

    local procedure CalcBudgAmount(SetColFilter: Boolean): Decimal
    var
        Amount: Decimal;
    begin
        AnalysisViewBudgetEntry.Reset();
        SetCommonBudgetFilters(AnalysisViewBudgetEntry);
        SetDimBudgetFilters(AnalysisViewBudgetEntry, 0);
        if SetColFilter then
            SetDimBudgetFilters(AnalysisViewBudgetEntry, 1);
        AnalysisViewBudgetEntry.CalcSums(Amount);
        Amount := AnalysisViewBudgetEntry.Amount;
        case AnalysisByDimParameters."Show Amount Field" of
            AnalysisByDimParameters."Show Amount Field"::"Debit Amount":
                if Amount < 0 then
                    Amount := 0;
            AnalysisByDimParameters."Show Amount Field"::"Credit Amount":
                if Amount > 0 then
                    Amount := 0
                else
                    Amount := -Amount;
        end;
        if (Amount <> 0) and AnalysisByDimParameters."Show In Add. Currency" then begin
            if AnalysisViewBudgetEntry.GetFilter("Posting Date") = '' then
                CurrExchDate := WorkDate
            else
                CurrExchDate := AnalysisViewBudgetEntry.GetRangeMin("Posting Date");
            Amount :=
              Round(
                CurrExchRate.ExchangeAmtLCYToFCY(
                  CurrExchDate, GLSetup."Additional Reporting Currency", Amount,
                  CurrExchRate.ExchangeRate(CurrExchDate, GLSetup."Additional Reporting Currency")),
                Currency."Amount Rounding Precision");
        end;

        OnAfterCalcBudgetAmount(AnalysisViewBudgetEntry, AnalysisByDimParameters, Amount);

        exit(Amount);
    end;

    local procedure MATRIX_UpdateMatrixRecord(MATRIX_NewColumnOrdinal: Integer)
    begin
        MATRIX_ColumnOrdinal := MATRIX_NewColumnOrdinal;
        MatrixRecord.SetPosition(MATRIX_PrimKeyFirstCol);
        MATRIX_OnFindRecord('=');
        if MATRIX_ColumnOrdinal <> 1 then
            MATRIX_OnNextRecord(MATRIX_ColumnOrdinal - 1);
    end;

    local procedure MATRIX_OnFindRecord(Which: Text[1024]): Boolean
    begin
        exit(FindRec(AnalysisByDimParameters."Column Dim Option", MatrixRecord, Which));
    end;

    local procedure MATRIX_OnNextRecord(Steps: Integer): Integer
    begin
        exit(NextRec(AnalysisByDimParameters."Column Dim Option", MatrixRecord, Steps));
    end;

    local procedure MATRIX_OnAfterGetRecord()
    begin
        MatrixAmount := MatrixMgt.RoundAmount(CalcAmount(true), AnalysisByDimParameters."Rounding Factor");

        MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixAmount;
    end;

    procedure SetVisible()
    begin
        Field1Visible := ColumnCaptions[1] <> '';
        Field2Visible := ColumnCaptions[2] <> '';
        Field3Visible := ColumnCaptions[3] <> '';
        Field4Visible := ColumnCaptions[4] <> '';
        Field5Visible := ColumnCaptions[5] <> '';
        Field6Visible := ColumnCaptions[6] <> '';
        Field7Visible := ColumnCaptions[7] <> '';
        Field8Visible := ColumnCaptions[8] <> '';
        Field9Visible := ColumnCaptions[9] <> '';
        Field10Visible := ColumnCaptions[10] <> '';
        Field11Visible := ColumnCaptions[11] <> '';
        Field12Visible := ColumnCaptions[12] <> '';
        Field13Visible := ColumnCaptions[13] <> '';
        Field14Visible := ColumnCaptions[14] <> '';
        Field15Visible := ColumnCaptions[15] <> '';
        Field16Visible := ColumnCaptions[16] <> '';
        Field17Visible := ColumnCaptions[17] <> '';
        Field18Visible := ColumnCaptions[18] <> '';
        Field19Visible := ColumnCaptions[19] <> '';
        Field20Visible := ColumnCaptions[20] <> '';
        Field21Visible := ColumnCaptions[21] <> '';
        Field22Visible := ColumnCaptions[22] <> '';
        Field23Visible := ColumnCaptions[23] <> '';
        Field24Visible := ColumnCaptions[24] <> '';
        Field25Visible := ColumnCaptions[25] <> '';
        Field26Visible := ColumnCaptions[26] <> '';
        Field27Visible := ColumnCaptions[27] <> '';
        Field28Visible := ColumnCaptions[28] <> '';
        Field29Visible := ColumnCaptions[29] <> '';
        Field30Visible := ColumnCaptions[30] <> '';
        Field31Visible := ColumnCaptions[31] <> '';
        Field32Visible := ColumnCaptions[32] <> '';
    end;


    procedure Load(NewAnalysisByDimParameters: Record "Analysis by Dim. Parameters"; LineDimCodeLocal: Text[30]; ColumnDimCodeLocal: Text[30]; NewMATRIX_ColumnCaptions: array[32] of Text[250]; NewPrimKeyFirstCol: Text[1024])
    begin
        AnalysisByDimParameters := NewAnalysisByDimParameters;
        AnalysisViewCode := AnalysisByDimParameters."Analysis View Code";
        LineDimCode := LineDimCodeLocal;
        ColumnDimCode := ColumnDimCodeLocal;
        CopyArray(ColumnCaptions, NewMATRIX_ColumnCaptions, 1);
        MATRIX_PrimKeyFirstCol := NewPrimKeyFirstCol;
        RoundingFactorFormatString := MatrixMgt.FormatRoundingFactor(AnalysisByDimParameters."Rounding Factor", false);
    end;

    local procedure FormatLine()
    begin
        Emphasize := "Show in Bold";
    end;

    local procedure FindPeriod(var DimCodeBuf: Record "Dimension Code Buffer"; Which: Text[3]) Found: Boolean
    var
        PeriodPageMgt: Codeunit PeriodPageManagement;
    begin
        Evaluate(PeriodOption."Period Start", DimCodeBuf.Code);
        FilterLinePeriod(DimCodeBuf);
        Found := PeriodPageMgt.FindDate(Which, PeriodOption, AnalysisByDimParameters."Period Type");
        if Found then
            CopyPeriodToBuf(PeriodOption, DimCodeBuf);
        exit(Found);
    end;

    local procedure NextPeriod(var DimCodeBuf: Record "Dimension Code Buffer"; Steps: Integer) ResultSteps: Integer
    var
        PeriodPageMgt: Codeunit PeriodPageManagement;
    begin
        Evaluate(PeriodOption."Period Start", DimCodeBuf.Code);
        FilterLinePeriod(DimCodeBuf);
        ResultSteps := PeriodPageMgt.NextDate(Steps, PeriodOption, AnalysisByDimParameters."Period Type");
        if ResultSteps <> 0 then
            CopyPeriodToBuf(PeriodOption, DimCodeBuf);
        exit(ResultSteps);
    end;

    local procedure FilterLinePeriod(var DimCodeBuf: Record "Dimension Code Buffer")
    begin
        if AnalysisByDimParameters."Line Dim Option" = AnalysisByDimParameters."Line Dim Option"::Period then begin
            PeriodOption.SetRange("Period Start");
            PeriodOption.SetRange("Period Name");
            PeriodOption.SetFilter("Period Start", DimCodeBuf.GetFilter(Code));
            PeriodOption.SetFilter("Period Name", DimCodeBuf.GetFilter(Name));
        end;
    end;

    local procedure InitDimValue(var DimensionCodeBuffer: Record "Dimension Code Buffer"; DimensionCode: Code[20]; DimensionFilter: Text)
    var
        DimensionValue: Record "Dimension Value";
    begin
        if DimensionCode <> '' then begin
            DimensionValue.SetRange("Dimension Code", DimensionCode);
            if DimensionFilter <> '' then
                DimensionValue.SetFilter(Code, DimensionFilter);
            if DimensionValue.FindSet then
                repeat
                    CopyDimValueToBuf(DimensionValue, DimensionCodeBuffer);
                until DimensionValue.Next() = 0;
        end;
    end;

    local procedure FormatStr(): Text
    begin
        exit(RoundingFactorFormatString);
    end;

    local procedure GetDimValueTotaling(DimValueFilter: Text; DimensionCode: Code[20]): Text
    var
        DimensionManagement: Codeunit DimensionManagement;
    begin
        DimensionManagement.ResolveDimValueFilter(DimValueFilter, DimensionCode);
        exit(DimValueFilter);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetCommonFilters(var AnalysisViewEntry: Record "Analysis View Entry"; AnalysisByDimParameters: Record "Analysis by Dim. Parameters")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetCommonBudgetFilters(var AnalysisViewBudgetEntry: Record "Analysis View Budget Entry"; AnalysisByDimParameters: Record "Analysis by Dim. Parameters")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalcActualAmount(var AnalysisViewEntry: Record "Analysis View Entry"; AnalysisByDimParameters: Record "Analysis by Dim. Parameters"; var Amount: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalcBudgetAmount(var AnalysisViewBudgetEntry: Record "Analysis View Budget Entry"; AnalysisByDimParameters: Record "Analysis by Dim. Parameters"; var Amount: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetDimFilters(var TheAnalysisViewEntry: Record "Analysis View Entry"; AnalysisView: Record "Analysis View"; DimOption: Option "G/L Account",Period,"Business Unit","Dimension 1","Dimension 2","Dimension 3","Dimension 4","Cash Flow Account","Cash Flow Forecast",Fund,DimAttrib1,DimAttrib2,DimAttrib3,DimAttrib4; var DimCodeBuf: Record "Dimension Code Buffer")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetDimBudgetFilters(var TheAnalysisViewBudgetEntry: Record "Analysis View Budget Entry"; AnalysisView: Record "Analysis View"; DimOption: Option "G/L Account",Period,"Business Unit","Dimension 1","Dimension 2","Dimension 3","Dimension 4","Cash Flow Account",CashFlow,Fund,DimAttrib1,DimAttrib2,DimAttrib3,DimAttrib4; var DimCodeBuf: Record "Dimension Code Buffer")
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnInitRecOnCaseElse(DimOption: Option "G/L Account",Period,"Business Unit","Dimension 1","Dimension 2","Dimension 3","Dimension 4","Cash Flow Account","Cash Flow Forecast",Fund,DimAttrib1,DimAttrib2,DimAttrib3,DimAttrib4; var TheDimCodeBuf: Record "Dimension Code Buffer"; var AnalysisView: Record "Analysis View")
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnLookUpCodeOnCaseElse(DimOption: Option "G/L Account",Period,"Business Unit","Dimension 1","Dimension 2","Dimension 3","Dimension 4","Cash Flow Account","Cash Flow Forecast",Fund,DimAttrib1,DimAttrib2,DimAttrib3,DimAttrib4; var "Code": Text[30])
    begin
    end;
}
