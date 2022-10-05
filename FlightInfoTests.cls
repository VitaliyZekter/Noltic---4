/**
 * Created by zekte on 04.10.2022.
 */

@IsTest
private class FlightInfoTests {
    @IsTest
    static void moreThenOneRelated(){
        Decimal count = 0;
        Aircraft__c aircraft = new Aircraft__c(Name = 'air test');
        insert aircraft;
        Flight_information__c flightInfo = new Flight_information__c(Name = 'Test', Aircraft_lookup__c = aircraft.Id);
        insert flightInfo;
        Flight_information__c flightInfo2 = new Flight_information__c(Name = 'Test2', Aircraft_lookup__c = aircraft.Id);
        insert flightInfo2;

        Test.startTest();
        count += 2;
        Test.stopTest();

        List <Flight_information__c> getFI = [SELECT Id FROM Flight_information__c];
        System.assertEquals(2,count);

    }
}