trigger ValidatePrimaryContact on Contact (before insert, before update) {
    for(Contact ct : Trigger.new) {
        if(ct.IsPrimary__c == true) {
            List<Contact> existingPrimaryContacts = [SELECT Id FROM Contact WHERE AccountId = :ct.AccountId AND IsPrimary__c = true AND Id != :ct.Id];
            if(!existingPrimaryContacts.isEmpty()) {
                ct.addError('A primary contact already exists for this account.');
            }
        }
    }
}