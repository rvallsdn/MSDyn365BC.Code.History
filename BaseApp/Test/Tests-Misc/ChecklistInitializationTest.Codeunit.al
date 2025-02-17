codeunit 132606 "Checklist Initialization Test"
{
    Subtype = Test;

    var
        Assert: Codeunit Assert;
        LibraryLowerPermissions: Codeunit "Library - Lower Permissions";

    [Test]
    [Scope('OnPrem')]
    procedure TestChecklistInitialization()
    var
        GuidedExperienceTestLibrary: Codeunit "Guided Experience Test Library";
        ChecklistTestLibrary: Codeunit "Checklist Test Library";
        ChecklistSetupTestLibrary: Codeunit "Checklist Setup Test Library";
        TestClientTypeSubscriber: Codeunit "Test Client Type Subscriber";
        CompanyTriggers: Codeunit "Company Triggers";
    begin
        // [GIVEN] The client type is set to Web
        TestClientTypeSubscriber.SetClientType(ClientType::Web);

        // [GIVEN] The company type is non-evaluation
        SetEvaluationPropertyForCompany(false);

        LibraryLowerPermissions.SetOutsideO365Scope();

        // [GIVEN] The Checklist Setup table is empty
        ChecklistSetupTestLibrary.DeleteAll();

        // [GIVEN] The Guided Experience Item and Checklist Item tables are empty
        GuidedExperienceTestLibrary.DeleteAll();
        ChecklistTestLibrary.DeleteAll();

        LibraryLowerPermissions.SetO365Basic();

        // [WHEN] Calling OnCompanyOpen
        CompanyTriggers.OnCompanyOpen();

        // [THEN] The checklist setup should be marked as done
        Assert.IsTrue(ChecklistSetupTestLibrary.IsChecklistSetupDone(),
            'The checklist setup should be done.');

        // [THEN] The guided experience item table should be populated
        Assert.AreNotEqual(0, GuidedExperienceTestLibrary.GetCount(),
            'The Guided Experience Item table should no longer be empty.');

        // [THEN] The checklist item table should contain the correct number of entries
        Assert.AreEqual(7, ChecklistTestLibrary.GetCount(),
            'The Checklist Item table contains the wrong number of entries.');

        // [THEN] Verify that the checklist items were created for the right objects
        VerifyChecklistItems();
    end;

    local procedure SetEvaluationPropertyForCompany(IsEvaluationCompany: Boolean)
    var
        Company: Record Company;
    begin
        Company.Get(CompanyName());

        Company."Evaluation Company" := IsEvaluationCompany;
        Company.Modify();
    end;

    local procedure VerifyChecklistItems()
    var
        ChecklistTestLibrary: Codeunit "Checklist Test Library";
        GuidedExperienceType: Enum "Guided Experience Type";
        BusinessManagerProfileID: Code[30];
    begin
        BusinessManagerProfileID := GetProfileID(Page::"Business Manager Role Center");

        Assert.IsTrue(ChecklistTestLibrary.ChecklistItemExists(GuidedExperienceType::"Assisted Setup",
            ObjectType::Page, Page::"Assisted Company Setup Wizard", BusinessManagerProfileID),
            'The checklist item for the Assisted Company Setup Wizard was not created.');

        Assert.IsTrue(ChecklistTestLibrary.ChecklistItemExists(GuidedExperienceType::"Assisted Setup",
            ObjectType::Page, Page::"Azure AD User Update Wizard", BusinessManagerProfileID),
            'The checklist item for the Azure AD User Update Wizard was not created.');

        Assert.IsTrue(ChecklistTestLibrary.ChecklistItemExists(GuidedExperienceType::"Manual Setup",
            ObjectType::Page, Page::Users, BusinessManagerProfileID),
            'The checklist item for the Users page was not created.');

        Assert.IsTrue(ChecklistTestLibrary.ChecklistItemExists(GuidedExperienceType::"Manual Setup",
            ObjectType::Page, Page::"User Settings List", BusinessManagerProfileID),
            'The checklist item for the User Personalization List page was not created.');

        Assert.IsTrue(ChecklistTestLibrary.ChecklistItemExists(GuidedExperienceType::"Assisted Setup",
            ObjectType::Page, Page::"Email Account Wizard", BusinessManagerProfileID),
            'The checklist item for the Email Account Wizard was not created.');

        Assert.IsTrue(ChecklistTestLibrary.ChecklistItemExists(GuidedExperienceType::"Assisted Setup",
            ObjectType::Page, Page::"Data Migration Wizard", BusinessManagerProfileID),
            'The checklist item for the Data Migration Wizard was not created.');

        Assert.IsTrue(ChecklistTestLibrary.ChecklistItemExists(GuidedExperienceType::Learn,
            'https://go.microsoft.com/fwlink/?linkid=2152979', BusinessManagerProfileID),
            'The checklist item for the Microsoft Learn link was not created.');
    end;

    local procedure GetProfileID(RoleCenterID: Integer): Code[30]
    var
        AllProfile: Record "All Profile";
    begin
        AllProfile.SetRange("Role Center ID", RoleCenterID);
        if AllProfile.FindFirst() then
            exit(AllProfile."Profile ID");
    end;
}