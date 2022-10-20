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
                field("Issue Date"; Rec."Issue Date")
                {
                    ToolTip = 'Specifies the value of the Issue Date field.';
                    ApplicationArea = All;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ToolTip = 'Specifies the value of the Expiration Date field.';
                    ApplicationArea = All;
                }
                field("Tenant Id"; Rec."Tenant Id")
                {
                    ToolTip = 'Specifies the value of the Tenant Id field.';
                    ApplicationArea = All;
                }
                field("Module 1"; Rec."Module 1")
                {
                    ToolTip = 'Specifies the value of the Module 1 field.';
                    ApplicationArea = All;
                }
                field("Module 2"; Rec."Module 2")
                {
                    ToolTip = 'Specifies the value of the Module 2 field.';
                    ApplicationArea = All;
                }
                field("Module 3"; Rec."Module 3")
                {
                    ToolTip = 'Specifies the value of the Module 3 field.';
                    ApplicationArea = All;
                }
                field("License File"; Rec."License File".HasValue)
                {
                    Caption = 'License File';
                    ToolTip = 'Specifies the value of the License file field.';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        InStr: InStream;
                        ToFile: Text;
                    begin
                        Rec.CalcFields("License File");
                        Rec."License File".CreateInStream(InStr, TextEncoding::UTF8);
                        ToFile := 'License.xml';
                        DownloadFromStream(InStr, '', '', '', ToFile);
                    end;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
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
                    Convert: Codeunit "Base64 Convert";
                    TempBlob: Codeunit "Temp Blob";
                    CryptographyManagement: codeunit "Cryptography Management";
                    HashAlgorithm: enum "Hash Algorithm";
                    SignatureBase64OutStr: OutStream;
                    SignatureOutStr: OutStream;
                    SignatureInStr: InStream;
                    XmlOutStr: OutStream;
                    PrivKeyXmlString: Text;
                    SigningString: Text;
                    SignatureBase64Txt: Text;
                    PrivKeyInStr: InStream;
                begin
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

                    Rec.Modify();
                    // AbleToEdit := false;
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
                    EmailItem: Record "Email Item";
                    EmailScenario: Enum "Email Scenario";
                    InStr: InStream;
                    AttachmentNameTxt: Label 'License.xml';
                begin
                    // Rec.CalcFields(License);
                    // Rec.License.CreateInStream(InStr);
                    EmailItem."Send to" := 'pasha.mailing@gmail.com';
                    EmailItem.Subject := 'Your License';
                    EmailItem.AddAttachment(InStr, AttachmentNameTxt);
                    EmailItem.Send(true, EmailScenario);
                end;
            }
        }
    }
}