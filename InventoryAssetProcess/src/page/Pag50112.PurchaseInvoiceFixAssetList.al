page 50112 "PurchaseInvoiceFixAssetList"
{
    Caption = 'Fixed Asset Purchase Invoice List';
    Description = 'Fixed Asset Purchase Invoice List Page';

    PageType = List;
    CardPageId = "Purchase Invoice";
    SourceTable = "Purchase Header";

    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;
    SourceTableView = where("Order Type" = filter('Fixed Asset'), "Document Type" = filter(Invoice));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.") { ApplicationArea = All; }
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.") { ApplicationArea = All; }
                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name") { ApplicationArea = All; }
                field("Location Code"; rec."Location Code") { ApplicationArea = All; }
                field("Assigned User ID"; rec."Assigned User ID") { ApplicationArea = All; }
                field(Amount; rec.Amount) { ApplicationArea = All; }
            }
        }
    }
    trigger OnOpenPage()
    var
        PurchaseOrderSetupTempTable: Record PurchaseOrderSetupTempTable;
    begin
        if PurchaseOrderSetupTempTable.FindFirst() = false then begin
            PurchaseOrderSetupTempTable.Init();
            PurchaseOrderSetupTempTable.Insert()
        end;
        PurchaseOrderSetupTempTable."Order Type" := PurchaseOrderSetupTempTable."Order Type"::"Inventory Asset";
        PurchaseOrderSetupTempTable.Modify();
    end;
}

