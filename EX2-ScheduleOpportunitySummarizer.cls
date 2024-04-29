global class ScheduleOpportunitySummarizer implements Schedulable {
    global void execute(SchedulableContext SC) {
        OpportunitySummarizerBatch batchJob = new OpportunitySummarizerBatch();
        Database.executeBatch(batchJob);
    }
}