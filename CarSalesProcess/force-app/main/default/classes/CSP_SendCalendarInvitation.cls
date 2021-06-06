public with sharing class CSP_SendCalendarInvitation {
  public void sendInvitation(List<Case> caseList) {
    Set<ID> casIds = new Set<ID>();

    for (Case cas : caseList) {
      casIds.add(cas.Id);
    }

    Map<ID, Case> caseMap = new Map<ID, Case>([SELECT ID, Account.Email__c, Service_scheduled_date__c, Car__r.Name FROM Case WHERE ID IN :casIds]);

    for (Case nCase : casemap.values()) {
      String toEmailAddress = nCase.Account.Email__c;
      String[] sendTo = new List<String>{ toEmailAddress };

      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      mail.setToAddresses(sendto);
      mail.setSubject('Car service invitation for' + nCase.Car__r.Name);
      mail.setPlainTextBody('Hello. This is invitaiton for upcoming car review.');
      Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
      attach.filename = 'invitation.ics';
      attach.ContentType = 'text/calendar';
      attach.inline = true;
      attach.body = invite(nCase.Service_scheduled_date__c);
      mail.setFileAttachments(new List<Messaging.EmailFileAttachment>{ attach });
      Messaging.SendEmailResult[] er = Messaging.sendEmail(new List<Messaging.Email>{ mail });
    }
  }
  public static Blob invite(datetime scheduleDate) {
    DateTime dt = scheduleDate;
    String startdatetime = String.valueof(dt.year() +'0' +dt.month() +'' +dt.day() +'T000000Z');
    String enddatetime = String.valueof(dt.year() +'0' +dt.month() +'' +dt.day() +'T010000Z' );
    String txtInvite = '';
    txtInvite += 'BEGIN:VCALENDAR\n';
    txtInvite += 'PRODID::-//hacksw/handcal//NONSGML v1.0//EN\n';
    txtInvite += 'VERSION:2.0\n';
    txtInvite += 'METHOD:PUBLISH\n';
    txtInvite += 'X-MS-OLK-FORCEINSPECTOROPEN:TRUE\n';
    txtInvite += 'BEGIN:VEVENT\n';
    txtInvite += 'CLASS:PUBLIC\n';
    txtInvite += 'CREATED:20091026T203709Z\n';
    txtInvite += 'DTEND:' + enddatetime + '\n';
    txtInvite += 'DTSTAMP:20191026T203709Z\n';
    txtInvite += 'DTSTART:' + startdatetime + '\n';
    txtInvite += 'LAST-MODIFIED:20091026T203709Z\n';
    txtInvite += 'LOCATION:Poland\n';
    txtInvite += 'PRIORITY:5\n';
    txtInvite += 'SEQUENCE:0\n';
    txtInvite += 'SUMMARY;';
    txtInvite += 'LANGUAGE=en-us:Meeting\n';
    txtInvite += 'TRANSP:OPAQUE\n';
    txtInvite += 'X-ALT-DESC;FMTTYPE=text/html:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN"><HTML><HEAD><META NAME="Generator" CONTENT="MS Exchange Server version 08.00.0681.000"><TITLE></TITLE></HEAD><BODY><!-- Converted from text/plain format --></BODY></HTML>\n';
    txtInvite += 'X-MICROSOFT-CDO-BUSYSTATUS:BUSY\n';
    txtInvite += 'X-MICROSOFT-CDO-IMPORTANCE:1\n';
    txtInvite += 'END:VEVENT\n';
    txtInvite += 'END:VCALENDAR';
    return Blob.valueOf(txtInvite);
  }
}
