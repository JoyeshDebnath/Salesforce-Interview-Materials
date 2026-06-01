//DELETE Stale leads records which are in 'Open - Not Contacted' status and created more than 180 days ago. This batch class will be scheduled to run on a weekly basis.


public class AutomatedLeadsCleanupBatch implements Database.Batchable<SObject>,Database.AllowsCallouts,Database.Stateful,Database.RaisesPlatformEvents{

    public Database.QueryLocator start (Database.BatchableContext bc ){
        return Database.getQueryLocator([SELECT Id 
                                            FROM Lead WHERE
                                            status='Open - Not Contacted' AND 
                                            CreatedDate < System.now().addDays(-180)
                                            ]);
    }

    public void execute (Database.BatchableContext bc , List<Lead> scope){
        if(!scope.isEmpty()){
            Database.SaveResult[] results = Database.delete(scope,false);
            for(Database.SaveResult res:results){
                if(!res.isSuccess()){
                        System.debug('FAILED -->'+ res.getId()+'   '+res.getErrors()[0].getMessage());
                }
            }
        }
    }

    public void finish (Database.BatchableContext bc ){
        System.debug('Data clean up JOB completed for JOB ID ----> '+bc.getJobId());
    }
}