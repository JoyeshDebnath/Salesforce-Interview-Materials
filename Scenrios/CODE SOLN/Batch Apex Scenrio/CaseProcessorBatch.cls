
public class CaseProcessorBatch implements Database.Batchable<SObject>,Database.Stateful,Database.AllowsCallouts,Database.RaisesPaltformEvents{

    public Database.QueryLocator start (Database.BatchableContext bc ){
        return Database.getQueryLocator([
            SELECT Id,Description,Status FROM Case 
                            WHERE LastModifiedDate < System.now().addDays(-30) 
                            AND Status='Working'
        ]); 
    }

    public void execute (Databse.BatchableContext bc,List<Case> scope){
        for(Case cse:scope){
            cse.Description='case processed at : '+System.now();
            cse.Status='Closed';
        }

        if(!scope.isEmpty()){
            Database.SaveResults[] results=Database.update(scope,false);
            for(Database.SaveResult res : results ){
                if(!res.isSuccess()){
                    System.debug('FAILED ---> '+res.getId()+'   -  '+res.getErrors()[0].getMessage());
                }
            }
        }
    }

    public void finish(Database.BatchableContext bc ){
        System.debug('Batch processing completed for JOB ID :'+bc.getJobId());
    }
}