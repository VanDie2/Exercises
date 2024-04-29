public class UpdatePrimaryContactPhoneBatch implements Database.Batchable<sObject> {

    private final String query;
    private final String primaryContactPhone;
    private final Id accountId;

    public UpdatePrimaryContactPhoneBatch(String primaryContactPhone, Id accountId) {
        this.query = 'SELECT Id, Primary_Contact_Phone__c FROM Contact WHERE AccountId = \'' + accountId + '\'';
        this.primaryContactPhone = primaryContactPhone;
        this.accountId = accountId;
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Contact> records) {
        List<Contact> contactsToUpdate = new List<Contact>();
        
        for(Contact c : records) {
            if(c.Primary_Contact_Phone__c != primaryContactPhone) {
                c.Primary_Contact_Phone__c = primaryContactPhone;
                contactsToUpdate.add(c);
            }
        }
        
        if(!contactsToUpdate.isEmpty()) {
            try {
                update contactsToUpdate;
            } catch(DmlException e) {
                System.debug('An error occurred while updating contacts: ' + e.getMessage());
            }
        }
    }
    
    public void finish(Database.BatchableContext BC) {
        System.debug('Batch process finished successfully.');
    }
}
