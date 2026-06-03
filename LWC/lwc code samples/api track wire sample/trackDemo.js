import {LightningElement,track} from 'lwc';

export default class TrackDemo extends LightningElement{
    @track userProfile={
        name:'John Doe',
        address:{
            city:'San Francisco',
            PIN:'23444223',
            country:'USA'
        }
    }

    updateCity(){
        this.userProfile.address.city='Los Angeles';
    }
}