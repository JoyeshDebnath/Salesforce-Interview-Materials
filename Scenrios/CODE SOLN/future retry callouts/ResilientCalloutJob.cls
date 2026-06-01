public class ResilientCalloutJob implements Queueable,Database.AllowsCallouts{
    
    private String payload;
    private Integer  currentRetryCount;
    private  static final Integer MAX_RETRY=3;//maximum retry allowed 
    
    // --> standard cosntructor for initial execuation 
    public ResilientCalloutJob(String payload){
        this.payload=payload;
        this.currentRetryCount=0;
    }
    //--> Overloaded constructor for retrying with updated retry count .. 
    public ResilientCalloutJob(String payload,Integer retryCount){
        this.payload=payload;
        this.currentRetryCount=retryCount;
    }

    public void execute (QueueableContext qc){
        Http http=new Http();
        HttpRequest req=new HttpRequest();
        req.setEndpoint('https://api.example.com/data');
        req.setMethod('POST');
        req.setHeader('Content-Type','application/json');
        req.setBody(this.payload);

        try{
                HttpResponse res=http.send(req);
                if(res.getStatusCode()!=200){
                    System.debug('Remote Server Error :'+res.getStatusCode());
                }
        }catch(Exception err){
             System.debug('Callout Failed at current # '+this.currentRetryCount+' With Error '+err.getMessage());
             
             if(this.currentRetryCount < MAX_RETRY){
                Integer delayTimer= this.currentRetryCount * 3;//--> crete a delay 
                ResilientCalloutJob retryJob=new ResilientCalloutJob(this.payload,this.currentRetryCount+1);
                System.enqueueJob(retryJob,delayTimer);
             }else{
                logHardFailure(this.payload,err.getMessage());
             }

        }
    }

    public void logHardFailure(String payload,String errorMsg){
        System.debug('Payload:'+payload+' Failed after max retries with error : '+errorMsg);
    }

}