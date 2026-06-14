public class ScalableProcessorQueueable  implements Queueable{
    private List<Id> recordsToProcess;
    private static final Integer BATCH_SIZE=100;//Throttling size 
    
    ScalableProcessorQueueable(List<Id> recordIds){
        this.recordsToProcess=recordIds;
    }

    public void execute(QeueableContext qc){
        List<Id> currentBatch=new List<Id>();
        List<Id> remainingIds=new List<Id>();

        for(Integer i=0;i<recordsToProcess.size();i++){
            if(i<BATCH_SIZE){
                currentBatch.add(recordsToProcess[i]);
            }else{
                remainingIds.add(recordsToProcess[i]);
            }
        }
        executeCallouts(currentBatch);
        if(!remainingIds.isEmpty()){
            System.enqueJob(new  ScalableProcessorQueueable(remainingIds));
        }

    }

    private void executeCallouts(List<Id> ids){
        //Perform you callouts and other logics .... 
    }
}

///------------- Call the Above Quauable from Triggrs -----------------
/*
List<Id> oppIds=new List<Id>();
for(Opporunity opp : Trigger.New){
    oppIds.add(opp.Id);
}

if(!oppIds.isEmpty()){
    System.enqueueJob(new ScalableProcessorQueueable(oppIds));
}

*/