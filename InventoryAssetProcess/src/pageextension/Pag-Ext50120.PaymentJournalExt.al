pageextension 50120 "PaymentJournalExt" extends "Payment Journal"
{

    var
        PurchaseOrderDocumentCode: Code[20];
        PurchaseOrderDocumentAmount: Integer;

    procedure SetGenJournalLineFromPurchaseOrderPage(var PurchaseHeader: Record "Purchase Header")
    begin
        PurchaseOrderDocumentCode := PurchaseHeader."No.";
        PurchaseOrderDocumentAmount := PurchaseHeader."Advance Payment Amount";
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if PurchaseOrderDocumentCode <> '' then begin
            rec."Document No." := PurchaseOrderDocumentCode;
            rec.Amount := PurchaseOrderDocumentAmount
        end;
    end;
}