public class AddPrimaryContact implements Queueable {
    private contact con;
    private string state;
    
    public AddPrimaryContact(contact con, String state) {
        this.con = con;
        this.state = state;
    }
    public void execute(QueueableContext context) {
        List<account> accounts = [Select Id, Name, (Select Firstname,LastName, Id from Contacts)
                                 from Account where BillingState = :state Limit 200];
        List<Contact> primaryContacts = new List<Contact>();
        for(Account acc : accounts){
            Contact c = con.clone();
            c.AccountId = acc.Id;
            primaryContacts.add(c);
        }
        
        if(primaryContacts.size() > 0){
            insert primaryContacts;
        }
    }

}