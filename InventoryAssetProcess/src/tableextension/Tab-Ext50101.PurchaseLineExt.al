tableextension 50101 "PurchaseLineExt" extends "Purchase Line"
{
    fields
    {
        // Add changes to table fields here
        field(2000; "Requested User ID"; Code[50])
        {
            Caption = 'Requested User ID';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
            trigger OnValidate()
            begin
                CalcFields("Requested User Name");
            end;
        }
        field(2001; "Requested User Name"; text[80])
        {
            Caption = 'Requested User Name';
            FieldClass = FlowField;
            CalcFormula = lookup(User."Full Name" where("User Name" = field("Requested User ID")));
        }
        field(2002; "Account Code"; Code[20])
        {
            Caption = 'Account Code';
            DataClassification = ToBeClassified;
        }
        field(2003; "Sub Account Code"; Code[20])
        {
            Caption = 'Sub Account Code';
            DataClassification = ToBeClassified;
        }
        field(2004; "Purpose"; Text[80])
        {
            caption = 'Purpose';
            DataClassification = ToBeClassified;
        }
        field(2005; "Order Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionMembers = "","Inventory Asset","Direct Expense","Fixed Asset";
        }
        field(2006; "Pr No."; Code[20])
        {
            Caption = 'Pr No';
            DataClassification = ToBeClassified;
        }
    }
}