pageextension 50115 "PurchaseModuleRoleCenterExt" extends "Business Manager Role Center"
{
    actions
    {
        modify("<Page Purchase Order>") { Visible = false; }
        modify("Purchase Invoice") { Visible = false; }
        modify("Purchase Quote") { Visible = false; }
        modify(Action41) { Visible = false; }
        addbefore(Action39)
        {
            group("Invt. Purchase Module")
            {
                Caption = 'Invt. Purchase Module';
                group("Invt. Purchase Requisition")
                {
                    action("GA Purchase Requisition List")
                    {
                        AccessByPermission = TableData "Purchase Header" = IMD;
                        Caption = 'GA Purchase Requisition List';
                        Image = Quote;
                        ApplicationArea = Suite;
                        RunObject = page PurchaseReqstGADeptList;
                        RunPageMode = Create;
                    }
                    action("PR Purchase Requisition List")
                    {
                        AccessByPermission = TableData "Purchase Header" = IMD;
                        Caption = 'PR Purchase Requisition List';
                        Image = Quote;
                        ApplicationArea = Suite;
                        RunObject = page PurchaseReqstPRDeptList;
                        RunPageMode = Create;
                    }
                    action("CS Purchase Requisition List")
                    {
                        AccessByPermission = TableData "Purchase Header" = IMD;
                        Caption = 'CS Purchase Requisition List';
                        Image = Quote;
                        ApplicationArea = Suite;
                        RunObject = page PurchaseReqstCSDeptList;
                        RunPageMode = Create;
                    }
                }
                group("Invt. Purchase Order")
                {
                    action("Inventory Asset Purchase Order")
                    {
                        AccessByPermission = TableData "Purchase Header" = IMD;
                        Caption = 'Inventory Asset Purchase Order';
                        Image = Order;
                        ApplicationArea = Suite;
                        RunObject = page PurchaseOrderInvAssetList;
                        RunPageMode = Create;
                    }
                    action("Direct Expense Purchase order")
                    {
                        AccessByPermission = TableData "Purchase Header" = IMD;
                        Caption = 'Direct Expense Purchase order';
                        Image = Order;
                        ApplicationArea = Suite;
                        RunObject = page PurchaseOrderDirExpenseList;
                        RunPageMode = Create;
                    }
                    action("Fixed Asset Purchase order")
                    {
                        AccessByPermission = TableData "Purchase Header" = IMD;
                        Caption = 'Fixed Asset Purchase order';
                        Image = Order;
                        ApplicationArea = Suite;
                        RunObject = page PurchaseOrderFixAssetList;
                        RunPageMode = Create;
                    }
                }
                group("Invt. Purchase Invoice")
                {
                    action("Inventory Asset Purchase Invoice")
                    {
                        AccessByPermission = TableData "Purchase Header" = IMD;
                        Caption = 'Inventory Asset Purchase Invoice';
                        Image = Invoice;
                        ApplicationArea = Suite;
                        RunObject = page PurchaseInvoiceInvAssetList;
                        RunPageMode = Create;
                    }
                    action("Direct Expense Purchase Invoice")
                    {
                        AccessByPermission = TableData "Purchase Header" = IMD;
                        Caption = 'Direct Expense Purchase Invoice';
                        Image = Invoice;
                        ApplicationArea = Suite;
                        RunObject = page PurchaseInvoiceDirExpenseList;
                        RunPageMode = Create;
                    }
                    action("Fixed Asset Purchase Invoice")
                    {
                        AccessByPermission = TableData "Purchase Header" = IMD;
                        Caption = 'Fixed Asset Purchase Invoice';
                        Image = Invoice;
                        ApplicationArea = Suite;
                        RunObject = page PurchaseInvoiceFixAssetList;
                        RunPageMode = Create;
                    }
                }
            }
        }
    }
}
