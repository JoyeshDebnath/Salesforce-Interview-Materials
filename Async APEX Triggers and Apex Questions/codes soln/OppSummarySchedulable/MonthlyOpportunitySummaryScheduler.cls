public class MonthlyOpportunitySummaryScheduler implements Schedulable{
    public void execute (SchedulableContext sc){
        Database.executeBatch(new MonthlyOppSummaryBatch(),200);
    }
}