# LWC Coding Scenerios ✨

### Q1> Code the following scenerio :

- Compoent A is an Account List Selector located in Left Column
- Component B is a Detailed Summary Viewer locatd in right column
- there is no Parent-child relationship between them . When the user clicks an Account in Component A , Component B must immediately catch the payload , extract the AccountId and sttus and update the UI .

**SOLN**:
[Message Channel Metadata ✨](./lwc%20code%20samples/lms%20scenerio/AccountDataChannel.messageChannel-meta.xml)
[Publisher Account Component code 👉](./lwc%20code%20samples/lms%20scenerio/AccountPublisher.js)
[Account Details Subscriber Component ](./lwc%20code%20samples/lms%20scenerio/AccountDetailSUbscriber.js)

### Q2> you are building a warehouse dashboard in LWC . When a warehouse worker updates an Orders Status to "Shipped" in Salesforce , every manager 's browsers tab showing the tab showing the dashboard must update instantly , - no refersh , no polling , how to achieve this ?

SOLN : use concept of subscribing to real time using **"lightning/empApi"**
[CODE SOLN](./lwc%20code%20samples/OrderDashboard/)

### Q3> Interviewer: "We are building a banking application home page. In the left sidebar, we have an AccountList component that displays a dropdown of a customer's bank accounts. In the right sidebar, completely independent of the left sidebar, we have an AccountBalances component.Write the code so that when a user selects a bank account from the dropdown in the left component, the right component immediately displays that account's specific balance and account number. You cannot wrap these in a single parent component."

SOLN :
[CODE](./lwc%20code%20samples/banking%20application%20scenerio/)
