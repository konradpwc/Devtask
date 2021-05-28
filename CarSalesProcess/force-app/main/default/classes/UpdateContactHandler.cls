public class UpdateContactHandler {
    public static void updateContact(List<Account> newaccountList,Map<id,Account> oldAccountMap){
        
       Set<Id> accIds = new Set<Id>();
    for (account acc : newaccountList){
        Account old = oldAccountMap.get(acc.Id);
        IF(acc.BillingStreet != old.BillingStreet){
            accIds.add(acc.id);
        }
    
    if (accIds.size()>0){
       Map<Id, Contact> updates = new Map<Id, Contact>();
        for(Contact con :[Select Id from Contact where AccountId in :accIds]){
            updates.put(con.Id, new Contact(
                Id = con.Id,
                MailingStreet = acc.BillingStreet
					
                ));
            
            
        }
        
        update updates.values();
        
    }

    
}
  
        
        
        
    }

}