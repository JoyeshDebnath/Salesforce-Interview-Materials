import {LightningElement,api,wire} from 'lwc';


export default  class AccountCardCmp extends LightningElement{
    @api recordId;

    constructor(){
        super();
        console.log('1. constructor -> component instance created ')
        //Dont access child elements here ... 
    }

    connectedCallback(){
        console.log('2. Component inserted into the DOM ')
        console.log('Record ID available.. ',this.recordId);
        //perfect for init data | event listeners ... 
    }

    renderedCallback(){
        console.log('3. Rendered Callback - DOM is rendered / updated ');
        //DOM manipulation ... 3rd party library init (use a static boolean flag to run once ...)
    }

    disconnectedCallback(){
        console.log('4. DisconnectedCallback - component Removed .. ');
        //cleanup event listeners ..timers .. unsubscribing 
    }

    errorCallback(error,stack){
        console.log('Child errors caught here : ',error.message, stack );
    }



}