page 70101 "EVT License Entry List"
{
    ApplicationArea = All;
    Caption = 'License Entry List';
    PageType = List;
    SourceTable = "EVT License Entry";
    UsageCategory = Lists;

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
                field("Action type"; Rec."Action type")
                {
                    ToolTip = 'Specifies the value of the Action type field.';
                    ApplicationArea = All;
                }
                field("Email address"; Rec."Email address")
                {
                    ToolTip = 'Specifies the value of the Email address field.';
                    ApplicationArea = All;
                }
                field(Recipients; Rec.Recipients)
                {
                    ToolTip = 'Specifies the value of the Recipients field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
