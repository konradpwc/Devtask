public with sharing class CSP_OpportunityTriggerHandler {
  public void afterupdate(List<Opportunity> oppList,Map<ID, Opportunity> oldOppMap) {
    Set<Id> oppIds = new Set<Id>();
    for (Opportunity opp : oppList) {
      if (opp.StageName != oldOppMap.get(opp.Id).StageName) {
        if (opp.StageName == 'Closed Won') {
          oppIds.add(opp.Id);
        }
      }
    }

    List<CSP_Car__c> newCar = new List<CSP_Car__c>();
    if (!oppIds.isEmpty()) {
      for (Opportunity o : [ SELECT Id, AccountId,(SELECT Product2.Name FROM OpportunityLineItems LIMIT 1)FROM Opportunity
                            WHERE Id IN :oppIds]) {
        for (OpportunityLineItem oli : o.OpportunityLineItems) {
          CSP_Car__c c = new CSP_Car__c();
          c.Name = oli.Product2.Name;
          c.Account__c = o.AccountId;
          c.Opportunity__c = o.Id;

          newCar.add(c);
        }
      }
    }
    insert newCar;

    system.debug('your car' + newcar);

    List<CSP_AdditionalEquipment__c> equList = [ SELECT ID, Opportunity__r.Id, Car__c, Car_equipment__c FROM CSP_AdditionalEquipment__c
                                               WHERE Opportunity__r.Id IN :oppIds];

    system.debug('your equipment' + equList);
    for (CSP_Car__c c : newcar) {
      for (CSP_AdditionalEquipment__c e : equList) {
        e.Car__c = c.id;
        system.debug('car id' + c.id);
      }
    }
    update equList;
  }
}
