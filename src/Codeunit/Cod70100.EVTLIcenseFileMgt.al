codeunit 70100 "EVT LIcense File Mgt"
{
    TableNo = "EVT Customer License";

    trigger OnRun()
    begin

    end;

    procedure DownloadLicense(var CustomerLicense: Record "EVT Customer License")
    var
        LicenseEntry: Record "EVT License Entry";
        InStr: InStream;
        ToFile: Text;
    begin
        CustomerLicense.CalcFields("License File");
        CustomerLicense."License File".CreateInStream(InStr, TextEncoding::UTF8);
        ToFile := 'License.xml';
        DownloadFromStream(InStr, '', '', '', ToFile);
        if CustomerLicense.Status = CustomerLicense.Status::" Issued" then
            CustomerLicense.Status := "EVT Status"::" Sent";
        CreateLicenseEntriesStausDownload(LicenseEntry, CustomerLicense);
    end;

    procedure SendLicense(var CustomerLicense: Record "EVT Customer License")
    var
        LicenseEntry: Record "EVT License Entry";
        TempEmailItem: Record "Email Item" temporary;
        EmailScenario: Enum "Email Scenario";
        InStr: InStream;
        AttachmentNameTxt: Label 'License.xml';
    begin
        CustomerLicense.FindSet();
        CustomerLicense.CalcFields(CustomerLicense."License File");
        CustomerLicense."License File".CreateInStream(InStr);
        TempEmailItem."Send to" := CustomerLicense.CustomerEmail;
        TempEmailItem.Subject := 'Your License';
        TempEmailItem.AddAttachment(InStr, AttachmentNameTxt);
        TempEmailItem.Send(true, EmailScenario);
        CustomerLicense.Status := "EVT Status"::" Sent";
        CustomerLicense.CreateLicenseEntriesStausSent(LicenseEntry);
    end;

    procedure CreateLicenseEntriesStausDownload(var LicenseEntry: Record "EVT License Entry"; var CustomerLicense: Record "EVT Customer License")
    begin
        if LicenseEntry.IsEmpty() then
            LicenseEntry.Insert();
        LicenseEntry.FindLast();
        LicenseEntry."Entry No." := LicenseEntry."Entry No." + 1;
        LicenseEntry."License No." := CustomerLicense."License No.";
        LicenseEntry."Customer No." := CustomerLicense."Customer No.";
        LicenseEntry."Customer Name" := CustomerLicense."Customer Name";
        LicenseEntry."Email address" := '';
        LicenseEntry."Created By" := CopyStr(UserId(), 1, MaxStrLen(LicenseEntry."Created By"));
        LicenseEntry."Action type" := CustomerLicense.Status::" Download";
        LicenseEntry."Performed By" := CopyStr(UserId(), 1, MaxStrLen(LicenseEntry."Performed By"));
        LicenseEntry."Performed At" := CurrentDateTime;
        LicenseEntry.Insert();
    end;



}
