@isTest
private class UpdatePrimaryContactPhoneBatchTest {
    @isTest static void testUpdatePrimaryContactPhoneBatch() {
        // Set up test data
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;
        
        Contact primaryContact = new Contact(AccountId=testAccount.Id, LastName='Primary', Primary_Contact_Phone__c='123-456-7890', IsPrimary__c=true);
        Contact secondaryContact = new Contact(AccountId=testAccount.Id, LastName='Secondary', Primary_Contact_Phone__c=null, IsPrimary__c=false);
        insert new List<Contact>{primaryContact, secondaryContact};
        
        // Execute batch job
        Test.startTest();
        UpdatePrimaryContactPhoneBatch batchProcess = new UpdatePrimaryContactPhoneBatch('123-456-7890', testAccount.Id);
        Id batchJobId = Database.executeBatch(batchProcess);
        Test.stopTest();
        
        // Verify that the secondary contact's Primary_Contact_Phone__c field was updated
        Contact updatedContact = [SELECT Primary_Contact_Phone__c FROM Contact WHERE Id=:secondaryContact.Id];
        System.assertEquals('123-456-7890', updatedContact.Primary_Contact_Phone__c);
    }
}