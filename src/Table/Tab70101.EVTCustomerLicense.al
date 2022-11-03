table 70101 "EVT Customer License"
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
            TableRelation = Customer;
            trigger OnValidate()
            begin
                Rec.Validate("Customer Name")
            end;
        }
        field(3; "Customer Name"; Text[75])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                CustomerName: Text[100];
            begin
                CustomerName := "Customer Name";
                SetCustomerName(CustomerName);
                "Customer Name" := CustomerName;
            end;
        }
        field(4; "Issue Date"; Date)
        {
            Caption = 'Issue Date';
            DataClassification = CustomerContent;
        }
        field(5; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(6; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = CustomerContent;
        }
        field(7; "Tenant Id"; Text[250])
        {
            Caption = 'Tenant Id';
            DataClassification = CustomerContent;
        }
        field(8; "Module 1"; Boolean)
        {
            Caption = 'Module 1';
            DataClassification = CustomerContent;
        }
        field(9; "Module 2"; Boolean)
        {
            Caption = 'Module 2';
            DataClassification = CustomerContent;
        }
        field(10; "Module 3"; Boolean)
        {
            Caption = 'Module 3';
            DataClassification = CustomerContent;
        }
        field(11; "License File"; Blob)
        {
            Caption = 'License File';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "License File".HasValue then
                    Status := "EVT Status"::" Issued"
                else
                    Status := "EVT Status"::New;
                Rec.Modify();
            end;
        }
        field(12; Status; Enum "EVT Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14; SignatureBase64; Blob)
        {
            Caption = 'Encrypted Data';
            DataClassification = CustomerContent;
        }
        field(15; CustomerEmail; Text[100])
        {
            Caption = 'Customer Email';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "License No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        InitInsert();
    end;

    procedure InitInsert()
    begin
        if "License No." = '' then begin
            TestNoSeries();
            NoSeriesMgt.InitSeries(GetNoSeriesCode(), xRec."No. Series", 0D, "License No.", "No. Series");
        end;
    end;

    local procedure TestNoSeries()
    begin
        GetLicenseSetup();
        LicenseSetup.Testfield("License Serial Nos");
    end;

    local procedure GetLicenseSetup()
    begin
        if LicenseSetup.Get() then
            exit;
        LicenseSetup.Init();
        LicenseSetup.Insert(true);
        Commit();
    end;

    procedure GetNoSeriesCode(): Code[20]
    begin
        exit(NoSeriesMgt.GetNoSeriesWithCheck(LicenseSetup."License Serial Nos", false, "No. Series"));
    end;

    procedure LookupCustomerName(): Boolean
    var
        Customer: Record Customer;
    begin
        if LookupCustomer(Customer) then
            Rec.Validate("Customer No.", Customer."No.");
        exit(true);
    end;

    procedure LookupCustomer(var Customer: Record Customer): Boolean
    var
        CustomerLookup: page "Customer Lookup";
        Result: Boolean;
    begin
        CustomerLookup.SetTableView(Customer);
        CustomerLookup.SetRecord(Customer);
        CustomerLookup.LookupMode := true;
        Result := CustomerLookup.RunModal() = ACTION::LookupOK;
        if Result then
            CustomerLookup.GetRecord(Customer)
        else
            Clear(Customer);
        exit(Result);
    end;

    procedure SetCustomerName(var CustomerName: Text[100]): Boolean
    var
        Customer: Record Customer;
    begin
        if "Customer No." <> '' then
            Customer.Get("Customer No.");

        if Rec."Customer Name" = Customer.Name then
            CustomerName := ''
        else
            CustomerName := Customer.Name;
        exit(true);
    end;

    // procedure CreateLicenseEntriesStausDownload(var LicenseEntry: Record "EVT License Entry")
    // begin
    //     if LicenseEntry.IsEmpty() then
    //         LicenseEntry.Insert();
    //     LicenseEntry.FindLast();
    //     LicenseEntry."Entry No." := LicenseEntry."Entry No." + 1;
    //     LicenseEntry."License No." := Rec."License No.";
    //     LicenseEntry."Customer No." := Rec."Customer No.";
    //     LicenseEntry."Customer Name" := Rec."Customer Name";
    //     LicenseEntry."Email address" := '';
    //     LicenseEntry."Created By" := CopyStr(UserId(), 1, MaxStrLen(LicenseEntry."Created By"));
    //     // LicenseEntry."Created At" := CurrentDateTime;
    //     LicenseEntry."Action type" := Rec.Status::" Download";
    //     LicenseEntry."Performed By" := CopyStr(UserId(), 1, MaxStrLen(LicenseEntry."Performed By"));
    //     LicenseEntry."Performed At" := CurrentDateTime;
    //     LicenseEntry.Insert();
    // end;

    procedure CreateLicenseEntriesStausSent(var LicenseEntry: Record "EVT License Entry")
    begin
        if LicenseEntry.IsEmpty() then
            LicenseEntry.Insert();
        LicenseEntry.FindLast();
        LicenseEntry."Entry No." := LicenseEntry."Entry No." + 1;
        LicenseEntry."License No." := Rec."License No.";
        LicenseEntry."Customer No." := Rec."Customer No.";
        LicenseEntry."Customer Name" := Rec."Customer Name";
        LicenseEntry."Email address" := Rec.CustomerEmail;
        LicenseEntry."Created By" := CopyStr(UserId(), 1, MaxStrLen(LicenseEntry."Created By"));
        // LicenseEntry."Created At" := CurrentDateTime;
        LicenseEntry."Action type" := Rec.Status::" Sent";
        LicenseEntry."Performed By" := CopyStr(UserId(), 1, MaxStrLen(LicenseEntry."Performed By"));
        LicenseEntry."Performed At" := CurrentDateTime;
        LicenseEntry.Insert();
    end;

    procedure CreateLicenseEntriesGenerateLicense(var LicenseEntry: Record "EVT License Entry")
    begin
        if LicenseEntry.IsEmpty() then
            LicenseEntry.Insert();
        LicenseEntry.FindLast();
        LicenseEntry."Entry No." := LicenseEntry."Entry No." + 1;
        LicenseEntry."License No." := Rec."License No.";
        LicenseEntry."Customer No." := Rec."Customer No.";
        LicenseEntry."Customer Name" := Rec."Customer Name";
        LicenseEntry."Email address" := '';
        LicenseEntry."Created By" := CopyStr(UserId(), 1, MaxStrLen(LicenseEntry."Created By"));
        LicenseEntry."Created At" := CurrentDateTime;
        LicenseEntry."Action type" := Rec.Status::" Issued";
        LicenseEntry."Performed By" := '';
        LicenseEntry."Performed At" := 0DT;
        LicenseEntry.Insert();
    end;

    var
        LicenseSetup: Record "EVT License Setup";
        NoSeriesMgt: codeunit NoSeriesManagement;
}
