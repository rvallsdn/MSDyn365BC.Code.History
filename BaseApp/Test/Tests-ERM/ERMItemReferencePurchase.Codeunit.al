codeunit 134464 "ERM Item Reference Purchase"
{
    Subtype = Test;
    TestPermissions = Disabled;

    trigger OnRun()
    begin
        // [FEATURE] [Item Reference] [Reference No] [Purchase]
    end;

    var
        LibraryPurchase: Codeunit "Library - Purchase";
        LibraryInventory: Codeunit "Library - Inventory";
        LibraryItemReference: Codeunit "Library - Item Reference";
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        LibraryUtility: Codeunit "Library - Utility";
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
        Assert: Codeunit Assert;
        ItemReferenceMgt: Codeunit "Item Reference Management";
        ItemRefNotExistsErr: Label 'There are no items with reference %1.';
        DialogCodeErr: Label 'Dialog';
        ConfirmCopyTxt: Label 'There are %1 filtered records in Item Cross Reference table. Do you want to copy them?', Comment = '%1 - a number';
        FinalMessageTxt: Label '%1 of %2 records were copied.', Comment = '%1 and %2 - numbers';
        isInitialized: Boolean;

    [Test]
    [HandlerFunctions('ItemReferenceListModalPageHandler')]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenSameVendorsForSameItemsAndBarCodeShowDialogTrue()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        VendorNo: array[2] of Code[20];
        ItemRefNo: Code[50];
        Index: Integer;
        ItemIndex: Integer;
        ItemNo: array[2] of Code[20];
    begin
        // [FEATURE] [UI] [Bar Code]
        // [SCENARIO 289240] Vendors: A,B, Items: X,Y,Z, Vendor Item References: AX, AY, BX, BY and Bar Code Reference PZ
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is Yes
        // [SCENARIO 289240] Page Item Reference List shows only Item References for Vendor A and Bar Code (AX, AY and PZ)
        Initialize();
        for ItemIndex := 1 to ArrayLen(ItemNo) do begin
            ItemNo[ItemIndex] := LibraryInventory.CreateItemNo;
            VendorNo[ItemIndex] := LibraryPurchase.CreateVendorNo;
        end;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");
        LibraryVariableStorage.Enqueue(ItemRefNo);

        // [GIVEN] Two Item Item References for Item 1000 with No = 1234, Type = Vendor and Type No = 10000 and 20000
        // [GIVEN] Two similar Item Item References for Item 1001
        for ItemIndex := 1 to ArrayLen(ItemNo) do begin
            for Index := 1 to ArrayLen(ItemReference) do
                LibraryItemReference.CreateItemReferenceWithNo(ItemReference[Index], ItemRefNo, ItemNo[ItemIndex],
                  ItemReference[Index]."Reference Type"::Vendor, VendorNo[Index]);
            EnqueueItemReferenceFields(ItemReference[1]);
        end;

        // [GIVEN] Item Reference for Item 1100 with No = 1234, Type = Bar Code
        LibraryItemReference.CreateItemReferenceWithNo(
          ItemReference[2], ItemRefNo, LibraryInventory.CreateItemNo, ItemReference[2]."Reference Type"::"Bar Code",
          LibraryUtility.GenerateGUID);
        EnqueueItemReferenceFields(ItemReference[2]);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, VendorNo[1], ItemRefNo);

        // [GIVEN] Ran ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[1], true);

        // [GIVEN] Page Item Reference List opened showing three Item References:
        // [GIVEN] Two with Type Vendor and Type No = 10000 and last one with Type Bar Code, Stan selected the last one
        // Done in ItemReferenceListModalPageHandler

        // [WHEN] Push OK on page Item Reference List
        // Done in ItemReferenceListModalPageHandler

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1100
        ItemReference[1].TestField("Item No.", ItemReference[2]."Item No.");
        LibraryVariableStorage.AssertEmpty;
    end;

    [Test]
    [HandlerFunctions('ItemReferenceListModalPageHandler')]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenSameVendorsForSameItemsShowDialogTrue()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        VendorNo: array[2] of Code[20];
        ItemRefNo: Code[50];
        Index: Integer;
        ItemIndex: Integer;
        ItemNo: array[2] of Code[20];
    begin
        // [FEATURE] [UI]
        // [SCENARIO 289240] Vendors: A,B, Items: X,Y, Item References: AX, AY, BX, BY
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is Yes
        // [SCENARIO 289240] Page Item Reference List shows only Item References for Vendor A (AX and AY)
        Initialize();
        for ItemIndex := 1 to ArrayLen(ItemNo) do begin
            ItemNo[ItemIndex] := LibraryInventory.CreateItemNo;
            VendorNo[ItemIndex] := LibraryPurchase.CreateVendorNo;
        end;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");
        LibraryVariableStorage.Enqueue(ItemRefNo);

        // [GIVEN] Two Item Item References for Item 1000 with No = 1234, Type = Vendor and Type No = 10000 and 20000
        // [GIVEN] Two similar Item Item References for Item 1001
        for ItemIndex := 1 to ArrayLen(ItemNo) do begin
            for Index := 1 to ArrayLen(ItemReference) do
                LibraryItemReference.CreateItemReferenceWithNo(ItemReference[Index], ItemRefNo, ItemNo[ItemIndex],
                  ItemReference[Index]."Reference Type"::Vendor, VendorNo[Index]);
            EnqueueItemReferenceFields(ItemReference[1]);
        end;

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, VendorNo[1], ItemRefNo);

        // [GIVEN] Ran ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[1], true);

        // [GIVEN] Page Item Reference List opened showing two Item References with Type No = 10000, first for Item 1000, second for Item 1001
        // [GIVEN] Stan selected the second one
        // Done in ItemReferenceListModalPageHandler

        // [WHEN] Push OK on page Item Reference List
        // Done in ItemReferenceListModalPageHandler

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1001
        ItemReference[1].TestField("Item No.", ItemReference[2]."Item No.");
        LibraryVariableStorage.AssertEmpty;
    end;

    [Test]
    [HandlerFunctions('ItemReferenceListModalPageHandler')]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenVendorAndBarCodeDifferentItemsShowDialogTrue()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        VendorNo: Code[20];
        ItemRefNo: Code[50];
    begin
        // [FEATURE] [UI] [Bar Code]
        // [SCENARIO 289240] Vendor A, Items: X,Y Vendor Reference AX and Bar Code Reference PY
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is Yes
        // [SCENARIO 289240] Page Item Reference List shows both Item References (AX and PY)
        Initialize();
        VendorNo := LibraryPurchase.CreateVendorNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");
        LibraryVariableStorage.Enqueue(ItemRefNo);

        // [GIVEN] Item Item References for Item 1000 with No = 1234, Type = Vendor and Type No = 10000
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[1], ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference[1]."Reference Type"::Vendor, VendorNo);
        EnqueueItemReferenceFields(ItemReference[1]);

        // [GIVEN] Item Item References for Item 1001 with same No and Type = Bar Code
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[2], ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference[2]."Reference Type"::"Bar Code", LibraryUtility.GenerateGUID);
        EnqueueItemReferenceFields(ItemReference[2]);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, VendorNo, ItemRefNo);

        // [GIVEN] Ran ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[1], true);

        // [GIVEN] Page Item Reference List opened showing both Item References, first for Item 1000, second for Item 1001
        // [GIVEN] Stan selected the second one
        // Done in ItemReferenceListModalPageHandler

        // [WHEN] Push OK on page Item Reference List
        // Done in ItemReferenceListModalPageHandler

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1001
        ItemReference[1].TestField("Item No.", ItemReference[2]."Item No.");
        LibraryVariableStorage.AssertEmpty;
    end;

    [Test]
    [HandlerFunctions('ItemReferenceListModalPageHandler')]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenVendorAndBlankTypeDifferentItemsShowDialogTrue()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        VendorNo: Code[20];
        ItemRefNo: Code[50];
    begin
        // [FEATURE] [UI] [Bar Code]
        // [SCENARIO 289240] Vendor A, Items: X,Y Vendor Reference AX and <blank> Type Reference TY
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is Yes
        // [SCENARIO 289240] Page Item Reference List shows both Item References (AX and TY)
        Initialize();
        VendorNo := LibraryPurchase.CreateVendorNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");
        LibraryVariableStorage.Enqueue(ItemRefNo);

        // [GIVEN] Item Item References for Item 1000 with No = 1234, Type = Vendor and Type No = 10000
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[1], ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference[1]."Reference Type"::Vendor, VendorNo);

        // [GIVEN] Item Item References for Item 1001 with No = 1234 and Type = <blank>
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[2], ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference[2]."Reference Type"::" ", '');
        EnqueueItemReferenceFields(ItemReference[2]); // <blank> type record is to be displayed first
        EnqueueItemReferenceFields(ItemReference[1]);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, VendorNo, ItemRefNo);

        // [GIVEN] Ran ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], true);

        // [GIVEN] Page Item Reference List opened showing both Item References, first with <blank> Type, second with Type Vendor
        // [GIVEN] Stan selected the second one
        // Done in ItemReferenceListModalPageHandler

        // [WHEN] Push OK on page Item Reference List
        // Done in ItemReferenceListModalPageHandler

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1000
        ItemReference[2].TestField("Item No.", ItemReference[1]."Item No.");
        LibraryVariableStorage.AssertEmpty;
    end;

    [Test]
    [HandlerFunctions('ItemReferenceListModalPageHandler')]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenSameVendorDifferentItemsShowDialogTrue()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        VendorNo: Code[20];
        ItemRefNo: Code[50];
        Index: Integer;
    begin
        // [FEATURE] [UI]
        // [SCENARIO 289240] Vendor A, Items: X,Y Item References AX and AY
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is Yes
        // [SCENARIO 289240] Page Item Reference List shows both Item References (AX and AY)
        Initialize();
        VendorNo := LibraryPurchase.CreateVendorNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");
        LibraryVariableStorage.Enqueue(ItemRefNo);

        // [GIVEN] Item Item References for Items 1000 and 1001 with same No = 1234, Type = Vendor and Type No = 10000
        for Index := 1 to ArrayLen(ItemReference) do begin
            LibraryItemReference.CreateItemReferenceWithNo(ItemReference[Index], ItemRefNo, LibraryInventory.CreateItemNo,
              ItemReference[Index]."Reference Type"::Vendor, VendorNo);
            EnqueueItemReferenceFields(ItemReference[Index]);
        end;

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, VendorNo, ItemRefNo);

        // [GIVEN] Ran ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[1], true);

        // [GIVEN] Page Item Reference List opened showing both Item References: first for Item 1000, second for Item 1001
        // [GIVEN] Stan selected the second one
        // Done in ItemReferenceListModalPageHandler

        // [WHEN] Push OK on page Item Reference List
        // Done in ItemReferenceListModalPageHandler

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1001
        ItemReference[1].TestField("Item No.", ItemReference[2]."Item No.");
        LibraryVariableStorage.AssertEmpty;
    end;

    [Test]
    [HandlerFunctions('ItemReferenceListModalPageHandler')]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenBarCodesDifferentItemsShowDialogTrue()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
        Index: Integer;
    begin
        // [FEATURE] [UI] [Bar Code]
        // [SCENARIO 289240] Items: X,Y, Bar Code Item References: PX,PY
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor and ShowDialog is Yes
        // [SCENARIO 289240] Page Item Reference List shows both Item References (PX and PY)
        Initialize();
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");
        LibraryVariableStorage.Enqueue(ItemRefNo);

        // [GIVEN] Item Item References for Items 1000 and 1001, both with No = 1234 and Type = Bar Code
        for Index := 1 to ArrayLen(ItemReference) do begin
            LibraryItemReference.CreateItemReferenceWithNo(ItemReference[Index], ItemRefNo, LibraryInventory.CreateItemNo,
              ItemReference[Index]."Reference Type"::"Bar Code", LibraryUtility.GenerateGUID);
            EnqueueItemReferenceFields(ItemReference[Index]);
        end;

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, LibraryPurchase.CreateVendorNo, ItemRefNo);

        // [GIVEN] Ran ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[1], true);

        // [GIVEN] Page Item Reference List opened showing both Item References: first for Item 1000, second for Item 1001
        // [GIVEN] Stan selected the second one
        // Done in ItemReferenceListModalPageHandler

        // [WHEN] Push OK on page Item Reference List
        // Done in ItemReferenceListModalPageHandler

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1001
        ItemReference[1].TestField("Item No.", ItemReference[2]."Item No.");
        LibraryVariableStorage.AssertEmpty;
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenVendorAndBarCodeSameItemShowDialogTrue()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        VendorNo: Code[20];
        ItemRefNo: Code[50];
    begin
        // [FEATURE] [Bar Code]
        // [SCENARIO 289240] Vendor A, Item X, Vendor Reference AX, Bar Code Reference PX
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is Yes
        // [SCENARIO 289240] Page Item Reference List is not shown, ICRLookupPurchaseItem returns Reference for Vendor A (AX)
        Initialize();
        VendorNo := LibraryPurchase.CreateVendorNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Item References for Item 1000 with No = 1234, Type = Vendor and Type No = 10000
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[1], ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference[1]."Reference Type"::Vendor, VendorNo);

        // [GIVEN] Item Item References for same Item with same No and Type = Bar Code
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[2], ItemRefNo, ItemReference[1]."Item No.",
          ItemReference[2]."Reference Type"::"Bar Code", LibraryUtility.GenerateGUID);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, VendorNo, ItemRefNo);

        // [WHEN] Ran ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], true);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1000
        ItemReference[2].TestField("Item No.", ItemReference[1]."Item No.");
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenVendorAndBlankTypeSameItemShowDialogTrue()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        VendorNo: Code[20];
        ItemRefNo: Code[50];
    begin
        // [FEATURE] [Bar Code]
        // [SCENARIO 289240] Vendor A, Item X, Vendor Reference AX, <blank> Type Reference TX
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is Yes
        // [SCENARIO 289240] Page Item Reference List is not shown, ICRLookupPurchaseItem returns Reference for Vendor A (AX)
        Initialize();
        VendorNo := LibraryPurchase.CreateVendorNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Item References for Item 1000 with No = 1234, Type = Vendor and Type No = 10000
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[1], ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference[1]."Reference Type"::Vendor, VendorNo);

        // [GIVEN] Item Item References for same Item with same No and Type = <blank>
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[2], ItemRefNo, ItemReference[1]."Item No.",
          ItemReference[2]."Reference Type"::" ", '');

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, VendorNo, ItemRefNo);

        // [WHEN] Ran ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], true);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1000
        ItemReference[2].TestField("Item No.", ItemReference[1]."Item No.");
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenBarCodesSameItemShowDialogTrue()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
        ItemNo: Code[20];
        Index: Integer;
    begin
        // [FEATURE] [Bar Code]
        // [SCENARIO 289240] Item X, Bar Code Item References: PX,TX
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor and ShowDialog is Yes
        // [SCENARIO 289240] Page Item Reference List is not shown, ICRLookupPurchaseItem returns Reference PX
        Initialize();
        ItemNo := LibraryInventory.CreateItemNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Item References both for same Item, No = 1234 and Type = Bar Code, Type No are "P" and "T"
        for Index := 1 to ArrayLen(ItemReference) do
            LibraryItemReference.CreateItemReferenceWithNo(ItemReference[Index], ItemRefNo, ItemNo,
              ItemReference[Index]."Reference Type"::"Bar Code", LibraryUtility.GenerateGUID);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, LibraryPurchase.CreateVendorNo, ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], true);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Type No = "P"
        ItemReference[2].TestField("Reference Type No.", ItemReference[1]."Reference Type No.");
        ItemReference[2].TestField("Item No.", ItemReference[1]."Item No.");
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenDifferentVendorsSameItemShowDialogTrue()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
        ItemNo: Code[20];
        Index: Integer;
    begin
        // [SCENARIO 289240] Vendors: A,B, Item X, Item References AX and BX
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is Yes
        // [SCENARIO 289240] Page Item Reference List is not shown, ICRLookupPurchaseItem returns Reference for Vendor A (AX)
        Initialize();
        ItemNo := LibraryInventory.CreateItemNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Two Item Item References for Item 1000 with same No = 1234, Type = Vendor, first has Type No = 10000, second has Type No = 20000
        for Index := 1 to ArrayLen(ItemReference) do
            LibraryItemReference.CreateItemReferenceWithNo(ItemReference[Index], ItemRefNo, ItemNo,
              ItemReference[Index]."Reference Type"::Vendor, LibraryPurchase.CreateVendorNo);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(
          PurchaseLine, CopyStr(ItemReference[1]."Reference Type No.", 1, MaxStrLen(PurchaseLine."Buy-from Vendor No.")),
          ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], true);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1000
        ItemReference[2].TestField("Item No.", ItemReference[1]."Item No.");
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenDifferentVendorsDifferentItemsShowDialogTrue()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
        Index: Integer;
    begin
        // [SCENARIO 289240] Vendors: A,B, Items X,Y, Item References AX and BY
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is Yes
        // [SCENARIO 289240] Page Item Reference List is not shown, ICRLookupPurchaseItem returns Reference for Vendor A (AX)
        Initialize();
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Reference for Item 1000 with No = 1234, Type = Vendor, Type No = 10000
        // [GIVEN] Item Reference for Item 1001 with No = 1234, Type = Vendor, Type No = 20000
        for Index := 1 to ArrayLen(ItemReference) do
            LibraryItemReference.CreateItemReferenceWithNo(ItemReference[Index], ItemRefNo, LibraryInventory.CreateItemNo,
              ItemReference[Index]."Reference Type"::Vendor, LibraryPurchase.CreateVendorNo);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(
          PurchaseLine, CopyStr(ItemReference[1]."Reference Type No.", 1, MaxStrLen(PurchaseLine."Buy-from Vendor No.")),
          ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], true);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1000
        ItemReference[2].TestField("Item No.", ItemReference[1]."Item No.");
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenOtherVendorAndBarCodeShowDialogTrue()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
    begin
        // [FEATURE] [Bar Code]
        // [SCENARIO 289240] Vendor B, Items X,Y Vendor Reference BX, Bar Code Reference PY
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is Yes
        // [SCENARIO 289240] Page Item Reference List is not shown, ICRLookupPurchaseItem returns Reference PY
        Initialize();
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Reference for Item 1000 with No = 1234, Type = Vendor and Type No = 20000
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[1], ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference[1]."Reference Type"::Vendor, LibraryPurchase.CreateVendorNo);

        // [GIVEN] Item Item References for Item 1001 with same No and Type = Bar Code
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[2], ItemRefNo, ItemReference[1]."Item No.",
          ItemReference[2]."Reference Type"::"Bar Code", LibraryUtility.GenerateGUID);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, LibraryPurchase.CreateVendorNo, ItemRefNo);

        // [WHEN] Ran ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[1], true);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1001
        ItemReference[1].TestField("Item No.", ItemReference[2]."Item No.");
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenOtherVendorShowDialogTrue()
    var
        ItemReference: Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
    begin
        // [SCENARIO 289240] Vendor B, Reference BX
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is Yes
        // [SCENARIO 289240] ICRLookupPurchaseItem throws error
        Initialize();
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference.FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Reference for Item with No = 1234, Type = Vendor and Type No = 20000
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference, ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference."Reference Type"::Vendor, LibraryPurchase.CreateVendorNo);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, LibraryPurchase.CreateVendorNo, ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        asserterror ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference, true);

        // [THEN] Error "There are no items with cross reference: 1234"
        Assert.ExpectedError(StrSubstNo(ItemRefNotExistsErr, ItemRefNo));
        Assert.ExpectedErrorCode(DialogCodeErr);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenOtherMultipleVendorsShowDialogTrue()
    var
        ItemReference: Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
    begin
        // [SCENARIO 289240] Vendors: B,C Item References BX,CY
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is Yes
        // [SCENARIO 289240] ICRLookupPurchaseItem throws error
        Initialize();
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference.FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Two Item Item References with same No = 1234, same Type = Vendor and Type No 20000 and 30000
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference, ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference."Reference Type"::Vendor, LibraryPurchase.CreateVendorNo);
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference, ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference."Reference Type"::Vendor, LibraryPurchase.CreateVendorNo);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, LibraryPurchase.CreateVendorNo, ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        asserterror ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference, true);

        // [THEN] Error "There are no items with cross reference: 1234"
        Assert.ExpectedError(StrSubstNo(ItemRefNotExistsErr, ItemRefNo));
        Assert.ExpectedErrorCode(DialogCodeErr);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenOneVendorShowDialogTrue()
    var
        ItemReference: Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
        ItemNo: Code[20];
    begin
        // [SCENARIO 289240] Vendor A, Reference AX
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is Yes
        // [SCENARIO 289240] ICRLookupPurchaseItem Returns Reference AX
        Initialize();
        ItemNo := LibraryInventory.CreateItemNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference.FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Reference for Item 1000 with No = 1234, Type = Vendor and Type No = 10000
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference, ItemRefNo, ItemNo,
          ItemReference."Reference Type"::Vendor, LibraryPurchase.CreateVendorNo);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(
          PurchaseLine, CopyStr(ItemReference."Reference Type No.", 1, MaxStrLen(PurchaseLine."Buy-from Vendor No.")),
          ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference, true);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1000
        ItemReference.TestField("Item No.", ItemNo)
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenNoItemRefShowDialogTrue()
    var
        DummyItemReference: Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
    begin
        // [SCENARIO 289240] No Item References with No = 1234
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A with Reference No = 1234 and ShowDialog is Yes
        // [SCENARIO 289240] ICRLookupPurchaseItem Returns Reference AX
        Initialize();
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(DummyItemReference.FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, LibraryPurchase.CreateVendorNo, ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        asserterror ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, DummyItemReference, true);

        // [THEN] Error "There are no items with cross reference: 1234"
        Assert.ExpectedError(StrSubstNo(ItemRefNotExistsErr, ItemRefNo));
        Assert.ExpectedErrorCode(DialogCodeErr);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenSameVendorsForSameItemsAndBarCodeShowDialogFalse()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        VendorNo: array[2] of Code[20];
        ItemRefNo: Code[50];
        Index: Integer;
        ItemIndex: Integer;
        ItemNo: array[2] of Code[20];
    begin
        // [FEATURE] [Intercompany]
        // [SCENARIO 289240] Vendors: A,B, Items: X,Y,Z, Vendor Item References: AX, AY, BX, BY and Bar Code Reference PZ
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is No
        // [SCENARIO 289240] ICRLookupPurchaseItem returns Reference for Vendor A and Item X (AX)
        Initialize();
        for ItemIndex := 1 to ArrayLen(ItemNo) do begin
            ItemNo[ItemIndex] := LibraryInventory.CreateItemNo;
            VendorNo[ItemIndex] := LibraryPurchase.CreateVendorNo;
        end;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Two Item Item References for Item 1000 with No = 1234, Type = Vendor and Type No = 10000 and 20000
        // [GIVEN] Two similar Item Item References for Item 1001
        for ItemIndex := 1 to ArrayLen(ItemNo) do
            for Index := 1 to ArrayLen(ItemReference) do
                LibraryItemReference.CreateItemReferenceWithNo(ItemReference[Index], ItemRefNo, ItemNo[ItemIndex],
                  ItemReference[Index]."Reference Type"::Vendor, VendorNo[Index]);

        // [GIVEN] Item Reference for Item 1100 with No = 1234, Type = Bar Code
        LibraryItemReference.CreateItemReferenceWithNo(
          ItemReference[2], ItemRefNo, LibraryInventory.CreateItemNo, ItemReference[2]."Reference Type"::"Bar Code",
          LibraryUtility.GenerateGUID);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, VendorNo[1], ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = FALSE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], false);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1000 and Type No = 10000
        ItemReference[2].TestField("Item No.", ItemNo[1]);
        ItemReference[2].TestField("Reference Type No.", VendorNo[1]);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenSameVendorsForSameItemsShowDialogFalse()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        VendorNo: array[2] of Code[20];
        ItemRefNo: Code[50];
        Index: Integer;
        ItemIndex: Integer;
        ItemNo: array[2] of Code[20];
    begin
        // [FEATURE] [Intercompany]
        // [SCENARIO 289240] Vendors: A,B, Items: X,Y, Item References: AX, AY, BX, BY
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is No
        // [SCENARIO 289240] ICRLookupPurchaseItem returns Reference for Vendor A and Item X (AX)
        Initialize();
        for ItemIndex := 1 to ArrayLen(ItemNo) do begin
            ItemNo[ItemIndex] := LibraryInventory.CreateItemNo;
            VendorNo[ItemIndex] := LibraryPurchase.CreateVendorNo;
        end;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Two Item Item References for Item 1000 with No = 1234, Type = Vendor and Type No = 10000 and 20000
        // [GIVEN] Two similar Item Item References for Item 1001
        for ItemIndex := 1 to ArrayLen(ItemNo) do
            for Index := 1 to ArrayLen(ItemReference) do
                LibraryItemReference.CreateItemReferenceWithNo(ItemReference[Index], ItemRefNo, ItemNo[ItemIndex],
                  ItemReference[Index]."Reference Type"::Vendor, VendorNo[Index]);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, VendorNo[1], ItemRefNo);

        // [When] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = FALSE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], false);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1000 and Type No = 10000
        ItemReference[2].TestField("Item No.", ItemNo[1]);
        ItemReference[2].TestField("Reference Type No.", VendorNo[1]);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenVendorAndBarCodeDifferentItemsShowDialogFalse()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        VendorNo: Code[20];
        ItemRefNo: Code[50];
    begin
        // [FEATURE] [Intercompany] [Bar Code]
        // [SCENARIO 289240] Vendor A, Items: X,Y Vendor Reference AX and Bar Code Reference PY
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is No
        // [SCENARIO 289240] ICRLookupPurchaseItem returns Reference for Vendor A and Item X (AX)
        Initialize();
        VendorNo := LibraryPurchase.CreateVendorNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Item References for Item 1000 with No = 1234, Type = Vendor and Type No = 10000
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[1], ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference[1]."Reference Type"::Vendor, VendorNo);

        // [GIVEN] Item Item References for Item 1001 with same No and Type = Bar Code
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[2], ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference[2]."Reference Type"::"Bar Code", LibraryUtility.GenerateGUID);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, VendorNo, ItemRefNo);

        // [WHEN] Ran ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = FALSE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], false);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1000
        ItemReference[2].TestField("Item No.", ItemReference[1]."Item No.");
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenVendorAndBlankTypeDifferentItemsShowDialogFalse()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        VendorNo: Code[20];
        ItemRefNo: Code[50];
    begin
        // [FEATURE] [Intercompany] [Bar Code]
        // [SCENARIO 289240] Vendor A, Items: X,Y Vendor Reference AX and <blank> Type Reference TY
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is No
        // [SCENARIO 289240] ICRLookupPurchaseItem returns Reference for Vendor A and Item X (AX)
        Initialize();
        VendorNo := LibraryPurchase.CreateVendorNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Item References for Item 1000 with No = 1234, Type = Vendor and Type No = 10000
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[1], ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference[1]."Reference Type"::Vendor, VendorNo);

        // [GIVEN] Item Item References for Item 1001 with No = 1234 and Type = <blank>
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[2], ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference[2]."Reference Type"::" ", '');

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, VendorNo, ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = FALSE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], false);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1000
        ItemReference[2].TestField("Item No.", ItemReference[1]."Item No.");
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenSameVendorDifferentItemsShowDialogFalse()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        VendorNo: Code[20];
        ItemRefNo: Code[50];
        Index: Integer;
    begin
        // [FEATURE] [Intercompany]
        // [SCENARIO 289240] Vendor A, Items: X,Y Item References AX and AY
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is No
        // [SCENARIO 289240] ICRLookupPurchaseItem returns Reference for Vendor A and Item X (AX)
        Initialize();
        VendorNo := LibraryPurchase.CreateVendorNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Item References for Items 1000 and 1001 with same No = 1234, Type = Vendor and Type No = 10000
        for Index := 1 to ArrayLen(ItemReference) do
            LibraryItemReference.CreateItemReferenceWithNo(ItemReference[Index], ItemRefNo, LibraryInventory.CreateItemNo,
              ItemReference[Index]."Reference Type"::Vendor, VendorNo);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, VendorNo, ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = FALSE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], false);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1000
        ItemReference[2].TestField("Item No.", ItemReference[1]."Item No.");
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenBarCodesDifferentItemsShowDialogFalse()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
        Index: Integer;
    begin
        // [FEATURE] [Intercompany] [Bar Code]
        // [SCENARIO 289240] Items: X,Y, Bar Code Item References: PX,PY
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor and ShowDialog is No
        // [SCENARIO 289240] ICRLookupPurchaseItem returns Reference PX
        Initialize();
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Item References for Items 1000 and 1001, both with No = 1234 and Type = Bar Code
        for Index := 1 to ArrayLen(ItemReference) do
            LibraryItemReference.CreateItemReferenceWithNo(ItemReference[Index], ItemRefNo, LibraryInventory.CreateItemNo,
              ItemReference[Index]."Reference Type"::"Bar Code", LibraryUtility.GenerateGUID);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, LibraryPurchase.CreateVendorNo, ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = FALSE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], false);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1001
        ItemReference[2].TestField("Item No.", ItemReference[1]."Item No.");
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenVendorAndBarCodeSameItemShowDialogFalse()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        VendorNo: Code[20];
        ItemRefNo: Code[50];
    begin
        // [FEATURE] [Intercompany] [Bar Code]
        // [SCENARIO 289240] Vendor A, Item X, Vendor Reference AX, Bar Code Reference PX
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is No
        // [SCENARIO 289240] ICRLookupPurchaseItem returns Reference for Vendor A (AX)
        Initialize();
        VendorNo := LibraryPurchase.CreateVendorNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Item References for Item 1000 with No = 1234, Type = Vendor and Type No = 10000
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[1], ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference[1]."Reference Type"::Vendor, VendorNo);

        // [GIVEN] Item Item References for same Item with same No and Type = Bar Code
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[2], ItemRefNo, ItemReference[1]."Item No.",
          ItemReference[2]."Reference Type"::"Bar Code", LibraryUtility.GenerateGUID);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, VendorNo, ItemRefNo);

        // [WHEN] Ran ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = FALSE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], false);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1000
        ItemReference[2].TestField("Item No.", ItemReference[1]."Item No.");
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenVendorAndBlankTypeSameItemShowDialogFalse()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        VendorNo: Code[20];
        ItemRefNo: Code[50];
    begin
        // [FEATURE] [Intercompany] [Bar Code]
        // [SCENARIO 289240] Vendor A, Item X, Vendor Reference AX, <blank> Type Reference TX
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is No
        // [SCENARIO 289240] Page Item Reference List is not shown, ICRLookupPurchaseItem returns Reference for Vendor A (AX)
        Initialize();
        VendorNo := LibraryPurchase.CreateVendorNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Item References for Item 1000 with No = 1234, Type = Vendor and Type No = 10000
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[1], ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference[1]."Reference Type"::Vendor, VendorNo);

        // [GIVEN] Item Item References for same Item with same No and Type = <blank>
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[2], ItemRefNo, ItemReference[1]."Item No.",
          ItemReference[2]."Reference Type"::" ", '');

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, VendorNo, ItemRefNo);

        // [WHEN] Ran ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = FALSE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], false);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1000
        ItemReference[2].TestField("Item No.", ItemReference[1]."Item No.");
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenBarCodesSameItemShowDialogFalse()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
        ItemNo: Code[20];
        Index: Integer;
    begin
        // [FEATURE] [Intercompany] [Bar Code]
        // [SCENARIO 289240] Item X, Bar Code Item References: PX,TX
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor and ShowDialog is No
        // [SCENARIO 289240] ICRLookupPurchaseItem returns Reference PX
        Initialize();
        ItemNo := LibraryInventory.CreateItemNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Item References both for same Item, No = 1234 and Type = Bar Code, Type No are "P" and "T"
        for Index := 1 to ArrayLen(ItemReference) do
            LibraryItemReference.CreateItemReferenceWithNo(ItemReference[Index], ItemRefNo, ItemNo,
              ItemReference[Index]."Reference Type"::"Bar Code", LibraryUtility.GenerateGUID);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, LibraryPurchase.CreateVendorNo, ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = FALSE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], false);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Type No = "P"
        ItemReference[2].TestField("Reference Type No.", ItemReference[1]."Reference Type No.");
        ItemReference[2].TestField("Item No.", ItemReference[1]."Item No.");
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenDifferentVendorsSameItemShowDialogFalse()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
        ItemNo: Code[20];
        Index: Integer;
    begin
        // [FEATURE] [Intercompany]
        // [SCENARIO 289240] Vendors: A,B, Item X, Item References AX and BX
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is No
        // [SCENARIO 289240] ICRLookupPurchaseItem returns Reference for Vendor A (AX)
        Initialize();
        ItemNo := LibraryInventory.CreateItemNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Two Item Item References for Item 1000 with same No = 1234, Type = Vendor, first has Type No = 10000, second has Type No = 20000
        for Index := 1 to ArrayLen(ItemReference) do
            LibraryItemReference.CreateItemReferenceWithNo(ItemReference[Index], ItemRefNo, ItemNo,
              ItemReference[Index]."Reference Type"::Vendor, LibraryPurchase.CreateVendorNo);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(
          PurchaseLine, CopyStr(ItemReference[1]."Reference Type No.", 1, MaxStrLen(PurchaseLine."Buy-from Vendor No.")),
          ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = FALSE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], false);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1000
        ItemReference[2].TestField("Item No.", ItemReference[1]."Item No.");
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenDifferentVendorsDifferentItemsShowDialogFalse()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
        Index: Integer;
    begin
        // [FEATURE] [Intercompany]
        // [SCENARIO 289240] Vendors: A,B, Items X,Y, Item References AX and BY
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is No
        // [SCENARIO 289240] ICRLookupPurchaseItem returns Reference for Vendor A (AX)
        Initialize();
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Reference for Item 1000 with No = 1234, Type = Vendor, Type No = 10000
        // [GIVEN] Item Reference for Item 1001 with No = 1234, Type = Vendor, Type No = 20000
        for Index := 1 to ArrayLen(ItemReference) do
            LibraryItemReference.CreateItemReferenceWithNo(ItemReference[Index], ItemRefNo, LibraryInventory.CreateItemNo,
              ItemReference[Index]."Reference Type"::Vendor, LibraryPurchase.CreateVendorNo);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(
          PurchaseLine, CopyStr(ItemReference[1]."Reference Type No.", 1, MaxStrLen(PurchaseLine."Buy-from Vendor No.")),
          ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = FALSE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[2], false);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1000
        ItemReference[2].TestField("Item No.", ItemReference[1]."Item No.");
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenOtherVendorAndBarCodeShowDialogFalse()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
    begin
        // [FEATURE] [Intercompany] [Bar Code]
        // [SCENARIO 289240] Vendor B, Items X,Y Vendor Reference BX, Bar Code Reference PY
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is No
        // [SCENARIO 289240] ICRLookupPurchaseItem returns Reference PY
        Initialize();
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Reference for Item 1000 with No = 1234, Type = Vendor and Type No = 20000
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[1], ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference[1]."Reference Type"::Vendor, LibraryPurchase.CreateVendorNo);

        // [GIVEN] Item Item References for Item 1001 with same No and Type = Bar Code
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference[2], ItemRefNo, ItemReference[1]."Item No.",
          ItemReference[2]."Reference Type"::"Bar Code", LibraryUtility.GenerateGUID);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, LibraryPurchase.CreateVendorNo, ItemRefNo);

        // [WHEN] Ran ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = FALSE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[1], false);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1001
        ItemReference[1].TestField("Item No.", ItemReference[2]."Item No.");
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenOtherVendorShowDialogFalse()
    var
        ItemReference: Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
    begin
        // [FEATURE] [Intercompany]
        // [SCENARIO 289240] Vendor B, Reference BX
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is No
        // [SCENARIO 289240] ICRLookupPurchaseItem throws error
        Initialize();
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference.FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Reference for Item with No = 1234, Type = Vendor and Type No = 20000
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference, ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference."Reference Type"::Vendor, LibraryPurchase.CreateVendorNo);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, LibraryPurchase.CreateVendorNo, ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = FALSE
        asserterror ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference, false);

        // [THEN] Error "There are no items with cross reference: 1234"
        Assert.ExpectedError(StrSubstNo(ItemRefNotExistsErr, ItemRefNo));
        Assert.ExpectedErrorCode(DialogCodeErr);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenOtherMultipleVendorsShowDialogFalse()
    var
        ItemReference: Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
    begin
        // [FEATURE] [Intercompany]
        // [SCENARIO 289240] Vendors: B,C Item References BX,CY
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is No
        // [SCENARIO 289240] ICRLookupPurchaseItem throws error
        Initialize();
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference.FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Two Item Item References with same No = 1234, same Type = Vendor and Type No 20000 and 30000
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference, ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference."Reference Type"::Vendor, LibraryPurchase.CreateVendorNo);
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference, ItemRefNo, LibraryInventory.CreateItemNo,
          ItemReference."Reference Type"::Vendor, LibraryPurchase.CreateVendorNo);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, LibraryPurchase.CreateVendorNo, ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = FALSE
        asserterror ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference, false);

        // [THEN] Error "There are no items with cross reference: 1234"
        Assert.ExpectedError(StrSubstNo(ItemRefNotExistsErr, ItemRefNo));
        Assert.ExpectedErrorCode(DialogCodeErr);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenOneVendorShowDialogFalse()
    var
        ItemReference: Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
        ItemNo: Code[20];
    begin
        // [FEATURE] [Intercompany]
        // [SCENARIO 289240] Vendor A, Reference AX
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is No
        // [SCENARIO 289240] ICRLookupPurchaseItem Returns Reference AX
        Initialize();
        ItemNo := LibraryInventory.CreateItemNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference.FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Item Reference for Item 1000 with No = 1234, Type = Vendor and Type No = 10000
        LibraryItemReference.CreateItemReferenceWithNo(ItemReference, ItemRefNo, ItemNo,
          ItemReference."Reference Type"::Vendor, LibraryPurchase.CreateVendorNo);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(
          PurchaseLine, CopyStr(ItemReference."Reference Type No.", 1, MaxStrLen(PurchaseLine."Buy-from Vendor No.")),
          ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = FALSE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference, false);

        // [THEN] ICRLookupPurchaseItem returns Item Reference with Item No = 1000
        ItemReference.TestField("Item No.", ItemNo)
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenNoItemRefShowDialogFalse()
    var
        DummyItemReference: Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemRefNo: Code[50];
    begin
        // [FEATURE] [Intercompany]
        // [SCENARIO 289240] No Item References with No = 1234
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A with Item Reference No = 1234 and ShowDialog is No
        // [SCENARIO 289240] ICRLookupPurchaseItem Returns Reference AX
        Initialize();
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(DummyItemReference.FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(
          PurchaseLine, LibraryPurchase.CreateVendorNo, ItemRefNo);

        // [WHEN] Run ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = FALSE
        asserterror ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, DummyItemReference, false);

        // [THEN] Error "There are no items with cross reference: 1234"
        Assert.ExpectedError(StrSubstNo(ItemRefNotExistsErr, ItemRefNo));
        Assert.ExpectedErrorCode(DialogCodeErr);
    end;

    [Test]
    [HandlerFunctions('ItemReferenceListCancelModalPageHandler')]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenStanCancelsItemReferenceList()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        VendorNo: array[2] of Code[20];
        ItemRefNo: Code[50];
        Index: Integer;
        ItemIndex: Integer;
        ItemNo: array[2] of Code[20];
    begin
        // [FEATURE] [UI]
        // [SCENARIO 289240] ICRLookupPurchaseItem for Vendor A and ShowDialog is Yes
        // [SCENARIO 289240] Page Item Reference List opened with Item References
        // [SCENARIO 289240] When Stan pushes cancel on page, then error
        Initialize();
        for ItemIndex := 1 to ArrayLen(ItemNo) do begin
            ItemNo[ItemIndex] := LibraryInventory.CreateItemNo;
            VendorNo[ItemIndex] := LibraryPurchase.CreateVendorNo;
        end;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");

        // [GIVEN] Two Item Item References for Item 1000 with No = 1234, Type = Vendor and Type No = 10000 and 20000
        // [GIVEN] Two similar Item Item References for Item 1001
        for ItemIndex := 1 to ArrayLen(ItemNo) do
            for Index := 1 to ArrayLen(ItemReference) do
                LibraryItemReference.CreateItemReferenceWithNo(ItemReference[Index], ItemRefNo, ItemNo[ItemIndex],
                  ItemReference[Index]."Reference Type"::Vendor, VendorNo[Index]);

        // [GIVEN] Item Reference for Item 1100 with No = 1234, Type = Bar Code
        LibraryItemReference.CreateItemReferenceWithNo(
          ItemReference[2], ItemRefNo, LibraryInventory.CreateItemNo, ItemReference[2]."Reference Type"::"Bar Code",
          LibraryUtility.GenerateGUID);

        // [GIVEN] Purchase Line had Type = Item, "Buy-from Vendor No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, VendorNo[1], ItemRefNo);

        // [GIVEN] Ran ICRLookupPurchaseItem from codeunit Dist. Integration for the Purchase Line with ShowDialog = TRUE
        asserterror ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[1], true);

        // [GIVEN] Page Item Reference List opened

        // [WHEN] Stan pushes Cancel on page Item Reference List
        // Done in ItemReferenceListCancelModalPageHandler

        // [THEN] Error "There are no items with cross reference: 1234"
        Assert.ExpectedError(StrSubstNo(ItemRefNotExistsErr, ItemRefNo));
        Assert.ExpectedErrorCode(DialogCodeErr);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure ChangeItemVendorLeadCalcTime()
    var
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        ItemVendor: Record "Item Vendor";
        ItemReference: Record "Item Reference";
        SavedItemReferenceDescription: Text[100];
    begin
        // [SCENARIO 292774] Description should not be cleared in item cross refference when updating Lead Time Calculation of related Item Vendor record
        Initialize();

        // [GIVEN] Item Reference of "Vendor" type with Item No. "ITEM", Vendor No. "VEND", Variant Code "VARIANT" and description "DESCR"
        LibraryInventory.CreateItem(Item);
        LibraryInventory.CreateItemVariant(ItemVariant, Item."No.");
        CreateItemReference(
          ItemReference, Item."No.", ItemVariant.Code,
          ItemReference."Reference Type"::Vendor, LibraryPurchase.CreateVendorNo);
        SavedItemReferenceDescription := ItemReference.Description;

        // [WHEN] "Lead Time Calculation" field of Item Vendor record "VEND", "ITEM", "VARIANT" is being updated
        ItemVendor.Get(ItemReference."Reference Type No.", Item."No.", ItemVariant.Code);
        Evaluate(ItemVendor."Lead Time Calculation", '<1D>');
        ItemVendor.Modify(true);

        // [THEN] Item Reference description is not changed
        ItemReference.Find;
        ItemReference.TestField(Description, SavedItemReferenceDescription);
    end;

    [Test]
    [HandlerFunctions('ItemReferenceListModalPageHandler')]
    [Scope('OnPrem')]
    procedure PurchLineLookupItemRefNoWhenSameVendorDifferentItems()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        VendorNo: Code[20];
        ItemRefNo: Code[50];
        Index: Integer;
    begin
        // [FEATURE] [UI]
        // [SCENARIO 289240] Vendor A, Items: X,Y Item References AX and AY
        // [SCENARIO 289240] Stan looks up Reference No in Purchase Line and selects Reference AY
        // [SCENARIO 289240] Purchase Line has Item Y
        Initialize();
        VendorNo := LibraryPurchase.CreateVendorNo;
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");
        LibraryVariableStorage.Enqueue(ItemRefNo);

        // [GIVEN] Item Item References for Items 1000 and 1001 with same No = 1234, Type = Vendor and Type No = 10000
        for Index := 1 to ArrayLen(ItemReference) do begin
            LibraryItemReference.CreateItemReferenceWithNo(ItemReference[Index], ItemRefNo, LibraryInventory.CreateItemNo,
              ItemReference[Index]."Reference Type"::Vendor, VendorNo);
            EnqueueItemReferenceFields(ItemReference[Index]);
        end;

        // [GIVEN] Purchase Invoice with "Buy-from Vendor No." = 10000 and Purchase Line had Type = Item
        CreatePurchaseInvoiceOneLineWithLineTypeItem(PurchaseLine, VendorNo);

        // [GIVEN] Stan Looked up Item Reference No in Purchase Line
        PurchaseHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.");
        ItemReferenceMgt.PurchaseReferenceNoLookup(PurchaseLine, PurchaseHeader);

        // [GIVEN] Page Item Reference List opened showing both Item References, first for Item 1000, second for Item 1001
        // [GIVEN] Stan selected the second one
        // Done in ItemReferenceListModalPageHandler

        // [WHEN] Push OK on page Item Reference List
        // Done in ItemReferenceListModalPageHandler

        // [THEN] Purchase Line has No = 1001
        PurchaseLine.TestField("No.", ItemReference[2]."Item No.");
        LibraryVariableStorage.AssertEmpty;
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CorrectCreatingItemReferenceFromItemVendorCatalog()
    var
        ItemReference: Record "Item Reference";
        ItemVariant: Record "Item Variant";
        ItemVendorCatalog: TestPage "Item Vendor Catalog";
        ItemNo: Code[20];
        VendorNo: Code[20];
        ItemVendorNo: Code[10];
    begin
        // [FEATURE] [UI]
        // [SCENARIO 402797] Only one "Item Reference" must be created by "Item Vendor Catalog" when user set "Variant Code" after "Item Vendor"
        Initialize();

        // [GIVEN] Item, Vendor, "Item Variant"
        ItemNo := LibraryInventory.CreateItemNo();
        VendorNo := LibraryPurchase.CreateVendorNo();

        // [GIVEN] Create new "Item Vendor" by "Item Vendor Catalog"
        ItemVendorCatalog.OpenNew();
        ItemVendorCatalog.Filter.SetFilter("Item No.", ItemNo);
        ItemVendorCatalog."Vendor No.".SetValue(VendorNo);
        ItemVendorNo := LibraryUtility.GenerateGUID();
        ItemVendorCatalog."Vendor Item No.".SetValue(ItemVendorNo);

        // [WHEN] Set "Variant Code" after "Vendor Item No."
        ItemVendorCatalog."Variant Code".SetValue(LibraryInventory.CreateItemVariant(ItemVariant, ItemNo));
        ItemVendorCatalog.Next();

        // [THEN] "Item Reference" for Item and Vendor is only one
        ItemReference.SetRange("Item No.", ItemNo);
        ItemReference.SetRange("Reference Type", ItemReference."Reference Type"::Vendor);
        ItemReference.SetRange("Reference Type No.", VendorNo);
        ItemReference.FindFirst();
        ItemReference.TestField("Reference No.", ItemVendorNo);
        Assert.RecordCount(ItemReference, 1);
    end;

#if not CLEAN19
    [Test]
    [Scope('OnPrem')]
    [HandlerFunctions('ConfirmYesHandler,MessageHandler,CopyItemCrossRefReportHandler')]
    [Obsolete('Will be removed along with Item Cross Reference table.', '19.0')]
    procedure CopyItemCrossReference()
    var
        ItemCrossReference: array[3] of Record "Item Cross Reference";
        ItemReference: Record "Item Reference";
        ItemReferences: TestPage "Item References";
        ItemNo: array[3] of Code[20];
    begin
        // [FEATURE] [Copy Item Reference]
        // [SCENARIO 419103] Copy item cross references
        Initialize();
        // [GIVEN] 3 Items'I1', 'I2', 'I3'
        ItemNo[1] := LibraryInventory.CreateItemNo();
        ItemNo[2] := LibraryInventory.CreateItemNo();
        ItemNo[3] := LibraryInventory.CreateItemNo();
        // [GIVEN] Item Cross Reference contains 2 records for items 'I1' and 'I2'
        ItemCrossReference[1].DeleteAll();
        ItemCrossReference[1]."Item No." := ItemNo[1];
        ItemCrossReference[1].Insert();
        ItemCrossReference[2]."Item No." := ItemNo[2];
        ItemCrossReference[2].Insert();
        ItemCrossReference[3]."Item No." := ItemNo[3];
        ItemCrossReference[3].Insert();
        // [GIVEN] Item Reference contains 2 records for items 'I1' and 'I3'
        ItemReference.DeleteAll();
        ItemReference."Item No." := ItemNo[1];
        ItemReference.Insert();
        ItemReference."Item No." := ItemNo[3];
        ItemReference.Insert();

        // [WHEN] Run "Copy Item Cross References" action on "Item References" page with filter 'Item No.' = 'I1..I2'
        ItemReferences.OpenView();
        Assert.IsTrue(ItemReferences.CopyItemCrossReferences.Enabled(), 'CopyItemCrossReferences.Enabled');
        LibraryVariableStorage.Enqueue(StrSubstNo('%1..%2', ItemNo[1], ItemNo[2])); // filter for CopyItemCrossRefReportHandler
        Commit();
        Report.Run(Report::"Copy Item Cross References");

        // [THEN] Confirmation 'There are 2 filtered records ...'
        Assert.AreEqual(StrSubstNo(ConfirmCopyTxt, 2), LibraryVariableStorage.DequeueText(), 'confirmation message');
        // [THEN] Message '1 of 2 records were copied'
        Assert.AreEqual(StrSubstNo(FinalMessageTxt, 1, 2), LibraryVariableStorage.DequeueText(), 'final message');
        LibraryVariableStorage.AssertEmpty();
        // [THEN] Item Reference contains 3 records for items 'I1', 'I2', 'I3'
        Assert.RecordCount(ItemReference, 3);
        // [THEN] SystemId of record for 'I2' equals to one in Item Cross Reference
        ItemReference.SetRange("Item No.", ItemNo[2]);
        ItemReference.FindFirst();
        Assert.AreEqual(ItemReference.SystemId, ItemCrossReference[2].SystemId, 'SystemID for I2 should match');
        // [THEN] SystemId of record for 'I1' does not equal to one in Item Cross Reference
        ItemReference.SetRange("Item No.", ItemNo[1]);
        ItemReference.FindFirst();
        Assert.AreNotEqual(ItemReference.SystemId, ItemCrossReference[1].SystemId, 'SystemID for I1 should not match');
        // [THEN] Item Cross Reference still contains 3 records for items 'I1', 'I2', 'I3'
        Assert.RecordCount(ItemCrossReference[1], 3);
    end;

    [ConfirmHandler]
    [Obsolete('Will be removed along with Item Cross Reference table.', '19.0')]
    procedure ConfirmYesHandler(Question: Text[1024]; var Reply: Boolean)
    begin
        LibraryVariableStorage.Enqueue(Question);
        Reply := true;
    end;

    [MessageHandler]
    [Obsolete('Will be removed along with Item Cross Reference table.', '19.0')]
    procedure MessageHandler(Message: Text[1024])
    begin
        LibraryVariableStorage.Enqueue(Message);
    end;

    [RequestPageHandler]
    [Obsolete('Will be removed along with Item Cross Reference table.', '19.0')]
    procedure CopyItemCrossRefReportHandler(var CopyItemCrossReferences: TestRequestPage "Copy Item Cross References")
    begin
        CopyItemCrossReferences.ItemCrossReference.SetFilter("Item No.", LibraryVariableStorage.DequeueText());
        CopyItemCrossReferences.OK().Invoke();
    end;
#endif

    [Test]
    [HandlerFunctions('ItemReferenceListModalPageHandler')]
    [Scope('OnPrem')]
    procedure ICRLookupPurchaseItemWhenSameVendorForSameItemDifferentVariants()
    var
        ItemReference: array[2] of Record "Item Reference";
        PurchaseLine: Record "Purchase Line";
        ItemVariant: Record "Item Variant";
        VendNo: Code[20];
        ItemRefNo: Code[50];
        Index: Integer;
        ItemNo: Code[20];
        VariantCode: array[2] of Code[20];
    begin
        // [FEATURE] [UI]
        // [SCENARIO 289240] Vendor: V Item: I, Variants: A,B Item References: IA, IB
        // [SCENARIO 289240] Page Item Reference List allow to select variant B
        Initialize();
        ItemNo := LibraryInventory.CreateItemNo();
        VendNo := LibraryPurchase.CreateVendorNo();
        VariantCode[1] := LibraryInventory.CreateItemVariant(ItemVariant, ItemNo);
        VariantCode[2] := LibraryInventory.CreateItemVariant(ItemVariant, ItemNo);
        ItemRefNo :=
          LibraryUtility.GenerateRandomCode(ItemReference[1].FieldNo("Reference No."), DATABASE::"Item Reference");
        LibraryVariableStorage.Enqueue(ItemRefNo);

        // [GIVEN] Two Item References for Item 1000 with No = 1234, Variant = A,B
        for Index := 1 to ArrayLen(VariantCode) do begin
            LibraryItemReference.CreateItemReference(
              ItemReference[Index], ItemNo, VariantCode[Index], '', "Item Reference Type"::Vendor, VendNo, ItemRefNo);
            EnqueueItemReferenceFields(ItemReference[Index]);
        end;

        // [GIVEN] Purchase Line had Type = Item, "Bill-to Customer No." = 10000 and Reference No. = 1234
        MockPurchaseLineForICRLookupPurchaseItem(PurchaseLine, VendNo, ItemRefNo);

        // [GIVEN] Ran ICRLookupPurchaseItem for the Purchase Line with ShowDialog = TRUE
        ItemReferenceMgt.ReferenceLookupPurchaseItem(PurchaseLine, ItemReference[1], true);

        // [GIVEN] Stan selected the second one
        // Done in ItemReferenceListModalPageHandler

        // [WHEN] Push OK on page Item Reference List
        // Done in ItemReferenceListModalPageHandler

        // [THEN] ICRLookupSalesItem returns Item Reference with Variant Code = B
        ItemReference[1].TestField("Item No.", ItemReference[2]."Item No.");
        ItemReference[1].TestField("Variant Code", ItemReference[2]."Variant Code");
        LibraryVariableStorage.AssertEmpty();
    end;

    local procedure Initialize()
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"ERM Item Reference Purchase");

        LibraryVariableStorage.Clear;
        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"ERM Item Reference Purchase");

        LibraryItemReference.EnableFeature(true);
        Commit();
        IsInitialized := true;

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"ERM Item Reference Purchase");
    end;

    local procedure CreateItemReference(var ItemReference: Record "Item Reference"; ItemNo: Code[20]; ItemVariantNo: Code[10]; ReferenceType: Enum "Item Reference Type"; ReferenceTypeNo: Code[30])
    begin
        with ItemReference do begin
            Init;
            Validate("Item No.", ItemNo);
            Validate("Variant Code", ItemVariantNo);
            Validate("Reference Type", ReferenceType);
            Validate("Reference Type No.", ReferenceTypeNo);
            Validate(
              "Reference No.",
              LibraryUtility.GenerateRandomCode(FieldNo("Reference No."), DATABASE::"Item Reference"));
            Validate(Description, ReferenceTypeNo);
            Insert(true);
        end;
    end;

    local procedure MockPurchaseLineForICRLookupPurchaseItem(var PurchaseLine: Record "Purchase Line"; VendorNo: Code[20]; ItemRefNo: Code[50])
    begin
        PurchaseLine.Init();
        PurchaseLine.Type := PurchaseLine.Type::Item;
        PurchaseLine."Buy-from Vendor No." := VendorNo;
        PurchaseLine."Item Reference No." := ItemRefNo;
    end;

    local procedure CreatePurchaseInvoiceOneLineWithLineTypeItem(var PurchaseLine: Record "Purchase Line"; VendorNo: Code[20])
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        LibraryPurchase.CreatePurchHeader(PurchaseHeader, PurchaseHeader."Document Type"::Invoice, VendorNo);
        LibraryPurchase.CreatePurchaseLineSimple(PurchaseLine, PurchaseHeader);
        PurchaseLine.Validate(Type, PurchaseLine.Type::Item);
        PurchaseLine.Modify(true);
    end;

    local procedure EnqueueItemReferenceFields(ItemReference: Record "Item Reference")
    begin
        LibraryVariableStorage.Enqueue(ItemReference."Reference Type");
        LibraryVariableStorage.Enqueue(ItemReference."Reference Type No.");
        LibraryVariableStorage.Enqueue(ItemReference."Item No.");
    end;

    [ModalPageHandler]
    [Scope('OnPrem')]
    procedure ItemReferenceListModalPageHandler(var ItemReferenceList: TestPage "Item Reference List")
    begin
        ItemReferenceList.FILTER.SetFilter("Reference No.", LibraryVariableStorage.DequeueText);
        repeat
            ItemReferenceList."Reference Type".AssertEquals(LibraryVariableStorage.DequeueInteger);
            ItemReferenceList."Reference Type No.".AssertEquals(LibraryVariableStorage.DequeueText);
            ItemReferenceList."Item No.".AssertEquals(LibraryVariableStorage.DequeueText);
        until ItemReferenceList.Next = false;
        ItemReferenceList.OK.Invoke;
    end;

    [ModalPageHandler]
    [Scope('OnPrem')]
    procedure ItemReferenceListCancelModalPageHandler(var ItemReferenceList: TestPage "Item Reference List")
    begin
        ItemReferenceList.Cancel.Invoke;
    end;

}

