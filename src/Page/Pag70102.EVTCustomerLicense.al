page 70102 "EVT Customer License"
{
    ApplicationArea = All;
    Caption = 'Customer License';
    PageType = Card;
    SourceTable = "EVT Customer License";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("License No."; Rec."License No.")
                {
                    ToolTip = 'Specifies the value of the License No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ToolTip = 'Specifies the value of the Issue Date field.';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ToolTip = 'Specifies the value of the Expiration Date field.';
                }
                field("Tenant Id"; Rec."Tenant Id")
                {
                    ToolTip = 'Specifies the value of the Tenant Id field.';
                }
                field("Module 1"; Rec."Module 1")
                {
                    ToolTip = 'Specifies the value of the Module 1 field.';
                }
                field("Module 2"; Rec."Module 2")
                {
                    ToolTip = 'Specifies the value of the Module 2 field.';
                }
                field("Module 3"; Rec."Module 3")
                {
                    ToolTip = 'Specifies the value of the Module 3 field.';
                }
                field("License file"; Rec."License file".HasValue)
                {
                    Caption = 'License file';
                    ToolTip = 'Specifies the value of the License file field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
            }
        }
    }
}
