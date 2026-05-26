import {LightningElement,wire} from 'lwc';
import {MessageContext,subscribe,unsubscribe,APPLICATION_SCOPE } from 'lightning/messageService';
import RECORD_SELECT_CHANNEL from '@salesforce/messageChannel/RecordSelectChannel__c';

export default class SubscriberCMP extends LightningElement{
    @track recieveMessage ='Waiting for message .....';
    subscription=null;

    @wire(MessageContext)
    messageContext;

    connectedCallback(){
        this.subscribeMEssgeChannel();
    }

    subscribeMEssgeChannel(){
        if(!this.subscription){
            this.subscription=subscribe(
                this.messageContext,
                RECORD_SELECT_CHANNEL,
                (message)=>this.handleMessage(message),
                {scope:APPLICATION_SCOPE}
            )
        }
    }

    handleMessage(message){
        this.recieveMessage=`Recived ID : ${message.recordId} -- Context : ${message.messageContext}   `;
    }
    disconnectedCallback(){
        this.unsubscribe(this.subscription);
        this.subscription=null;
    }
}