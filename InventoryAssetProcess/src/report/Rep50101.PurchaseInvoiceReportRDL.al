report 50101 "PurchaseInvoiceReportRDL"
{
    Caption = 'Purchase Invoice Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/PurchaseInvoiceReport.rdl';

    dataset
    {
        dataitem(DataItemName; "Purchase Header")
        {
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
            column(No_; "No.") { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
            column(Payment_Method_Code; "Payment Method Code") { }
            column(Document_Type; "Document Type") { }
            column(Currency_Code; "Currency Code") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Due_Date; "Due Date") { }
            column(Posting_Date; "Posting Date") { }
            column(Released_Date; "Released Date") { }
            column(Posting_Description; "Posting Description") { }
            column(Currency_Factor; "Currency Factor") { }
        }

    }
}