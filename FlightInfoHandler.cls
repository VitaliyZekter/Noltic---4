/**
 * Created by zekte on 04.10.2022.
 */

public with sharing class FlightInfoHandler {
    public static void handler(TriggerOperation opType, List<Flight_information__c> recordNew) {
        switch on opType {
            when BEFORE_INSERT {
                FlightInfoService.checkForAircraftDuplicates(recordNew);
            }

            when BEFORE_UPDATE {
                FlightInfoService.checkForAircraftDuplicates(recordNew);
            }
        }
    }
}