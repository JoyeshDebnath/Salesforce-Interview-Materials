### Q1> Explain in depth about LWC Lifecycle Hooks .

soln : LWC Lifecycle hooks are explained below :

- **Constructor ()** : components are created | DOM still not ready
- **connectedCallback ()** : components inserted into the DOM
- **renderedCallback ()** : called after every render ..
- **disconnectedCallback ()** : component is removed from the DOM
- **errorCallback (error,stack)** : catches child errors .
