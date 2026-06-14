trigger AccountTrigger on Account(after insert){
    List<Id> accountIdsToProcess=new List<Id>();
    for(Account acc:Trigger.New){
        if(acc.AccountNumber!=null){
            accountsToProcess.add(acc.Id);
        }
    }

    if(!accountsToProcess.isEmpty()){
        System.enqueueJob(new AccountCalloutQuauable(accountToProcess));
    }
}