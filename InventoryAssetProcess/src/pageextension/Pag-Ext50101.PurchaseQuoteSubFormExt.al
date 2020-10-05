pageextension 50101 "PurchaseQuoteSubFormExt" extends "Purchase Quote Subform"
{
    Caption = 'Open Purchase Req Line';
    layout
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                PurchaseHeader: Record "Purchase Header";
            begin
                PurchaseHeader.SetRange("No.", rec."Document No.");
                PurchaseHeader.FindFirst();
                rec."Order Type" := PurchaseHeader."Order Type";
                rec."Pr No." := rec."Document No.";
                rec."Shortcut Dimension 1 Code" := PurchaseHeader."Shortcut Dimension 1 Code";
                CurrPage.Update();
            end;
        }
        addbefore("No.")
        {
            field("Line No."; rec."Line No.")
            {
                Caption = 'Line No.';
                ApplicationArea = all;
            }
        }
        moveafter("No."; "Unit of Measure Code")
        addafter(Description)
        {
            field("Description 2"; rec."Description 2")
            {
                Caption = 'Description 2';
                ApplicationArea = all;
            }
        }
        addafter(Quantity)
        {
            field("Requested User ID"; rec."Requested User ID")
            {
                Caption = 'Requested User ID';
                ApplicationArea = all;
            }
            field("Requested User Name"; rec."Requested User Name")
            {
                Caption = 'Requested User Name';
                ApplicationArea = all;
            }
        }
        moveafter("Requested User Name"; "Shortcut Dimension 1 Code")
        addafter("Shortcut Dimension 1 Code")
        {
            field("Sub Account Code"; rec."Sub Account Code")
            {
                Caption = 'Sub Account Code';
                ApplicationArea = all;
            }
            field("Requested Receipt Date"; rec."Requested Receipt Date")
            {
                Caption = 'Date Needed';
                ApplicationArea = all;
            }
            field(Purpose; rec.Purpose)
            {
                Caption = 'Purpose';
                ApplicationArea = all;
            }
        }
        //changed
        modify("Shortcut Dimension 1 Code") { Visible = false; }
        modify("Shortcut Dimension 2 Code") { Visible = false; }
        modify("Direct Unit Cost") { Visible = false; }
        modify("Tax Area Code") { Visible = false; }
        modify("Tax Group Code") { Visible = false; }
        modify("Line Discount %") { Visible = false; }
        modify("Line Amount") { Visible = false; }
        modify("Qty. Assigned") { Visible = false; }
        modify("Qty. to Assign") { Visible = false; }
        modify(Control31) { Visible = false; }
        modify(Control17) { Visible = false; }
    }
}