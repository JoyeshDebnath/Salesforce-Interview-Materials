### Q1> Explain in depth about LWC Lifecycle Hooks .

soln : LWC Lifecycle hooks are explained below :

- **Constructor ()** : components are created | DOM still not ready
- **connectedCallback ()** : components inserted into the DOM
- **renderedCallback ()** : called after every render ..
- **disconnectedCallback ()** : component is removed from the DOM
- **errorCallback (error,stack)** : catches child errors .

### Q2 > How do you pass data from parent to child .

SOLN :

- Use @api decorator in child to expose a public property .
- Parent passes data via HTML attribute binding .

```html
<template>
  <c-child-cmp greeting="Hello" account-name="{accountName}"></c-child-cmp>
</template>
```

```js
import { LightningElement, api } from "lwc";
export default class ParentCmp extends LightningElement {
  accountName = "Joyesh Debnath & CO.";
}
```

```html
<template>
  <p>{greeting} - {accountName}</p>
</template>
```

```js
import { LightningElement, api } from "lwc";
export default class ChildCmp extends LightningElement {
  @api greeting;
  @api accountName;
}
```

### Q3> How do you pass data from Child To Parent ?

SOLN : Using custom events

- child component dispatches a Custom Event .
- Parent listens via on<eventname> handler .

```js
// Child.js
import { LightningElement } from "lwc";
export default class Child extends LightningElement {
  handleClick(evt) {
    const selectedValue = evt.target.value; //selected value
    this.dispatchEvent(
      new CustomEvent("recordselect", {
        detail: {
          recordId: selectedValue,
        },
      }),
    );
  }
}
```

```html
<!--parent html-->
<template>
  <c-child-cmp onrecordselect="{handleRecordSelect}"></c-child-cmp>
</template>
```

```js
import { LightningElement } from "lwc";
export default class Parent extends LightningElement {
  selectedRecord = "";

  handleRecordSelect(evt) {
    this.selectedRecord = evt.detail.recordId;
  }
}
```

### Q4> @wire VS Impretaive Calls Difference ?

soln :
| Properties | @wire | Imperative Apex calls |
|-------------------|-----------------|-------|
| Reactivity | Its Recative , auto Re-runs when the property changes | Its not reactive , manual calls needed |
| Cacheable | ✅ yes caheable | Only if cacheable=true defined in Apex |
| Error Handling | Via { error } access | using try catch bock |
|USE Cases | Read data on load | DML , conditional calls

EXAmple :

```js
//Wire call Example
import { LightningElement, wire } from "lwc";
import getAccounts from "@salesforce/apex/AccountController.getAccounts";

export default class WiredExample extends LightningElemnt {
  Industry = "Technology";

  @wire(getAccounts, { industry: "$Industry" })
  accounts;
}
```

```js
//Impretaive calls example
import { LightningElement } from "lwc";
import getAccounts from "@salesforce/apex/AccountController.getAccounts";
export default class ImperativeCallsExample extends LightningElement {
  accounts = [];

  async handleLoad() {
    try {
      this.accounts = await getAccounts({ industry: "Technology" });
    } catch (error) {
      console.log(erroir.message);
    }
  }
}
```

### Q5> Explain LWC lifecycle hooks and when to use `renderedCallback()` vs `connectedCallback()`.

SOLN : A lifecycle hook is simply a frmework defined methods that automatically fires at specific phases of a components existance .

- Constructor () : component is created . memory allocated Still not inserted in DOM yet . Parne t fires before Child component .
- connectedCallback() : component is inserted into the Browsers DOM . Parent fires before Child component .
- renderedCallback () : The component has finished painitng its html on screen . Child fires before parent .
- disconnectedCallback () : the component is removed from DOM and destroyed .
- errorCallback (error , stack ) : Catches childs errors thrown .

_ConnectedCalback() VS renderdCallback () hooks_  
 |Feature | ConnectedCallback() | RenderdCallback () |
|-------------------|-----------------|-------|
When To USE | Once Component is inserted into the Browsers DOM |Multiple times , wvery time the component finishes rendering or re-rendering .
IS DOM accessible ? | No , The HTML elemnts are not yet painted on the screen . | Yes DOM is ccessible
Can you access @api properties | Yes public properties passed from Parent are fully accessible in connectedcallback | Yes accessible in renderdcallback
Primary USE CASES : | Fetching data from APex , subscribing to lms, setting up default values to variables | Initlising 3rd party js libraries like Chart.js , manipulating DOM elemnts directly

### Q6> What if I update the Recative properties @track variables in renderdCallback hook ?

SOLN : It will crash the browser or cause infinite loops . Updating a reactive property triggers component Re-rendering . because the component is re-renderd so it will triggered renderedCallback hook , this updates the property again the the cycle goes on crashing the browser .

**FIX**
: use a boolean Flag ( eg : isRendered = False ) to ensure that the code inside only runs once .

### Q7> How would you show/hide a form section based on a picklist field value in LWC?

SOLN :[JS code ](./lwc%20code%20samples/scenerio-show%20form%20section%20based%20on%20picklist/picklistselection.js)
[template code ](./lwc%20code%20samples/scenerio-show%20form%20section%20based%20on%20picklist/picklistselection.html)

### Q8> How do you communicate between two components not in a parent-child relationship?

SOLN : when two components arent connected with parent child relation then we opt for LMS .
LMS is built on top of PUB/SUB patten . Its like a radio station .

- one component broadcasts a message on a specific frequency (a message channel)
- Any other component turned into that same frequency can hear the message and react to it , regardless of where it sits on the page.
- _Cross Framework Capabilities_ : LMS doesnt just connect LWC to LWC , it can bridge communication between LWC, Aura and VF Components on same page .
- _Scope_ : LMS allows to define the scope of the message ( APPLICATION scope ) , meaning that you can choose whether a component recieves messages only when it is active on the screen or event when its hiddene i background console lab .
- It consisits of a Metadata file (Message Channel) , Publisher component (Sender) and Subscriber Component (Reciever )
  CODE Sample :
  [message channel demo](./lwc%20code%20samples/lms%20demo/RecordSelectChannel.messageChannel-meta.xml)
  [Publisher Component](./lwc%20code%20samples/lms%20demo/PublisherCmp.js)
  [Subscriber Component](./lwc%20code%20samples/lms%20demo/SubscriberCmp.js)

### Q9> How to implement sortable columns in LWC `lightning-datatable`?

SOLN : use sortable = true for the columns the code sample is given below ✨

[Sortable Datatable HTML](./lwc%20code%20samples/datatable/sortableDatatable.html)
[Sortabel Datable JS](./lwc%20code%20samples/datatable/sortableDatatable.js)

### Q10> How does Lightning messaging service works ?

SOLN : Before LMS =the communication between different components that doesnt have parent-child relationship used to happen by :

- Standard DOM events (CustomEvent) only travel upwards thrugh strict parent-chld component hiererchy .
- Custom PUBSUB javascript utilities worked within lwc , but couldnt cross framework border .
  LMS is based on pubsub model , where decoupled components communicate through event bus . one component passes payload in eventbus and another component listens and consumes the payload .
  Underneath it uses metadata file called a **Lightning Message Channel(.messageChannel-meta.xml)** .

  ### Q11> How do you handle real time updates in LWC without polling ?

  SOLN :
  - Short ansswer is using **lightning/empAPi**(stands for Enterprise Messaging Platform API)
  - traditional way was to call apex every 5 seconds to see any data change . The problem was first it makes the client side very slow in performance , and secondly floods the server logs, also it _Repaidly consumes Concurrent Apex transaction limits_
    .

- Salesforce uses a PUBSUB model based on Streaming API , where the server streams messages only when change occurs to the client , the client maintains a long lived HTTP connection(basd on COMETD protocol) and listens to the changes .
  **[Code Sample](./lwc%20code%20samples/Real%20Time%20Polling%20Codes/realTimeMonitor.js)**
