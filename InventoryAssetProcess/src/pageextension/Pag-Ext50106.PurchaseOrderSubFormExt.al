pageextension 50106 "PurchaseOrderSubFormExt" extends "Purchase Order Subform"
{
    Caption = 'Inv. Purchase Order Subform';
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Pr No."; rec."Pr No.")
            {
                Caption = 'Pr No.';
                ApplicationArea = all;
            }
        }
        modify("GST/HST") { Visible = false; }
        moveafter("Pr No."; "Unit of Measure Code")

        modify("VAT Prod. Posting Group") { Visible = true; }
        moveafter("Pr No."; "VAT Prod. Posting Group")

        addafter("VAT Prod. Posting Group")
        {
            field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
            {
                Caption = 'WHT Business Posting Group';
                ApplicationArea = all;
            }
            field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
            {
                Caption = 'WHT Product Posting Group';
                ApplicationArea = all;
            }
        }
        modify("Whse. Outstanding Qty. (Base)") { Visible = true; Caption = 'WHT Absorb Base'; }
        moveafter("Gen. Prod. Posting Group"; "Whse. Outstanding Qty. (Base)")
        addafter(Description)
        {
            field("Description 2"; rec."Description 2")
            {
                Caption = 'Description 2';
                ApplicationArea = all;
            }
        }
        moveafter("Description 2"; Quantity)
        modify("Line Discount %") { Visible = true; }
        modify("Line Discount Amount") { Visible = true; }
        movebefore("Qty. to Receive"; "Line Discount Amount")
        movebefore("Line Discount Amount"; "Line Discount %")
        moveafter("Quantity Received"; "Expected Receipt Date")


        modify("Reserved Quantity") { Visible = false; }
        modify("Location Code") { Visible = false; }
        modify("Bin Code") { Visible = false; }
        modify("Tax Area Code") { Visible = false; }
        modify("Tax Group Code") { Visible = false; }
        modify("Qty. to Invoice") { Visible = false; }
        modify("Quantity Invoiced") { Visible = false; }
        modify("Qty. to Assign") { Visible = false; }
        modify("Qty. Assigned") { Visible = false; }
        modify("Promised Receipt Date") { Visible = false; }
        modify("Planned Receipt Date") { Visible = false; }
        modify("Shortcut Dimension 1 Code") { Visible = false; }
        modify("Over-Receipt Quantity") { Visible = false; }
        modify("Over-Receipt Code") { Visible = false; }
        modify("Shortcut Dimension 2 Code") { Visible = false; }
        modify(Control37) { Visible = false; }
        modify(Control19) { Visible = false; }
    }
}