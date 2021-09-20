page 1384 "Item Templ. Card"
{
    Caption = 'Item Template';
    PageType = Card;
    SourceTable = "Item Templ.";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code of the template.';
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the description of the template.';
                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number series that will be used to assign numbers to items.';
                }
            }
            group(Item)
            {
                Caption = 'Item';
                field(Blocked; Blocked)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example an item that is placed in quarantine.';
                }
                field("Sales Blocked"; "Sales Blocked")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the item cannot be entered on sales documents, except return orders and credit memos, and journals.';
                }
                field("Purchasing Blocked"; "Purchasing Blocked")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the item cannot be entered on purchase documents, except return orders and credit memos, and journals.';
                }
                field(Type; Type)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether the item card represents a physical inventory unit (Inventory), a labor time unit (Service), or a physical unit that is not tracked in inventory (Non-Inventory).';
                }
                field("Base Unit of Measure"; "Base Unit of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the base unit used to measure the item, such as piece, box, or pallet. The base unit of measure also serves as the conversion basis for alternate units of measure.';
                }
                field("Item Category Code"; "Item Category Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the category that the item belongs to. Item categories also contain any assigned item attributes.';
                }
                field("Service Item Group"; "Service Item Group")
                {
                    ApplicationArea = Service;
                    Importance = Additional;
                    ToolTip = 'Specifies the code of the service item group that the item belongs to.';
                }
                field("Automatic Ext. Texts"; "Automatic Ext. Texts")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies that an extended text that you have set up will be added automatically on sales or purchase documents for this item.';
                }
                field("Common Item No."; "Common Item No.")
                {
                    ApplicationArea = Intercompany;
                    Importance = Additional;
                    ToolTip = 'Specifies the unique common item number that the intercompany partners agree upon.';
                    Visible = false;
                }
                field("Purchasing Code"; "Purchasing Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the code for a special procurement method, such as drop shipment.';
                    Visible = false;
                }
                field(GTIN; GTIN)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the Global Trade Item Number (GTIN) for the item. For example, the GTIN is used with bar codes to track items, and when sending and receiving documents electronically. The GTIN number typically contains a Universal Product Code (UPC), or European Article Number (EAN).';
                    Visible = false;
                }
            }
            group(InventoryGrp)
            {
                Caption = 'Inventory';
                field("Shelf No."; "Shelf No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies where to find the item in the warehouse. This is informational only.';
                }
                field("Lifo Category"; "Lifo Category")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code for the Last In, First Out (LIFO) category that is assigned to each item.';
                }
                field("Inventory Valuation"; "Inventory Valuation")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the method of inventory valuation that is used to calculate item cost.';
                }
                field("Net Weight"; "Net Weight")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the net weight of the item.';
                    Visible = false;
                }
                field("Gross Weight"; "Gross Weight")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the gross weight of the item.';
                    Visible = false;
                }
                field("Unit Volume"; "Unit Volume")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the volume of one unit of the item.';
                    Visible = false;
                }
                field("Over-Receipt Code"; "Over-Receipt Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the policy that will be used for the item if more items than ordered are received.';
                    Visible = false;
                }
            }
            group(CostsAndPosting)
            {
                Caption = 'Costs & Posting';
                group(CostDetails)
                {
                    Caption = 'Cost Details';
                    field("Standard Cost"; "Standard Cost")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the unit cost that is used as an estimation to be adjusted with variances later. It is typically used in assembly and production where costs can vary.';
                        Visible = false;
                    }
                    field("Unit Cost"; "Unit Cost")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ToolTip = 'Specifies the cost of one unit of the item or resource on the line.';
                        Visible = false;
                    }
                    field("Costing Method"; "Costing Method")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies how the item''s cost flow is recorded and whether an actual or budgeted value is capitalized and used in the cost calculation.';
                    }
                    field("Indirect Cost %"; "Indirect Cost %")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the percentage of the item''s last purchase cost that includes indirect costs, such as freight that is associated with the purchase of the item.';
                    }
                }
                group(PostingDetails)
                {
                    Caption = 'Posting Details';
                    field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ShowMandatory = true;
                        ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
                    }
                    field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        ShowMandatory = true;
                        ToolTip = 'Specifies the VAT specification of the involved item or resource to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                    }
                    field("Tax Group Code"; "Tax Group Code")
                    {
                        ApplicationArea = SalesTax;
                        Importance = Promoted;
                        ToolTip = 'Specifies the tax group that is used to calculate and post sales tax.';
                    }
                    field("Inventory Posting Group"; "Inventory Posting Group")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ToolTip = 'Specifies links between business transactions made for the item and an inventory account in the general ledger, to group amounts for that item type.';
                    }
                    field("Default Deferral Template Code"; "Default Deferral Template Code")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Default Deferral Template';
                        ToolTip = 'Specifies how revenue or expenses for the item are deferred to other accounting periods by default.';
                        Visible = false;
                    }
                }
                group(ForeignTrade)
                {
                    Caption = 'Foreign Trade';
                    field("Tariff No."; "Tariff No.")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies a code for the item''s tariff number.';
                    }
                    field("Country/Region of Origin Code"; "Country/Region of Origin Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        ToolTip = 'Specifies a code for the country/region where the item was produced or processed.';
                        Visible = false;
                    }
                }
            }
            group(PricesAndSales)
            {
                Caption = 'Prices & Sales';
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the price of one unit of the item or resource. You can enter a price manually or have it entered according to the Price/Profit Calculation field on the related card.';
                    Visible = false;
                }
                field("Price Includes VAT"; "Price Includes VAT")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies if the Unit Price and Line Amount fields on sales document lines for this item should be shown with or without VAT.';
                }
                field("Price/Profit Calculation"; "Price/Profit Calculation")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the relationship between the Unit Cost, Unit Price, and Profit Percentage fields associated with this item.';
                }
                field("Profit %"; "Profit %")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the profit margin that you want to sell the item at. You can enter a profit percentage manually or have it entered according to the Price/Profit Calculation field';
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies whether to include the item when calculating an invoice discount on documents where the item is traded.';
                }
                field("Item Disc. Group"; "Item Disc. Group")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies an item group code that can be used as a criterion to grant a discount when the item is sold to a certain customer.';
                }
                field("VAT Bus. Posting Gr. (Price)"; "VAT Bus. Posting Gr. (Price)")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the VAT business posting group for customers for whom you want the sales price including VAT to apply.';
                    Visible = false;
                }
            }
            group(Replenishment)
            {
                Caption = 'Replenishment';
                field("Lead Time Calculation"; "Lead Time Calculation")
                {
                    ApplicationArea = Assembly, Planning;
                    ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
                }
                group(Purchase)
                {
                    Caption = 'Purchase';
                    field("Vendor No."; "Vendor No.")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the vendor code of who supplies this item by default.';
                    }
                    field("Vendor Item No."; "Vendor Item No.")
                    {
                        ApplicationArea = Planning;
                        ToolTip = 'Specifies the number that the vendor uses for this item.';
                        Visible = false;
                    }
                }
                group(Replenishment_Production)
                {
                    Caption = 'Production';
                    field("Manufacturing Policy"; "Manufacturing Policy")
                    {
                        ApplicationArea = Manufacturing;
                        ToolTip = 'Specifies if additional orders for any related components are calculated.';
                    }
                    field("Routing No."; "Routing No.")
                    {
                        ApplicationArea = Manufacturing;
                        ToolTip = 'Specifies the number of the production routing that the item is used in.';
                        Visible = false;
                    }
                    field("Production BOM No."; "Production BOM No.")
                    {
                        ApplicationArea = Manufacturing;
                        ToolTip = 'Specifies the number of the production BOM that the item represents.';
                        Visible = false;
                    }
                    field("Flushing Method"; "Flushing Method")
                    {
                        ApplicationArea = Manufacturing;
                        ToolTip = 'Specifies how consumption of the item (component) is calculated and handled in production processes. Manual: Enter and post consumption in the consumption journal manually. Forward: Automatically posts consumption according to the production order component lines when the first operation starts. Backward: Automatically calculates and posts consumption according to the production order component lines when the production order is finished. Pick + Forward / Pick + Backward: Variations with warehousing.';
                        Visible = false;
                    }
                    field("Overhead Rate"; "Overhead Rate")
                    {
                        ApplicationArea = Manufacturing;
                        Importance = Additional;
                        ToolTip = 'Specifies the item''s indirect cost as an absolute amount.';
                        Visible = false;
                    }
                    field("Scrap %"; "Scrap %")
                    {
                        ApplicationArea = Manufacturing;
                        ToolTip = 'Specifies the percentage of the item that you expect to be scrapped in the production process.';
                        Visible = false;
                    }
                    field("Lot Size"; "Lot Size")
                    {
                        ApplicationArea = Manufacturing;
                        ToolTip = 'Specifies the default number of units of the item that are processed in one production operation. This affects standard cost calculations and capacity planning. If the item routing includes fixed costs such as setup time, the value in this field is used to calculate the standard cost and distribute the setup costs. During demand planning, this value is used together with the value in the Default Dampener % field to ignore negligible changes in demand and avoid re-planning. Note that if you leave the field blank, it will be threated as 1.';
                        Visible = false;
                    }
                }
                group(Replenishment_Assembly)
                {
                    Caption = 'Assembly';
                    field("Assembly Policy"; "Assembly Policy")
                    {
                        ApplicationArea = Assembly;
                        ToolTip = 'Specifies which default order flow is used to supply this assembly item.';
                    }
                }
            }
            group(Planning)
            {
                Caption = 'Planning';
                field("Reordering Policy"; "Reordering Policy")
                {
                    ApplicationArea = Planning;
                    Importance = Promoted;
                    ToolTip = 'Specifies the reordering policy.';
                }
                field(Reserve; Reserve)
                {
                    ApplicationArea = Reservation;
                    Importance = Additional;
                    ToolTip = 'Specifies if and how the item will be reserved. Never: It is not possible to reserve the item. Optional: You can reserve the item manually. Always: The item is automatically reserved from demand, such as sales orders, against inventory, purchase orders, assembly orders, and production orders.';
                    Visible = false;
                }
                field("Order Tracking Policy"; "Order Tracking Policy")
                {
                    ApplicationArea = Planning;
                    Importance = Promoted;
                    ToolTip = 'Specifies if and how order tracking entries are created and maintained between supply and its corresponding demand.';
                    Visible = false;
                }
                field("Dampener Period"; "Dampener Period")
                {
                    ApplicationArea = Planning;
                    Importance = Additional;
                    ToolTip = 'Specifies a period of time during which you do not want the planning system to propose to reschedule existing supply orders forward. The dampener period limits the number of insignificant rescheduling of existing supply to a later date if that new date is within the dampener period. The dampener period function is only initiated if the supply can be rescheduled to a later date and not if the supply can be rescheduled to an earlier date. Accordingly, if the suggested new supply date is after the dampener period, then the rescheduling suggestion is not blocked. If the lot accumulation period is less than the dampener period, then the dampener period is dynamically set to equal the lot accumulation period. This is not shown in the value that you enter in the Dampener Period field. The last demand in the lot accumulation period is used to determine whether a potential supply date is in the dampener period. If this field is empty, then the value in the Default Dampener Period field in the Manufacturing Setup window applies. The value that you enter in the Dampener Period field must be a date formula, and one day (1D) is the shortest allowed period.';
                    Visible = false;
                }
                field("Dampener Quantity"; "Dampener Quantity")
                {
                    ApplicationArea = Planning;
                    Importance = Additional;
                    ToolTip = 'Specifies a dampener quantity to block insignificant change suggestions for an existing supply, if the change quantity is lower than the dampener quantity.';
                    Visible = false;
                }
                field(Critical; Critical)
                {
                    ApplicationArea = OrderPromising;
                    ToolTip = 'Specifies if the item is included in availability calculations to promise a shipment date for its parent item.';
                    Visible = false;
                }
                field("Safety Lead Time"; "Safety Lead Time")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies a date formula to indicate a safety lead time that can be used as a buffer period for production and other delays.';
                    Visible = false;
                }
                field("Safety Stock Quantity"; "Safety Stock Quantity")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies a quantity of stock to have in inventory to protect against supply-and-demand fluctuations during replenishment lead time.';
                    Visible = false;
                }
                group(LotForLotParameters)
                {
                    Visible = false;
                    Caption = 'Lot-for-Lot Parameters';
                    field("Include Inventory"; "Include Inventory")
                    {
                        ApplicationArea = Planning;
                        ToolTip = 'Specifies that the inventory quantity is included in the projected available balance when replenishment orders are calculated.';
                        Visible = false;
                    }
                    field("Lot Accumulation Period"; "Lot Accumulation Period")
                    {
                        ApplicationArea = Planning;
                        ToolTip = 'Specifies a period in which multiple demands are accumulated into one supply order when you use the Lot-for-Lot reordering policy.';
                        Visible = false;
                    }
                    field("Rescheduling Period"; "Rescheduling Period")
                    {
                        ApplicationArea = Planning;
                        ToolTip = 'Specifies a period within which any suggestion to change a supply date always consists of a Reschedule action and never a Cancel + New action.';
                        Visible = false;
                    }
                }
                group(ReorderPointParameters)
                {
                    Caption = 'Reorder-Point Parameters';
                    group(Control64)
                    {
                        ShowCaption = false;
                        field("Reorder Point"; "Reorder Point")
                        {
                            ApplicationArea = Planning;
                            ToolTip = 'Specifies a stock quantity that sets the inventory below the level that you must replenish the item.';
                        }
                        field("Reorder Quantity"; "Reorder Quantity")
                        {
                            ApplicationArea = Planning;
                            ToolTip = 'Specifies a standard lot size quantity to be used for all order proposals.';
                            Visible = false;
                        }
                        field("Maximum Inventory"; "Maximum Inventory")
                        {
                            ApplicationArea = Planning;
                            ToolTip = 'Specifies a quantity that you want to use as a maximum inventory level.';
                            Visible = false;
                        }
                    }
                    field("Overflow Level"; "Overflow Level")
                    {
                        ApplicationArea = Planning;
                        Importance = Additional;
                        ToolTip = 'Specifies a quantity you allow projected inventory to exceed the reorder point, before the system suggests to decrease supply orders.';
                        Visible = false;
                    }
                    field("Time Bucket"; "Time Bucket")
                    {
                        ApplicationArea = Planning;
                        Importance = Additional;
                        ToolTip = 'Specifies a time period that defines the recurring planning horizon used with Fixed Reorder Qty. or Maximum Qty. reordering policies.';
                        Visible = false;
                    }
                }
                group(OrderModifiers)
                {
                    Caption = 'Order Modifiers';
                    group(Control61)
                    {
                        ShowCaption = false;
                        field("Minimum Order Quantity"; "Minimum Order Quantity")
                        {
                            ApplicationArea = Planning;
                            ToolTip = 'Specifies a minimum allowable quantity for an item order proposal.';
                        }
                        field("Maximum Order Quantity"; "Maximum Order Quantity")
                        {
                            ApplicationArea = Planning;
                            ToolTip = 'Specifies a maximum allowable quantity for an item order proposal.';
                            Visible = false;
                        }
                        field("Order Multiple"; "Order Multiple")
                        {
                            ApplicationArea = Planning;
                            ToolTip = 'Specifies a parameter used by the planning system to modify the quantity of planned supply orders.';
                            Visible = false;
                        }
                    }
                }
            }
            group(ItemTracking)
            {
                Caption = 'Item Tracking';
                field("Item Tracking Code"; "Item Tracking Code")
                {
                    ApplicationArea = ItemTracking;
                    Importance = Promoted;
                    ToolTip = 'Specifies how serial or lot numbers assigned to the item are tracked in the supply chain.';
                }
                field("Serial Nos."; "Serial Nos.")
                {
                    ApplicationArea = ItemTracking;
                    ToolTip = 'Specifies a number series code to assign consecutive serial numbers to items produced.';
                }
                field("Lot Nos."; "Lot Nos.")
                {
                    ApplicationArea = ItemTracking;
                    ToolTip = 'Specifies the number series code that will be used when assigning lot numbers.';
                }
                field("Expiration Calculation"; "Expiration Calculation")
                {
                    ApplicationArea = ItemTracking;
                    ToolTip = 'Specifies the date formula for calculating the expiration date on the item tracking line. Note: This field will be ignored if the involved item has Require Expiration Date Entry set to Yes on the Item Tracking Code page.';
                    Visible = false;
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                field("Warehouse Class Code"; "Warehouse Class Code")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies the warehouse class code for the item.';
                }
                field("Special Equipment Code"; "Special Equipment Code")
                {
                    ApplicationArea = Warehouse;
                    Importance = Additional;
                    ToolTip = 'Specifies the code of the equipment that warehouse employees must use when handling the item.';
                }
                field("Put-away Template Code"; "Put-away Template Code")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies the code of the put-away template by which the program determines the most appropriate zone and bin for storage of the item after receipt.';
                }
                field("Phys Invt Counting Period Code"; "Phys Invt Counting Period Code")
                {
                    ApplicationArea = Warehouse;
                    Importance = Promoted;
                    ToolTip = 'Specifies the code of the counting period that indicates how often you want to count the item in a physical inventory.';
                    Visible = false;
                }
                field("Use Cross-Docking"; "Use Cross-Docking")
                {
                    ApplicationArea = Warehouse;
                    Importance = Additional;
                    ToolTip = 'Specifies if this item can be cross-docked.';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(Dimensions)
            {
                ApplicationArea = Dimensions;
                Caption = 'Dimensions';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Default Dimensions";
                RunPageLink = "Table ID" = const(1382),
                              "No." = field(Code);
                ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
            }
            action(CopyTemplate)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Copy Template';
                Image = Copy;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Copies all information to the current template from the selected one.';

                trigger OnAction()
                var
                    ItemTempl: Record "Item Templ.";
                    ItemTemplList: Page "Item Templ. List";
                begin
                    TestField(Code);
                    ItemTempl.SetFilter(Code, '<>%1', Code);
                    ItemTemplList.LookupMode(true);
                    ItemTemplList.SetTableView(ItemTempl);
                    if ItemTemplList.RunModal() = Action::LookupOK then begin
                        ItemTemplList.GetRecord(ItemTempl);
                        CopyFromTemplate(ItemTempl);
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        InventorySetup: Record "Inventory Setup";
    begin
        if Code <> '' then
            exit;

        if not InventorySetup.Get() then
            exit;

        "Costing Method" := InventorySetup."Default Costing Method";
    end;
}