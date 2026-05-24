

### **🔹 Category 1: Basic Logic & Validation**

1. **Name Formatting:** Write a trigger to automatically title-case a Lead's Name (e.g., "john doe" to "John Doe") before saving.  
2. **Conditional Defaults:** If an Account's Industry is set to 'Technology', automatically set the Rating to 'Hot'.  
3. **Prevention Logic:** Prevent a user from changing an Opportunity's Stage back to a previous value (e.g., from 'Closed Won' to 'Prospecting').  
4. **Delete Protection:** Prevent the deletion of a Contact if they are marked as the "Primary Contact" on their parent Account.  
5. **Task Generation:** When a Case is created with a priority of 'High', automatically create and assign a Follow-up Task to the Case Owner.  
6. **Field Sync:** If an Account's Billing Address changes, update the Shipping Address only if the Match\_Address\_\_c checkbox is checked.  
7. **Simple De-duplication:** Prevent the insertion of a Lead if an existing Lead already has the same Email or Phone number.

### **🔹 Category 2: Related Objects & Bulkification**

8. **Child Field Update:** When an Account's Owner is changed, update the Owner of all its open Opportunities to match.  
9. **One-to-Many Creation:** When a 'Project' record (custom) is created, automatically create 5 default 'Project Task' child records.  
10. **Primary Record Enforcement:** If a 'Contact' is marked as 'Primary', uncheck the 'Primary' flag on all other Contacts under the same Account.  
11. **Context-Aware Linkage:** When a Case is created via Email-to-Case, look up a Contact with a matching email; if found, link it; if not, create a new Contact and link it.  
12. **Opportunity Line Item Check:** Prevent an Opportunity from being moved to 'Negotiation' stage if it has no Products (Line Items) attached.  
13. **Cross-Object Sequence:** Add a sequence number (1, 2, 3...) to Contacts as they are added to an Account. If \#2 is deleted, re-number the others.  
14. **Recursive Guard:** Implement a TriggerHandler that ensures a specific update logic only runs once per transaction to avoid infinite loops.

### **🔹 Category 3: Custom Rollup Summaries (The "Lookup" Rollups)**

*Since standard Rollup Summary fields only work on Master-Detail relationships, interviewers love asking you to code them for **Lookup** relationships.*

15. **Total Amount Summation:** Calculate the total Amount of all 'Closed Won' Opportunities on the parent Account and store it in a custom field Total\_Won\_Value\_\_c.  
16. **Child Count:** Maintain a count of all 'Active' Contacts on an Account. Ensure the count updates correctly on **Insert, Delete, and Undelete**.  
17. **Date Rollup (Min/Max):** On a 'Program' record, roll up the Earliest\_Start\_Date\_\_c from all associated 'Course' child records.  
18. **Average Rating:** Calculate the Average\_Survey\_Score\_\_c on a Product based on child 'Review' records.  
19. **Conditional Rolling Sum:** Sum the Total\_Hours\_\_c from 'Time\_Log\_\_c' records onto a 'Project\_\_c' record, but only for logs marked as 'Billable'.

### **🔹 Category 4: Complex Business Logic & Architecture**

20. **Apex Sharing:** When a 'Job\_Application\_\_c' record is set to 'Private', create an Apex Sharing record to grant 'Read' access specifically to the Hiring Manager.  
21. **Product Inventory Management:** When an Opportunity is 'Closed Won', decrement the Units\_in\_Stock\_\_c on the related Product records based on the quantities sold.  
22. **Hierarchy Status Sync:** If a Parent Account is marked 'Inactive', use a trigger to mark all Child Accounts in the hierarchy as 'Inactive'.  
23. **Contact Role Enforcement:** Throw an error if a user tries to close an Opportunity without at least one 'Decision Maker' assigned in the Opportunity Contact Roles.  
24. **File Automation:** When a ContentDocument (File) is uploaded to an Opportunity, automatically create a Chatter post notifying the team.  
25. **Lead Conversion Override:** Write logic that executes specifically after a Lead is converted to ensure custom fields are mapped to a custom "Financial\_Profile\_\_c" object.

### **🔹 Category 5: Asynchronous & Integration**

26. **Future Callout:** When a Contact's email is updated, call an external API (Future method) to sync the update to a Marketing tool (e.g., Mailchimp).  
27. **Platform Event Publishing:** When an Order's status changes to 'Paid', publish a Platform Event so an external shipping system can pick it up.  
28. **Queueable Chaining:** Upon Account creation, use a Queueable to create a default Opportunity, and then chain another Queueable to call an external Credit Check service.  
29. **Change Data Capture (CDC):** Write a trigger on AccountChangeEvent to capture field-level changes and log them into a custom "Audit\_Log\_\_c" object for compliance.  
30. **Bulk API Optimization:** Explain and code a scenario where you process a list of 200 records, filtering them into different maps to perform DML on multiple related objects efficiently.

### **🔹 Level-Up Questions (Common at IBM/Deloitte)**

31. **The "Undelete" Scenario:** How do you handle a scenario where a child record is deleted and then restored from the Recycle Bin? (Hint: after undelete).  
32. **Bypass Logic:** How do you design a trigger so that an Admin can temporarily disable it (e.g., during a large data migration) without deploying code? (Hint: Custom Metadata or Custom Settings).  
33. **Multi-Object Rollup:** How do you sum values from two *different* child objects (e.g., Invoices\_\_c and Expenses\_\_c) into a single Balance\_\_c field on the Account?  
34. **The "Old Map" Logic:** Write a trigger that only fires if the AnnualRevenue of an Account has increased by more than 20% compared to its previous value.  
35. **Map Strategy:** On a whiteboard, demonstrate how to query all related Contacts for a list of 200 Accounts using a Map\<Id, List\<Contact\>\> without hitting SOQL limits.\</Id,\>

