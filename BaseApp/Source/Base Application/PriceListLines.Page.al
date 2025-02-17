page 7001 "Price List Lines"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Price List Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(SourceType; SourceType)
                {
                    ApplicationArea = All;
                    Caption = 'Assign-to Type';
                    Visible = not IsJobGroup and AllowUpdatingDefaults;
                    ToolTip = 'Specifies the type of entity to which the price list is assigned. The options are relevant to the entity you are currently viewing.';

                    trigger OnValidate()
                    begin
                        ValidateSourceType(SourceType.AsInteger());
                    end;
                }
                field(JobSourceType; JobSourceType)
                {
                    ApplicationArea = All;
                    Caption = 'Assign-to Type';
                    Visible = IsJobGroup and AllowUpdatingDefaults;
                    ToolTip = 'Specifies the type of entity to which the price list is assigned. The options are relevant to the entity you are currently viewing.';

                    trigger OnValidate()
                    begin
                        ValidateSourceType(JobSourceType.AsInteger());
                    end;
                }
                field(ParentSourceNo; Rec."Parent Source No.")
                {
                    ApplicationArea = All;
                    Caption = 'Assign-to Job No.';
                    Importance = Promoted;
                    Editable = IsParentAllowed;
                    Visible = AllowUpdatingDefaults and IsParentAllowed;
                    ToolTip = 'Specifies the job to which the prices are assigned. If you choose an entity, the price list will be used only for that entity.';
                }
                field(SourceNo; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Enabled = SourceNoEnabled;
                    Visible = AllowUpdatingDefaults;
                    ToolTip = 'Specifies the entity to which the prices are assigned. The options depend on the selection in the Assign-to Type field. If you choose an entity, the price list will be used only for that entity.';
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Visible = AllowUpdatingDefaults;
                    ToolTip = 'Specifies the currency that is used for the prices on the price list. The currency can be the same for all prices on the price list, or you can specify a currency for individual lines.';
                }
                field(StartingDate; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    Visible = AllowUpdatingDefaults;
                    ToolTip = 'Specifies the date from which the price is valid.';
                }
                field(EndingDate; Rec."Ending Date")
                {
                    ApplicationArea = All;
                    Visible = AllowUpdatingDefaults;
                    ToolTip = 'Specifies the last date that the price is valid.';
                }
                field("Asset Type"; Rec."Asset Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the product.';

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Asset No."; Rec."Asset No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the identifier of the product. If no product is selected, the price and discount values will apply to all products of the selected product type for which those values are not specified. For example, if you choose Item as the product type but do not specify a specific item, the price will apply to all items for which a price is not specified.';
                    Style = Attention;
                    StyleExpr = LineToVerify;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the product.';
                    Style = Attention;
                    StyleExpr = LineToVerify;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Enabled = ItemAsset;
                    Editable = ItemAsset;
                    ToolTip = 'Specifies the item variant.';
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = All;
                    Enabled = ResourceAsset;
                    Editable = ResourceAsset;
                    ToolTip = 'Specifies the work type code for the resource.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Enabled = UOMEditable;
                    Editable = UOMEditable;
                    ToolTip = 'Specifies the unit of measure for the product.';
                }
                field("Minimum Quantity"; Rec."Minimum Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the minimum quantity of the product.';
                }
                field("Amount Type"; Rec."Amount Type")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    Visible = AmountTypeIsVisible;
                    Editable = AmountTypeIsEditable;
                    ToolTip = 'Specifies whether the price list line defines prices, discounts, or both.';
                    trigger OnValidate()
                    begin
                        SetMandatoryAmount();
                    end;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    AccessByPermission = tabledata "Sales Price Access" = R;
                    ApplicationArea = All;
                    Editable = AmountEditable;
                    Enabled = PriceMandatory;
                    Visible = PriceVisible;
                    StyleExpr = PriceStyle;
                    ToolTip = 'Specifies the unit price of the product.';
                }
                field("Cost Factor"; Rec."Cost Factor")
                {
                    AccessByPermission = tabledata "Sales Price Access" = R;
                    ApplicationArea = All;
                    Editable = AmountEditable;
                    Enabled = PriceMandatory;
                    Visible = IsJobGroup and PriceVisible;
                    StyleExpr = PriceStyle;
                    ToolTip = 'Specifies the unit cost factor for job-related prices, if you have agreed with your customer that he should pay certain item usage by cost value plus a certain percent value to cover your overhead expenses.';
                }
#if not CLEAN18
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Visible = false;
                    ToolTip = 'Specifies the unit cost of the product.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Purchase price field is in the Purchase Price List Lines page.';
                    ObsoleteTag = '18.0';
                }
                field(DirectUnitCost; Rec."Direct Unit Cost")
                {
                    Visible = false;
                    ToolTip = 'Specifies the direct unit cost of the product.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Purchase price field is in the Purchase Price List Lines page.';
                    ObsoleteTag = '18.0';
                }
#endif
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ApplicationArea = All;
                    Visible = PriceVisible;
                    Enabled = PriceMandatory;
                    Editable = PriceMandatory;
                    ToolTip = 'Specifies if a line discount will be calculated when the price is offered.';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    AccessByPermission = tabledata "Sales Discount Access" = R;
                    ApplicationArea = All;
                    Visible = DiscountVisible;
                    Enabled = DiscountMandatory;
                    Editable = DiscountMandatory;
                    StyleExpr = DiscountStyle;
                    ToolTip = 'Specifies the line discount percentage for the product.';
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                    Visible = PriceVisible;
                    Enabled = PriceMandatory;
                    Editable = PriceMandatory;
                    ToolTip = 'Specifies if an invoice discount will be calculated when the price is offered.';
                }
                field(PriceIncludesVAT; Rec."Price Includes VAT")
                {
                    ApplicationArea = All;
                    Visible = AllowUpdatingDefaults;
                    ToolTip = 'Specifies the if prices include VAT.';
                }
                field(VATBusPostingGrPrice; Rec."VAT Bus. Posting Gr. (Price)")
                {
                    ApplicationArea = All;
                    Visible = AllowUpdatingDefaults;
                    ToolTip = 'Specifies the default VAT business posting group code.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateSourceType();
        LineToVerify := Rec.IsLineToVerify();
        SetMandatoryAmount();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetEditable();
        UpdateSourceType();
        LineToVerify := Rec.IsLineToVerify();
        SetMandatoryAmount();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if not GetHeader() then
            exit;
        if PriceListHeader."Allow Updating Defaults" then begin
            Rec.CopySourceFrom(PriceListHeader);
            if Rec."Starting Date" = 0D then
                Rec."Starting Date" := PriceListHeader."Starting Date";
            if Rec."Ending Date" = 0D then
                Rec."Ending Date" := PriceListHeader."Ending Date";
            if Rec."Currency Code" = '' then
                Rec."Currency Code" := PriceListHeader."Currency Code";
        end;
        Rec.Validate("Asset Type", xRec."Asset Type");
        UpdateSourceType();
        Rec."Amount Type" := ViewAmountType;
    end;

    local procedure GetHeader(): Boolean
    begin
        if Rec."Price List Code" = '' then
            exit(false);
        if PriceListHeader.Code = Rec."Price List Code" then
            exit(true);
        exit(PriceListHeader.Get(Rec."Price List Code"));
    end;

    var
        DiscountStyle: Text;
        PriceStyle: Text;
        JobSourceType: Enum "Job Price Source Type";
        SourceType: Enum "Sales Price Source Type";
        LineToVerify: Boolean;
        SourceNoEnabled: Boolean;

    protected var
        PriceListHeader: Record "Price List Header";
        PriceType: Enum "Price Type";
        ViewAmountType: Enum "Price Amount Type";
        AllowUpdatingDefaults: Boolean;
        AmountEditable: Boolean;
        AmountTypeIsEditable: Boolean;
        AmountTypeIsVisible: Boolean;
        DiscountMandatory: Boolean;
        DiscountVisible: Boolean;
        IsJobGroup: Boolean;
        IsParentAllowed: Boolean;
        ItemAsset: Boolean;
        PriceMandatory: Boolean;
        PriceVisible: Boolean;
        ResourceAsset: Boolean;
        UOMEditable: Boolean;

    local procedure GetStyle(Mandatory: Boolean): Text;
    begin
        if LineToVerify and Mandatory then
            exit('Attention');
        if Mandatory then
            exit('Strong');
        exit('Subordinate');
    end;

    local procedure SetEditable()
    begin
        AmountTypeIsEditable := Rec."Asset Type" <> Rec."Asset Type"::"Item Discount Group";
        AmountEditable := Rec.IsAmountSupported();
        UOMEditable := Rec.IsUOMSupported();
        ItemAsset := Rec.IsAssetItem();
        ResourceAsset := Rec.IsAssetResource();
    end;

    local procedure SetMandatoryAmount()
    begin
        DiscountMandatory := Rec.IsAmountMandatory(Rec."Amount Type"::Discount);
        DiscountStyle := GetStyle(DiscountMandatory);
        PriceMandatory := Rec.IsAmountMandatory(Rec."Amount Type"::Price);
        PriceStyle := GetStyle(PriceMandatory);
    end;

    local procedure UpdateColumnVisibility()
    begin
        AllowUpdatingDefaults := PriceListHeader."Allow Updating Defaults";
        AmountTypeIsVisible := ViewAmountType = ViewAmountType::Any;
        DiscountVisible := ViewAmountType in [ViewAmountType::Any, ViewAmountType::Discount];
        PriceVisible := ViewAmountType in [ViewAmountType::Any, ViewAmountType::Price];
    end;

    procedure SetHeader(NewPriceListHeader: Record "Price List Header")
    begin
        PriceListHeader := NewPriceListHeader;
        Rec.SetHeader(PriceListHeader);

        SetSubFormLinkFilter(PriceListHeader."Amount Type");
    end;

    procedure SetPriceType(NewPriceType: Enum "Price Type")
    begin
        PriceType := NewPriceType;
        PriceListHeader."Price Type" := NewPriceType;
    end;

    procedure SetSubFormLinkFilter(NewViewAmountType: Enum "Price Amount Type")
    begin
        ViewAmountType := NewViewAmountType;
        Rec.FilterGroup(2);
        if ViewAmountType = ViewAmountType::Any then
            Rec.SetRange("Amount Type")
        else
            Rec.SetFilter("Amount Type", '%1|%2', ViewAmountType, ViewAmountType::Any);
        Rec.FilterGroup(0);
        UpdateColumnVisibility();
        CurrPage.Update(false);
        CurrPage.Activate(true);
    end;

    local procedure UpdateSourceType()
    var
        PriceSource: Record "Price Source";
    begin
        case PriceListHeader."Source Group" of
            "Price Source Group"::Customer:
                begin
                    IsJobGroup := false;
                    SourceType := "Sales Price Source Type".FromInteger(Rec."Source Type".AsInteger());
                end;
            "Price Source Group"::Job:
                begin
                    IsJobGroup := true;
                    JobSourceType := "Job Price Source Type".FromInteger(Rec."Source Type".AsInteger());
                end;
            else
                OnUpdateSourceTypeOnCaseElse(PriceListHeader, SourceType, IsJobGroup);
        end;
        PriceSource."Source Type" := Rec."Source Type";
        IsParentAllowed := PriceSource.IsParentSourceAllowed();
    end;

    local procedure SetSourceNoEnabled()
    begin
        SourceNoEnabled := Rec.IsSourceNoAllowed();
    end;

    local procedure ValidateSourceType(SourceType: Integer)
    begin
        Rec.Validate("Source Type", SourceType);
        SetSourceNoEnabled();
        CurrPage.Update(true);
    end;

#if not CLEAN18
    [Obsolete('Used to be a workaround for now fixed bug 374742.', '18.0')]
    procedure RunOnAfterSetSubFormLinkFilter()
    var
        SkipActivate: Boolean;
    begin
        OnAfterSetSubFormLinkFilter(SkipActivate);
    end;

    [Obsolete('Used to be a workaround for now fixed bug 374742.', '18.0')]
    [IntegrationEvent(true, false)]
    local procedure OnAfterSetSubFormLinkFilter(var SkipActivate: Boolean)
    begin
    end;
#endif

    [IntegrationEvent(false, false)]
    local procedure OnUpdateSourceTypeOnCaseElse(PriceListHeader: Record "Price List Header"; var SourceType: Enum "Sales Price Source Type"; var IsJobGroup: Boolean)
    begin
    end;
}
