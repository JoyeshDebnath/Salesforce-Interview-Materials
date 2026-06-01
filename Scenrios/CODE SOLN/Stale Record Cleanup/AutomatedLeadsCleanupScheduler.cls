public class AutomatedLeadsCleanupScheduler implements Schedulable{
    public void execute (SchedulableContext sc){
        AutomatedLeadsCleanupBatch batch = new AutomatedLeadsCleanupBatch();
        Database.executeBatch(batch,200);

    }
}

// ----------------- anonymous Apex Script to run the scheduler class ------------------ 

String cronExp='0 0 23 * * ?';
System.schedule('Automated LEads cleanup',cronExp,new AutomatedLeadsCleanupScheduler())

