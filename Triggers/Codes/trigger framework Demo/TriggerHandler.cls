public virtual class TriggerHandler{
    
    public static Set<String> bypassHandlers = new Set<String>();

    public void run(){

        if(Trigger.isBefore){
            if(Trigger.isInsert) beforeInsert();
            else if(Trigger.isUpdate) beforeUpdate();
        }else if(Trigger.isAfter){
            if(Trigger.isInsert) afterInsert();
            else if(Trigger.isUpdate) afterUpdate();
        }
    }

    protected virtual beforeInsert();
    protected virtual beforeUpdate();
    protected virtual afterInsert();
    protected virtual afterUpdate();

} 