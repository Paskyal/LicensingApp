page 70103 "EVT Customer License"
{
    ApplicationArea = All;
    Caption = 'Customer License';
    PageType = List;
    SourceTable = "EVT Customer License";
    CardPageId = "EVT Customer License Card";
    UsageCategory = Administration;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("License No."; Rec."License No.")
                {
                    ToolTip = 'Specifies the value of the License No. field.';
                    ApplicationArea = All;
                }
                field(IsActive; IsActive)
                {
                    ToolTip = 'Specifies the value of the IsActive field.';
                    ApplicationArea = All;
                    Caption = 'Is Active';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ToolTip = 'Specifies the value of the Issue Date field.';
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
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
                    Visible = false;
                }
                field("Module 1"; Rec."Module 1")
                {
                    ToolTip = 'Specifies the value of the Module 1 field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Module 2"; Rec."Module 2")
                {
                    ToolTip = 'Specifies the value of the Module 2 field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Module 3"; Rec."Module 3")
                {
                    ToolTip = 'Specifies the value of the Module 3 field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("License file"; Rec."License File".HasValue)
                {
                    Caption = 'License file';
                    ToolTip = 'Specifies the value of the License file field.';
                    ApplicationArea = All;
                    Visible = false;
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
                RunObject = Page "EVT License Entry List";
                RunPageLink = "Customer No." = FIELD("Customer No.");
                RunPageView = sorting("Entry No.")
                                  order(descending);
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        IsActive := false;
        if ((Rec."Expiration Date" > Today) and (Rec."Starting Date" <= Today)) then
            IsActive := true;
    end;

    var
        IsActive: Boolean;
}