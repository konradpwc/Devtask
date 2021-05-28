public class updateContactAddressHandler {
     public static void createContact(List<Account> accounts) {
        List<Contact> contact = new List<Contact>();
        for(Account acc : accounts){
            Contact con = new Contact(LastName = acc.name,
                        AccountId=acc.id,
                        MailingStreet=acc.BillingStreet,
                        MailingCity=acc.BillingCity,
                        MailingState=acc.BillingState,
                        MailingPostalCode=acc.BillingPostalCode,
                        MailingCountry=acc.BillingCountry,
                        Fax=acc.Fax);
            contact.add(con);
        }
        insert contact; 

}
}