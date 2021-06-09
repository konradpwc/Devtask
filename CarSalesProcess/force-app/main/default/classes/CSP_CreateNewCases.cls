global class CSP_CreateNewCases implements Database.Batchable<sObject> {
  global Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
      'SELECT ID,CreatedDate,Account__c FROM CSP_Car__c WHERE CreatedDate  = TODAY');
  }

  global void execute(Database.BatchableContext bc, List<CSP_Car__c> cars) {
    Set<ID> carsids = new Set<ID>();
    for (CSP_Car__c c : cars) {
      carsids.add(c.Id);
    }

    Map<Id, CSP_Car__c> carmap = new Map<Id, CSP_Car__c>([SELECT ID,Name, Account__c, Opportunity__r.OwnerId
                                                          FROM CSP_Car__C
                                                          WHERE ID IN :carsids]);

    List<Case> newCase = new List<Case>();

    Id caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName()
                      .get('Car_Sales').getRecordTypeId();

    for (CSP_Car__c c : carmap.values()) {
      Case cas = new Case();


      cas.Car__c = c.id;
      cas.Origin = 'Apex Schedule';
      cas.RecordTypeId = caseRecordTypeId;
      cas.AccountId = c.Account__c;
      cas.OwnerId = c.Opportunity__r.OwnerId;
      cas.Subject = 'Service review for ' + c.Name;

      newCase.add(cas);
    }
    insert newCase;

    List<Task> newTask = new List<Task>();
    for (Case ca : newCase) {
      Task t = new Task();
      t.OwnerId = ca.OwnerId;
      t.WhatId = ca.Id;
      t.Status = 'Not Started';
      t.Priority = 'Normal';
      t.Subject = 'Car service';
      t.Type = 'Email';
      t.ActivityDate  =date.today()+7;
      t.Description =('Car service for' + ca.Car__c + ',for client'+ ca.Accountid);

      newTask.add(t);
    }
    insert newTask;
  }

  global void finish(Database.BatchableContext bc) {
  }
}
