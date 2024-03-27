@IsTest
private class ScheduleOpportunitySummarizerTest {
    @IsTest static void testScheduling() {
        Test.startTest();
        ScheduleOpportunitySummarizer scheduler = new ScheduleOpportunitySummarizer();
        scheduler.execute(null); 
        Test.stopTest();

        
    }
}