trigger UpdateContactAdress on Account (after update) {
    
   //Set<Id> accIds = new Set<Id>();
    //for (account acc : Trigger.new){
      //  Account old = Trigger.oldMap.get(acc.Id);
      //  IF(acc.BillingStreet != old.BillingStreet){
      //      accIds.add(acc.id);
    //    }
    
  //  if (accIds.size()>0){
 //      Map<Id, Contact> updates = new Map<Id, Contact>();
  //      for(Contact con :[Select Id from Contact where AccountId in :accIds]){
  //          updates.put(con.Id, new Contact(
   //             Id = con.Id,
   //             MailingStreet = acc.BillingStreet
                    
      //          ));
            
            
  //      }
        
  //      update updates.values();
        
//    }

    

  //}

    
    if(Trigger.isAfter) {
        UpdateContactHandler.UpdateContact(trigger.New,Trigger.OldMap);
    
}
    

}