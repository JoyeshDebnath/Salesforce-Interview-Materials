import {LightningElement,track,wire} from 'lwc';
import {subscribe,unsubscribe,onError} from 'lightning/empApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class RealTimeMonitor extends LightningElement{
     channelName='/event/Order_Status_Update__e';//(specify you channel -> Platform Event | Change Data Capture )
     subscription=null;

     @track notifications=[];
    
     connectedCallback(){
        this.handleErrors();
        this.handleSubscribe();
    }


    handleErrors(){
        onError(error=>{
            console.error('Recived Errors from Streaming API :'+JSON.stringify(error))
        })
    }

    handleSubscribe(){
            const messageCallback = (response)=>{
                console.log('Response =>'+JSON.stringify(response));

                const newNotification=response.data.payload.Status_Message__e;
                this.notifications=[...this.notifications,newNotification];
                this.dispatchEvent(
                    new ShowToastEvent({
                        title:'New Notification!',
                        message:newNotification,
                        variant:'success'
                    })
                )
            }

            subscribe(this.channelName,-1,messageCallback).then(res=>{
                console.log('Successfully subscribed to channel :'+res.channel)
                this.subscription=res;
            })
    }

    disconnectedCallback(){
        unsubscribe(this.subscription,(response)=>{
            console.log('Successfully unsubscribed from channel :'+response.channel);
        })
    }





}