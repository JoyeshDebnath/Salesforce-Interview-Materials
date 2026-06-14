public class UpdateLeadsSchedulerClass implements Schedulable{
    public void execute(SchedulableContext ctx){
        Database.executeBatch(new UpdateLeadsBatch(),200);
    }
}

// ----------------------------------------------------
String CronExpression = '0 0 0 * * ?';
String jobname='Nightly Leads Update';
System.schedule(jobname,cronExpression);