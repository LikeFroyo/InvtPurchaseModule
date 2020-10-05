page 50101 "PurchaseReqstPRDeptList"
{
    Caption = 'PR Purchase Requisition List';
    Description = 'PR Purchase Requisition List Page';

    PageType = List;
    CardPageId = "Purchase Quote";
    SourceTable = "Purchase Header";

    Editable = false;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTableView = where("No." = filter('PR*'), "Document Type" = filter(Quote));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No.:"; rec."No.") { ApplicationArea = All; }
                field("Requestor Name:"; RequestorName) { ApplicationArea = All; }
                field("Document Type:"; rec."Order Type") { ApplicationArea = All; }
                field("Department Name:"; rec."Department Name") { ApplicationArea = All; }
                field("Location Code:"; rec."Location Code") { ApplicationArea = All; }
                field("Status:"; rec.Status) { ApplicationArea = All; }
                field("Document Date:"; rec."Document Date") { ApplicationArea = All; }
                field("Released Date:"; rec."Released Date") { ApplicationArea = All; }
                field("User ID"; rec."Creator ID") { ApplicationArea = All; }
                field("Date Modified"; rec."Last Modified") { ApplicationArea = All; }
            }
        }
    }


    //Global Variables
    var
        PurchaseAndPayableSetup: Record "Purchases & Payables Setup";
        RequestorName: text[80];


    // Set Requestor Name From Purchase Line
    trigger OnAfterGetRecord()
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.SetRange("Document No.", Rec."No.");
        if PurchaseLine.FindFirst() then
            RequestorName := PurchaseLine."Requested User Name";
    end;


    //Set Purchase&Payable Setup No. Series According To Page Type
    trigger OnOpenPage()
    begin
        PurchaseAndPayableSetup.FindFirst();
        PurchaseAndPayableSetup."Quote Nos." := 'PR-DE-PR';
        PurchaseAndPayableSetup.Modify(true);
    end;
}