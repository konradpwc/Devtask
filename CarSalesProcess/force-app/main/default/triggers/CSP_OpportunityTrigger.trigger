trigger CSP_OpportunityTrigger on Opportunity (after update) {

    CSP_OpportunityTriggerHandler handler = new CSP_OpportunityTriggerHandler();

    if(Trigger.isUpdate){

        handler.createNewCars(trigger.new, trigger.oldMap);
    }


}