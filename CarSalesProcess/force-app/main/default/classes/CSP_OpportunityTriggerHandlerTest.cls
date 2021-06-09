@isTest
public with sharing class CSP_OpportunityTriggerHandlerTest {
  @isTest
  public static void validateCreateNewCars() {
    Account acc = new Account();
    acc.Name = 'Test Account';
    insert acc;

    Opportunity opp = new Opportunity();
    opp.Name = 'Test Opportunity';
    opp.Accountid = acc.id;
    opp.CloseDate = system.Today() + 5;
    opp.StageName = 'Qualification';
    insert opp;

    Product2 prod = new Product2();
    prod.Name = 'test';
    prod.isActive = true;

    insert prod;

    PriceBookEntry pb = new PriceBookEntry();
    pb.UnitPrice = 300;
    pb.PriceBook2Id = test.getStandardPricebookId();
    pb.Product2Id = prod.Id;
    pb.IsActive = true;

    insert pb;

    OpportunityLineItem oli = new OpportunityLineItem();
    oli.pricebookentryid = pb.Id;
    oli.UnitPrice = 30000;
    oli.Quantity = 2;
    oli.OpportunityID = opp.Id;
    insert oli;

    opp.StageName = 'Closed Won';

    Test.startTest();

    update opp;

    Test.stopTest();
  }

@isTest
public static void validatecountAdditionalEquipmentPrice(){

    Account acc = new Account();
    acc.Name = 'Test Account';
    insert acc;

    Opportunity opp = new Opportunity();
    opp.Name = 'Test Opportunity';
    opp.Accountid = acc.id;
    opp.CloseDate = system.Today() + 5;
    opp.StageName = 'Qualification';
    insert opp;

    Product2 prod = new Product2();
    prod.Name = 'test';
    prod.isActive = true;

    insert prod;

    PriceBookEntry pb = new PriceBookEntry();
    pb.UnitPrice = 300;
    pb.PriceBook2Id = test.getStandardPricebookId();
    pb.Product2Id = prod.Id;
    pb.IsActive = true;

    insert pb;

    OpportunityLineItem oli = new OpportunityLineItem();
    oli.pricebookentryid = pb.Id;
    oli.UnitPrice = 30000;
    oli.Quantity = 2;
    oli.OpportunityID = opp.Id;
    insert oli;

    Car_equipment__c carEq = new Car_equipment__c();
    carEq.Name='Test Equipment';
    carEq.Price__c=5000;
    insert carEq;

    CSP_AdditionalEquipment__c carAddEq = new CSP_AdditionalEquipment__c();
    carAddEq.Car_equipment__c = carEq.id;
    carAddEq.Car_suggestion__c = oli.id;

    Test.startTest();
    insert carAddEq;
    Test.stopTest();








}


}
