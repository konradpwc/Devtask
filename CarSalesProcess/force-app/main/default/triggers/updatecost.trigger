trigger updatecost on OpportunityLineItem (after update,after insert) {
    
   
    Set<ID> setcost = new Set<ID>();
    For(OpportunityLineItem oopl : Trigger.new){
        setcost.add(oopl.Product2Id);
       
           

    Map<Id,OpportunityLineItem> productcost = new Map<Id,OpportunityLineItem>();
    for( OpportunityLineItem linecost : [Select Id, Product2.Cost__c From OpportunityLineItem Where Product2Id in :setcost]){
        productcost.put(linecost.Id, new OpportunityLineItem(
                Id = linecost.Id,
                Product_Cost__c = linecost.Product2.Cost__c ));
        
        
        
        
    }
        update productcost.values();
        
        
    }
    
    }