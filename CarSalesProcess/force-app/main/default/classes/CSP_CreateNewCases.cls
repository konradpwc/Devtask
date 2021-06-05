global class CSP_CreateNewCases implements Database.Batchable<sObject> {
  global Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
      'SELECT ID,CreatedDate,Account__c FROM CSP_Car__c WHERE CreatedDate  = LAST_N_YEARS:2 AND CreatedDate = LAST_N_YEARS:1');
  }

  global void execute(Database.BatchableContext bc, List<CSP_Car__c> cars) {
    Set<ID> carsids = new Set<ID>();
    for (CSP_Car__c c : cars) {
      carsids.add(c.Id);
    }

    Map<Id, CSP_Car__c> carmap = new Map<Id, CSP_Car__c>([SELECT ID, Account__c, Opportunity__r.OwnerId
                                                          FROM CSP_Car__C
                                                          WHERE ID IN :carsids]);

    List<Case> newCase = new List<Case>();

    for (CSP_Car__c c : carmap.values()) {
      Case cas = new Case();

      Cas.Car__c = c.id;
      cas.Origin = 'Apex Schedlue';
      //cas.RecordType.DeveloperName = 'Car_Sales';
      cas.AccountId = c.Account__c;
      cas.OwnerId = c.Opportunity__r.OwnerId;

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
      t.Subject = 'Other';
      t.Type = 'Email';

      newTask.add(t);
    }
    insert newTask;
  }

  global void finish(Database.BatchableContext bc) {
  }
}
