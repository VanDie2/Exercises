global class OpportunitySummarizerBatch implements Database.Batchable<sObject> {
    private Map<Id, AccountData> accountDataMap = new Map<Id, AccountData>();

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Amount, StageName, AccountId, Account.Name 
            FROM Opportunity 
            WHERE CALENDAR_MONTH(LastModifiedDate) = :Date.today().month() 
            AND CALENDAR_YEAR(LastModifiedDate) = :Date.today().year()
        ]);
    }

    global void execute(Database.BatchableContext bc, List<Opportunity> opportunities) {
        for (Opportunity opp : opportunities) {
            if (!accountDataMap.containsKey(opp.AccountId)) {
                accountDataMap.put(opp.AccountId, new AccountData(opp.AccountId, opp.Account.Name));
            }
            accountDataMap.get(opp.AccountId).addOpportunity(opp);
        }
    }

    global void finish(Database.BatchableContext bc) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for (AccountData data : accountDataMap.values()) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {data.primaryContactEmail};
            mail.setToAddresses(toAddresses);
            mail.setSubject('Monthly Opportunities Summary');
            mail.setHtmlBody(data.getEmailBody());
            emails.add(mail);
        }
        Messaging.sendEmail(emails);
    }
}