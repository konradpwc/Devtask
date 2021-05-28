public class AccountProcessor {

    @future
    public static void countContacts(Set<id> setId){
        List<Account> lstAccount = [SELECT Id, Number_of_Contacts__c, (SELECT Id FROM Contacts) From Account where ID in :setId];
        for(Account acct : lstAccount){
            List<Contact>lstCont = acct.Contacts;
            acct.Number_Of_Contacts__c = lstCont.size();
        }
            update lstAccount;
      
    }
   
        
        
}