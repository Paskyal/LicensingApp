table 70100 "EVT License Setup"
{
    Caption = 'License Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; PK; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; PublicKey; Blob)
        {
            Caption = 'PublicKey';
            DataClassification = CustomerContent;
        }
        field(3; PrivateKey; Blob)
        {
            Caption = 'PrivateKey';
            DataClassification = CustomerContent;
        }
        field(4; "License Serial Nos"; Code[20])
        {
            Caption = 'Serial Number';
            DataClassification = CustomerContent;
            // TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; PK)
        {
            Clustered = true;
        }
    }
}
