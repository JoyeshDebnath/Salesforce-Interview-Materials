# Questions FROM Async APEX (Also covers Scenerios based questions )✨✨

### Q1>We want to automatically generate a monthly opportunity summary report and send to Sales manager on the first of every month . How would you implement this using Apex .

SOLN :

- Schedulable Apex : Used to invoke execuation at a specific time using CRON expression. However it runs syncronously within its excuation context , meaning it is tightly bound by standard ransaction limits .
- Batch Apex : By offloading the calculation from schedulable apex to batch job, we can process up to 50 million records efficientl in seperate , smaller chunks .
- Database.Stateful : by default batch apex is stateless - each chunk executes in a brand new transaction context. To accumulate summary data (like revenue and record counts ) acrosss all chunks , our batch class must implement _Database.Stateful_ to preserve the instance variable states between execuation .

  CODE :->
  [Scehuleable class ](../codes%20soln/OppSummarySchedulable/MonthlyOpportunitySummaryScheduler.cls)
  [Batch class ](../codes%20soln/OppSummarySchedulable/MonthlyOppSummaryBatch.cls)
  [Scheduler ](../codes%20soln/OppSummarySchedulable/executionscript.cls)

### Q2>After a user submits a form We need to do heavy calculations and update the related Records in the background . How to achieve this ?

SOLN : [Code Sample using Quauable ](../codes%20soln/RelatedRecordsCalculation/AsyncOpportunityCalculator.cls)

### Q3>We are calling a 3rd party API when a user clicks a button . This must happen asynchronously . What Apex will you use .

### Q4>What would you do if some records fails in Async batch or queueable jobs ? how would you retry them ?

_SOLN_ : For handling the erorrs there are two kinds of errors that might comeup : 1> erros that can be handled during execution and 2> unhandled errors like limitexceptions etc .

- **For handled Errors** : Use _Database.insert(scope,false)_ for partial commit to DB and _Database.SaveResult_ to capture the records with exception in that chunk in batch apex .

- **For Unhandled Errors** : Implement the **Database.RaisesPlatformEvents** which fires a standard platform event called **BatchApexErrorEvent** which you can catch and write a trigger on it .

CODE : 👉
[Batch APEX Retry DEMO✨](../codes%20soln/RetryFailedRecords/RetryBatchClass.cls);

### Q5>We want to clean up Sales records automatically How would you implement this

### Q6>"There is a scenario we want to process Accounts records in step 1 and then Related Contacts records in step2 - all asynchronously . How would you handle this in Apex ".

SOLN :

- **Why not @future Method :** Because future cannot chain . If you try to call a second future method from another @future method Salesforce throws a fatal error .

- **Queueable Chaining :** We can chain another Queueable Apex from execute method of a Queueable Apex using **System.enqueueJob()** inside the _execute()_ method of a queueable apex(this gives a fresh set of governor limits to the second call). Best suited for medium volume records .

- **Batch Apex chaining** (Best when we are dealing with large volumes of records >50,000): chain Batch apex calls in _finish()_ method using **Database.executeBatch()**.

### Q7>We used Future methods earlier . When and why should we migrate to Quauable Apex .

### Q8>How would you handle Governor limits when processing large number of records inside Scheduled Apex job ?

**SOLN**:

- Scheddulable Apex runs within standard synchronous transaction limits , meaning you will instantly hit hard limis like 50k Queried rows limit , 10K DML rows limit or 10 seconds CPU timout limits .

- To bypass it best appraoch is to move the heavy processing inside Batch class or Quauable and call that from Scheduled Apex .

- Advantage of using Batch:
  - **Fresh limits per chunk** : the entire large dataset broken into maangebale chunks of lets say 200 records . Each chunk runs in its own seperate Asyncronous transactional context. This means we get 100 SOQL queries limit and 10K DML limits per chunk .
  - **Massive scaling via Database.QueryLocator**: In batch apex start method when we use _Database.getQueryLocator()_ We can easily bypass 50K queried rows limit and can query upto 50 million queried rows out from database.

### Q9>Our callouts from Future method sometimes fails due to timeout issue or endpoint issue . How to make this retry-able .

### Q10>Can we schedule a job from a FLow or lightning component . ? For example a user selects a date/time and JOB should run then ?

### Q11> Whats Scheduled apex ?

SOLN :

- Scheduled Apex lets you to run Apex code at specific time or on a recurring schedule - like a cron JOB .
- It runs in its own transaction with a fresh set of Governor limits . .
- Common use cases :
  - Nightly data cleanup
  - Data sync time to time periodically with external systems
  - Weekly report generation
- Runs asyncrounously in its own seperate transaction with fresh set of Governor limits.
- Maximum **100 scheduled JOBS in an org at a time** .
- use a cron expression string to define a schedule .

### Q12> What is Schedulable Interface ?

SOLN :

- Schedulable Interface is a marker interface that tells the platform if a specific class is a Schedulable Class meant for timely execution .
- It implements a mehod named **execute()** which takes a paramter named "**SchedulableContext ctx**" . This param gives a jobID (eg : ctx.getTriggerId() ) which you can query from the **CronTrigger** Object to get the job details .
- I put heavy DML operation inside Batch Apex to make it chunk wise excution and Governor limits safe .
  DEMO 👇

```java
public void execute (SchedulableContext ctx){
  Id jobID=ctx.getTriggerId();//get the current job id

  CronTrigger job = [SELECT Id,NextFireTime,PreviousFireTime,State FROM CronTrigger WHERE Id=:jobId];
  System.debug('JOB will fire next at : '+job.NextFireTime);
  Database.executeBatch(new MyBatchClass(),200);

}
```

### Q13> what are the methods in a Schedulable Interface ?

SOLN :

- Schedulable interface has only one single method named "execute()" that needs to be implemented.
- execute gives takes a parameter named **SchedulableContext ctx** which gives access to job id ( **ctx.getTriggerId()**) which can be used to retrive job related info from CronTrigger Object .
- Table showing interfaces and their methods () :

---

| Interface               | Required Methods                                                                                                               |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| Schedulable             | execute(SchedulableContex ctx)                                                                                                 |
| Database.Batchable      | start(Database.BatchableContex bc) , execute(Database.BatchableContext bc,List<T> scope), finish(Database.BatchableContext bc) |
| Queueable               | execute( QueuableContext qc )                                                                                                  |
| Database.AllowsCallouts | (marker only - no methods)                                                                                                     |
| Database.Stateful       | (marker only - no methods , used with Batchable)                                                                               |

_CODE Demo👇_

```java
public class FullSchedulableExample implements Schedulable{
    public void execute(SchedulableContext ctx){
       Id jobID = ctx.getTriggerId();

       CronTrigger cronJob = [SELECT Id,NextFireTime,PreviousFireTime,TimeTriggered,State FROM CronTrigger WHERE Id=:jobId];
       System.debug('Timees this job has run : =>'+cronJob.TimeTriggered);
       System.debug('Next Schdeuled Ru : '+cronJob.NextFireTime);

       Database.executeBatch(new MyBatchClass(),200);

    }
}
```
