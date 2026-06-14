public class PartialUpdateDemo {

    public static void updateDemo(List<Account> accRecordsToBeUpdated){
        if(accRecordsToBeUpdated.isEmpty() || accRecordsToBeUpdated==null){
            return;
        }

        Database.SaveResult[] results=Database.update(accRecordsToBeUpdated,false);
        for(Database.SaveResult sr:results){
            if(!sr.isSuccess){
                System.debug('Failed Record ID=>'+sr.getId());
                System.debug('Below Errors Occurred...'); 
                for(Database.Error err:sr.getErros()){
                    System.debug(err.getStatusCode()+'   -   '+err.getMessage());
                    System.debug('Account fields that affcted this error ==>'+err.getFields());
                }
            }
        }
    }
} 