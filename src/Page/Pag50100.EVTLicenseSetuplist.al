page 50100 "EVT License Setup list"
{
    ApplicationArea = All;
    Caption = 'License Setup list';
    PageType = List;
    SourceTable = "EVT License Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(PublicKey; Rec.PublicKey.HasValue)
                {
                    ToolTip = 'Specifies the value of the PublicKey field.';
                    Caption = 'Public Key';
                }
                field(PrivateKey; Rec.PrivateKey.HasValue)
                {
                    ToolTip = 'Specifies the value of the PrivateKey field.';
                    Caption = 'Private Key';
                }
                field("Serial Nos"; Rec."License Serial Nos")
                {
                    ToolTip = 'Specifies the value of the Serial Number field.';
                    Caption = 'Serial Numbers';
                }
            }
        }
    }
}
