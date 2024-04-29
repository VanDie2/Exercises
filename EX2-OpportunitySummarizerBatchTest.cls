@IsTest
private class OpportunitySummarizerBatchTest {
    @IsTest static void testOpportunitySummarization() {
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;

        Opportunity testOpportunity = new Opportunity(
            Name='Test Opportunity',
            StageName='Closed Won',
            Amount=1000,
            CloseDate=System.today(),
            AccountId=testAccount.Id);
        insert testOpportunity;

        Test.startTest();
        OpportunitySummarizerBatch batchJob = new OpportunitySummarizerBatch();
        Database.executeBatch(batchJob);
        Test.stopTest();

        
    }
}