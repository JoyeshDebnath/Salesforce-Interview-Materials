trigger OpportunityTrigger on Opportunity (before insert){
    if(Trigger.isBefore && Trigger.isInsert){
        OpportunityTriggerHandler.preventClosedLostWithActiveContacts(Trigger.New);
    }
}