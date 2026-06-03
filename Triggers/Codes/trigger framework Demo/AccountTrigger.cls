trigger AccountTrigger on Account(before insert,after insert,before update,after update,before delete,after undelete){
    
    AccountTriggerHandler handler = new AccountTriggerHandler();   
    handler.run(); 
}