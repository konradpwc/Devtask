trigger CSP_AdditionalEquipmentTrigger on CSP_AdditionalEquipment__c (after insert, after delete) {

    CSP_OpportunityTriggerHandler handler = new CSP_OpportunityTriggerHandler();

    if(Trigger.isInsert){

        handler.countAdditionalEquipmentPrice(trigger.new);
    }
    if(Trigger.isAfter && Trigger.isDelete){

        handler.countAdditionalEquipmentPrice(trigger.old);
    }
}