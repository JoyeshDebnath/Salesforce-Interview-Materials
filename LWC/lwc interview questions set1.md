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

### Q> Explain LWC lifecycle hooks and when to use `renderedCallback()` vs `connectedCallback()`.

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

### Q> What if I update the Recative properties @track variables in renderdCallback hook ?

SOLN : It will crash the browser or cause infinite loops . Updating a reactive property triggers component Re-rendering . because the component is re-renderd so it will triggered renderedCallback hook , this updates the property again the the cycle goes on crashing the browser .

**FIX**
: use a boolean Flag ( eg : isRendered = False ) to ensure that the code inside only runs once .
