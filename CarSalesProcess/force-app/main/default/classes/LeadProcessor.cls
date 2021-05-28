global class LeadProcessor implements
 Database.Batchable<sObject>, Database.Stateful {
   
    global Integer count = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT ID, LeadSource FROM Lead');
        
    }
     
     global void execute (Database.BatchableContext bc, List<Lead> l_lst) {
         List<Lead> l_lst_new = new List<lead>();
         for(lead l : l_lst){
             
           l.leadsource = 'Dreamforce';
           l_lst_new.add(l);
            count += 1;
             
         }
         update l_lst_new;
         
     }
     global void finish (Database.BatchableContext bc){
         system.debug('count = ' +count);
     }
                  
         
         
     }