import {LightningElement,api,wire,track} from 'lwc';
import {subscribe,unsubscribe,onError,setDebugFlag,isEmpEnabled} from 'lighting/empApi';

const CHANNEL='/event/Order_Shipped__e';//Platform Event Channel

export default class OrderDashboardComponent extends LightningElement{
    @track orders=[];
    connectionStatus='connecting....';
    subscription=null;

    connectedCallback(){
        this.registerErrorHandler();
        this.subscribeToChannel();
    }

    subscribeToChannel(){
        //--> -1 : only new events from this point forward 
        //--> -2 => Replay all retained events (last 24 hrs ) 
        subscribe(CHANNEL,-1,(event)=>{
            this.handleEvent(event)
        }).then(response=>{
            this.subscription=response;
            this.connectionStatus='connected!';
        }).catch(err=>{
            this.connectionStatus='Connnection Failed!';
            console.error('Subscription error:'+err);
        })
    }

    handleEvent(event){
        const payload=event.data.payload;
        const newOrder={
            id:payload.Order_Id__c,
            orderNumber:payload.Order_Number__c,
            status:payload.Status__c,
            updatedAt:new Date().toLocaleTimeString()
        }
        this.orders=[newOrder,...this.orders];
    }

    registerErrorHandler(){
        onError(error=>{
            console.log('EMP API Error:'+JSON.stringify(error));
            this.connectionStatus='Error - connecting ....';
        })
    }
    
}