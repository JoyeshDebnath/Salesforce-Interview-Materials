import {LightningElement,wire,track} from 'lwc';
import {subscribe,MessageContext,unsubscribe,APPLICATION_SCOPE} from 'lightning/messageService';
import ACCOUNT_CHANNEL from '@salesforce/messageChannel/AccountDataChannel__c';

export default class AccountSubscriber extends LightningElement{
    @track recievedId='';
    @track recievedStatus='';
    subscription=null;

    @wire(MessageContext)
    messageContext;

    connectedCallback(){
        this.subscription=subscribe(
            this.messageContext,
            ACCOUNT_CHANNEL,
            (message)=>this.handleIncomingMessage(message),
            {scope:APPLICATION_SCOPE}
        )
    }

    handleIncomingMessage(message){
        this.recievedId=message.recordId;
        this.recievedStatus=message.recordStatus;
    }

    disconnectedCallback(){
        unsubscribe(this.subscription);
        this.subscription=null;
    }
}