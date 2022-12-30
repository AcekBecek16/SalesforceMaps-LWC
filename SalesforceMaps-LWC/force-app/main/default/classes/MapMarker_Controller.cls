public class MapMarker_Controller {

    @AuraEnabled
    public static List<Account> getAccountLocation(){
        try {
            
            List<Account> account = [
                SELECT Id, Name, BillingState, BillingStreet, BillingCity, BillingCountry, BillingPostalCode, Description
                FROM Account WHERE MapMakers__c = TRUE        
                ];
            String getAccount = JSON.serialize(account);
            return account;


        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Event> getEventLocation(){
        try {
            
            List<Event> event = [
                SELECT Id , Subject, OwnerId, Location, Check_In_Date__c, Check_Out_Date__c, Check_In_Address_Line__c, Check_Out_Address_Line__c,
                Check_In_Latitude__c, Check_In_Longitude__c
                FROM Event WHERE OwnerId = :UserInfo.getUserId()
            ];

            return event;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
