pageextension 50105 "PurchaseOrderExt" extends "Purchase Order"
{
    Caption = 'Invt. Purchase Order';
    layout
    {
        modify("No.")
        {
            Visible = true;
            AssistEdit = true;
            trigger OnAssistEdit()
            begin
                if PurchaseOrderAssistEdit() then begin
                    PurchaseOrderGeneralDataUpdate();
                    CurrPage.Update();
                end;
            end;
        }
        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            begin
                PurchaseOrderDepartmentUpdate();
                CurrPage.Update();
            end;
        }
        modify("Buy-from Vendor Name")
        {
            trigger OnAfterValidate()
            begin
                PurchaseOrderDepartmentUpdate();
                CurrPage.Update();
            end;
        }
        addafter("Buy-from Vendor Name")
        {
            field("Location Code PO"; rec."Location Code")
            {
                Caption = 'Location Code:';
                ApplicationArea = all;
            }
            field("Order Type"; rec."Order Type")
            {
                Caption = 'Order Type:';
                ApplicationArea = all;
                Editable = false;
            }
            field("Department type"; rec."Shortcut Dimension 1 Code")
            {
                Caption = 'Department Type:';
                ApplicationArea = all;
                Editable = false;
            }
            field("Require Advance Payment"; rec."Require Advance Payment")
            {
                Caption = 'Require Advanace Payment';
                ApplicationArea = all;
            }
            field("Advance Payment Amount"; rec."Advance Payment Amount")
            {
                Caption = 'Advance Payment Amount';
                ApplicationArea = all;
                Editable = rec."Require Advance Payment";
            }
            field("Reason Code"; rec."Reason Code")
            {
                Caption = 'Reason Code:';
                ApplicationArea = all;
            }
        }
        modify("Document Date") { Editable = false; }
        addafter("Document Date")
        {
            field("DR No."; rec."DR No.")
            {
                Caption = 'DR No.:';
                ApplicationArea = all;
            }
            field("ATP No."; rec."ATP No.")
            {
                Caption = 'APT No.:';
                ApplicationArea = all;
            }
            field("SI No."; rec."SI No.")
            {
                Caption = 'SI No.:';
                ApplicationArea = all;
            }
        }
        modify("Buy-from") { Visible = false; }
        modify("Buy-from Contact") { Visible = false; }
        modify("Due Date") { Visible = false; }
        modify("Vendor Invoice No.") { Visible = false; }
        modify("Purchaser Code") { Visible = false; }
        modify("No. of Archived Versions") { Visible = false; }
        modify("Order Date") { Visible = false; }
        modify("Quote No.") { Visible = false; }
        modify("Vendor Order No.") { Visible = false; }
        modify("Vendor Shipment No.") { Visible = false; }
        modify("Order Address Code") { Visible = false; }
        modify("Responsibility Center") { Visible = false; }
        modify("Shipping and Payment") { Visible = false; }
        modify(Prepayment) { Visible = false; }
        modify("Invoice Details") { Visible = false; }
    }


    actions
    {
        // Add changes to page actions here
        addfirst(navigation)
        {
            group("Invt. PurchaseOrder Module")
            {
                Caption = 'Invt. PurchaseOrder Module';
                action("Post Purchase Order")
                {
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        PurchaseOrderPost: Codeunit "Purch.-Post (Yes/No) V2";
                    begin
                        if rec."ATP No." = '' then
                            Error('ATP no. is blank')
                        else
                            PurchaseOrderPost.Run(Rec);
                    end;
                }
                action("Get PR Lines")
                {
                    ApplicationArea = all;
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        GetPurchaseLine: Page "Get Purchase Lines";
                        PurchaseLine: Record "Purchase Line";
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseLine.SetFilter("Document No.", format(rec."No.").Substring(1, 2) + '*');
                        PurchaseLine.SetFilter("Location Code", rec."Location Code");
                        PurchaseLine.SetFilter("Order Type", format(rec."Order Type"));

                        PurchaseHeader.SetRange("Document Type", "Purchase Document Type"::Quote);
                        PurchaseHeader.SetRange(Status, "Purchase Document Status"::Released);
                        if PurchaseHeader.FindSet() then
                            repeat
                                PurchaseLine.SetFilter("Document No.", PurchaseHeader."No.");
                            until PurchaseHeader.Next() = 0;

                        GetPurchaseLine.SetFromPurchaseHeaderDocNo(rec."No.");
                        GetPurchaseLine.SetTableView(PurchaseLine);
                        GetPurchaseLine.LookupMode(true);
                        GetPurchaseLine.RunModal();
                    end;

                }
                action("Close Order")
                {
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = Close;
                    trigger OnAction()
                    begin
                        Message('Order Closed');
                        CurrPage.Close();
                    end;
                }
                action("Make Advance Payment")
                {
                    Enabled = rec."Require Advance Payment";
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = Payment;
                    trigger OnAction()
                    var
                        PaymentJournal: page "Payment Journal";
                        GenJournalLine: Record "Gen. Journal Line";
                    begin
                        GenJournalLine.Init();
                        GenJournalLine."Document No." := Rec."No.";
                        PaymentJournal.SetTableView(GenJournalLine);
                        PaymentJournal.LookupMode(true);
                        PaymentJournal.RunModal();
                    end;
                }
            }
            group("Invt. PurchaseOrder Report")
            {
                action("Purchase Order Report")
                {
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Report;
                    image = Report;
                    trigger OnAction()
                    begin
                    end;
                }
                action("Purchase Order Report (Pre-Printed)")
                {
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Report;
                    image = Report;
                    trigger OnAction()
                    begin
                    end;
                }
                action("Purchase Order Report(PP Current)")
                {
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Report;
                    image = Report;
                    trigger OnAction()
                    begin
                    end;
                }
            }
        }

        modify(Statistics)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(Release)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(Dimensions)
        {
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(Post) { Visible = false; }
        modify(Preview) { Visible = false; }
        modify(Reopen) { Visible = false; }
        modify("Post and &Print") { Visible = false; }
        modify(Approvals) { Visible = false; }
        modify("Co&mments") { Visible = false; }
        modify(DocAttach) { Visible = false; }
        modify(AttachAsPDF) { Visible = false; }
        modify(Print) { Visible = false; }
        modify(SendCustom) { Visible = false; }
        modify("&Print") { Visible = false; }
        modify(CopyDocument) { Visible = false; }
        modify("Create Inventor&y Put-away/Pick") { Visible = false; }
        modify(Vendor) { Visible = false; }
        modify(Receipts) { Visible = false; }
        modify(Invoices) { Visible = false; }
        modify(PostedPrepaymentCrMemos) { Visible = false; }
        modify(PostedPrepaymentInvoices) { Visible = false; }
        modify(PostAndNew) { Visible = false; }
        modify(CreateFlow) { Visible = false; }
        modify(SeeFlows) { Visible = false; }
    }

    local procedure PurchaseOrderAssistEdit(): Boolean
    var
        PurchaseAndPayableSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        PurchaseAndPayableSetup.FindFirst();
        if NoSeriesMgt.SelectSeries(PurchaseAndPayableSetup."Order Nos.", xRec."No. Series", rec."No. Series") then begin
            NoSeriesMgt.SetSeries(rec."No.");
            exit(true);
        end;
    end;


    local procedure PurchaseOrderGeneralDataUpdate()
    begin
        PurchaseOrderDepartmentUpdate();
        PurchaseOrderOrderTypeUpdate();
    end;

    local procedure PurchaseOrderDepartmentUpdate()
    var
        PurchaseOrderDeptCode: Code[10];
        PurchaseReqDimensionValue: Record "Dimension Value";
    begin
        case format(rec."No.").Substring(1, 2) of
            'GA':
                PurchaseOrderDeptCode := 'GADEPT';
            'PR':
                PurchaseOrderDeptCode := 'PRDEPT';
            'CS':
                PurchaseOrderDeptCode := 'CSDEPT';
        end;
        PurchaseReqDimensionValue.SetRange(Code, PurchaseOrderDeptCode);
        PurchaseReqDimensionValue.FindFirst();
        Rec."Shortcut Dimension 1 Code" := PurchaseReqDimensionValue.code;
        rec."Department Name" := PurchaseReqDimensionValue.Name;
    end;

    local procedure PurchaseOrderOrderTypeUpdate()
    var
        PurchaseOrderSetupTempTable: Record PurchaseOrderSetupTempTable;
    begin
        if PurchaseOrderSetupTempTable.FindFirst() then
            Rec."Order Type" := PurchaseOrderSetupTempTable."Order Type";
    end;
}