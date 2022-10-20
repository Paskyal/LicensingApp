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
    actions
    {
        area(Processing)
        {
            action(ImportKeys)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Uploads Private and Public Key files';
                Caption = 'Import Keys';
                Image = Import;
                trigger OnAction()
                var
                    PrivKeyInStr: InStream;
                    PubKeyInStr: InStream;
                    PubKeyOutStr: OutStream;
                    PivKeyOutStr: OutStream;
                    ExtFilterTxt: label 'Xml Files|*.xml';
                    FileName: Text;
                    SelectPrivKeyTxt: label 'Select a Private Key file';
                    SelectPubKeyTxt: label 'Select a Public Key file';
                begin
                    UploadIntoStream(SelectPubKeyTxt, '', ExtFilterTxt, FileName, PubKeyInStr);
                    Rec.PublicKey.CreateOutStream(PubKeyOutStr);
                    CopyStream(PubKeyOutStr, PubKeyInStr);

                    UploadIntoStream(SelectPrivKeyTxt, '', ExtFilterTxt, FileName, PrivKeyInStr);
                    Rec.PrivateKey.CreateOutStream(PivKeyOutStr);
                    CopyStream(PivKeyOutStr, PrivKeyInStr);
                    Rec.Modify();
                end;
            }
            action(DownloadPubKey)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Downloads a Public Key file';
                Caption = 'Download Public Key';
                Image = Download;
                trigger OnAction()
                var
                    PubKeyInStr: InStream;
                    ToFile: Text;
                begin
                    Rec.CalcFields(PublicKey);
                    Rec.PublicKey.CreateInStream(PubKeyInStr);
                    ToFile := 'Public Key.xml';
                    DownloadFromStream(PubKeyInStr, 'Dialog', '', '', ToFile);
                end;
            }
        }
    }
}