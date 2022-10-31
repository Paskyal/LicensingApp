page 70101 "EVT License Entry List"
{
    ApplicationArea = All;
    Caption = 'License Entry List';
    PageType = List;
    SourceTable = "EVT License Entry";
    UsageCategory = Lists;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    ApplicationArea = All;
                }
                field("License No."; Rec."License No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the License No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created At field.';
                }
                field("Action type"; Rec."Action type")
                {
                    ToolTip = 'Specifies the value of the Action type field.';
                    ApplicationArea = All;
                }
                field("Email address"; Rec."Email address")
                {
                    Caption = 'Sent To';
                    ToolTip = 'Specifies the value of the Email address field.';
                    ApplicationArea = All;
                }
                field("Performed By"; Rec."Performed By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Performed By field.';
                }
                field("Performed At"; Rec."Performed At")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Performed At field.';
                }
            }
        }
    }
}
