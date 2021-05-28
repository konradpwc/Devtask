public class AccountUtility {
    public static void viewAnnualRevenue(){
        List <Account> accountsList = [SELECT Name,AnnualRevenue from Account];
        
        for(account acc : accountslist){
            
          String  acctRev = 'account name: ' + acc.name + ', annual revenue: ' + acc.AnnualRevenue;
            system.debug(acctRev);
        }
    
 }
}