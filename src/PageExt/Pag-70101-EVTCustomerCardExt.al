pageextension 70101 "EVT Customer Card" extends "Customer Card"
{
    actions
    {
        addbefore(Dimensions)
        {
            action("EVT Licenses")
            {
                ApplicationArea = Suite;
                Caption = 'Licenses';
                Image = List;
                Promoted = true;
                PromotedCategory = Category9;
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