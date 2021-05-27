public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(List<Case> cases , Map<Id,Case> oldcases) 
    {
        // TODO: Complete the method to update workorders
    
           SET<ID> mrid = new Set<ID>();
    For(Case cas : cases)
    {
    	Case old = oldcases.get(cas.id);  
        IF(old.Status != cas.Status)
        
        {
       		 If((cas.Type == 'Repair' || cas.Type == 'Routine Maintenance')&& cas.Status == 'Closed')
            {
            
          mrid.add(cas.id);
            
             }
        }
    }
            IF(!mrid.isempty())
            
            {
       
       
        				  LIST<DECIMAL> lowestvalue = new LIST<DECIMAL>();
                          FOR(Equipment_Maintenance_Item__c test : [Select Equipment__r.Maintenance_Cycle__c from Equipment_Maintenance_Item__c 
                                                                              Where Maintenance_Request__c in :mrid])
                          {
                              lowestvalue.add(test.Equipment__r.Maintenance_Cycle__c);
                              
                          }
                          
        				Decimal lowvalue;
        					for(Integer  i= 0; i<lowestvalue.size();i++){
                                if(lowvalue == null || lowestvalue.get(i) <lowvalue){
                                    lowvalue =lowestvalue.get(i);
                            }
                            }
                           
           
                       /// Map<ID,Case> casemap = new Map <Id,Case>();

                		LIST<Case> casetocreate = New List<Case>();
        			
                        For(Case c : [Select ID, Type, Product__c,Vehicle__c From Case Where ID in :mrid ])
                        {
                                  
                                    
                            Case cas = new Case();
                            
                            cas.Origin = 'Phone';
                            cas.Type = 'Routine Maintenance';
                            cas.Vehicle__c = c.Vehicle__c;
                            cas.Description = 'utworzyny automatycznie';
                            cas.Subject = 'Routine Maintenance';
                            cas.Date_Reported__c = Date.today();
                            cas.Maintanance__c = lowvalue;                           
                            cas.Date_Due__c = Date.Today().addDays(Integer.valueOf(lowvalue)) ;
                            
                            
                           	 	//casemap.put(c.ID, New Case(                               
                               	//Origin = 'Phone',
                                //Type = 'Routine Maintenance',
                                //Vehicle__c = c.Vehicle__c,
                                //Description = 'utworzyny automatycznie',
                                //Subject = 'Routine Maintenance',
                                //Date_Reported__c = Date.today(),
                                //Maintanance__c = lowvalue,
                                //Date_Due__c = Date.Today().addDays(Integer.valueOf(lowvalue))
                               
                            	///));
                            
                     ///insert casemap.values();    
                     
                            
							casetocreate.add(cas);
                        }    
                        
                            
                        insert casetocreate;

            
           // List<Equipment_Maintenance_Item__c> emi = new List <Equipment_Maintenance_Item__c>();
            	
            //For(Equipment_Maintenance_Item__c emid : [SELECT Maintenance_Request__r.id,Equipment__c, Equipment__r.Name,Equipment__r.Maintenance_Cycle__c 
               
                           //FROM Equipment_Maintenance_Item__c Where Maintenance_Request__c in :casemap.get(emid)])

            List<Equipment_Maintenance_Item__c> exisEmis = [SELECT Maintenance_Request__r.id,Equipment__c, Equipment__r.Name,Equipment__r.Maintenance_Cycle__c 
                                                         FROM Equipment_Maintenance_Item__c where Maintenance_Request__c in :mrid];
            FOR (Case ca : casetocreate)
               

            {
                FOR( Equipment_Maintenance_Item__c emid  : exisEmis)
                {                              
                                      
                                            
                                           
                      emid.Maintenance_Request__c = ca.id;
                                                                                                           
                }    
                           
            }
            
            Update exisEmis;           					              
         }
        
        
    }        
    
}