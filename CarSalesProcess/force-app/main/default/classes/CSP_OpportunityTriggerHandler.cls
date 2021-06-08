public with sharing class CSP_OpportunityTriggerHandler {
  public void createnewCars(List<Opportunity> oppList,Map<ID, Opportunity> oldOppMap ) {
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
      for (Opportunity o : [SELECT Id, AccountId, (SELECT Product2.Name FROM OpportunityLineItems)
                            FROM Opportunity
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
  }

  public void countAdditionalEquipmentPrice(List<CSP_AdditionalEquipment__c> equList) {

    Set<Id> oliId = new Set<Id>();

    for (CSP_AdditionalEquipment__c e : equList) {
      oliId.add(e.Car_suggestion__c);
    }

    List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
    decimal totalprice = 0;

    for (OpportunityLineItem oli : [ SELECT ID,Name,Additional_equipment_price__c,(SELECT ID, name, Price__c FROM Additional_equipment_assignements__r)
                                     FROM OpportunityLineItem
                                      WHERE id IN :oliId]) {
      for (CSP_AdditionalEquipment__c c : oli.Additional_equipment_assignements__r) {
        totalprice += c.Price__c;
      }

        oli.Additional_equipment_price__c = totalprice;
        oliList.add(oli);
    }

    update oliList;

    Map<Id, OpportunityLineItem> oppliMap = new Map<Id, OpportunityLineItem>([SELECT Id, OpportunityId, Opportunity.Amount 
                                                                              FROM OpportunityLineItem
                                                                              WHERE ID IN :oliId]);

    Set<Id> oppids = new Set<id>();

    for (OpportunityLineItem oppli : oppliMap.values()) {
      oppids.add(oppli.OpportunityId);
    }

    for (Opportunity opprice : [SELECT  ID,Amount,Car_Sales_Amount__c,(SELECT ID, Additional_equipment_price__c FROM OpportunityLineItems)
                                FROM Opportunity
                                WHERE id IN :oppids]) {
      decimal totaleqprice = 0;
      for (OpportunityLineItem oliPrice : opprice.OpportunityLineItems) {
        totaleqprice += oliprice.Additional_equipment_price__c;
      }

      opprice.Car_Sales_Amount__c = totaleqprice;
      update opprice;
    }
  }

  public void checkAccountBudgetBeforeInsert(List<OpportunityLineItem> oppliList) {
    Set<ID> oppIds = new Set<ID>();
    set<Id> oliId = new Set<ID>();
    for (OpportunityLineItem oli : oppliList) {
      oppIds.add(oli.OpportunityId);
      oliId.add(oli.Id);

      List<OpportunityLineItem> oliTotalPrice = [SELECT ID, OpportunityID, TotalPrice, Opportunity.Account.Budget__c
                                                 FROM OpportunityLineItem
                                                 WHERE OpportunityId IN :oppIds
                                                 AND ID NOT IN :oliId ];

      decimal beforeTotPrice = 0;

      for (OpportunityLineItem price : oliTotalPrice) {
        beforeTotPrice += price.TotalPrice;
      }

      List<Opportunity> oppList = [SELECT ID, Amount, Car_Sales_Amount__c, Account.Budget__c
                                   FROM Opportunity
                                   WHERE id IN :oppIds ];

      for (OpportunityLineItem nOli : oppliList) {
        for (Opportunity opp : oppList) {
          if ((nOli.UnitPrice * nOli.Quantity)+beforeTotPrice >opp.Account.Budget__c) {
            nOli.addError('Not enough budget');
          }

          
        }
        system.debug('price' +beforeTotPrice);
      }
    }




  }

  public void checkAccountBudgetBeforeUpdate(List<OpportunityLineItem> oppliList,Map<Id, OpportunityLineItem> oldOliMap) {
    Set<ID> oppIds = new Set<ID>();
    set<Id> oliId = new Set<ID>();
    for (OpportunityLineItem oli : oppliList) {
      oppIds.add(oli.OpportunityId);
      oliId.add(oli.Id);

      List<OpportunityLineItem> oliTotalPrice = [ SELECT ID, OpportunityID, TotalPrice, Opportunity.Account.Budget__c
                                                  FROM OpportunityLineItem
                                                  WHERE OpportunityId IN :oppIds AND ID NOT IN :oliId ];

      decimal beforeTotPrice = 0;

      for (OpportunityLineItem price : oliTotalPrice) {
        beforeTotPrice += price.TotalPrice;
      }

      List<Opportunity> oppList = [SELECT ID, Amount, Account.Budget__c, Car_Sales_Amount__c
                                   FROM Opportunity
                                    WHERE id IN :oppIds ];

      for (OpportunityLineItem nOli : oppliList) {
        Decimal oldQuantity = oldOliMap.get(nOli.Id).Quantity;
        for (Opportunity opp : oppList) {
          if (
            oldQuantity != nOli.Quantity &&(nOli.UnitPrice * nOli.Quantity) + beforeTotPrice >opp.Account.Budget__c) {
            nOli.addError('Not enough budget');
          }
          update opp;
        }
      }
    }
  }
}