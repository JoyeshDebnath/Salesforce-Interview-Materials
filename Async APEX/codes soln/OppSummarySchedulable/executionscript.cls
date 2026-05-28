//CRON Expression : second - minutes - hours - DAY_OF_MONTH - Month - DAY_OF_WEEK 

String cron_expression = '0 0 0 1 * ?';
System.schedule('Automated monthly opportunity summary ,',cron_expression,new MonthlyOpportunitySummaryScheduler());