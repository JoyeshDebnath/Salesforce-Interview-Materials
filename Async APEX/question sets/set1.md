# Questions FROM Async APEX (Also covers Scenerios based questions )

### Q>We want to automatically generate a monthly opportunity summary report and send to Sales manager on the first of every month . How would you implement this using Apex .

SOLN :

- Schedulable Apex : Used to invoke execuation at a specific time using CRON expression. However it runs syncronously within its excuation context , meaning it is tightly bound by standard ransaction limits .
- Batch Apex : By offloading the calculation from schedulable apex to batch job, we can process up to 50 million records efficientl in seperate , smaller chunks .
- Database.Stateful : by default batch apex is stateless - each chunk executes in a brand new transaction context. To accumulate summary data (like revenue and record counts ) acrosss all chunks , our batch class must implement _Database.Stateful_ to preserve the instance variabl states between execuation .

  CODE :->
  [Scehuleable class ](../codes%20soln/OppSummarySchedulable/MonthlyOpportunitySummaryScheduler.cls)
  [Batch class ](../codes%20soln/OppSummarySchedulable/MonthlyOppSummaryBatch.cls)
  [Scheduler ](../codes%20soln/OppSummarySchedulable/executionscript.cls)

### Q>After a user submits a form We need to do heavy calculations and update the related Records in the background . How to achieve this ?

SOLN : [Code Sample using Quauable ](../codes%20soln/RelatedRecordsCalculation/AsyncOpportunityCalculator.cls)

### We are calling a 3rd party API when a user clicks a button . This must happen asynchronously . What Apex will you use .

### What would you do if some records fails in Async batch or queueable jobs ? how would you retry them ?

### We want to clean up Sales records automatically How would you implement this

### "There is a scenario we want to process Accounts records in step 1 and then Related Contacts records in step2 - all asynchronously . How would you handle this in Apex ".

### We used Future methods earlier . When and why should we migrate to Quauable Apex .

### How would you handle Governor limits when processing large number of records inside Scheduled Apex job ?

### Our callouts from Future method sometimes fails due to timeout issue or endpoint issue . How to make this retry-able .

### Can we schedule a job from a FLow or lightning component . ? For example a user selects a date/time and JOB should run then ?
