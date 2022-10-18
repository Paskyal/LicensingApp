page 50101 "EVT License Entry List"
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
                }
                field("Action type"; Rec."Action type")
                {
                    ToolTip = 'Specifies the value of the Action type field.';
                }
                field("Email address"; Rec."Email address")
                {
                    ToolTip = 'Specifies the value of the Email address field.';
                }
                field(Recipients; Rec.Recipients)
                {
                    ToolTip = 'Specifies the value of the Recipients field.';
                }
            }
        }
    }
}
