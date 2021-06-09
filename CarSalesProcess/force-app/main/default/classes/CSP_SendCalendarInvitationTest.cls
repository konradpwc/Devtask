@isTest
public class CSP_SendCalendarInvitationTest {
    @isTest
    private static void validateSendInvitation() {


    Account testAccount = new Account();
    testAccount.Name = 'Test Account';
    testAccount.Email__c = 'testclass@testclass.com';

    insert testAccount;

    List<case> caseList = new List<case>();

    For(Integer i = 0; i<10;i++){
        Case c = new Case();
        c.Origin= 'Apex Schedule';
        c.Status = 'New';
        c.AccountId = testAccount.id;

        
        caseList.add(c);
    }
    

    Test.startTest();
    insert caseList;
    Test.stopTest();
    system.debug(caseList);

    }


    }

