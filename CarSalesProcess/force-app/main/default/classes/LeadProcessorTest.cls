@isTest
public class  LeadProcessorTest {
    @isTest
    public static void testit(){
        List<Lead> l_lst= new List<Lead>();
        for(integer i=0;i<200;i++){
        l_lst.add( new Lead(Lastname ='l_lst'+i,
                            Company='Company', Status='Random Status'));
                  
                           
       
    }
      insert l_lst;
        
        test.StartTest();
        LeadProcessor lp = new Leadprocessor();
        Id batchId = Database.executeBatch(lp);
        Test.StopTest();
                  
}
}