# LWC Coding Scenerios ✨

### Q1> Code the following scenerio :

- Compoent A is an Account List Selector located in Left Column
- Component B is a Detailed Summary Viewer locatd in right column
- there is no Parent-child relationship between them . When the user clicks an Account in Component A , Component B must immediately catch the payload , extract the AccountId and sttus and update the UI .

**SOLN**:
[Message Channel Metadata ✨](./lwc%20code%20samples/lms%20scenerio/AccountDataChannel.messageChannel-meta.xml)
[Publisher Account Component code 👉](./lwc%20code%20samples/lms%20scenerio/AccountPublisher.js)
[Account Details Subscriber Component ](./lwc%20code%20samples/lms%20scenerio/AccountDetailSUbscriber.js)
