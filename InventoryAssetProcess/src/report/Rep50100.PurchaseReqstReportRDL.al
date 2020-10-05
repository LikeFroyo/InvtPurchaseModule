report 50100 "PurchaseReqstReportRDL"
{
    Caption = 'Purchase Requisition Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/PurchaseRequistionReport.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(DocumentNo; "No.") { }
            column(RequestFor; "Shortcut Dimension 1 Code") { }
            column(DocumentType; "Order Type") { }
            column(DocumentDate; "Document Date") { }
            column(CreatorID; "Creator ID") { }
            column(CreatorName; "Creator Name") { }
            column(DepartmentName; "Department Name") { }
            column(LocationCode; "Location Code") { }
            column(Status; Status) { }
            column(ReleasedDate; "Released Date") { }
            column(Remarks; Remarks) { }

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Pr No." = field("No.");
                column(Type; Type) { }
                column(LineNo; "Line No.") { }
                column(ItemNo; "No.") { }
                column(UnitOfMeasue; "Unit of Measure Code") { }
                column(Description; Description) { }
                column(Description2; "Description 2") { }
                column(RequestedQuantity; Quantity) { }
                column(RequesterUserId; "Requested User ID") { }
                column(RequesterUserName; "Requested User Name") { }
                column(DepttCode; "Shortcut Dimension 1 Code") { }
                column(AccountID; "Account Code") { }
                column(SubAccountCode; "Sub Account Code") { }
                column(DateNeeded; "Requested Receipt Date") { }
                column(Purpose; Purpose) { }
            }
        }
    }
}