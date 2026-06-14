public class AccountCalloutQuaueable implement Quaeuable,Dlatabase.AllowsCallouts{
    private List<Id> accountIds;
    AccountCalloutQuaueable(List<Id> accountIds){
        this.accountIds=accountIds;
    }

    public void execute(QuaueableContext qc){

        List<Account> accntsToProcess=[SELECT ID,Name,AccountNumber FROM Account WHERE Id IN : accountIds];
        for(Account acc:accntsToProcess){
            Http http=new Http();
            HttpRequest req=new HttpRequest();
            req.setEndpount('https://wwww.example.com/accounts/'+acc.AccountNumber);
            req.setMethod('POST');
            req.setHeader('Content-Type','application/json');
            req.setBody('{"name":"' + acc.Name + '"}');

            try{
                HttpResponse response=http.send(req);
                if(response.getStatusCode()==200){
                    System.debug('Response sent=>'+response.getBody());
                }
                else{
                    System.denug('Something occurred !!!');
                }
            }catch(Exception err){
                System.debug('Exception ocurred =>'+err.getMessage());
        }
    }
}
}