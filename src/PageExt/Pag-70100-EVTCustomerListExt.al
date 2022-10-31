pageextension 70100 "EVT Customer List" extends "Customer List"
{
    actions
    {
        addbefore(CustomerLedgerEntries)
        {
            action("EVT Licenses")
            {
                ApplicationArea = Suite;
                Caption = 'Licenses';
                Image = List;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                RunObject = Page "EVT Customer License";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageView = SORTING("License No.")
                                  ORDER(Descending);
                ShortCutKey = 'Ctrl+F7';
                ToolTip = 'View a list of licenses issued for the selected customer.';
            }
        }
    }
}
