trigger CSP_OpportunnityLineItemTrigger on OpportunityLineItem(before insert,before update) {

CSP_OpportunityTriggerHandler handler = new CSP_OpportunityTriggerHandler();

if(Trigger.isInsert){
   
  handler.checkAccountBudgetBeforeInsert(trigger.new);
}

if(Trigger.isUpdate){
    handler.checkAccountBudgetBeforeUpdate(trigger.new, trigger.oldMap);

}


}