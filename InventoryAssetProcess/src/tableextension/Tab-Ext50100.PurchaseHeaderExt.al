tableextension 50100 "PurchaseHeaderExt" extends "Purchase Header"
{
    fields
    {
        field(2000; "Order Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionMembers = "","Inventory Asset","Direct Expense","Fixed Asset";
        }
        field(2001; "Creator ID"; Code[50])
        {
            Caption = 'Creator ID';
            DataClassification = ToBeClassified;
        }
        field(2002; "Creator Name"; text[80])
        {
            Caption = 'Creator Name';
            DataClassification = ToBeClassified;
        }
        field(2003; "Department Name"; Text[20])
        {
            Caption = 'Department Name';
            DataClassification = ToBeClassified;
        }
        field(2004; "Released Date"; Date)
        {
            Caption = 'Release Date';
            DataClassification = ToBeClassified;
        }
        field(2005; "Remarks"; text[80])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(2006; "Require Advance Payment"; Boolean)
        {
            Caption = 'Require Advnace Payment';
            DataClassification = ToBeClassified;
        }
        field(2007; "Advance Payment Amount"; Decimal)
        {
            Caption = 'Advance Payment Amount';
            DataClassification = ToBeClassified;
        }
        field(2008; "DR No."; Code[20])
        {
            Caption = 'DR No.';
            DataClassification = ToBeClassified;
        }
        field(2009; "SI No."; Code[20])
        {
            Caption = 'SI No.';
            DataClassification = ToBeClassified;
        }
        field(2010; "ATP No."; Code[20])
        {
            Caption = 'ATP No.';
            DataClassification = ToBeClassified;
        }
        field(2011; "Last Modified"; Date)
        {
            Caption = 'Last Modified';
            DataClassification = ToBeClassified;
        }
    }
    trigger OnModify();
    begin
        "Last Modified" := Today;
        if rec.Status = Rec.Status::Released then
            rec."Released Date" := Today;
    end;
}