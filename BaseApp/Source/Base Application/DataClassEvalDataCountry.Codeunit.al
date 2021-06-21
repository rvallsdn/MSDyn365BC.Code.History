codeunit 1752 "Data Class. Eval. Data Country"
{

    trigger OnRun()
    begin
    end;

    procedure ClassifyCountrySpecificTables()
    var
        DataClassificationEvalData: Codeunit "Data Classification Eval. Data";
    begin
        ClassifyEmployee;
        ClassifyPayableEmployeeLedgerEntry;
        ClassifyDetailedEmployeeLedgerEntry;
        ClassifyEmployeeLedgerEntry;
        ClassifyEmployeeRelative;
        ClassifyEmployeeQualification;
        ClassifyVATReportHeader;
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Employee Posting Group");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Cause of Absence");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Payment Day");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Non-Payment Period");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"AEAT Transference Format");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Statistical Code");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"AEAT Transference Format XML");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"G/L Accounts Equivalence Tool");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Historic G/L Account");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"New G/L Account");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"G/L Acc. Equiv. Tool Setup");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"History of Equivalences COA");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Hist. G/L Account (An. View)");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Selected G/L Accounts");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Selected Gen. Prod. Post. Gr.");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Customer/Vendor Warning 349");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Selected Gen. Prod. Post. 340");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Selected Rev. Charge Grp. 340");
        DataClassificationEvalData.SetTableFieldsToNormal(10744); // 340 Declaration Line
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Operation Code");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"SII History");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"SII Setup");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"SII Doc. Upload State");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"SII Session");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"SII Sales Document Scheme Code");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"SII Purch. Doc. Scheme Code");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Cartera Doc.");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Posted Cartera Doc.");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Closed Cartera Doc.");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Bill Group");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Posted Bill Group");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Closed Bill Group");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"BG/PO Comment Line");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Category Code");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Operation Fee");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Cartera Report Selections");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Customer Pmt. Address");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Vendor Pmt. Address");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Cartera Setup");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::Installment);
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Fee Range");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Payment Order");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Posted Payment Order");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Closed Payment Order");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Customer Rating");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::Suffix);
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"SII Missing Entries State");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"No Taxable Entry");
        DataClassificationEvalData.SetTableFieldsToNormal(DATABASE::"Sales Header Archive");
    end;

    local procedure ClassifyPayableEmployeeLedgerEntry()
    var
        DummyPayableEmployeeLedgerEntry: Record "Payable Employee Ledger Entry";
        DataClassificationMgt: Codeunit "Data Classification Mgt.";
        TableNo: Integer;
    begin
        TableNo := DATABASE::"Payable Employee Ledger Entry";
        DataClassificationMgt.SetTableFieldsToNormal(TableNo);
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyPayableEmployeeLedgerEntry.FieldNo(Positive));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyPayableEmployeeLedgerEntry.FieldNo("Currency Code"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyPayableEmployeeLedgerEntry.FieldNo(Amount));
        DataClassificationMgt.SetFieldToCompanyConfidential(
          TableNo, DummyPayableEmployeeLedgerEntry.FieldNo("Employee Ledg. Entry No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyPayableEmployeeLedgerEntry.FieldNo("Entry No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyPayableEmployeeLedgerEntry.FieldNo("Employee No."));
    end;

    local procedure ClassifyDetailedEmployeeLedgerEntry()
    var
        DummyDetailedEmployeeLedgerEntry: Record "Detailed Employee Ledger Entry";
        DataClassificationMgt: Codeunit "Data Classification Mgt.";
        TableNo: Integer;
    begin
        TableNo := DATABASE::"Detailed Employee Ledger Entry";
        DataClassificationMgt.SetTableFieldsToNormal(TableNo);
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Ledger Entry Amount"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Application No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(
          TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Unapplied by Entry No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo(Unapplied));
        DataClassificationMgt.SetFieldToCompanyConfidential(
          TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Applied Empl. Ledger Entry No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(
          TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Initial Document Type"));
        DataClassificationMgt.SetFieldToCompanyConfidential(
          TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Initial Entry Global Dim. 2"));
        DataClassificationMgt.SetFieldToCompanyConfidential(
          TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Initial Entry Global Dim. 1"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Credit Amount (LCY)"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Debit Amount (LCY)"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Credit Amount"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Debit Amount"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Reason Code"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Journal Batch Name"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Transaction No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Source Code"));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("User ID"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Currency Code"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Employee No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Amount (LCY)"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo(Amount));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Document No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Document Type"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Posting Date"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Entry Type"));
        DataClassificationMgt.SetFieldToCompanyConfidential(
          TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Employee Ledger Entry No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyDetailedEmployeeLedgerEntry.FieldNo("Entry No."));
    end;

    local procedure ClassifyEmployeeLedgerEntry()
    var
        DummyEmployeeLedgerEntry: Record "Employee Ledger Entry";
        DataClassificationMgt: Codeunit "Data Classification Mgt.";
        TableNo: Integer;
    begin
        TableNo := DATABASE::"Employee Ledger Entry";
        DataClassificationMgt.SetTableFieldsToNormal(TableNo);
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Applying Entry"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Amount to Apply"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Payment Method Code"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Payment Reference"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Creditor No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("No. Series"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Message to Recipient"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Closed by Amount (LCY)"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Transaction No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Bal. Account No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Bal. Account Type"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Reason Code"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Journal Batch Name"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Applies-to ID"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Closed by Amount"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Closed at Date"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Closed by Entry No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo(Positive));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo(Open));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Applies-to Doc. No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Applies-to Doc. Type"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Source Code"));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployeeLedgerEntry.FieldNo("User ID"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Salespers./Purch. Code"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Global Dimension 2 Code"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Global Dimension 1 Code"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Employee Posting Group"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Dimension Set ID"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Currency Code"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Exported to Payment File"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo(Description));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Document No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Document Type"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Posting Date"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Employee No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeLedgerEntry.FieldNo("Entry No."));
    end;

    local procedure ClassifyEmployeeRelative()
    var
        DummyEmployeeRelative: Record "Employee Relative";
        DataClassificationMgt: Codeunit "Data Classification Mgt.";
        TableNo: Integer;
    begin
        TableNo := DATABASE::"Employee Relative";
        DataClassificationMgt.SetTableFieldsToNormal(TableNo);
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeRelative.FieldNo("Relative's Employee No."));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployeeRelative.FieldNo("Phone No."));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployeeRelative.FieldNo("Birth Date"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeRelative.FieldNo("Relative Code"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeRelative.FieldNo("Line No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeRelative.FieldNo("Employee No."));
    end;

    local procedure ClassifyEmployeeQualification()
    var
        DummyEmployeeQualification: Record "Employee Qualification";
        DataClassificationMgt: Codeunit "Data Classification Mgt.";
        TableNo: Integer;
    begin
        TableNo := DATABASE::"Employee Qualification";
        DataClassificationMgt.SetTableFieldsToNormal(TableNo);
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeQualification.FieldNo("Expiration Date"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeQualification.FieldNo("Employee Status"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeQualification.FieldNo("Course Grade"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeQualification.FieldNo(Cost));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeQualification.FieldNo("Institution/Company"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeQualification.FieldNo(Description));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeQualification.FieldNo(Type));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeQualification.FieldNo("To Date"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeQualification.FieldNo("From Date"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeQualification.FieldNo("Qualification Code"));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeQualification.FieldNo("Line No."));
        DataClassificationMgt.SetFieldToCompanyConfidential(TableNo, DummyEmployeeQualification.FieldNo("Employee No."));
    end;

    local procedure ClassifyEmployee()
    var
        DummyEmployee: Record Employee;
        DataClassificationMgt: Codeunit "Data Classification Mgt.";
        TableNo: Integer;
    begin
        TableNo := DATABASE::Employee;
        DataClassificationMgt.SetTableFieldsToNormal(TableNo);
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo(Image));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo(IBAN));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo("Bank Account No."));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo("Bank Branch No."));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo("Company E-Mail"));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo("Fax No."));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo(Pager));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo(Extension));
        DataClassificationMgt.SetFieldToSensitive(TableNo, DummyEmployee.FieldNo("Termination Date"));
        DataClassificationMgt.SetFieldToSensitive(TableNo, DummyEmployee.FieldNo("Inactive Date"));
        DataClassificationMgt.SetFieldToSensitive(TableNo, DummyEmployee.FieldNo(Status));
        DataClassificationMgt.SetFieldToSensitive(TableNo, DummyEmployee.FieldNo("Employment Date"));
        DataClassificationMgt.SetFieldToSensitive(TableNo, DummyEmployee.FieldNo(Gender));
        DataClassificationMgt.SetFieldToSensitive(TableNo, DummyEmployee.FieldNo("Union Membership No."));
        DataClassificationMgt.SetFieldToSensitive(TableNo, DummyEmployee.FieldNo("Union Code"));
        DataClassificationMgt.SetFieldToSensitive(TableNo, DummyEmployee.FieldNo("Social Security No."));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo("Birth Date"));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo(Picture));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo("E-Mail"));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo("Mobile Phone No."));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo("Phone No."));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo(County));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo("Post Code"));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo(City));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo("Address 2"));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo(Address));
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyEmployee.FieldNo("Search Name"));
    end;

    local procedure ClassifyVATReportHeader()
    var
        DummyVATReportHeader: Record "VAT Report Header";
        DataClassificationMgt: Codeunit "Data Classification Mgt.";
        TableNo: Integer;
    begin
        TableNo := DATABASE::"VAT Report Header";
        DataClassificationMgt.SetTableFieldsToNormal(TableNo);
        DataClassificationMgt.SetFieldToPersonal(TableNo, DummyVATReportHeader.FieldNo("Submitted By"));
        DataClassificationMgt.SetTableFieldsToNormal(DATABASE::"VAT Return Period");
    end;
}

