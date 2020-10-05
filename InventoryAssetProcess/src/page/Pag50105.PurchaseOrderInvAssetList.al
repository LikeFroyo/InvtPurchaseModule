page 50105 "PurchaseOrderInvAssetList"
{
    Caption = 'Inventory Asset Purchase Order List';
    Description = 'Inventory Asset Purchase Order List Page';

    PageType = List;
    CardPageId = "Purchase Order";
    SourceTable = "Purchase Header";

    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;
    SourceTableView = where("Order Type" = filter('Inventory Asset'), "Document Type" = filter(Order));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document Type"; rec."Document Type") { ApplicationArea = All; }
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.") { ApplicationArea = All; }
                field("Order Type"; rec."Order Type") { ApplicationArea = All; }
                field("No."; rec."No.") { ApplicationArea = All; }
                field("Order Date"; rec."Order Date") { ApplicationArea = All; }
                field("Posting Date"; rec."Posting Date") { ApplicationArea = All; }
                field("Due Date"; rec."Due Date") { ApplicationArea = All; }
                field("Location Code"; rec."Location Code") { ApplicationArea = All; }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code") { ApplicationArea = all; }
                field("Currency Code"; rec."Currency Code") { ApplicationArea = All; }
                field(Status; rec.Status) { ApplicationArea = All; }
                field("Department Type"; rec."Department Name") { ApplicationArea = All; }
                field("Assigned User ID"; rec."Assigned User ID") { ApplicationArea = All; }
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
