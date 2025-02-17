codeunit 1311 "Activities Mgt."
{

    trigger OnRun()
    begin
        if IsCueDataStale then
            RefreshActivitiesCueData;
    end;

    var
        DefaultWorkDate: Date;
        RefreshFrequencyErr: Label 'Refresh intervals of less than 10 minutes are not supported.';
        NoSubCategoryWithAdditionalReportDefinitionOfCashAccountsTok: Label 'There are no %1 with %2 specified for %3', Comment = '%1 Table Comment G/L Account Category, %2 field Additional Report Definition, %3 value: Cash Accounts';

    [Obsolete('Replaced by OverdueSalesInvoiceAmount(CalledFromWebService, UseCachedValue)', '17.0')]
    procedure CalcOverdueSalesInvoiceAmount(CalledFromWebService: Boolean) Amount: Decimal
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        SetFilterForCalcOverdueSalesInvoiceAmount(DetailedCustLedgEntry, CalledFromWebService);
        DetailedCustLedgEntry.CalcSums("Amount (LCY)");
        Amount := Abs(DetailedCustLedgEntry."Amount (LCY)");
    end;

    [Scope('OnPrem')]
    [Obsolete('Replaced by SetFilterOverdueSalesInvoice(VendorLedgerEntry, CalledFromWebService', '17.0')]
    procedure SetFilterForCalcOverdueSalesInvoiceAmount(var DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; CalledFromWebService: Boolean)
    begin
        DetailedCustLedgEntry.SetRange("Initial Document Type", DetailedCustLedgEntry."Initial Document Type"::Invoice);
        if CalledFromWebService then
            DetailedCustLedgEntry.SetFilter("Initial Entry Due Date", '<%1', Today)
        else
            DetailedCustLedgEntry.SetFilter("Initial Entry Due Date", '<%1', GetDefaultWorkDate());
    end;

    procedure OverdueSalesInvoiceAmount(CalledFromWebService: Boolean; UseCachedValue: Boolean): Decimal
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        CustLedgerEntry: Record "Cust. Ledger Entry";
        ActivitiesCue: record "Activities Cue";
        Amount: Decimal;
    begin
        Amount := 0;
        if UseCachedValue then
            if ActivitiesCue.Get then
                if not IsPassedCueData(ActivitiesCue) then
                    Exit(ActivitiesCue."Overdue Sales Invoice Amount");
        SetFilterOverdueSalesInvoice(CustLedgerEntry, CalledFromWebService);
        CustLedgerEntry.SetAutoCalcFields("Remaining Amt. (LCY)");
        if CustLedgerEntry.FindSet() then
            repeat
                Amount := Amount + CustLedgerEntry."Remaining Amt. (LCY)";
            until CustLedgerEntry.Next() = 0;
        exit(Amount);
    end;

    procedure SetFilterOverdueSalesInvoice(var CustLedgerEntry: Record "Cust. Ledger Entry"; CalledFromWebService: Boolean)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeSetFilterOverdueSalesInvoice(CustLedgerEntry, CalledFromWebService, IsHandled);
        if IsHandled then
            exit;

        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange(Open, true);
        if CalledFromWebService then
            CustLedgerEntry.SetFilter("Due Date", '<%1', Today)
        else
            CustLedgerEntry.SetFilter("Due Date", '<%1', GetDefaultWorkDate());
    end;

    procedure DrillDownCalcOverdueSalesInvoiceAmount()
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        CustLedgerEntry: Record "Cust. Ledger Entry";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeDrillDownCalcOverdueSalesInvoiceAmount(CustLedgerEntry, IsHandled);
        if IsHandled then
            exit;

        SetFilterOverdueSalesInvoice(CustLedgerEntry, false);
        CustLedgerEntry.SetFilter("Remaining Amt. (LCY)", '<>0');
        CustLedgerEntry.SetCurrentKey("Remaining Amt. (LCY)");
        CustLedgerEntry.Ascending := false;

        PAGE.Run(PAGE::"Customer Ledger Entries", CustLedgerEntry);
    end;

    [Obsolete('Replaced by OverduePurchaseInvoiceAmount(CalledFromWebService, UseCache', '17.0')]
    procedure CalcOverduePurchaseInvoiceAmount(CalledFromWebService: Boolean) Amount: Decimal
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
    begin
        SetFilterForCalcOverduePurchaseInvoiceAmount(DetailedVendorLedgEntry, CalledFromWebService);
        DetailedVendorLedgEntry.CalcSums("Amount (LCY)");
        Amount := Abs(DetailedVendorLedgEntry."Amount (LCY)");
    end;

    [Scope('OnPrem')]
    [Obsolete('Replaced by SetFilterOverduePurchaseInvoice(VendorLedgerEntry, CalledFromWebService', '17.0')]
    procedure SetFilterForCalcOverduePurchaseInvoiceAmount(var DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry"; CalledFromWebService: Boolean)
    begin
        DetailedVendorLedgEntry.SetRange("Initial Document Type", DetailedVendorLedgEntry."Initial Document Type"::Invoice);
        if CalledFromWebService then
            DetailedVendorLedgEntry.SetFilter("Initial Entry Due Date", '<%1', Today)
        else
            DetailedVendorLedgEntry.SetFilter("Initial Entry Due Date", '<%1', GetDefaultWorkDate());
    end;

    procedure OverduePurchaseInvoiceAmount(CalledFromWebService: Boolean; UseCachedValue: Boolean): Decimal
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        ActivitiesCue: Record "Activities Cue";
        Amount: Decimal;
    begin
        Amount := 0;
        if UseCachedValue then
            if ActivitiesCue.Get then
                if not IsPassedCueData(ActivitiesCue) then
                    exit(ActivitiesCue."Overdue Purch. Invoice Amount");
        SetFilterOverduePurchaseInvoice(VendorLedgerEntry, CalledFromWebService);
        VendorLedgerEntry.SetAutoCalcFields("Remaining Amt. (LCY)");
        if VendorLedgerEntry.FindSet() then
            repeat
                Amount := Amount + VendorLedgerEntry."Remaining Amt. (LCY)";
            until VendorLedgerEntry.Next() = 0;
        exit(-Amount);
    end;

    procedure SetFilterOverduePurchaseInvoice(var VendorLedgerEntry: Record "Vendor Ledger Entry"; CalledFromWebService: Boolean)
    begin
        VendorLedgerEntry.SetRange(Open, true);
        VendorLedgerEntry.SetRange("Document Type", VendorLedgerEntry."Document Type"::Invoice);
        if CalledFromWebService then
            VendorLedgerEntry.SetFilter("Due Date", '<%1', Today)
        else
            VendorLedgerEntry.SetFilter("Due Date", '<%1', GetDefaultWorkDate());
    end;

    procedure DrillDownOverduePurchaseInvoiceAmount()
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        SetFilterOverduePurchaseInvoice(VendorLedgerEntry, false);
        VendorLedgerEntry.SetFilter("Remaining Amt. (LCY)", '<>0');
        VendorLedgerEntry.SetCurrentKey("Remaining Amt. (LCY)");
        VendorLedgerEntry.Ascending := true;

        PAGE.Run(PAGE::"Vendor Ledger Entries", VendorLedgerEntry);
    end;

    procedure CalcSalesThisMonthAmount(CalledFromWebService: Boolean) Amount: Decimal
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        SetFilterForCalcSalesThisMonthAmount(CustLedgerEntry, CalledFromWebService);
        CustLedgerEntry.CalcSums("Sales (LCY)");
        Amount := CustLedgerEntry."Sales (LCY)";
    end;

    [Scope('OnPrem')]
    procedure SetFilterForCalcSalesThisMonthAmount(var CustLedgerEntry: Record "Cust. Ledger Entry"; CalledFromWebService: Boolean)
    begin
        CustLedgerEntry.SetFilter("Document Type", '%1|%2',
          CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Credit Memo");
        if CalledFromWebService then
            CustLedgerEntry.SetRange("Posting Date", CalcDate('<-CM>', Today), Today)
        else
            CustLedgerEntry.SetRange("Posting Date", CalcDate('<-CM>', GetDefaultWorkDate()), GetDefaultWorkDate());
    end;

    procedure DrillDownSalesThisMonth()
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry.SetFilter("Document Type", '%1|%2',
          CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Credit Memo");
        CustLedgerEntry.SetRange("Posting Date", CalcDate('<-CM>', GetDefaultWorkDate()), GetDefaultWorkDate());
        PAGE.Run(PAGE::"Customer Ledger Entries", CustLedgerEntry);
    end;

    procedure CalcSalesYTD() Amount: Decimal
    var
        AccountingPeriod: Record "Accounting Period";
        [SecurityFiltering(SecurityFilter::Filtered)]
        CustLedgEntrySales: Query "Cust. Ledg. Entry Sales";
    begin
        CustLedgEntrySales.SetRange(Posting_Date, AccountingPeriod.GetFiscalYearStartDate(GetDefaultWorkDate()), GetDefaultWorkDate());
        CustLedgEntrySales.Open;

        if CustLedgEntrySales.Read then
            Amount := CustLedgEntrySales.Sum_Sales_LCY;
    end;

    procedure CalcTop10CustomerSalesYTD() Amount: Decimal
    var
        AccountingPeriod: Record "Accounting Period";
        Top10CustomerSales: Query "Top 10 Customer Sales";
    begin
        // Total Sales (LCY) by top 10 list of customers year-to-date.
        Top10CustomerSales.SetRange(Posting_Date, AccountingPeriod.GetFiscalYearStartDate(GetDefaultWorkDate()), GetDefaultWorkDate());
        Top10CustomerSales.Open;

        while Top10CustomerSales.Read do
            Amount += Top10CustomerSales.Sum_Sales_LCY;
    end;

    procedure CalcTop10CustomerSalesRatioYTD() Amount: Decimal
    var
        TotalSales: Decimal;
    begin
        // Ratio of Sales by top 10 list of customers year-to-date.
        TotalSales := CalcSalesYTD;
        if TotalSales <> 0 then
            Amount := CalcTop10CustomerSalesYTD / TotalSales;
    end;

    procedure CalcAverageCollectionDays() AverageDays: Decimal
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        CustLedgerEntry: Record "Cust. Ledger Entry";
        SumCollectionDays: Integer;
        CountInvoices: Integer;
    begin
        GetPaidSalesInvoices(CustLedgerEntry);
        if CustLedgerEntry.FindSet then begin
            repeat
                SumCollectionDays += (CustLedgerEntry."Closed at Date" - CustLedgerEntry."Posting Date");
                CountInvoices += 1;
            until CustLedgerEntry.Next() = 0;

            AverageDays := SumCollectionDays / CountInvoices;
        end
    end;

    local procedure GetPaidSalesInvoices(var CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange(Open, false);
        CustLedgerEntry.SetRange("Posting Date", CalcDate('<CM-3M>', GetDefaultWorkDate()), GetDefaultWorkDate());
        CustLedgerEntry.SetRange("Closed at Date", CalcDate('<CM-3M>', GetDefaultWorkDate()), GetDefaultWorkDate());
    end;

    procedure CalcCashAccountsBalances() CashAccountBalance: Decimal
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        GLAccount: Record "G/L Account";
        [SecurityFiltering(SecurityFilter::Filtered)]
        GLAccCategory: Record "G/L Account Category";
        [SecurityFiltering(SecurityFilter::Filtered)]
        GLEntries: Record "G/L Entry";
    begin
        GLAccount.SetRange("Account Category", GLAccount."Account Category"::Assets);
        GLAccount.SetRange("Account Type", GLAccount."Account Type"::Posting);
        GLAccount.SetFilter("Account Subcategory Entry No.", CreateFilterForGLAccSubCategoryEntries(GLAccCategory."Additional Report Definition"::"Cash Accounts"));
        GLEntries.SetFilter("G/L Account No.", CreateFilterForGLAccounts(GLAccount));
        GLEntries.CalcSums(Amount);
        CashAccountBalance := GLEntries.Amount;
    end;

    procedure DrillDownCalcCashAccountsBalances()
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        GLAccount: Record "G/L Account";
        [SecurityFiltering(SecurityFilter::Filtered)]
        GLAccCategory: Record "G/L Account Category";
    begin
        GLAccount.SetRange("Account Category", GLAccount."Account Category"::Assets);
        GLAccount.SetRange("Account Type", GLAccount."Account Type"::Posting);
        TestifSubCategoryIsSpecifield();
        GLAccount.SetFilter("Account Subcategory Entry No.", CreateFilterForGLAccSubCategoryEntries(GLAccCategory."Additional Report Definition"::"Cash Accounts"));
        PAGE.Run(PAGE::"Chart of Accounts", GLAccount);
    end;

    local procedure TestifSubCategoryIsSpecifield();
    var
        GLAccCategory: Record "G/L Account Category";
    begin
        GLAccCategory.setrange("Additional Report Definition", GlaccCategory."Additional Report Definition"::"Cash Accounts");
        if GLAccCategory.IsEmpty() then
            Message(NoSubCategoryWithAdditionalReportDefinitionOfCashAccountsTok,
              GLAccCategory.TableCaption, GLAccCategory.FieldCaption("Additional Report Definition"),
              GLAccCategory."Additional Report Definition"::"Cash Accounts");
    end;

    local procedure RefreshActivitiesCueData()
    var
        ActivitiesCue: Record "Activities Cue";
    begin
        ActivitiesCue.LockTable();

        ActivitiesCue.Get();

        if not IsPassedCueData(ActivitiesCue) then
            exit;

        ActivitiesCue.SetFilter("Due Date Filter", '>=%1', GetDefaultWorkDate());
        ActivitiesCue.SetFilter("Overdue Date Filter", '<%1', GetDefaultWorkDate());
        ActivitiesCue.SetFilter("Due Next Week Filter", '%1..%2', CalcDate('<1D>', GetDefaultWorkDate()), CalcDate('<1W>', GetDefaultWorkDate()));

        if ActivitiesCue.FieldActive("Overdue Sales Invoice Amount") then
            ActivitiesCue."Overdue Sales Invoice Amount" := OverdueSalesInvoiceAmount(false, false);

        if ActivitiesCue.FieldActive("Overdue Purch. Invoice Amount") then
            ActivitiesCue."Overdue Purch. Invoice Amount" := OverduePurchaseInvoiceAmount(false, false);

        if ActivitiesCue.FieldActive("Sales This Month") then
            ActivitiesCue."Sales This Month" := CalcSalesThisMonthAmount(false);

        if ActivitiesCue.FieldActive("Average Collection Days") then
            ActivitiesCue."Average Collection Days" := CalcAverageCollectionDays;

        ActivitiesCue."Last Date/Time Modified" := CurrentDateTime;
        ActivitiesCue.Modify();
        Commit();
    end;

    [Scope('OnPrem')]
    procedure IsCueDataStale(): Boolean
    var
        ActivitiesCue: Record "Activities Cue";
    begin
        if not ActivitiesCue.Get then
            exit(false);

        exit(IsPassedCueData(ActivitiesCue));
    end;

    local procedure IsPassedCueData(ActivitiesCue: Record "Activities Cue"): Boolean
    begin
        if ActivitiesCue."Last Date/Time Modified" = 0DT then
            exit(true);

        exit(CurrentDateTime - ActivitiesCue."Last Date/Time Modified" >= GetActivitiesCueRefreshInterval)
    end;

    local procedure GetDefaultWorkDate(): Date
    var
        LogInManagement: Codeunit LogInManagement;
    begin
        if DefaultWorkDate = 0D then
            DefaultWorkDate := LogInManagement.GetDefaultWorkDate;
        exit(DefaultWorkDate);
    end;

    local procedure GetActivitiesCueRefreshInterval() Interval: Duration
    var
        MinInterval: Duration;
    begin
        MinInterval := 10 * 60 * 1000; // 10 minutes
        Interval := 60 * 60 * 1000; // 1 hr
        OnGetRefreshInterval(Interval);
        if Interval < MinInterval then
            Error(RefreshFrequencyErr);
    end;

    local procedure CreateFilterForGLAccSubCategoryEntries(AddRepDef: Option): Text
    var
        GLAccCategory: Record "G/L Account Category";
        FilterOperand: Char;
        FilterTxt: Text;
    begin
        FilterOperand := '|';
        with GLAccCategory do begin
            GLAccCategory.SetRange("Additional Report Definition", AddRepDef);
            if GLAccCategory.FindSet() then begin
                repeat
                    if FilterTxt = '' then
                        FilterTxt := Format("Entry No.") + FilterOperand
                    else
                        FilterTxt := FilterTxt + Format("Entry No.") + FilterOperand;
                until GLAccCategory.Next() = 0;
            end;
        end;
        // Remove the last |
        exit(DelChr(FilterTxt, '>', FilterOperand));
    end;

    local procedure CreateFilterForGLAccounts(var GLAccount: Record "G/L Account"): Text
    var
        FilterOperand: Char;
        FilterTxt: Text;
    begin
        FilterOperand := '|';
        with GLAccount do begin
            if GLAccount.FindSet() then begin
                repeat
                    if FilterTxt = '' then
                        FilterTxt := Format("No.") + FilterOperand
                    else
                        FilterTxt := FilterTxt + Format("No.") + FilterOperand;
                until GLAccount.Next() = 0;
            end;
        end;
        // Remove the last |
        exit(DelChr(FilterTxt, '>', FilterOperand));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDrillDownCalcOverdueSalesInvoiceAmount(var CustLedgerEntry: Record "Cust. Ledger Entry"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSetFilterOverdueSalesInvoice(var CustLedgerEntry: Record "Cust. Ledger Entry"; CalledFromWebService: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnGetRefreshInterval(var Interval: Duration)
    begin
    end;
}

