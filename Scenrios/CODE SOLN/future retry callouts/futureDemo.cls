public class FutureDemo {
    @future(callout=true)
    public static void executeLegacyCallout(String payload) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:MyExternalService/v1/sync');
        request.setMethod('POST');
        request.setBody(payload);

        try {
            HttpResponse response = http.send(request);
            if (response.getStatusCode() != 200) {
                throw new CalloutException('HTTP Error: ' + response.getStatusCode());
            }
        } catch (Exception ex) {
            System.debug('Legacy Future callout failed. Handing off to Queueable Retry Engine.');
            
            // Kickoff a Queueable job to handle retries from this point forward
            // Passing '1' indicates the first retry attempt is now beginning
            System.enqueueJob(new ResilientCalloutJob(payload, 1));
        }
    }
}