global class CSP_CreateNewCases implements Database.Batchable<sObject> {
  global Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
      'SELECT ID,CreatedDate,Account__c FROM CSP_Car__c WHERE CreatedDate  = LAST_N_YEARS:2'
    );
  }

  global void execute(Database.BatchableContext bc, List<CSP_Car__c> cars) {
    List<Case> newCase = new List<Case>();

    for (CSP_Car__c c : cars) {
      Case cas = new Case();

      Cas.Car__c = c.id;
      cas.Origin = 'web';
      //cas.RecordType.DeveloperName = 'Car_Sales';
      cas.AccountId = c.Account__c;

      newCase.add(cas);
    }
    insert newCase;
  }

  global void finish(Database.BatchableContext bc) {
  }
}
