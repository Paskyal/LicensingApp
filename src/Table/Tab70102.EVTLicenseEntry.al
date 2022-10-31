table 70102 "EVT License Entry"
{
    Caption = 'License Entry';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(11; "License No."; Text[20])
        {
            Caption = 'License No.';
            DataClassification = CustomerContent;
        }
        field(12; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(13; "Customer Name"; Text[75])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
        }
        field(14; "Email address"; Text[50])
        {
            Caption = 'Email address';
            DataClassification = CustomerContent;
        }
        field(15; "Created By"; Text[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(16; "Created At"; DateTime)
        {
            Caption = 'Created At';
            DataClassification = CustomerContent;
        }
        field(20; "Action type"; enum "EVT Status")
        {
            Caption = 'Action type';
            DataClassification = CustomerContent;
        }
        field(21; "Performed By"; Text[50])
        {
            Caption = 'Performed By';
            DataClassification = CustomerContent;
        }
        field(22; "Performed At"; DateTime)
        {
            Caption = 'Performed At';
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