# Async APEX Coding Scenerios

### Q1> Automatically Delete Stale Leads Records (Leads that has not been opened for 180 days or more ) on a nightly basis .[Clean UP Process Scsnerios].

SOLN : [Batch class](../CODE%20SOLN/Stale%20Record%20Cleanup/AutomatedLeadsCleanupBatch.cls) --
[Schuler class](../CODE%20SOLN/Stale%20Record%20Cleanup/AutomatedLeadsCleanupScheduler.cls)

### Q2> Once the Account processing is done Related Contacts must be processed .

_SOLN_:
Anonymous Apex to invoke the Queueable class  
 **List<Id> accntsToClean=new List<Id>{'23444deefwefwe','qefef122244'};
System.enqueueJob(new Step1_AccountProcessor(accntsToClean));**

[Code 1 👩‍💻](../CODE%20SOLN/Related%20records%20chain/AccountProcessor.cls)
[Code 2 ✨](../CODE%20SOLN/Related%20records%20chain/Step2_ContactProcessor.cls)

### Q3> Implement a system Where a Daily Scheduler wakes up at midnight , quries all outdated Case Records and closes them .

SOLN :

[Batch Processor class ](../CODE%20SOLN/Batch%20Apex%20Scenrio/CaseProcessorBatch.cls) |
[Schduler class](../CODE%20SOLN/Batch%20Apex%20Scenrio/CaseProcessorScheduler.cls)
