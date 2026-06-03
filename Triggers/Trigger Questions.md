## Trigger Questions .

### Q1> Write an Apex Trigger that prevents insertion of opportunities with stage='Closed Lost' if related Contacts are active .

SOLN :
[Trigger](./Codes/OpportunityTrigger.cls)
[Code Soln](./Codes/OpportunityTriggerHandler.cls)

### Q2> How do you design sclabale Apex Triggers?

SOLN :

- There should be one trigger per object . When there are mutiple triggers per objects the order of executaion becomes unpredictable.
- No logic or business rules must be written inside the trigger . Move all the business logics inside the handler or Sevice class .
- Focus on bulkification from Day 1 . Collect ids in collection make soql query , process data and map it and then do dml at end . No DML\SOQL inside loop .
  CODE: 👇
  [Framework Demo folder](./Codes/trigger%20framework%20Demo/)

### Q3> How do you handle large data volumes in Triggers and what patterns Recduces Governor limit issues ?

SOLN :

- **Map-based Query Aggregation:** : (use case : Standard parent - child record filtering in triggers ) --> DROPS SOQL count from O(N) to O(1) query
- **Queable Apex offloading**: Heavy CPU calculation , complex child creation or http callouts inside trigger move to queueable Apex . Grants a brand new set of syncronous limits[ eg : SOQL >> 100 queries | CPU time --> 60,000 ms]
- **Platform events Offloading**: Decoupling heavy logging, multi-system sysncronisation or massive background data processing . Move processing entirely out of the standard syncronous pipleine .
