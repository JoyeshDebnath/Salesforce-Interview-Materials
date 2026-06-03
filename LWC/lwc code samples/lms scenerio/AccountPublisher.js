import {LightningElement,wire} from 'lwc';
import {publish,MessageContext} from 'lightning/messageService';
import ACCOUNT_CHANNEL from '@salesforce/messageChannel/AccountDataChannel__c';

export default class AccountPublisher extends LightningElement{
    @wire(MessageContext)
    messageContext;

    handleAccountSelect(evt){
        const selectedAccountId=evt.currentTarget.dataset.id;
        const selectedAccountStatus=evt.currentTarget.dataset.status;
        const payload={
            recordId:selectedAccountId,
            recordStatus:selectedAccountStatus
        }

        publish(
            this.messageContext,
            ACCOUNT_CHANNEL,
            payload
        )
    }
}