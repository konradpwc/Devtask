global class CSP_CreateNewCasesSchedule implements Schedulable {
  global void execute(SchedulableContext ctx) {
    CSP_CreateNewCases cas = new CSP_CreateNewCases();
    Database.executebatch(cas);
  }
}
