trigger AccountTrigger on Account (before insert,after insert,before update,after update,before delete,after undelete){
    AccountTriggerHandler handler=new AccountTriggerHandler();
    if(Trigger.isBefore && Trigger.isInsert){
        handler.beforeInsert(Trigger.New);
    }
    else if(Trigger.isAfter && Trigger.isInsert){
        handler.afterInsert(Trigger.New);
    }
}