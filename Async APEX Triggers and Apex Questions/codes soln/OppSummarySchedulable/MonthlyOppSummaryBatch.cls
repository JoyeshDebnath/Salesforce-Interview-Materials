public class MonthlyOppSummaryBatch implements Database.Batchable<SObject>,Database.Stateful{
    public Decimal totalAmount=0.0;
    public Integer totalDeals=0;

    public Database.QueryLocator start (Database.BatchableContext bc ){
        return Database.getQueryLocator([
            SELECT Id,Amount 
                FROM Opportunity 
                WHERE 
            StageName='Closed Won' AND CloseDate=LAST_MONTH
        ]);
    }

    public void execute (Database.BatchableContext bc ,List<Opportunity> scope){
            for(Opportunity opp : scope){
                if(opp.Amount != null){
                    this.totalAmount+=opp.Amount;
                }
                  this.totalDeals++;
            }
          
    }

    public void finish (Database.BatchableContext bc ){
        Messaging.SingleEmailMessge email=new Messaging.SingleEmailMessage();

        email.setToAddresses(new String[]{'salesmanager@company.com'});
        email.setSubject('Monthly Closed-Won Opportunity Summary Report !');

        String body='Hello sales manager,\n\n'+
                    'Here is your automated Summary for previous month : \n\n'+
                    '-  Total Revenue generated : $'+this.totalAmount.format()+' \n'+
                    '-  Total Deals Closed - Won : '+this.totalDeals +' \n\n'+
                    'Regards,\n Salesforce Automated Systems . ';
        email.setPlainTextBody(body);
        Messaging.sendEmail(new List<Messaging.SingleEmailMEssage>{email});

    }
}