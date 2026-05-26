import {LightningElement,wire} from 'lwc';

import {MessageContext,publish} from 'lightning/messageService';
import RECORD_SELECT_CHANNEL from '@salesforce/messageChannel/RecordSelectChannel__c';

export default class PublishCmp extends LightningElement{
    
    @wire(MessageContext)
    messageContext;

    handleButtonClick(){
        const payload={
            recordId:'34455433333',
            messageContext:'Hello from Decoupled Publisher ...'
        }

        publish(this.messageContext,RECORD_SELECT_CHANNEL,payload);
        console.log('Message published Succesfully !!');
    }
}
