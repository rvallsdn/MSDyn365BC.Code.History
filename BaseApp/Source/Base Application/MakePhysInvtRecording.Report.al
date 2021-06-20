report 5881 "Make Phys. Invt. Recording"
{
    Caption = 'Make New Phys. Invt. Recording';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Phys. Invt. Order Header"; "Phys. Invt. Order Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            dataitem("Phys. Invt. Order Line"; "Phys. Invt. Order Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                RequestFilterFields = "Item No.", "Location Code", "Bin Code", "Shelf No.", "Inventory Posting Group";

                trigger OnAfterGetRecord()
                begin
                    if CheckOrderLine("Phys. Invt. Order Line") then begin
                        if not HeaderInserted then begin
                            InsertRecordingHeader("Phys. Invt. Order Header");
                            HeaderInserted := true;
                            NextLineNo := 10000;
                            HeaderCount := HeaderCount + 1;
                        end;
                        InsertRecordingLine("Phys. Invt. Order Line");
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    HeaderInserted := false;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TestField(Status, Status::Open);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(OnlyLinesNotInRecordings; OnlyLinesNotInRecordings)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Only Lines Not In Recordings';
                        ToolTip = 'Specifies that a new physical inventory recording lines are only created when the data does not exist on any other physical inventory recording line. This is useful when you want to make sure that different recordings do not contain the same items.';
                    }
                    field(AllowRecWithoutOrder; AllowRecWithoutOrder)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Allow Recording Without Order';
                        ToolTip = 'Specifies that recording lines are automatically created for items that do not exist on the physical inventory order. This can only happen if none of the values in these four fields exist for an item on the order: Item No., Variant Code, Location Code, and Bin Code.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        case HeaderCount of
            0:
                Message(NewOrderNotCreatedMsg);
            1:
                Message(NewOrderCreatedMsg,
                  PhysInvtRecordHeader."Order No.", PhysInvtRecordHeader."Recording No.");
            else
                Message(DifferentOrdersMsg, HeaderCount);
        end;

        OnAfterOnPostReport(PhysInvtRecordHeader, HeaderCount);
    end;

    trigger OnPreReport()
    begin
        HeaderCount := 0;
    end;

    var
        NewOrderNotCreatedMsg: Label 'A physical inventory recording was not created because no valid physical inventory order lines exist.';
        NewOrderCreatedMsg: Label 'Physical inventory recording %1 %2 has been created.', Comment = '%1 = Order No. %2 = Recording No.';
        DifferentOrdersMsg: Label '%1 different orders has been created.', Comment = '%1 = counter';
        PhysInvtRecordHeader: Record "Phys. Invt. Record Header";
        PhysInvtRecordLine: Record "Phys. Invt. Record Line";
        NextLineNo: Integer;
        HeaderCount: Integer;
        OnlyLinesNotInRecordings: Boolean;
        HeaderInserted: Boolean;
        AllowRecWithoutOrder: Boolean;

    procedure CheckOrderLine(PhysInvtOrderLine: Record "Phys. Invt. Order Line"): Boolean
    var
        PhysInvtRecordLine2: Record "Phys. Invt. Record Line";
    begin
        with PhysInvtOrderLine do begin
            if EmptyLine then
                exit(false);
            TestField("Item No.");
            if OnlyLinesNotInRecordings then begin
                PhysInvtRecordLine2.SetCurrentKey(
                  "Order No.", "Item No.", "Variant Code", "Location Code", "Bin Code");
                PhysInvtRecordLine2.SetRange("Order No.", "Document No.");
                PhysInvtRecordLine2.SetRange("Item No.", "Item No.");
                PhysInvtRecordLine2.SetRange("Variant Code", "Variant Code");
                PhysInvtRecordLine2.SetRange("Location Code", "Location Code");
                PhysInvtRecordLine2.SetRange("Bin Code", "Bin Code");
                OnCheckOrderLineOnAfterSetFilters(PhysInvtRecordLine2, PhysInvtOrderLine);
                if PhysInvtRecordLine2.FindFirst then
                    exit(false);
            end;
        end;
        exit(true);
    end;

    procedure InsertRecordingHeader(PhysInvtOrderHeader: Record "Phys. Invt. Order Header")
    begin
        with PhysInvtRecordHeader do begin
            Init;
            "Order No." := PhysInvtOrderHeader."No.";
            "Recording No." := 0;
            "Person Responsible" := PhysInvtOrderHeader."Person Responsible";
            "Location Code" := PhysInvtOrderHeader."Location Code";
            "Bin Code" := PhysInvtOrderHeader."Bin Code";
            "Allow Recording Without Order" := AllowRecWithoutOrder;
            Insert(true);
        end;
    end;

    procedure InsertRecordingLine(PhysInvtOrderLine: Record "Phys. Invt. Order Line")
    begin
        with PhysInvtRecordLine do begin
            Init;
            "Order No." := PhysInvtRecordHeader."Order No.";
            "Recording No." := PhysInvtRecordHeader."Recording No.";
            "Line No." := NextLineNo;
            Validate("Item No.", PhysInvtOrderLine."Item No.");
            Validate("Variant Code", PhysInvtOrderLine."Variant Code");
            Validate("Location Code", PhysInvtOrderLine."Location Code");
            Validate("Bin Code", PhysInvtOrderLine."Bin Code");
            Description := PhysInvtOrderLine.Description;
            "Description 2" := PhysInvtOrderLine."Description 2";
            "Use Item Tracking" := PhysInvtOrderLine."Use Item Tracking";
            Validate("Unit of Measure Code", PhysInvtOrderLine."Base Unit of Measure Code");
            Recorded := false;
            OnBeforePhysInvtRecordLineInsert(PhysInvtRecordLine, PhysInvtOrderLine);
            Insert;
            OnAfterPhysInvtRecordLineInsert(PhysInvtRecordLine, PhysInvtOrderLine);
            NextLineNo := NextLineNo + 10000;
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnPostReport(var PhysInvtRecordHeader: Record "Phys. Invt. Record Header"; HeadCount: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPhysInvtRecordLineInsert(var PhysInvtRecordLine: Record "Phys. Invt. Record Line"; PhysInvtOrderLine: Record "Phys. Invt. Order Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePhysInvtRecordLineInsert(var PhysInvtRecordLine: Record "Phys. Invt. Record Line"; PhysInvtOrderLine: Record "Phys. Invt. Order Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCheckOrderLineOnAfterSetFilters(var PhysInvtRecordLine: Record "Phys. Invt. Record Line"; PhysInvtOrderLine: Record "Phys. Invt. Order Line")
    begin
    end;
}

