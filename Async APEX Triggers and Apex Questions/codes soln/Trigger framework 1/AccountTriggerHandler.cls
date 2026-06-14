class AccountTriggerHandler{
    public void beforeInsert (List<Account> newList){
        AccountService.validateAccountData(newList);
        AccountService.populateDefaultFields(newList);
    }

    public void afterInsert(List<Account> newList){
        AccountService.createDefaultContacts(newList);
        AccountService.sendToExternalSystem(newList);
    }
}