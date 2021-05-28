@isTest
private class TestVerifyDate{
    @isTest static void CheckDatesTesttrue(){
        Date date1 = date.today();
        Date date2 = date1.addDays(29);
        Date t = VerifyDate.CheckDates(date1,date2);
        System.assertEquals(t,date2);
        
    }
     @isTest static void DateOver(){
        Date date1 = date.today();
        Date date2 = date1.addDays(31);
        Date t = VerifyDate.CheckDates(date1,date2);
        System.assertNotEquals(t,date1);
    
        
    }
    
    

}