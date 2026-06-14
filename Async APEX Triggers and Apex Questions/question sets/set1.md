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

### Q14> A trigger is Hitting CPU timeout limit when updating 10,000 records from Data Loader . How to redesign it .

SOLN :

1. **Identify the Ani-Patterns and Eliminate**
   - Nested Loops O(N^2) Complexity .Ensure that code is not iterating over a list of child records inside a loop of parent records . Use Map <Id,List<Child\_\_c>> to Lookup O(1)
   - Redundant and unnecessary Queries and DML operations : Ensure no SOQL or DML statements written inside the loop . Remove unnecssary DML statements in Before Triggers since they save automatically in Before Triggers .
2. **Implement Trigger Famework & Lazy loading**:
   - If multiple triggers runs on same objects , combine them under one trigger Framework (Handler Pattern)
   - Implement Bypass mechanism / logic (Using a custom settings OR custom permission ) to deactivate the trigger temporarily if already data preprocessed .

3. **Offload heavy logics and calculations to Async Apex**
   - Move complex calculatons and computational logics to Async Apex like Batchh / Quauable . pass ids and process there . Async apex runs in their seperate transaction with own set of Governor limits . CPU limit is 60000 ms which is 6 times . 😶

### Q15 > You need to stop recursion in an after update trigger where the records updates themselves . How will you handle it ?

SOLN :

1. **APPROACH 1 : Use static SET < Id > Pattern**
   - Instead of using a simple static Global Boolean flag variable which breaks during a Data loader batches over 200 records , you maintain a **Public Static Set< Id >** inside a handler or Utility class
   - When the trigger executes , check if the Record ID exists in the **processedId Set** .
   - If it is in the set skip , else execute bsuiness Logic , add the record ID in the set , and prepare it for the update DML .

2. **APPROACH 2 : Explicit OLD vs NEW Field Value Comparison**
   - Compare the **Trigger.newMap.get(Rec.Id).Your_Field\_\_c** against **Trigger.oldMap.get(Rec.Id).Your_Field\_\_c**
   - If the Value are different then only perform the business logics and DML .

### Q16> A Batch Job Fails intermittently with "Too many SOQL queries". How would you debug and Fix it !

SOLN :

### Q.16> You need to make tyhe callouts from a trigger . How to do that .

SOLN :

- To make Callouts from a trigger I would generally move the callout logic to a Future method(**(callout=true)**) or a Queuable Apex (**implement Database.AllowsCallouts**).
- Triggers runs syncronously on Database transaction , so making a callout will throw **"System.CalloutException"**
- I prefer Quauabele Apex more because it can handle Complex datatypes while Future can only accept primitve datatypes. (Collect the record ID s and pass to Quauable or Future [Bulkification of Coede])

[Example Code](../codes%20soln/callout%20demo%20from%20trigger/)

### Q17> Multiple Triggers runs on the same Object and order is breaking . How to handle this scenerio?

- Salesforce doesn not guarntee the order of execution of triggers if multiple triggers run on same Object .
- We need to define and design a trigger handler framework - Where we have seperate handler / Helper class where the core business logic and complex calculations are written and triggers only routes to those . One trigger per object
- **Benifits:**: - We have a total control of which logic to implement first after what . The Validation logic can be implemented before the Auto populate logic . - We can have better Recursion control and Bypass mechanism in case of any bulk data migration .
  [Code Demo](../codes%20soln/Trigger%20framework%201/)

### Q18> Future method is hittingh limits during peak loads . What cn be the workaround to solve the ,issue ?

- @Future method is hitting Governor limits during peak hours like 50 callouts limits per transaction . The good soln is to transfer the logc to Quauaable Apex . Why ?
- Queueable supports complex datatypes to be passed in params , Future doesnt allows chaining , no tracking of Job ids to know their status is possible .
- Queueable Chaining is a big win cause we are not processing and dumping everything paralelly , instead processing and chaining next once the current batch finishes .
- Queueable Delay : you can pass an optional delay parameter to delay the execuation to handle sudden traffic spikes .
- **Fianlizer Interface**: Quauable supports Finalizer interface to handle sudden exceptions , log errors and safely retry if the action fails .
- **We can also implement logic using Platform Events**:instead we can fire platform events , event Bus has capacity to hold event for 72 hours , we can seperately handle the logic asyncronously .
  [CODE DEMO](../codes%20soln/Peak%20Traffic%20Call%20Demo/)

### Q19> You need partial success in Bulk Updates . How to implement this ?

SOLN:

- Instead of using standard DML commands like -> (insert,update,delete) which rolls back entire transaction if one of the records is faulty , we use Database class .
- Database.update , Database.isnert etc have an optional parameter (allORNone=True OR False) . This allows partial success even if some records are faulty .
- Database class have SaveResult[] array which gives us ids of the faulty record as well .
  [code demo](../codes%20soln/Database%20class%20demo/partialUpdate.cls)

### Q20 > You need to run a trigger o specific Profiles only . How To implement this .

SOLN:

- **What To Avoid?**- Hardcoding of Ids ,and names and using profile IDs and names in Trigger cause the IDs changes across Environments and names can be altered .
- Never use **UserInfo.getProfileId()**
- **Use Custom Permission**: and assign that Custom permission to speicifc Profiles and permission sets . Access the Custom Permission using **FeatureManagement.checkPermission() method** .
  [CODE](../codes%20soln/Permission%20Based%20Trigger/AccountTriggerHandler.cls)

### Q21> In Apex whats With Sharing and Without Sharing ?
