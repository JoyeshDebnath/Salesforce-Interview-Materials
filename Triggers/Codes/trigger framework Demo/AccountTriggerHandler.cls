public class AccountTriggerHandler extends TriggerHandler{
    
    private List<Account> newRecords;
    private Map<Id,Account> oldMap;

    public AccountTriggerHandler(){
        this.newRecords = (List<Account>)Trigger.new;
        this.oldMap = (Map<Id,Account>) Trigger.oldMap;
    }

    protected override void beforeInsert(){
        AccountService.validateTaxIdentifiers(newRecords);
    }

    protected override void beforeUpdate(){
        AccountService.CalculateRiskScores(newRecords,oldMap);
    }
}