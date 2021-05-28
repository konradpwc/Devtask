public class RandomContactFactory {
    
    public static list<Contact> generateRandomContacts(Integer numofcont, String lastname){
        List<Contact> con = new List<Contact>();
        for (integer i=0; i<numofcont;i++){
            Lastname = 'Test' +i;
            Contact c = new Contact( FirstName = lastname,LastName = lastname);
            con.add(c);
        }
        return con;
    }
 

}