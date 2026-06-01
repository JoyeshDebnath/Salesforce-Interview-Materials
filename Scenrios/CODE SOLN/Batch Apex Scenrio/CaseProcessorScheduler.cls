public class CaseProcessorScheduler implemments Schedulable {
    public void execute (SchedulableContext sc){
        Database.executeBatch(new CaseProcessorBatch(),200);
    }
}

//----------------------------------------Schedule 👇

String cronExp = '0 0 0 * * ?';
System.schedule('Daily Automated Case Processor ,,',cronExp,new CaseCaseProcessorScheduler());