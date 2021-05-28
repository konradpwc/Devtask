trigger UpdateContacttrigger2 on Account (after update) {

 
   	
    
    if(Trigger.isUpdate) {
        UpdateContactHandler.UpdateContact(trigger.New,Trigger.OldMap);
    
}
    

}