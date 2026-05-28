//Let’s say the user submits an Account form, and you need to perform heavy calculations to update all its child Opportunities.
public class AsyncOpportunityCalculator implements Queueable{
    private List<Id> accountIds;

    public AsyncOpportunityCalculator(List<Id> targetAccountIds){
        this.accountIds=targetAccountIds;
    }

    public void execute (QueuableContext qc){
        List<Opportunity> oppListToUpdate=new List<Opportunity>();
        //fetch related opps 
        List<Opportunity> relatedOpps=[SELECT Id,Amount,StageName,AccountId 
                                        FROM Opportunity 
                                        WHERE 
                                        AccountId IN : this.accountIds];
        if(relatedOpps.isEmpty()){
            return;
        }
        for(Opportunity opp : relatedOpps){
            if(opp.StageName=='Prospecting'){
                opp.Amount=(opp.Amount!=null)?opp.Amount*2.16 :1000.00;
                oppListToUpdate.add(opp);
            }
        }

        if(!oppListToUpdate.isEmpty())
                Database.update(oppListToUpdate,false);
    }
}