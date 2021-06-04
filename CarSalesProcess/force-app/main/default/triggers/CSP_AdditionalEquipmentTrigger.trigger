trigger CSP_AdditionalEquipmentTrigger on CSP_AdditionalEquipment__c (after insert) {

    CSP_OpportunityTriggerHandler handler = new CSP_OpportunityTriggerHandler();

    if(Trigger.isInsert){

        handler.countAdditionalEquipmentPrice(trigger.new);
    }






}