global class DailyLeadProcessor implements schedulable {
     global void execute(SchedulableContext ctx) {
        List<lead> leadstoupdate = new List<Lead>();
        List<Lead> leads = [SELECT Id
            FROM LEAD
            WHERE LeadSource = NULL Limit 200];
       
         FOR(Lead l : leads){
             l.LeadSource = 'Dreamforce';
             leadstoupdate.add(l);
         }
         
         update leadstoupdate;
         
     }

}