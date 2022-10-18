page 70100 "EVT License Setup"
{
    ApplicationArea = All;
    Caption = 'License Setup';
    PageType = Card;
    SourceTable = "EVT License Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                ShowCaption = false;
                field(PublicKey; Rec.PublicKey.HasValue)
                {
                    ToolTip = 'Specifies the value of the PublicKey field.';
                    Caption = 'Public Key';
                    ApplicationArea = All;
                }
                field(PrivateKey; Rec.PrivateKey.HasValue)
                {
                    ToolTip = 'Specifies the value of the PrivateKey field.';
                    Caption = 'Private Key';
                    ApplicationArea = All;
                }
                field("Serial Nos"; Rec."License Serial Nos")
                {
                    ToolTip = 'Specifies the value of the Serial Number field.';
                    Caption = 'Serial Numbers';
                    ApplicationArea = All;
                }
            }
        }
    }
}
