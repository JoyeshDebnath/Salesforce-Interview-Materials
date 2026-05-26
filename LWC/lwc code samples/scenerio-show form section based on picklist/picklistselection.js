import {LightningElement} from 'lwc';

export default class PicklistSelection extends LightningElement{
    selectedType='';
    enterpriseRevenue;
    contarctTerm;

    get typeOptions(){
        return [
            {label:'Standard',value:'Standard'},
            {label:'Partner',value:'Partner'},
            {label:'Enterprise',value:'Enterprise'}
        ]
    }

    get isEnterPriseSelected(){
        return this.selectedType==='Enterprise'
    }
    
    handleTypeChange(evt){
        const type=evt.detail.value;
        this.selectedType=type;
        if(type!=='Enterprise'){
            this.enterpriseRevenue=null;
            this.contarctTerm=null;
        }
    }
    handleRevenueChange(evt){
        this.enterpriseRevenue=evt.detail.value;
    }
    handleContractTermChange(evt){
        this.contarctTerm=evt.detail.value;
    }

}