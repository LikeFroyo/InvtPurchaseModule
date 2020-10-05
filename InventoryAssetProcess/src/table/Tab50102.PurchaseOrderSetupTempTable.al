table 50102 "PurchaseOrderSetupTempTable"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(2000; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2005; "Order Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionMembers = "","Inventory Asset","Direct Expense","Fixed Asset";
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}