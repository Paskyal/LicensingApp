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
                    trigger OnAssistEdit()
                    var
                        Selected: Integer;
                        PubKeyInStr: InStream;
                        PubKeyOutStr: OutStream;
                        PubKeyInStr2: InStream;
                        Notice: text;
                        FileName: Text;
                        Options: Text[30];
                        ToFile: Text;
                    begin
                        Options := OptionsImportDownloadLbl;
                        Selected := Dialog.StrMenu(Options, 1, ChooseOptionLbl);
                        if Selected = 1 then begin
                            Notice := KeyImportedLbl;
                            UploadIntoStream(SelectPubKeyTxt, '', ExtFilterTxt, FileName, PubKeyInStr);
                            Rec.PublicKey.CreateOutStream(PubKeyOutStr);
                            CopyStream(PubKeyOutStr, PubKeyInStr);
                            Message(Notice, Selected)
                        end;
                        if Selected = 2 then begin
                            Notice := KeyDownloadedLbl;
                            Rec.CalcFields(PublicKey);
                            Rec.PublicKey.CreateInStream(PubKeyInStr2);
                            ToFile := 'Public Key.xml';
                            DownloadFromStream(PubKeyInStr2, 'Dialog', '', '', ToFile);
                            Message(Notice);
                        end;
                    end;
                }
                field(PrivateKey; Rec.PrivateKey.HasValue)
                {
                    ToolTip = 'Specifies the value of the PrivateKey field.';
                    Caption = 'Private Key';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        Selected: Integer;
                        PrivKeyInStr: InStream;
                        PivKeyOutStr: OutStream;
                        Notice: text;
                        FileName: Text;
                        Options: Text[30];
                    begin
                        Options := OptionImportLbl;
                        Selected := Dialog.StrMenu(Options, 1);
                        if Selected = 1 then begin
                            Notice := PrivKeyImportedLbl;
                            UploadIntoStream(SelectPrivKeyTxt, '', ExtFilterTxt, FileName, PrivKeyInStr);
                            Rec.PrivateKey.CreateOutStream(PivKeyOutStr);
                            CopyStream(PivKeyOutStr, PrivKeyInStr);
                            Message(Notice);
                            Rec.Modify();
                        end;
                    end;
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
    var
        KeyImportedLbl: label 'You Imported a Public Key';
        KeyDownloadedLbl: label 'You Downloaded a Public Key';
        ExtFilterTxt: label 'Xml Files|*.xml';
        SelectPubKeyTxt: label 'Select a Public Key file';
        SelectPrivKeyTxt: label 'Select a Private Key file';
        PrivKeyImportedLbl: label 'You Imported a Private Key';
        ChooseOptionLbl: label 'Choose one of the following options:';
        OptionsImportDownloadLbl: label 'Import,Download';
        OptionImportLbl: label 'Import';
}