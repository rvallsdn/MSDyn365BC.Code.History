codeunit 362 PeriodPageManagement
{

    trigger OnRun()
    begin
    end;

    var
        AccountingPeriod: Record "Accounting Period";
        AccountingPeriodMgt: Codeunit "Accounting Period Mgt.";
        WeekYear4Txt: Label '<Week>.<Year4>', Locked = true;
        MonthText3Year4Txt: Label '<Month Text,3> <Year4>', Locked = true;
        QuarterYear4Txt: Label '<Quarter>/<Year4>', Locked = true;
        Year4Txt: Label '<Year4>', Locked = true;

    procedure FindDate(SearchString: Text[3]; var Calendar: Record Date; PeriodType: Enum "Analysis Period Type"): Boolean
    var
        Found: Boolean;
    begin
        Calendar.SetRange("Period Type", PeriodType);
        Calendar."Period Type" := PeriodType.AsInteger();
        if Calendar."Period Start" = 0D then
            Calendar."Period Start" := WorkDate();
        if SearchString in ['', '=><'] then
            SearchString := '=<>';
        if PeriodType = PeriodType::"Accounting Period" then begin
            AccountingPeriod.SetRange("Starting Date");
            if AccountingPeriod.IsEmpty() then begin
                AccountingPeriodMgt.InitDefaultAccountingPeriod(AccountingPeriod, GetCalendarPeriodMinDate(Calendar));
                Found := true;
            end else begin
                SetAccountingPeriodFilter(Calendar);
                Found := AccountingPeriod.Find(SearchString);
            end;
            if Found then
                CopyAccountingPeriod(Calendar);
        end else begin
            Found := Calendar.Find(SearchString);
            if Found then
                Calendar."Period End" := NormalDate(Calendar."Period End");
        end;
        exit(Found);
    end;

    procedure NextDate(NextStep: Integer; var Calendar: Record Date; PeriodType: Enum "Analysis Period Type"): Integer
    begin
        Calendar.SetRange("Period Type", PeriodType);
        Calendar."Period Type" := PeriodType.AsInteger();
        if PeriodType = PeriodType::"Accounting Period" then begin
            if AccountingPeriod.IsEmpty() then
                AccountingPeriodMgt.InitDefaultAccountingPeriod(AccountingPeriod, CalcDate('<+1M>', GetCalendarPeriodMinDate(Calendar)))
            else begin
                SetAccountingPeriodFilter(Calendar);
                NextStep := AccountingPeriod.Next(NextStep);
            end;
            if NextStep <> 0 then
                CopyAccountingPeriod(Calendar);
        end else begin
            NextStep := Calendar.Next(NextStep);
            if NextStep <> 0 then
                Calendar."Period End" := NormalDate(Calendar."Period End");
        end;
        exit(NextStep);
    end;

    procedure CreatePeriodFormat(PeriodType: Enum "Analysis Period Type"; Date: Date) PeriodFormat: Text[10]
    begin
        case PeriodType of
            PeriodType::Day:
                PeriodFormat := Format(Date);
            PeriodType::Week:
                begin
                    if Date2DWY(Date, 2) = 1 then
                        Date := Date + 7 - Date2DWY(Date, 1);
                    PeriodFormat := Format(Date, 0, WeekYear4Txt);
                end;
            PeriodType::Month:
                PeriodFormat := Format(Date, 0, MonthText3Year4Txt);
            PeriodType::Quarter:
                PeriodFormat := Format(Date, 0, QuarterYear4Txt);
            PeriodType::Year:
                PeriodFormat := Format(Date, 0, Year4Txt);
            PeriodType::"Accounting Period":
                PeriodFormat := Format(Date);
        end;

        OnAfterCreatePeriodFormat(PeriodType, Date, PeriodFormat, AccountingPeriod);
    end;

    procedure MoveDateByPeriod(Date: Date; PeriodType: Option; MoveByNoOfPeriods: Integer): Date
    var
        DateExpression: DateFormula;
    begin
        Evaluate(DateExpression, '<' + Format(MoveByNoOfPeriods) + GetPeriodTypeSymbol(PeriodType) + '>');
        exit(CalcDate(DateExpression, Date));
    end;

    procedure MoveDateByPeriodToEndOfPeriod(Date: Date; PeriodType: Option; MoveByNoOfPeriods: Integer): Date
    var
        DateExpression: DateFormula;
    begin
        Evaluate(DateExpression, '<' + Format(MoveByNoOfPeriods + 1) + GetPeriodTypeSymbol(PeriodType) + '-1D>');
        exit(CalcDate(DateExpression, Date));
    end;

    procedure GetPeriodTypeSymbol(PeriodType: Option): Text[1]
    var
        Date: Record Date;
    begin
        case PeriodType of
            Date."Period Type"::Date:
                exit('D');
            Date."Period Type"::Week:
                exit('W');
            Date."Period Type"::Month:
                exit('M');
            Date."Period Type"::Quarter:
                exit('Q');
            Date."Period Type"::Year:
                exit('Y');
        end;
    end;

    local procedure SetAccountingPeriodFilter(var Calendar: Record Date)
    begin
        AccountingPeriod.SetFilter("Starting Date", Calendar.GetFilter("Period Start"));
        AccountingPeriod.SetFilter(Name, Calendar.GetFilter("Period Name"));
        AccountingPeriod."Starting Date" := Calendar."Period Start";
    end;

    local procedure GetCalendarPeriodMinDate(var Calendar: Record Date): Date
    begin
        if Calendar.GetFilter("Period Start") <> '' then
            exit(Calendar.GetRangeMin("Period Start"));
        exit(Calendar."Period Start");
    end;

    local procedure CopyAccountingPeriod(var Calendar: Record Date)
    begin
        Calendar.Init();
        Calendar."Period Start" := AccountingPeriod."Starting Date";
        Calendar."Period Name" := AccountingPeriod.Name;
        if AccountingPeriod.IsEmpty() then
            Calendar."Period End" := AccountingPeriodMgt.GetDefaultPeriodEndingDate(Calendar."Period Start")
        else
            if AccountingPeriod.Next() = 0 then
                Calendar."Period End" := EndOfPeriod()
            else
                Calendar."Period End" := AccountingPeriod."Starting Date" - 1;
    end;

    procedure EndOfPeriod(): Date
    begin
        exit(DMY2Date(31, 12, 9999));
    end;

    procedure GetFullPeriodDateFilter(PeriodType: Enum "Analysis Period Type"; DateFilter: Text): Text
    var
        Period: Record Date;
        StartDate: Date;
        EndDate: Date;
    begin
        if DateFilter = '' then
            exit(DateFilter);

        Period.SetFilter("Period Start", DateFilter);
        StartDate := Period.GetRangeMin("Period Start");
        EndDate := Period.GetRangeMax("Period Start");
        case PeriodType of
            PeriodType::Week,
            PeriodType::Month,
            PeriodType::Quarter,
            PeriodType::Year:
                begin
                    Period.SetRange("Period Type", PeriodType);
                    Period.SetFilter("Period Start", '<=%1', StartDate);
                    Period.FindLast();
                    StartDate := Period."Period Start";
                    Period.SetRange("Period Start");
                    Period.SetFilter("Period End", '>%1', EndDate);
                    Period.FindFirst();
                    EndDate := NormalDate(Period."Period End");
                end;
            PeriodType::"Accounting Period":
                begin
                    AccountingPeriod.SetFilter("Starting Date", '<=%1', StartDate);
                    AccountingPeriod.FindLast();
                    StartDate := AccountingPeriod."Starting Date";
                    AccountingPeriod.SetFilter("Starting Date", '>%1', EndDate);
                    AccountingPeriod.FindFirst();
                    EndDate := AccountingPeriod."Starting Date" - 1;
                end;
        end;
        Period.SetRange("Period Start", StartDate, EndDate);
        exit(Period.GetFilter("Period Start"));
    end;

    procedure FindPeriod(var Item: Record Item; SearchText: Text[3]; PeriodType: Enum "Analysis Period Type"; AmountType: Enum "Analysis Amount Type")
    var
        Calendar: Record Date;
    begin
        with Item do begin
            if GetFilter("Date Filter") <> '' then begin
                Calendar.SetFilter("Period Start", GetFilter("Date Filter"));
                if not FindDate('+', Calendar, PeriodType) then
                    FindDate('+', Calendar, PeriodType::Day);
                Calendar.SetRange("Period Start");
            end;
            FindDate(SearchText, Calendar, PeriodType);
            if AmountType = AmountType::"Net Change" then begin
                SetRange("Date Filter", Calendar."Period Start", Calendar."Period End");
                if GetRangeMin("Date Filter") = GetRangeMax("Date Filter") then
                    SetRange("Date Filter", GetRangeMin("Date Filter"));
            end else
                SetRange("Date Filter", 0D, Calendar."Period End");
        end;
    end;

    procedure FindPeriodOnMatrixPage(var DateFilter: Text; var InternalDateFilter: Text; SearchText: Text[3]; PeriodType: Enum "Analysis Period Type"; UpdateDateFilter: Boolean)
    var
        Item: Record Item;
        Calendar: Record Date;
    begin
        if DateFilter <> '' then begin
            Calendar.SetFilter("Period Start", DateFilter);
            if not FindDate('+', Calendar, PeriodType) then
                FindDate('+', Calendar, PeriodType::Day);
            Calendar.SetRange("Period Start");
        end;
        FindDate(SearchText, Calendar, PeriodType);
        Item.SetRange("Date Filter", Calendar."Period Start", Calendar."Period End");
        if Item.GetRangeMin("Date Filter") = Item.GetRangeMax("Date Filter") then
            Item.SetRange("Date Filter", Item.GetRangeMin("Date Filter"));
        InternalDateFilter := Item.GetFilter("Date Filter");
        if UpdateDateFilter then
            DateFilter := InternalDateFilter;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreatePeriodFormat(PeriodType: Enum "Analysis Period Type"; Date: Date; var PeriodFormat: Text[10]; var AccountingPeriod: Record "Accounting Period")
    begin
    end;
}
