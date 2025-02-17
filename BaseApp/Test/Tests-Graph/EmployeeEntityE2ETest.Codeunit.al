#if not CLEAN18
codeunit 135527 "Employee Entity E2E Test"
{
    Subtype = Test;
    TestPermissions = Disabled;

    trigger OnRun()
    begin
        // [FEATURE] [Graph] [Employee]
    end;

    var
        LibraryHumanResource: Codeunit "Library - Human Resource";
        Assert: Codeunit Assert;
        LibraryGraphMgt: Codeunit "Library - Graph Mgt";
        LibraryUtility: Codeunit "Library - Utility";
        IsInitialized: Boolean;
        ServiceNameTxt: Label 'employees';
        EmptyJSONErr: Label 'The JSON should not be blank.';
        WrongPropertyValueErr: Label 'Incorrect property value for %1.';

    local procedure Initialize()
    var
        LibraryApplicationArea: Codeunit "Library - Application Area";
    begin
        LibraryApplicationArea.EnableBasicHRSetup;

        // Lazy Setup.
        if IsInitialized then
            exit;

        LibraryHumanResource.SetupEmployeeNumberSeries;

        IsInitialized := true;
        Commit();
    end;

    [Test]
    [Scope('OnPrem')]
    procedure TestGetEmployee()
    var
        Employee: Record Employee;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        ResponseText: Text;
        TargetURL: Text;
    begin
        // [SCENARIO] User can get an Employee with a GET request to the service.
        Initialize;

        NoSeriesManagement.GetNextNo(LibraryHumanResource.SetupEmployeeNumberSeries, WorkDate, true);

        // [GIVEN] An Employee exists in the system.
        CreateEmployee(Employee);

        // [WHEN] The user makes a GET request for a given Employee.
        TargetURL := LibraryGraphMgt.CreateTargetURL(Employee.SystemId, PAGE::"Employee Entity", ServiceNameTxt);
        LibraryGraphMgt.GetFromWebService(ResponseText, TargetURL);

        // [THEN] The response text contains the employee information.
        VerifyEmployeeSimpleProperties(ResponseText, Employee);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure TestCreateEmployee()
    var
        Employee: Record Employee;
        TempEmployee: Record Employee temporary;
        EmployeeJSON: Text;
        ResponseText: Text;
        TargetURL: Text;
    begin
        // [SCENARIO] Create an Employee through a POST method and check if it was created
        Initialize;

        // [GIVEN] The user has constructed a simple Employee JSON object to send to the service.
        EmployeeJSON := GetEmployeeJSON(TempEmployee);

        // [WHEN] The user posts the JSON to the service.
        TargetURL := LibraryGraphMgt.CreateTargetURL('', PAGE::"Employee Entity", ServiceNameTxt);
        LibraryGraphMgt.PostToWebService(TargetURL, EmployeeJSON, ResponseText);

        // [THEN] The response text contains the Employee information.
        VerifyEmployeeSimpleProperties(ResponseText, TempEmployee);

        // [THEN] The Employee has been created in the database.
        Employee.Get(TempEmployee."No.");
        VerifyEmployeeSimpleProperties(ResponseText, Employee);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure TestModifyEmployee()
    var
        Employee: Record Employee;
        TempEmployee: Record Employee temporary;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        RequestBody: Text;
        ResponseText: Text;
        TargetURL: Text;
    begin
        // [SCENARIO] User can modify an Employee through a PATCH request.
        Initialize;

        NoSeriesManagement.GetNextNo(LibraryHumanResource.SetupEmployeeNumberSeries, WorkDate, true);

        // [GIVEN] An Employee exists.
        CreateEmployee(Employee);
        TempEmployee.TransferFields(Employee);
        TempEmployee."E-Mail" := LibraryUtility.GenerateGUID;
        RequestBody := GetEmployeeJSON(TempEmployee);

        // [WHEN] The user makes a patch request to the service.
        TargetURL := LibraryGraphMgt.CreateTargetURL(Employee.SystemId, PAGE::"Employee Entity", ServiceNameTxt);
        LibraryGraphMgt.PatchToWebService(TargetURL, RequestBody, ResponseText);

        // [THEN] The response text contains the new values.
        VerifyEmployeeSimpleProperties(ResponseText, TempEmployee);

        // [THEN] The record in the database contains the new values.
        Employee.Get(Employee."No.");
        VerifyEmployeeSimpleProperties(ResponseText, Employee);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure TestDeleteEmployee()
    var
        Employee: Record Employee;
        EmployeeNo: Code[20];
        TargetURL: Text;
        Responsetext: Text;
    begin
        // [SCENARIO 201343] User can delete an Employee by making a DELETE request.
        Initialize;

        // [GIVEN] An Employee exists.
        CreateEmployee(Employee);
        EmployeeNo := Employee."No.";

        // [WHEN] The user makes a DELETE request to the endpoint for the Employee.
        TargetURL := LibraryGraphMgt.CreateTargetURL(Employee.SystemId, PAGE::"Employee Entity", ServiceNameTxt);
        LibraryGraphMgt.DeleteFromWebService(TargetURL, '', Responsetext);

        // [THEN] The response is empty.
        Assert.AreEqual('', Responsetext, 'DELETE response should be empty.');

        // [THEN] The Employee is no longer in the database.
        Assert.IsFalse(Employee.Get(EmployeeNo), 'Employee should be deleted.');
    end;

    local procedure CreateEmployee(var Employee: Record Employee)
    begin
        LibraryHumanResource.CreateEmployee(Employee);
        Commit();
    end;

    local procedure VerifyEmployeeSimpleProperties(EmployeeJSON: Text; Employee: Record Employee)
    begin
        Assert.AreNotEqual('', EmployeeJSON, EmptyJSONErr);
        LibraryGraphMgt.VerifyIDInJson(EmployeeJSON);
        VerifyPropertyInJSON(EmployeeJSON, 'number', Employee."No.");
        VerifyPropertyInJSON(EmployeeJSON, 'givenName', Employee."First Name");
        VerifyPropertyInJSON(EmployeeJSON, 'surname', Employee."Last Name");
    end;

    local procedure VerifyPropertyInJSON(JSON: Text; PropertyName: Text; ExpectedValue: Text)
    var
        PropertyValue: Text;
    begin
        LibraryGraphMgt.GetObjectIDFromJSON(JSON, PropertyName, PropertyValue);
        Assert.AreEqual(ExpectedValue, PropertyValue, StrSubstNo(WrongPropertyValueErr, PropertyName));
    end;

    local procedure GetEmployeeJSON(var Employee: Record Employee) EmployeeJSON: Text
    var
        JSONManagement: Codeunit "JSON Management";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        JsonObject: DotNet JObject;
    begin
        JSONManagement.InitializeEmptyObject;
        JSONManagement.GetJSONObject(JsonObject);
        if Employee."No." = '' then
            Employee."No." := NoSeriesManagement.GetNextNo(LibraryHumanResource.SetupEmployeeNumberSeries, WorkDate, false);
        if Employee."First Name" = '' then
            Employee."First Name" := Employee."No.";
        JSONManagement.AddJPropertyToJObject(JsonObject, 'number', Employee."No.");
        JSONManagement.AddJPropertyToJObject(JsonObject, 'givenName', Employee."First Name");
        EmployeeJSON := JSONManagement.WriteObjectToString;
    end;
}
#endif
