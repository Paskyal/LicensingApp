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
                        Options: Text[30];
                        Selected: Integer;
                        ListOfOptionsLbl: label 'Import,Download,Exit';
                        ChooseOptionLbl: label 'Choose one of the following options:';
                        Notice: text;
                        PubKeyInStr: InStream;
                        PubKeyOutStr: OutStream;
                        ExtFilterTxt: label 'Xml Files|*.xml';
                        FileName: Text;
                        SelectPubKeyTxt: label 'Select a Public Key file';
                        PubKeyInStr2: InStream;
                        ToFile: Text;
                        KeyImportedLbl: label 'You Imported a Public Key';
                        KeyDownloadedLbl: label 'You Imported a Public Key';
                    begin
                        Options := ListOfOptionsLbl;
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
                        if Selected = 3 then exit;
                    end;
                }
                field(PrivateKey; Rec.PrivateKey.HasValue)
                {
                    ToolTip = 'Specifies the value of the PrivateKey field.';
                    Caption = 'Private Key';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        Options: Text[30];
                        Selected: Integer;
                        ListOfOptionsLbl: label 'Import,Exit';
                        ChooseOptionLbl: label 'Choose one of the following options:';
                        Notice: text;
                        PrivKeyInStr: InStream;
                        PivKeyOutStr: OutStream;
                        ExtFilterTxt: label 'Xml Files|*.xml';
                        FileName: Text;
                        SelectPrivKeyTxt: label 'Select a Private Key file';
                        KeyImportedLbl: label 'You Imported a Private Key';
                    begin
                        Options := ListOfOptionsLbl;
                        Selected := Dialog.StrMenu(Options, 1, ChooseOptionLbl);
                        if Selected = 1 then begin
                            Notice := KeyImportedLbl;
                            UploadIntoStream(SelectPrivKeyTxt, '', ExtFilterTxt, FileName, PrivKeyInStr);
                            Rec.PrivateKey.CreateOutStream(PivKeyOutStr);
                            CopyStream(PivKeyOutStr, PrivKeyInStr);
                            Message(Notice);
                            Rec.Modify();
                        end;
                        if Selected = 2 then exit;
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
}