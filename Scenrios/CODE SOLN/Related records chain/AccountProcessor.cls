public class Step1_AccountProcessor implements Queueable{
    private List<Id> accntIdsToProcess;

    Step1_AccountProcessor(List<Id> accIds){
        this.accntIdsToprocess=accIds;
    }

    public void execute (QueueableContext qc){
           List<Account> accounts = [ SELECT Id,Name,Description 
                                        FROM Account 
                                        WHERE Id IN : this.accntIdsToProcess ];
        for(Account acc:accounts){
            acc.Description='Account processed at '+System.now();
        }
        if(!accounts.isEmpty()){
            update(accounts);
        }

        System.enqueueJob(new Step2_ContactProcessor(this.accntIdsToProcess));
    }
} 