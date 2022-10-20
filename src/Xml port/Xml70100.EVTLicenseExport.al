xmlport 70100 "EVT LicenseExport"
{
    Caption = 'LicenseExport';
    Direction = Export;
    Format = Xml;
    schema
    {
        tableelement(Root; "EVT Customer License")
        {
            fieldelement(TenantID; Root."Tenant Id")
            {
            }
            fieldelement(ExpirationDate; Root."Expiration Date")
            {
            }
            fieldelement(Module1; Root."Module 1")
            {
            }
            fieldelement(Module2; Root."Module 2")
            {
            }
            fieldelement(Module3; Root."Module 3")
            {
            }
            textelement(PublicKey)
            {
            }
            textelement(Signature)
            {
            }
            trigger OnAfterGetRecord()
            var
                LicenseSetup: Record "EVT License Setup";
                Convert: Codeunit "Base64 Convert";
                PubKeyInStr: InStream;
                SignatureInStr: InStream;
                KeyTxt: Text;
                SignatureTxt: Text;
                PubKeyBase64: Text;
            begin
                LicenseSetup.CalcFields(PublicKey);
                LicenseSetup.PublicKey.CreateInStream(PubKeyInStr);
                PubKeyBase64 := Convert.ToBase64(PubKeyInStr);
                PublicKey := PubKeyBase64;
                Root.CalcFields(SignatureBase64);
                Root.SignatureBase64.CreateInStream(SignatureInStr);
                SignatureInStr.Read(SignatureTxt);
                Signature := SignatureTxt;
            end;
        }
    }
}
