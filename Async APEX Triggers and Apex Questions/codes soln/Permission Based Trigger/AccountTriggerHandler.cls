public class AccountTriggerHandler {

    public  void handleBeforeInsert(List<Account> newAccounts){

        Boolean hasAccess=FeatureManagement.checkPermission('Run_Account_Trigger');//API name of the custom permission
        if(!hasAccess){
            System.debug('Trigger execuation skipped : User Profile doesn not have required Custom permission !');
            return;
        } 
        else{
            runBusinessLogic(newAccounts);
        }
    }

    private   void runBusinessLogic(List<Account> newAccounts){
        //run ur business logics here ..... 
    }
}