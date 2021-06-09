@isTest
public with sharing class CSP_CreateNewCasesTest {
  @isTest
  public static void testCreateNewCasesBatch() {

    Account testAccount = new Account();
    testAccount.Name = 'Test Account';
    insert testAccount;
    

    Opportunity testOpportunity = new Opportunity();
    testOpportunity.Name = 'Test Opportunity';
    testOpportunity.Accountid = testAccount.id;
    testOpportunity.StageName = 'Qualification';
    testOpportunity.CloseDate = system.Today() + 5;
    insert testOpportunity;

    CSP_car__c car = new CSP_Car__c();
    car.Name = 'Test';
    car.Account__c = testAccount.id;
    car.Opportunity__c = testOpportunity.id;

   

    // List<Case> cases = new List<Case>();
    // List<Task> tasks = new List<Task>();

    // for (Integer i = 0; i < 200; i++) {
    //   Case c = new Case();
    //   c.Origin = 'Apex Schedule';
    //   c.Subject = 'test' + i;
    //   c.Car__c = car.id;
    //   c.AccountId = car.Account__c;

    //   cases.add(c);
    // }
    // insert cases;

    // for (Case cas : cases) {
    //   Task t = new Task();

    //   t.WhatId = cas.Id;
    //   t.Status = 'Not Started';
    //   t.Priority = 'Normal';
    //   t.Subject = 'Other';
    //   t.Type = 'Email';
    //   t.ActivityDate = cas.Service_scheduled_date__c;

    //   Tasks.add(t);
    // }

    // insert Tasks;

    Test.StartTest();
    insert car;
    CSP_CreateNewCases cas = new CSP_CreateNewCases();
    Id batchid = Database.executeBatch(cas, 200);
    Test.stopTest();
      
    Case createdCase = [Select ID, Car__c,AccountID FROM Case];
      system.debug('wynik' + createdCase);
      
      System.assertEquals(createdCase.Car__c,Car.Id);


  }
}
