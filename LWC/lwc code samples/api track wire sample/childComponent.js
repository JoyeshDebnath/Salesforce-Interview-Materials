import {LightningElement,api} from 'lwc';

export default class ChildComponent extends LightningElement{
    @api publicMessage='Default Message';

    @api
    executeChildRoutine(greetingPrefix){
        console.log(`${greetingPrefix} , child Routine has executed Successfully !!!`);
    }
    
}