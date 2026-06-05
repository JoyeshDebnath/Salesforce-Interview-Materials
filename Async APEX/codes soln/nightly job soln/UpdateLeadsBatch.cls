public class UpdateLeadsBatch implements Database.Batchable<SOBject>{
  public Database.QueryLocator start(Database.BatchableContext bc){
    Date cutoffDate=Date.today().addDays(-90);
    return Database.getQueryLocator([
        SELECT Id,CreatedDate,Status 
        FROM Lead
        WHERE Status='Open - Not Contacted' 
        AND  CreatedDate <= :cuttoffDate
    ]);
  }  

  public void execute(Database.BatchableContext bc,List<Lead> scope){
        for(Lead ld:scope){
            ld.Status='Unqualified';
        }

        if(!scope.isEmpty())
            {
                Database.SaveResult[] results=Database.update(scope,false);
                for(Database.SaveResult sr:results){
                    if(!sr.isSuccess()){
                        System.debug('The failed record->'+sr.getId() +' - '+'Error=>'+sr.getErrors[0].getMessage());
                    }
                }
            }
  }

  public void finish(Database.BatchableContext bc ){
    System.debug('Processed !!!');
  }
}