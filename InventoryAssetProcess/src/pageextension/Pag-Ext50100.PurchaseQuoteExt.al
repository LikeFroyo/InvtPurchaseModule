pageextension 50100 "PurchaseQuoteExt" extends "Purchase Quote"
{
    Caption = 'Create Purchase Requisition';
    layout
    {
        modify("No.")
        {
            Visible = true;
            AssistEdit = true;
            trigger OnAssistEdit()
            begin
                if PurchaseReqAssistEdit() then begin
                    PurchaseReqGeneralDataUpdate();
                    CurrPage.Update();
                end;
            end;
        }
        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            begin
                PurchaseReqDepartmentAndLocationUpdate();
                CurrPage.Update();
            end;
        }
        addafter("No.")
        {
            field("Request For"; rec."Shortcut Dimension 1 Code")
            {
                Caption = 'Request For:';
                Editable = false;
                ApplicationArea = All;
            }
            field("Order Type"; rec."Order Type")
            {
                Caption = 'Document Type:';
                Editable = false;
                ApplicationArea = all;
            }
            field("Creator ID"; rec."Creator ID")
            {
                Caption = 'Creator ID:';
                Editable = false;
                ApplicationArea = all;
            }
            field("Creator Name"; rec."Creator Name")
            {
                Caption = 'Creator Name:';
                Editable = false;
                ApplicationArea = all;
            }
            field("Department Name"; rec."Department Name")
            {
                Caption = 'Department Name:';
                Editable = false;
                ApplicationArea = all;
            }
        }
        addafter("Department Name")
        {
            field("Location Code PQ"; rec."Location Code")
            {
                Caption = 'Location Code:';
                ApplicationArea = All;
            }
        }
        modify("Document Date") { Editable = false; }
        addafter("Document Date")
        {
            field("Released Date"; rec."Released Date")
            {
                Caption = 'Released Date:';
                Editable = false;
                ApplicationArea = All;
            }
            field("Remarks"; rec.Remarks)
            {
                Caption = 'Remarks:';
                ApplicationArea = All;
            }
        }

        //modifications
        modify("Buy-from") { Visible = false; }
        modify("Buy-from Contact") { Visible = false; }
        modify("Buy-from Vendor Name") { Visible = false; }
        modify("Order Date") { Visible = false; }
        modify("Requested Receipt Date") { Visible = false; }
        modify("Vendor Shipment No.") { Visible = false; }
        modify("No. of Archived Versions") { Visible = false; }
        modify("Purchaser Code") { Visible = false; }
        modify("Vendor Order No.") { Visible = false; }
        modify("Campaign No.") { Visible = false; }
        modify("Responsibility Center") { Visible = false; }
        modify("Assigned User ID") { Visible = false; }
        modify("Due Date") { Visible = false; }
        modify("Order Address Code") { Visible = false; }
        modify("Invoice Details") { Visible = false; }
        modify("Shipping and Payment") { Visible = false; }
    }

    actions
    {
        addafter(CancelApprovalRequest)
        {
            action("Purchase Requisition")
            {
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedCategory = Category5;
                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Released then begin
                        Report.Run(Report::PurchaseReqstReportRDL);
                    end
                    else begin
                        Message('Document Not Yet Released!!!');
                    end;
                end;
            }
        }
        modify("Make Order") { Visible = false; }
        modify(CopyDocument) { Visible = false; }
        modify(AttachAsPDF) { Visible = false; }
        modify(Print) { Visible = false; }
        modify(Statistics) { Visible = false; }
        modify(Dimensions) { Visible = false; }
        modify(Comment) { Visible = false; }
        modify(Approvals) { Visible = false; }
        modify(Release) { Visible = false; }
        modify(Reopen) { Visible = false; }
        modify(Vendor) { Visible = false; }
        modify(MakeOrder) { Visible = false; }
        modify(Send) { Visible = false; }
        modify("Co&mments") { Visible = false; }
        modify(DocAttach) { Visible = false; }
    }





    local procedure PurchaseReqAssistEdit(): Boolean
    var
        PurchaseAndPayableSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        PurchaseAndPayableSetup.FindFirst();
        if NoSeriesMgt.SelectSeries(PurchaseAndPayableSetup."Quote Nos.", xRec."No. Series", rec."No. Series") then begin
            NoSeriesMgt.SetSeries(rec."No.");
            exit(true);
        end;
    end;


    local procedure PurchaseReqGeneralDataUpdate()
    var
        User: Record User;
    begin
        //Populate
        user.Get(UserSecurityId());
        rec."Creator ID" := user."User Name";
        rec."Creator Name" := user."Full Name";

        PurchaseReqDepartmentAndLocationUpdate();
        PurchaseReqOrderTypeUpdate();
        //  rec."Location Code" := PurchaseReqLocCode;
    end;


    local procedure PurchaseReqDepartmentAndLocationUpdate()
    var
        PurchaseReqDeptCode: Code[10];
        PurchaseReqLocCode: Code[10];
        PurchaseReqDimensionValue: Record "Dimension Value";
        PurchaseReqLocation: Record Location;
    begin
        case format(rec."No.").Substring(1, 2) of
            'GA':
                begin
                    PurchaseReqDeptCode := 'GADEPT';
                    PurchaseReqLocCode := 'GADEPTLOC';
                end;
            'PR':
                begin
                    PurchaseReqDeptCode := 'PRDEPT';
                    PurchaseReqLocCode := 'PRDEPTLOC';
                end;
            'CS':
                begin
                    PurchaseReqDeptCode := 'CSDEPT';
                    PurchaseReqLocCode := 'CSDEPTLOC';
                end;
        end;
        PurchaseReqDimensionValue.SetRange(Code, PurchaseReqDeptCode);
        PurchaseReqDimensionValue.FindFirst();
        Rec."Shortcut Dimension 1 Code" := PurchaseReqDimensionValue.code;
        rec."Department Name" := PurchaseReqDimensionValue.Name;
        PurchaseReqLocation.SetRange(Code, PurchaseReqLocCode);
        PurchaseReqLocation.FindFirst();
        rec."Location Code" := PurchaseReqLocation.Code;
    end;



    local procedure PurchaseReqOrderTypeUpdate()
    begin
        case format(rec."No.").Substring(3, 2) of
            'IN':
                Rec."Order Type" := Rec."Order Type"::"Inventory Asset";
            'DE':
                Rec."Order Type" := Rec."Order Type"::"Direct Expense";
            'FA':
                Rec."Order Type" := Rec."Order Type"::"Fixed Asset";
        end;
    end;
}