import {LightningElement,wire,api} from 'lwc';
import {getRecord,getFieldValue} from 'lightning/uiRecordApi';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';

export default class WireDemo extends LightningElement{
    @api recordId

    @wire(getRecord,{recordId:'$recordId',fields:[ACCOUNT_NAME]})
    accountRecord;

    get nameValue(){
        return this.accountRecord.data ? getFieldValue(this.accountRecord,ACCOUNT_NAME) : 'N/A'
    }
}