import {LightningElement} from 'lwc';
import getAccountDetails from '@salesforce/apex/AccountController.getAccouuntDetails';

export default class Hooks1 extends LightningElement{
    @api recordId;
    @track accountData;

    hasRendered=false;//boolean guard 

    // 1 >
    constructor(){
        super();
        console.log('1. constructor : component initiated ....');
    }
    connectedCallback(){
        console.log('2. conectedCallback . Component inserted into DOM .. fetchingg data ..... ');
        getAccountDetails({
            accId :  this.recordId
        }).then(res=>{
                this.accountData=res;
        }).catch(err=>{
            console.log('Error:'+err.message)
        })
    }

    renderedCallback(){
        console.log('3. renderedCallback : UI has been painted on screen DOM accessible ');
        if(this.hasRendered){
            return;
        }
        const targetDiv=this.template.querySelector('.dynamic-container');
        if(targetDiv){
                this.hasRendered=true;
                targetDiv.style.border='2px solid green';
        }
    }

    disconnectedCallback(){
        console.log('4: disconnectedCallback :  cleaningb up resources ');

    }

    errorCallback(error,stack){
        console.log('5: erorCallback ...')
    }
}