public with sharing class OpportunityTriggerHandler {
        /**
         * Prevents Inserting opportunities with stage='Closed Lost' if the Parent Account has Active Contacts
         */
        public static void preventClosedLostWithActiveContacts(List<Opportunity> newOpps){
            Set<Id> accountIds=new Set<Id>();
            List<Opportunity> oppsToUpdate = new List<Opportunity>();

            for(Opportunity opp : newOpps){
                if(opp.StageName=='Closed Lost' && opp.AccountId!=null){
                    accountIds.add(opp.AccountId);
                    oppsToUpdate.add(opp);
                }
            }
            if(!accountIds.isEmpty()){

                Set<Id> accountsWithActiveContacts  = new Set<Id>();
                for(Contact con : [SELECT Id,AccountId FROM Contact 
                                      WHERE AccountId IN : accountIds])
                {
                    accountsWithActiveContacts.add(con.AccountId);
                }
                for(Opportunity opp : oppsToUpdate){
                    if(accountsWithActiveContacts.contains(opp.AccountId)){
                        opp.addError('Cannot insert an Opportunity as Closed Lost if Related Account  has Contacts ..');
                    }
                }
        }
}