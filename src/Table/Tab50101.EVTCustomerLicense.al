table 50101 "EVT Customer License"
{
    Caption = 'Customer License';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "License No."; Code[20])
        {
            Caption = 'License No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "License No." <> xRec."License No." then begin
                    GetLicenseSetup();
                    NoSeriesMgt.TestManual(GetNoSeriesCode());
                end;
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(3; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
        }
        field(4; "Issue Date"; Date)
        {
            Caption = 'Issue Date';
            DataClassification = CustomerContent;
        }
        field(5; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = CustomerContent;
        }
        field(6; "Tenant Id"; Integer)
        {
            Caption = 'Tenant Id';
            DataClassification = CustomerContent;
        }
        field(7; "Module 1"; Boolean)
        {
            Caption = 'Module 1';
            DataClassification = CustomerContent;
        }
        field(8; "Module 2"; Boolean)
        {
            Caption = 'Module 2';
            DataClassification = CustomerContent;
        }
        field(9; "Module 3"; Boolean)
        {
            Caption = 'Module 3';
            DataClassification = CustomerContent;
        }
        field(10; "License file"; Blob)
        {
            Caption = 'License file';
            DataClassification = CustomerContent;
        }
        field(11; Status; Enum "EVT Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(12; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "License No.")
        {
            Clustered = true;
        }
    }
    local procedure GetLicenseSetup()
    var
        LicenseSetup: Record "EVT License Setup";
    begin
        if LicenseSetup.Get() then
            exit;
        LicenseSetup.Init();
        LicenseSetup.Insert(true);
        Commit();
    end;

    procedure GetNoSeriesCode(): Code[20]
    var
        LicenseSetup: Record "EVT License Setup";
    begin
        exit(NoSeriesMgt.GetNoSeriesWithCheck(LicenseSetup."License Serial Nos", false, "No. Series"));
    end;

    var
        NoSeriesMgt: codeunit NoSeriesManagement;
}
