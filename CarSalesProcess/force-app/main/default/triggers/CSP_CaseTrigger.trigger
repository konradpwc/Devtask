trigger CSP_CaseTrigger on Case(after insert) {
    
  CSP_SendCalendarInvitation handler = new CSP_SendCalendarInvitation();

  if (Trigger.isInsert) {
    handler.sendInvitation(Trigger.new);
  }

}
