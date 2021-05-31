public with sharing class CSP_OpportunityTriggerHandler {
    public void afterupdate(List<Opportunity> oppList,Map<ID, Opportunity> oldOppMap ) {
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
        for (Opportunity o : [ SELECT Id, AccountId FROM Opportunity WHERE Id IN :oppIds]) {
          CSP_Car__c c = new CSP_Car__c();
          c.name = 'New Car';
          c.Account__c = o.AccountId;
          c.Opportunity__c = o.Id;
  
          newCar.add(c);
        }
      }
      insert newCar;
    }
  }
  