public class AccountUIController {

    @AuraEnabled
    public static String triggerExternalSync(Id accountId,String payload){
        try{
            Id jobID= System.enqueueJob( new AsyncCalloutJob(accountId,payload));
            return jobID;//return job id to ui for tracking status and progress spinner or tracker in ui 
        }catch(Exception e ){
            throw new AuraHandleException('Failed to inititiate Background sync :'+e.getMessage());
            
        }
    }
}