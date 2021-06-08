trigger CSP_OpportunnityLineItemTrigger on OpportunityLineItem(before insert,after insert, before update) {

  CSP_OpportunityTriggerHandler handler = new CSP_OpportunityTriggerHandler();

  if (Trigger.isAfter && Trigger.isInsert) {
    handler.checkAccountBudgetBeforeInsert(Trigger.new);
    } 
  else if (Trigger.isUpdate) {
    handler.checkAccountBudgetBeforeUpdate(Trigger.new, Trigger.oldMap);
  }

}
