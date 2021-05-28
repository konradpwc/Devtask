trigger CreateContactTrigger on Account (after insert) {
    List<Contact> contacts = new List<Contact>();
    For(Account acc : Trigger.new){
        
        Contact c = new Contact();
        c.LastName = acc.name;
        c.AccountId = acc.id;
        
        contacts.add(c);
    }
    
  insert contacts;  
}