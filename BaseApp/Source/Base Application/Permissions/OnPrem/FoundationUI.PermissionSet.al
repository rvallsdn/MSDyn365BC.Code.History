permissionset 6946 "Foundation UI"
{
    Access = Public;
    Assignable = false;
    Caption = 'Recommended for UI Removal';

    IncludedPermissionSets = "BaseApp Objects - Exec",
                             "System App - Basic";

    Permissions = tabledata Field = R,
                  tabledata Media = imd,
                  tabledata "Media Set" = imd,
                  tabledata User = R,
                  tabledata "Acc. Sched. KPI Web Srv. Setup" = Rim,
                  tabledata "Account Schedules Chart Setup" = Rim,
                  tabledata "Accounting Period" = R,
                  tabledata "Analysis by Dim. Parameters" = RIMD,
                  tabledata "Analysis by Dim. User Param." = RIMD,
                  tabledata "Analysis Report Chart Setup" = Rim,
                  tabledata "Application Area Buffer" = RIMD,
                  tabledata "Application Area Setup" = RIMD,
                  tabledata "Assembly Setup" = Rim,
                  tabledata "Availability at Date" = Rimd,
                  tabledata "Azure AI Usage" = Rimd,
                  tabledata "Bank Export/Import Setup" = Rim,
                  tabledata "Base Calendar" = R,
                  tabledata "Base Calendar Change" = R,
                  tabledata "Business Chart Buffer" = RIMD,
                  tabledata "Business Chart Map" = RIMD,
                  tabledata "Business Chart User Setup" = Rim,
                  tabledata "Cash Flow Azure AI Buffer" = Rimd,
                  tabledata "Cash Flow Chart Setup" = Rim,
                  tabledata "Cash Flow Setup" = Rim,
                  tabledata "CDS Connection Setup" = R,
                  tabledata "Change Log Entry" = ri,
                  tabledata "Change Log Setup (Field)" = r,
                  tabledata "Change Log Setup (Table)" = r,
                  tabledata "Change Log Setup" = Rim,
                  tabledata "Company Information" = R,
                  tabledata "Config. Setup" = Rim,
                  tabledata "Contact Business Relation" = R,
                  tabledata "Cost Accounting Setup" = Rim,
                  tabledata "CRM Connection Setup" = R,
                  tabledata "Custom Report Layout" = RIMD,
                  tabledata "Customer Discount Group" = R,
                  tabledata "Customized Calendar Change" = R,
                  tabledata "Customized Calendar Entry" = R,
                  tabledata "Depreciation Book" = R,
                  tabledata Dimension = R,
                  tabledata "Dimension Buffer" = R,
                  tabledata "Dimension Code Buffer" = R,
                  tabledata "Dimension Selection Buffer" = R,
                  tabledata "Dimension Set Entry" = Rim,
                  tabledata "Dimension Set Tree Node" = Rim,
                  tabledata "Dimension Translation" = R,
                  tabledata "Dimension Value" = R,
                  tabledata "Document Entry" = RIMD,
                  tabledata "Duplicate Search String Setup" = Rim,
                  tabledata "Dynamic Request Page Entity" = R,
                  tabledata "Dynamic Request Page Field" = R,
                  tabledata "Excel Template Storage" = RIMD,
                  tabledata "Experience Tier Buffer" = RIMD,
                  tabledata "Experience Tier Setup" = RIMD,
                  tabledata "Extended Text Header" = R,
                  tabledata "FA Date Type" = RIMD,
                  tabledata "FA Journal Setup" = Rim,
                  tabledata "FA Matrix Posting Type" = RIMD,
                  tabledata "FA Posting Type" = RIMD,
                  tabledata "FA Posting Type Setup" = Rim,
                  tabledata "FA Setup" = Rim,
                  tabledata "Field Buffer" = RIMD,
                  tabledata "G/L Account Net Change" = RIMD,
                  tabledata "General Ledger Setup" = Rim,
                  tabledata "General Posting Setup" = Rim,
                  tabledata "Generic Chart Setup" = Rim,
                  tabledata "Human Resources Setup" = Rim,
                  tabledata "Incoming Documents Setup" = Rim,
                  tabledata "Interaction Log Entry" = r,
                  tabledata "Interaction Template Setup" = Rim,
                  tabledata "Inventory Posting Setup" = Rim,
                  tabledata "Inventory Setup" = Rim,
                  tabledata "Item Discount Group" = R,
                  tabledata "Item Entry Relation" = Rimd,
                  tabledata "Job Buffer" = RIMD,
                  tabledata "Job Difference Buffer" = RIMD,
                  tabledata "Job Entry No." = RIMD,
                  tabledata "Job Queue Category" = Rimd,
                  tabledata "Job Queue Entry" = Rimd,
                  tabledata "Job Queue Log Entry" = Rimd,
                  tabledata "Job WIP Buffer" = RIMD,
                  tabledata "Jobs Setup" = Rim,
                  tabledata "License Agreement" = RIM,
                  tabledata "Manufacturing Setup" = Rim,
                  tabledata "Marketing Setup" = Rim,
                  tabledata "No. Series" = Rm,
                  tabledata "No. Series Line" = Rm,
                  tabledata "No. Series Relationship" = Rm,
                  tabledata "Nonstock Item Setup" = Rim,
                  tabledata "Notification Entry" = Rimd,
                  tabledata "Online Map Parameter Setup" = Rim,
                  tabledata "Online Map Setup" = Rim,
                  tabledata Opportunity = r,
                  tabledata "Opportunity Entry" = r,
                  tabledata "Order Promising Setup" = R,
#if not CLEAN19
                  tabledata "Outlook Synch. User Setup" = Rim,
#endif
                  tabledata "Payment Registration Setup" = Rim,
                  tabledata "Picture Entity" = RIMD,
                  tabledata "Post Code" = Ri,
                  tabledata "Printer Selection" = R,
                  tabledata "Purch. Inv. Entity Aggregate" = RIMD,
                  tabledata "Purch. Inv. Line Aggregate" = RIMD,
                  tabledata "Purchase Order Entity Buffer" = RIMD,
                  tabledata "Purchases & Payables Setup" = Rim,
                  tabledata "Reclas. Dimension Set Buffer" = RIMD,
                  tabledata "Report List Translation" = RIMD,
                  tabledata "Resources Setup" = Rim,
                  tabledata "Restricted Record" = Rimd,
                  tabledata "Returns-Related Document" = Rimd,
                  tabledata "Sales & Receivables Setup" = Rim,
                  tabledata "Sales by Cust. Grp.Chart Setup" = Rim,
                  tabledata "Sales Cr. Memo Entity Buffer" = RIMD,
                  tabledata "Sales Invoice Entity Aggregate" = RIMD,
                  tabledata "Sales Invoice Line Aggregate" = RIMD,
                  tabledata "Sales Order Entity Buffer" = RIMD,
                  tabledata "Selected Dimension" = RIMD,
                  tabledata "Sent Notification Entry" = Rimd,
                  tabledata "Serv. Price Group Setup" = Rim,
                  tabledata "Service Connection" = RIMD,
                  tabledata "Service Mgt. Setup" = Rim,
                  tabledata "Service Status Priority Setup" = Rim,
                  tabledata "SMTP Mail Setup" = Rim,
                  tabledata "Social Listening Search Topic" = Rim,
                  tabledata "Social Listening Setup" = Rim,
                  tabledata "Source Code" = R,
                  tabledata "Source Code Setup" = Rim,
                  tabledata "Standard Text" = R,
                  tabledata "Time Sheet Chart Setup" = Rim,
                  tabledata "To-do" = r,
                  tabledata "Top Customers By Sales Buffer" = RIMD,
                  tabledata "Trailing Sales Orders Setup" = RIm,
                  tabledata "Trial Balance Setup" = Rim,
                  tabledata "Troubleshooting Setup" = Rim,
#if not CLEAN19
                  tabledata "User Callouts" = RIMD,
#endif
                  tabledata "User Setup" = Rim,
                  tabledata "User Time Register" = rim,
                  tabledata "Value Entry Relation" = Rimd,
                  tabledata "VAT Assisted Setup Bus. Grp." = Rim,
                  tabledata "VAT Assisted Setup Templates" = Rim,
                  tabledata "VAT Posting Setup" = Rim,
                  tabledata "VAT Rate Change Setup" = Rim,
                  tabledata "VAT Report Setup" = Rim,
                  tabledata "VAT Setup Posting Groups" = Rim,
                  tabledata "Warehouse Setup" = Rim,
                  tabledata "Where Used Base Calendar" = Rimd,
                  tabledata "Whse. Item Entry Relation" = Rimd,
                  tabledata "Whse. Item Tracking Line" = Rimd,
                  tabledata "Workflow - Record Change" = Rimd,
                  tabledata "Workflow - Table Relation" = R,
                  tabledata Workflow = R,
                  tabledata "Workflow Buffer" = RIMD,
                  tabledata "Workflow Category" = R,
                  tabledata "Workflow Event" = R,
                  tabledata "Workflow Event Queue" = Rimd,
                  tabledata "Workflow Record Change Archive" = Rimd,
                  tabledata "Workflow Response" = R,
                  tabledata "Workflow Rule" = Rimd,
                  tabledata "Workflow Step" = R,
                  tabledata "Workflow Step Argument" = Rimd,
                  tabledata "Workflow Step Argument Archive" = Rimd,
                  tabledata "Workflow Step Instance" = Rimd,
                  tabledata "Workflow Step Instance Archive" = Rimd,
                  tabledata "Workflow Table Relation Value" = Rimd,
                  tabledata "Workflow User Group" = R,
                  tabledata "Workflow User Group Member" = R;
}
