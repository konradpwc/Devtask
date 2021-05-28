@istest
public class AccountProcessorTest {
    public static testmethod void  TestAccountProcessorTest(){
        Account a = new Account();
        a.Name = 'Test Account';
        Insert a;
        
        Contact cont = New Contact();
        cont.FirstName = 'JJ';
        cont.LastName = 'Hello';
        cont.AccountId = a.id;
        Insert cont;
        
        set<Id> setAccid = new Set<ID>();
        SetAccid.add(a.ID);
        
        Test.startTest();
        	AccountProcessor.countContacts(setAccId);
        Test.StopTest();

        Account ACC = [Select Number_of_Contacts__c FROM Account WHERE ID = :a.id LIMIT 1];
		System.assertEquals(integer.valueof(Acc.Number_of_Contacts__c),1);        
        
    }

}