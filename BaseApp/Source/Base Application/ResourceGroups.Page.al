page 72 "Resource Groups"
{
    ApplicationArea = Jobs;
    Caption = 'Resource Groups';
    PageType = List;
    SourceTable = "Resource Group";
    PromotedActionCategories = 'New,Process,Report,Prices & Discounts';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; "No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Name; Name)
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies a short description of the resource group.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Res. &Group")
            {
                Caption = 'Res. &Group';
                Image = Group;
                action(Statistics)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Res. Gr. Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Unit of Measure Filter" = FIELD("Unit of Measure Filter"),
                                  "Chargeable Filter" = FIELD("Chargeable Filter");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Resource Group"),
                                  "No." = FIELD("No.");
                    ToolTip = 'View or add comments for the record.';
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(152),
                                      "No." = FIELD("No.");
                        ShortCutKey = 'Alt+D';
                        ToolTip = 'View or edit the single set of dimensions that are set up for the selected record.';
                    }
                    action("Dimensions-&Multiple")
                    {
                        AccessByPermission = TableData Dimension = R;
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;
                        ToolTip = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.';

                        trigger OnAction()
                        var
                            ResGr: Record "Resource Group";
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SetSelectionFilter(ResGr);
                            DefaultDimMultiple.SetMultiRecord(ResGr, FieldNo("No."));
                            DefaultDimMultiple.RunModal;
                        end;
                    }
                }
            }
            group("&Prices")
            {
                Caption = '&Prices';
                Image = Price;
#if not CLEAN19
                action(Costs)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Costs';
                    Image = ResourceCosts;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Resource Costs";
                    RunPageLink = Type = CONST("Group(Resource)"),
                                  Code = FIELD("No.");
                    Visible = not ExtendedPriceEnabled;
                    ToolTip = 'View or change detailed information about costs for the resource.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
                    ObsoleteTag = '17.0';
                }
                action(Prices)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Prices';
                    Image = Price;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Resource Prices";
                    RunPageLink = Type = CONST("Group(Resource)"),
                                  Code = FIELD("No.");
                    Visible = not ExtendedPriceEnabled;
                    ToolTip = 'View or edit prices for the resource.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
                    ObsoleteTag = '17.0';
                }
#endif
                action(PurchPriceLists)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Purchase Prices';
                    Image = ResourceCosts;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = ExtendedPriceEnabled;
                    ToolTip = 'View or change detailed information about costs for the resource group.';

                    trigger OnAction()
                    var
                        AmountType: Enum "Price Amount Type";
                        PriceType: Enum "Price Type";
                    begin
                        Rec.ShowPriceListLines(PriceType::Purchase, AmountType::Any);
                    end;
                }
                action(SalesPriceLists)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Sales Prices';
                    Image = Price;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = ExtendedPriceEnabled;
                    ToolTip = 'View or edit prices for the resource group.';

                    trigger OnAction()
                    var
                        AmountType: Enum "Price Amount Type";
                        PriceType: Enum "Price Type";
                    begin
                        Rec.ShowPriceListLines(PriceType::Sale, AmountType::Any);
                    end;
                }
            }
            group("Plan&ning")
            {
                Caption = 'Plan&ning';
                Image = Planning;
                action(ResGroupCapacity)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Res. Group &Capacity';
                    Image = Capacity;
                    RunObject = Page "Res. Group Capacity";
                    RunPageOnRec = true;
                    ToolTip = 'View the capacity of the resource group.';
                }
                action("Res. Group All&ocated per Job")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Res. Group All&ocated per Job';
                    Image = ViewJob;
                    RunObject = Page "Res. Gr. Allocated per Job";
                    RunPageLink = "Resource Gr. Filter" = FIELD("No.");
                    ToolTip = 'View the job allocations of the resource group.';
                }
                action("Res. Group Allocated per Service &Order")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Res. Group Allocated per Service &Order';
                    Image = ViewServiceOrder;
                    RunObject = Page "Res. Gr. Alloc. per Serv Order";
                    RunPageLink = "Resource Group Filter" = FIELD("No.");
                    ToolTip = 'View the service order allocations of the resource group.';
                }
                action("Res. Group Availa&bility")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Res. Group Availa&bility';
                    Image = Calendar;
                    RunObject = Page "Res. Group Availability";
                    RunPageLink = "No." = FIELD("No."),
                                  "Unit of Measure Filter" = FIELD("Unit of Measure Filter"),
                                  "Chargeable Filter" = FIELD("Chargeable Filter");
                    ToolTip = 'View a summary of resource group capacities, the quantity of resource hours allocated to jobs on order, the quantity allocated to service orders, the capacity assigned to jobs on quote, and the resource group availability.';
                }
            }
        }
        area(creation)
        {
            action("New Resource")
            {
                ApplicationArea = Jobs;
                Caption = 'New Resource';
                Image = NewResource;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Resource Card";
                RunPageLink = "Resource Group No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new resource.';
            }
        }
    }

    trigger OnOpenPage()
    var
        PriceCalculationMgt: Codeunit "Price Calculation Mgt.";
    begin
        ExtendedPriceEnabled := PriceCalculationMgt.IsExtendedPriceCalculationEnabled();
    end;

    var
        ExtendedPriceEnabled: Boolean;
}

