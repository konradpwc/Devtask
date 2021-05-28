public class AccountHandler {
    public static void insertAccount(Integer value){
        Integer n = 1;
       
        List<Account> addAccounts = new List<Account>();
        while(n <= value){
           
         
            Account store = new Account();
            store.Name = 'Acme Inc ' + n;
            store.AccountNumber = 'A000' + n;
            addAccounts.add(store);
          
          
            n = n + 1;
          
        }
        insert AddAccounts;
    }
}