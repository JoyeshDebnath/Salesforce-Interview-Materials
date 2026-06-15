import { LightningElement, api, wire, track } from 'lwc';
import { subscribe, unsubscribe, messageContext, APPLICATION_SCOPE } from 'lightning/messageService';
import BANK_CHANNEL from '@salesforce/messageChannel/bankChannel__c';

export default class AccountBalance extends LightningElement {
    subscription = null;
    @track selectedAccoutId = '';
    @track selectedAccountNumber = '';
    @wire(messageContext)
    messageContext;

    connectedCallback() {
        this.subscribeToChannel();
    }

    subscribeToChannel() {
        this.subscription = subscribe(
            this.messageContext,
            BANK_CHANNEL,
            (msg) => this.handleMessage(msg),
            { scope: APPLICATION_SCOPE }
        )
    }

    handleMessage(message) {
        this.selectedAccoutId = message.accountId;
        this.selectedAccountNumber = message.accountNumber;
    }

    disconnectedCallback() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }

} 