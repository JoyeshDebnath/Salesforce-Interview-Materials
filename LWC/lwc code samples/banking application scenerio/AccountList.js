import { LightningElement, api, wire } from 'lwc'
import { messageContext, publish } from 'lightning/messageService';
import BANK_CHANNEL from '@salesforce/messageChannel/bankChannel__c';

export default class AccountListComponent extends LightningElement {

    value = '';
    options = [
        { label: 'Saving Account (...3445)', value: '001xx000003DabcAAA,ACT-4590' },
        { label: 'Saving Account (...9990)', value: '001xx000003DefgBBB,ACT-9912' },
        { label: 'Saving Account (...7883)', value: '001xx000003DefgBBB,ACT-9912' }
    ]

    @wire(messageContext)
    messageContext

    connectedCallback() {

    }

    handleAccountChange(evt) {
        var selectedValue = evt.detail.value;
        if (selectedValue) {
            const [accountId, accountNumber] = selectedValue.split('.');
            const payload = {
                accountId,
                accountNumber
            }
            publish(this.messageContext, BANK_CHANNEL, payload);
        }
    }
}
