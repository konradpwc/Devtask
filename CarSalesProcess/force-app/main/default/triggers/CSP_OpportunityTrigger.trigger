trigger CSP_OpportunityTrigger on Opportunity (after update) {

    CSP_OpportunityTriggerHandler handler = new CSP_OpportunityTriggerHandler();

    if(Trigger.isUpdate){

        handler.afterUpdate(trigger.new, trigger.oldMap);
    }


}