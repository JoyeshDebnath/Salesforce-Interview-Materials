
public class RetryBatchClass implements Database.Batchable<SObject>,Database.AllowsCallouts,Database.Statefule,Database.RaisesPlatformEvents{

    List<Id> failedRecordIds=new List<Id>();

    public Database.QueryLocator start (Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id,Name FROM Account WHERE AccountSource='FAILED']);
    }

    public void execute(Database.BatchableContext bc , List<Account> scope){
        for(Account acc:scope){
            acc.AccountSource='processed';
        }
        Database.SaveResult[] results=Database.update(scope,false);
        for(Integer i=0;i<results.size();i++){
            if(!results[i].isSuccess){
                failedRecordIds.add(scope[i].Id);
            }
        }   
    }

    public void finish(Database.BatchableContext bc ){
        if(!failedRecordIds.isEmpty()){
            System.debug('Total Records failed -> '+failedRecordIds.size());
        }
    }
}