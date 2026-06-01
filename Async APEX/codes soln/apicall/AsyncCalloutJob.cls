public class AsyncCalloutJob implements Queueable,Database.AllowCallouts{

    private String payload ;
    private Id recordID;

    AsyncCalloutJob(Id recordId,String payload){
        this.payload=payload;
        this.recordID=recordId;
    }

    public void execute (QueueableContext qc){
        Http http=new Http();
        HttpRequest req=new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://example.com');
        req.setHeader('Content-Type','Application/json');
        req.setTimeout(120000);
        req.setBody(this.payload);
        try{
                HttpResponse response=http.send(req);
            i(response.getStatusCode()==200){
                updateRecordStatus(this.recordID,'SUCCESS',response.getBody());
            }
            else{
                updateRecordStatus(this.RecordID,'FAILED','Error Code - '+response.getStatusCode());
            }
    }catch(Exception e){
        updateRecordStatus(this.RecordID,'ERROR',e.getMEssage());
    }
}  
    private void updateRecordStatus(Id recordId,String status,String message){
        Account acc=new Account(Id=recordId,AccountSource=status,Description=message);
        Database.update(acc,false);
    }
}