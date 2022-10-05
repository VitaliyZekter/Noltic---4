/**
 * Created by zekte on 04.10.2022.
 */

public with sharing class FlightInfoService {
    public static void checkForAircraftDuplicates(List<Flight_information__c> recordNew) {
        List <Flight_information__c> fiList = [SELECT Aircraft_lookup__c FROM Flight_information__c];
        Decimal count = 0;
        for (Flight_information__c f : fiList) {
            if (recordNew[0].Aircraft_lookup__c == f.Aircraft_lookup__c) {
                count++;
            }

            if (count > 1) {
                Trigger.new[0].addError('Aircraft unavailable');
            }
        }
    }
}