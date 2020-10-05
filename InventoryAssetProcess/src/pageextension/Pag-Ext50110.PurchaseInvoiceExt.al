pageextension 50110 "PurchaseInvoiceExt" extends "Purchase Invoice"
{
    Caption = 'Invt. Purchase Invoice';
    layout
    {
        modify("No.")
        {
            Visible = true;
            AssistEdit = true;
            trigger OnAssistEdit()
            begin
                if PurchaseOrderAssistEdit() then begin
                    PurchaseOrderOrderTypeUpdate();
                    CurrPage.Update();
                end;
            end;
        }
    }

    local procedure PurchaseOrderAssistEdit(): Boolean
    var
        PurchaseAndPayableSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        PurchaseAndPayableSetup.FindFirst();
        if NoSeriesMgt.SelectSeries(PurchaseAndPayableSetup."Invoice Nos.", xRec."No. Series", rec."No. Series") then begin
            NoSeriesMgt.SetSeries(rec."No.");
            exit(true);
        end;
    end;

    local procedure PurchaseOrderOrderTypeUpdate()
    var
        PurchaseOrderSetupTempTable: Record PurchaseOrderSetupTempTable;
    begin
        if PurchaseOrderSetupTempTable.FindFirst() then
            Rec."Order Type" := PurchaseOrderSetupTempTable."Order Type";
    end;
}