@istest
private class TestRestrictContactByName {
    @isTest static void TestRestrictContactByName(){
        Contact con = New Contact(LastName = 'INVALIDNAME', FirstName='Error');        
                   
        Test.startTest();
           try
            {
                insert con;
            }
        catch(Exception e){
                Test.stopTest(); 
            
                           
              
        
            }
        }

}