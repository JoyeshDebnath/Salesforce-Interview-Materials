import {LightningElement,wire} from 'lwc';

const COLUMNS=[
    {label:'Account name',fieldName:'name',type:'text',sortable:true},
    {label:'Website',fieldName:'website',type:'url',sortable:true},
    {label:'Annual Revenue',fieldnName:'revenue',type:'currency',sortable:true},
    {label:'Phone',fieldName:'phone',type:'phone'}
]
const DATA=[
    { id: '1', name: 'Salesforce', website: 'https://salesforce.com', revenue: 26000000000, phone: '123-456-7890' },
    { id: '2', name: 'Google', website: 'https://google.com', revenue: 257000000000, phone: '987-654-3210' },
    { id: '3', name: 'Apple', website: 'https://apple.com', revenue: 394000000000, phone: '555-555-5555' },
    { id: '4', name: 'Microsoft', website: 'https://microsoft.com', revenue: 198000000000, phone: '111-222-3333' }
]

export default class SortableDatatable extends LightningElement{
    columns=COLUMNS;
    data=DATA;
    sortedBy;
    sortDirection='asc';

    handleSort(event){
        const {fieldName,sortDirection} = event.detail;
        this.sortedBy=fieldName;
        this.sortDirection=sortDirection;

        this.data=this.sortData(fieldName,sortDirection);

    }

    sortData(fieldName,sortDirection){
         const clonedData=[...this.data];
         const multiplier=this.sortDirection==='asc'?1:-1;
         clonedData.sort((a,b)=>{
            const valueA=a[fieldName]??'';
            const valueB=b[fieldName]??'';

            if(valueA<valueB) return -1*multiplier;
            if(valueA>valueB) return 1*multiplier;
            return 0;

         })
         return clonedData;
    }
}