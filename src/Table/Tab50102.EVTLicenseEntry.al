table 50102 "EVT License Entry"
{
    Caption = 'License Entry';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Code[20])
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Action type"; enum "EVT Action type")
        {
            Caption = 'Action type';
            DataClassification = CustomerContent;
        }
        field(3; "Email address"; Text[100])
        {
            Caption = 'Email address';
            DataClassification = CustomerContent;
        }
        field(4; Recipients; Text[1024])
        {
            Caption = 'Recipients';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
