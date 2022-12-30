@isTest
public class Test_Geolocation {
   @IsTest
   static void testGeolocationController(){

    Profile p = [select id from profile where name ='System Administrator'];
    User user = new User(Alias = 'newUser', Email='newuser@testorg.com',
         EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
         LocaleSidKey='en_US', ProfileId = p.Id,
         TimeZoneSidKey='America/Los_Angeles', UserName='new-acek@testorg.com');
    //Insert user;

    Account account = new Account(
        Name = 'testAccount',
        RecordTypeId = '0125i0000001LdHAAU'
    );
    Insert account;

    Test.startTest();
    System.runAs(user){
        try {

            String ResultHttp = Geolocation_Controller.GeoapifyReverse('-6.1978323', '106.8058839');
            System.debug('ResultHttp: ' + ResultHttp);

        } catch (Exception e) {
            
        }
    }
    Test.stopTest();
    
   }

   @IsTest
   static void Test_CheckIn(){
        Profile p = [select id from profile where name ='System Administrator'];
        User user = new User(Alias = 'newUser', Email='newuser@testorg.com',
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
            LocaleSidKey='en_US', ProfileId = p.Id,
            TimeZoneSidKey='America/Los_Angeles', UserName='new-acek@testorg.com');

        Account account = new Account(
            Name = 'testAccount',
            RecordTypeId = '0125i0000001LdHAAU'
        );
        Insert account;

        Contact contact = new Contact(
            FirstName = 'testContact',
            LastName = 'testContact',
            AccountId = account.Id
        );
        Insert contact;
    Test.startTest();
    System.runAs(user){
        
        String ResultCheckIn = Geolocation_Controller.CreateEventCheckIn('-6.1978323', '106.8058839', contact.Id, 'Address', 'Contact');
        System.debug('ResultCheckIn'+ResultCheckIn);

    }
    Test.stopTest();
    
   }

   @IsTest
   static void testCheckOut(){
        Profile p = [select id from profile where name ='System Administrator'];
        User user = new User(Alias = 'newUser', Email='newuser@testorg.com',
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
            LocaleSidKey='en_US', ProfileId = p.Id,
            TimeZoneSidKey='America/Los_Angeles', UserName='new-acek@testorg.com');

        Account account = new Account(
            Name = 'testAccount',
            RecordTypeId = '0125i0000001LdHAAU'
        );
        Insert account;

        String value_Datetime = String.ValueOf(Datetime.now()).replace('T','');
        Datetime datetime_format = Datetime.valueOf(value_Datetime);
        RecordType eventRecordType = [Select Id FROM RecordType Where sObjectType = 'Event' And Name = 'Geolocation'];

        Event event = new Event(
            Subject = 'testEvent',
            WhoId = user.id,
            WhatId = account.Id,
            StartDateTime = datetime_format,
            EndDateTime = datetime_format,
            RecordTypeId = eventRecordType.Id
        );
        Insert event;
    Test.startTest();
    System.runAs(user){

        String ResultCheckOut = Geolocation_Controller.CreateEventCheckOut('-6.1978323', '106.8058839', event.id, 'Adress');
        System.debug('ResultCheckOut'+ResultCheckOut);

    }
    Test.stopTest();
    
   }

   @IsTest
   static void testValidasi(){
        Profile p = [select id from profile where name ='System Administrator'];
        User user = new User(Alias = 'newUser', Email='newuser@testorg.com',
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
            LocaleSidKey='en_US', ProfileId = p.Id,
            TimeZoneSidKey='America/Los_Angeles', UserName='new-acek@testorg.com');

        Account account = new Account(
            Name = 'testAccount',
            RecordTypeId = '0125i0000001LdHAAU'
        );
        Insert account;

        String value_Datetime = String.ValueOf(Datetime.now()).replace('T','');
        Datetime datetime_format = Datetime.valueOf(value_Datetime);
        RecordType eventRecordType = [Select Id FROM RecordType Where sObjectType = 'Event' And Name = 'Geolocation'];

        Event event = new Event(
            Subject = 'testEvent',
            WhoId = user.id,
            WhatId = account.Id,
            StartDateTime = datetime_format,
            EndDateTime = datetime_format,
            RecordTypeId = eventRecordType.Id
        );
        Insert event;
    Test.startTest();
    System.runAs(user){

        String ResultValidasi = Geolocation_Controller.ValidateCheckOut(event.id);
        System.debug('ResultValidasi'+ResultValidasi);

    }
    Test.stopTest();
    
   }

}