✅ Total Questions under each topics

- LWC: 26
- Triggers & Async Apex: 25
- Integrations: 15
- Security & Sharing: 10
- Batch Apex: 15
- Scheduled Apex: 15
- General Concepts: 8  
   **Grand Total: 114 unique questions**

---

## **🔹 Lightning Web Components (LWC) — 26**

1. Explain LWC lifecycle hooks and when to use `renderedCallback()` vs `connectedCallback()`.
2. How would you show/hide a form section based on a picklist field value in LWC?
3. How do you communicate between two components not in a parent-child relationship?
4. How to implement sortable columns in LWC `lightning-datatable`?
5. How do you call an Apex method and bind returned data to UI?
6. How do you populate a dynamic picklist from Apex in LWC?
7. How do you quickly show a record’s detail/edit UI in LWC?
8. How do you navigate to a record page programmatically?
9. How do you show success/error notifications (toasts) in LWC?
10. How do you apply conditional styling inside `for:each` loop?
11. Describe how LWC differs from Aura and why Salesforce recommends LWC.
12. How would you migrate Aura to LWC? Mention steps and pitfalls.
13. How do you handle real-time updates in LWC without polling?
14. What are the limitations of Lightning Data Service (LDS)?
15. Explain `@api`, `@track`, and `@wire` decorators.
16. Explain `CustomEvent` in detail. What are bubbles and composed?
17. How does Lightning Message Service (LMS) work?
18. What is LMS? What is LSD?
19. Explain a time you optimized LWC performance and what steps you took.
20. What are LWC performance best practices?
21. How do you implement debounce in LWC for a search input?
22. What is the difference between `lwc:ref` and `querySelector` in LWC?
23. How do you handle errors in LWC? What is `errorCallback`?
24. How do you write a Jest test for an LWC component?
25. How many times can a wire method execute?
26. Show Accounts records in a Lightning datatable with two buttons (inline delete with restrictions, create account with duplicate prevention).

---

## **🔹 Triggers & Async Apex — 25**

1. Write an Apex trigger that prevents inserting Opportunities with Stage \= 'Closed Lost' if related Contacts are Active.
2. How do you design scalable Apex triggers?
3. How do you handle large data volume in triggers, and what pattern reduces governor limit issues?
4. How would you build a scalable and reusable trigger framework for multiple objects?
5. How do you prevent recursion in triggers efficiently?
6. What happens if a trigger updates the same record that fired it?
7. Difference between Before Trigger and After Trigger.
8. What is Bulkification in Apex, and why is it important?
9. Can you make an external API callout directly from a trigger?
10. Future vs Queueable vs Batch Apex vs Schedulable Apex — when to use each?
11. Have you used chained Queueable jobs in real projects? How did you handle error flow?
12. How to schedule a Batch Apex job?
13. How do you prevent SOQL injections when user input is involved?
14. How do you enforce FLS and CRUD in Apex manually?
15. How do you handle unexpected errors in Apex?
16. How would you handle CPU timeout limit issues?
17. What is `isExecutable` in trigger?
18. Trigger to maintain sequence number on Contact under Account.
19. How many Queueable jobs per transaction?
20. How many jobs can be chained in Queueable?
21. How do you avoid recursion in triggers / prevent infinite loops?
22. How do you avoid SOQL governor limits in bulk processing?
23. When should you use SOQL for loops instead of a normal query?
24. How would you process thousands of records in a trigger without governor limit issues?
25. Give one best scenario you implemented using Schedule Apex.

---

## **🔹 Integrations — 15**

1. How to handle callouts in Salesforce?
2. How do you handle API limits in integrations?
3. Integrations fail intermittently — what’s the solution?
4. You are calling a REST API from Salesforce that returns paginated data. How would you handle pagination and collect all data?
5. You are consuming a 3rd party API where the response structure may vary. How to handle this scenario?
6. Explain in depth how Platform Events are used in integration.
7. What are the differences between Platform Events and Change Data Capture, and when would you use each?
8. How do you handle API rate limits in real-time integrations?
9. What’s the best way to refresh expired OAuth tokens automatically?
10. How do you ensure idempotency in API retries to avoid duplicate records?
11. How would you integrate with an external system using Named Credentials?
12. How do you set up OAuth 2.0 for secure Salesforce integration?
13. What is the difference between user-level and application-level authentication?
14. How do you monitor and debug Salesforce integration issues?
15. How do you ensure data integrity during Salesforce integrations?

---

## **🔹 Security & Sharing — 10**

1. How do you enforce security in Salesforce Apex?
2. Differentiate between Sharing Rules, Roles, and Profiles.
3. What is Apex Sharing?
4. What’s the difference between System Mode and User Mode?
5. Best practices for designing record-sharing solutions.
6. Explain the difference between Auth Providers and Named Credentials.
7. How does Salesforce secure the credentials stored within Named Credentials?
8. How would you audit and remediate excessive admin permissions across the org?
9. Restrict one specific user from updating records though same profile.
10. User has access but cannot access records – how to find issue?

---

## **🔹 Batch Apex — 15**

1. What is Batch Apex?
2. What are the governing limits in Batch Apex?
3. What is Database.Batchable Interface?
4. What methods exist in Database.Batchable Interface?
5. What is Database.queryLocator?
6. What is Database.BatchableContext?
7. What is the purpose of the start method?
8. What is the execute method?
9. Can we call callouts in execute?
10. What is the finish method?
11. Can we call another batch in finish?
12. What best practices have you followed in Batch Apex?
13. Give a scenario you implemented using Batch Apex and why.
14. What is AsyncApexJob?
15. Write a Batch Apex class.

---

## **🔹 Scheduled Apex — 15**

1. What is Scheduled Apex? [✅]
2. What is the Schedulable Interface?
3. What are the methods in the Schedulable Interface?
4. What is SchedulableContext?
5. What is CronTrigger?
6. How to know the status and next schedule of a scheduled job?
7. What is CronExpression?
8. What is System.schedule()?
9. Can we call callouts from Schedule Apex?
10. Can we call future methods from Schedule Apex?
11. Can we call Batch Apex from Schedule Apex?
12. Can we manually schedule an Apex class?
13. What are the governing limits of Schedule Apex?
14. What good practices have you followed in Schedule Apex?
15. Give one best scenario you implemented using Schedule Apex and why you preferred it.

---

## **🔹 General Salesforce Concepts — 8**

1. What are Governor Limits, and why do they exist in Salesforce?
2. Apex Programming: Best practices for writing efficient and scalable Apex code.
3. What methods do you use for exception handling in Apex?
4. How would you debug and handle governor limit breaches?
5. Have you used Dynamic SOQL? Write and explain the use case.
6. Give a real-life scenario where you have used Custom Metadata in Apex.
7. Visualforce vs Lightning: What are the key differences?
8. Flow vs Trigger — when would you prefer Flows over triggers?

---
