page 50115 "Get Purchase Lines"
{
    PageType = List;
    Caption = 'Get Purchase Line';
    Description = 'Get Purchase Line List';

    SourceTable = "Purchase Line";
    Editable = false;
    UsageCategory = Administration;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No."; rec."Document No.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = All;
                }
                field("Line No."; rec."Line No.")
                {
                    Caption = 'Line No.';
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    Caption = 'Type';
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = all;
                }
                field("Description 2"; rec."Description 2")
                {
                    Caption = 'Description 2';
                    ApplicationArea = all;
                }
                field("Order Type"; rec."Order Type")
                {
                    Caption = 'Document Type';
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    Caption = 'Requested Quantity';
                    ApplicationArea = all;
                }
                field("Outstanding Quantity"; rec."Outstanding Quantity")
                {
                    Caption = 'Outstanding Quantity';
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    Caption = 'Unit Of Measure';
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    Caption = 'Location Code';
                    ApplicationArea = all;
                }
                field("Expected Receipt Date"; rec."Expected Receipt Date")
                {
                    Caption = 'Expected Receipt Date';
                    ApplicationArea = all;
                }
                field("Direct Unit Cost"; rec."Direct Unit Cost")
                {
                    Caption = 'Direct Unit Cost';
                    ApplicationArea = all;
                }
                field("Line Amount"; rec."Line Amount")
                {
                    Caption = 'Line Amount';
                    ApplicationArea = all;
                }
            }
        }
    }

    var
        FromPurchaseHeaderDocNo: Code[20];

    procedure CopyPurchaseLines()
    var
        SelectedPurchaseLine: Record "Purchase Line";
        PurchaseOrderLine: Record "Purchase Line";
        LineNo: Integer;
    begin
        CurrPage.SetSelectionFilter(SelectedPurchaseLine);
        LineNo := 1000;
        SelectedPurchaseLine.Next();
        repeat begin
            //Intialize the record
            PurchaseOrderLine.Init();
            PurchaseOrderLine.Copy(SelectedPurchaseLine);
            PurchaseOrderLine."Document No." := FromPurchaseHeaderDocNo;
            PurchaseOrderLine."Document Type" := PurchaseOrderLine."Document Type"::Order;
            PurchaseOrderLine."Line No." := LineNo;
            LineNo += 1000;
            PurchaseOrderLine.Insert();
            //Insert the record
            Message('Copied: ' + Format(SelectedPurchaseLine."Document No."));
        end until SelectedPurchaseLine.Next() = 0;
    end;

    procedure SetFromPurchaseHeaderDocNo(PurchaseHeaderDocNo: Code[20])
    begin
        FromPurchaseHeaderDocNo := PurchaseHeaderDocNo;
    end;



    trigger OnInit()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Quote);
        PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Released);
        if PurchaseHeader.FindFirst() then begin
            repeat
                if PurchaseHeader.Status = "Purchase Document Status"::Released then begin
                    Message(Format(PurchaseHeader.Status));
                    rec.SetRange("Document No.", PurchaseHeader."No.");
                end;
            until PurchaseHeader.Next() = 0;
        end
        else begin
            Message('Purchase Lines Not Released Yet');
        end;
    end;


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction in [ACTION::OK, ACTION::LookupOK] then
            CopyPurchaseLines();
    end;
}