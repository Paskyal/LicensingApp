page 70102 "EVT Customer License Card"
{
    Caption = 'Customer License Card';
    PageType = Card;
    SourceTable = "EVT Customer License";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                ShowCaption = false;
                field("License No."; Rec."License No.")
                {
                    ToolTip = 'Specifies the value of the License No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = All;
                    Editable = AbleToEdit;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = AbleToEdit;
                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update(true);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupCustomerName();
                    end;
                }
                field(CustomerEmail; Rec.CustomerEmail)
                {
                    ToolTip = 'Specifies the value of the Customer Email field.';
                    ApplicationArea = All;
                    Editable = AbleToEdit;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ToolTip = 'Specifies the value of the Issue Date field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                    ApplicationArea = All;
                    Editable = AbleToEdit;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ToolTip = 'Specifies the value of the Expiration Date field.';
                    ApplicationArea = All;
                    Editable = AbleToEdit;
                }
                field("Tenant Id"; Rec."Tenant Id")
                {
                    ToolTip = 'Specifies the value of the Tenant Id field.';
                    ApplicationArea = All;
                    Editable = AbleToEdit;
                }
                field("Module 1"; Rec."Module 1")
                {
                    ToolTip = 'Specifies the value of the Module 1 field.';
                    ApplicationArea = All;
                    Editable = AbleToEdit;
                }
                field("Module 2"; Rec."Module 2")
                {
                    ToolTip = 'Specifies the value of the Module 2 field.';
                    ApplicationArea = All;
                    Editable = AbleToEdit;
                }
                field("Module 3"; Rec."Module 3")
                {
                    ToolTip = 'Specifies the value of the Module 3 field.';
                    ApplicationArea = All;
                    Editable = AbleToEdit;
                }
                field("License File"; Rec."License File".HasValue)
                {
                    Caption = 'License File';
                    ToolTip = 'Specifies the value of the License file field.';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        LicenseEntry: Record "EVT License Entry";
                        TempEmailItem: Record "Email Item" temporary;

                        InStr: InStream;
                        ToFile: Text;

                        Options: Text[30];
                        Selected: Integer;
                        ListOfOptionsLbl: label 'Download,Send,Exit';
                        ChooseOptionLbl: label 'Choose one of the following options:';
                        Notice: text;
                        KeyImportedLbl: label 'You''ve Downloaded a License File';
                        KeySentLbl: label 'You''ve Sent a License File';
                        EmailScenario: Enum "Email Scenario";
                        InStr2: InStream;
                        AttachmentNameTxt: Label 'License.xml';
                    begin
                        Options := ListOfOptionsLbl;
                        Selected := Dialog.StrMenu(Options, 1, ChooseOptionLbl);
                        if Selected = 1 then begin
                            Notice := KeyImportedLbl;
                            Rec.CalcFields("License File");
                            Rec."License File".CreateInStream(InStr, TextEncoding::UTF8);
                            ToFile := 'License.xml';
                            DownloadFromStream(InStr, '', '', '', ToFile);
                            if Rec.Status = Rec.Status::" Issued" then
                                Rec.Status := "EVT Status"::" Sent";
                            Rec.CreateLicenseEntriesStausDownload(LicenseEntry);
                            Message(Notice);
                        end;
                        if Selected = 2 then begin
                            Notice := KeySentLbl;
                            Rec.CalcFields("License File");
                            Rec."License File".CreateInStream(InStr2);
                            TempEmailItem."Send to" := Rec.CustomerEmail;
                            TempEmailItem.Subject := 'Your License';
                            TempEmailItem.AddAttachment(InStr2, AttachmentNameTxt);
                            TempEmailItem.Send(true, EmailScenario);
                            Rec.Status := "EVT Status"::" Sent";
                            Rec.CreateLicenseEntriesStausSent(LicenseEntry);
                        end;
                        if Selected = 3 then exit;
                    end;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(GenerateLicense)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Generates Licensing Xml';
                Caption = 'Generate license';
                Image = CreateXMLFile;

                trigger OnAction()
                var
                    CustomerLicense: Record "EVT Customer License";
                    LicenseSetup: Record "EVT License Setup";
                    LicenseEntry: Record "EVT License Entry";
                    Convert: Codeunit "Base64 Convert";
                    TempBlob: Codeunit "Temp Blob";
                    CryptographyManagement: codeunit "Cryptography Management";
                    HashAlgorithm: enum "Hash Algorithm";
                    SignatureBase64OutStr: OutStream;
                    SignatureOutStr: OutStream;
                    SignatureInStr: InStream;
                    XmlOutStr: OutStream;
                    LicenseAlreadyGenErr: label 'License file has already been generated!';
                    PrivKeyXmlString: Text;
                    SigningString: Text;
                    SignatureBase64Txt: Text;
                    PrivKeyInStr: InStream;
                begin
                    if Rec."License File".HasValue then
                        Error(LicenseAlreadyGenErr);
                    LicenseSetup.FindFirst();
                    LicenseSetup.CalcFields(PrivateKey);
                    LicenseSetup.PrivateKey.CreateInStream(PrivKeyInStr);
                    PrivKeyInStr.Read(PrivKeyXmlString);
                    SigningString := Rec."Tenant Id" + format(Rec."Expiration Date");
                    TempBlob.CreateOutStream(SignatureOutStr);
                    CryptographyManagement.SignData(SigningString, PrivKeyXmlString, HashAlgorithm::SHA256, SignatureOutStr);
                    TempBlob.CreateInStream(SignatureInStr);
                    SignatureBase64Txt := Convert.ToBase64(SignatureInStr);
                    Rec.SignatureBase64.CreateOutStream(SignatureBase64OutStr);
                    SignatureBase64OutStr.Write(SignatureBase64Txt);
                    Rec.Modify();
                    Rec."License File".CreateOutStream(XmlOutStr);
                    CustomerLicense.SetRange("License No.", Rec."License No.");
                    Xmlport.Export(Xmlport::"EVT LicenseExport", XmlOutStr, CustomerLicense);
                    Rec.Status := "EVT Status"::" Issued";
                    Rec."Issue Date" := Today;
                    Rec.CreateLicenseEntriesGenerateLicense(LicenseEntry);

                    Rec.Modify();
                    AbleToEdit := false;
                end;
            }
            action("&SendEmail")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Sends Email';
                Caption = 'Send license';
                Image = Email;
                trigger OnAction()
                var
                    LicenseEntry: Record "EVT License Entry";
                    TempEmailItem: Record "Email Item" temporary;
                    EmailScenario: Enum "Email Scenario";
                    InStr: InStream;
                    AttachmentNameTxt: Label 'License.xml';
                begin
                    Rec.CalcFields("License File");
                    Rec."License File".CreateInStream(InStr);
                    TempEmailItem."Send to" := Rec.CustomerEmail;
                    TempEmailItem.Subject := 'Your License';
                    TempEmailItem.AddAttachment(InStr, AttachmentNameTxt);
                    TempEmailItem.Send(true, EmailScenario);
                    Rec.Status := "EVT Status"::" Sent";
                    Rec.CreateLicenseEntriesStausSent(LicenseEntry);

                end;
            }
            action(LicenseEntries)
            {
                Caption = 'License Entries';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = List;
                ToolTip = 'View information about licenses issued for selected customer.';
                RunObject = page "EVT License Entry List";
                RunPageLink = "Customer No." = FIELD("Customer No.");
                RunPageView = sorting("Entry No.")
                                  order(descending);
            }
        }
    }
    trigger OnOpenPage()
    begin
        AbleToEdit := true;
        if Rec."License File".HasValue then
            AbleToEdit := false;
    end;

    var
        AbleToEdit: Boolean;
}