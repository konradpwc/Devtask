//Modified Trigger Code
trigger CustomerAfterUpdateTrigger on APEX_Customer__c (after update) {
    List<apex_invoice__c> InvoiceList = new List<apex_invoice__c>();
    for (APEX_Customer__c objCustomer: Trigger.new) {
        //condition to check the old value and new value
        if (objCustomer.APEX_Customer_Status__c == 'Active' && trigger.oldMap.get(objCustomer.id).APEX_Customer_Status__c != 'Active') {
            APEX_Invoice__c objInvoice = new APEX_Invoice__c();
            objInvoice.APEX_Status__c = 'Pending';
            objInvoice.APEX_Customer__c = objCustomer.id;
            objInvoice.Apex_Description__c='trigger created the invoice';
            InvoiceList.add(objInvoice);
        }
    }

    //DML to insert the Invoice List in SFDC
    insert InvoiceList;
    
    }