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
