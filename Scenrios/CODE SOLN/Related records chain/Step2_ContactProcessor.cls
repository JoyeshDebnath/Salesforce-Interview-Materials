public class Step2_ContactProcessor implements Queueable{
    private List<Id> accntIdsToProcess;

    Step2_ContactProcessor(List<Id> accIds){
        this.Step2_ContactProcessor=accIds;
    }

    public void execute(QueueableContext qc){
        List<Contact> contactsToUpdate=[SELECT Id,AccountId,Description 
                                        FROM Contact 
                                        WHERE 
                                        AccountId IN : this.accntIdsToProcess];
    for(Contact con : contactsToUpdate){
        con.Description='Contact processed at '+System.now();
    }
    if(!contactsToUpdate.isEmpty()){
        update(contactsToUpdate);
    }
    
    }
}