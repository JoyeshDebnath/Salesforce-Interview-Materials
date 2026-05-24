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
