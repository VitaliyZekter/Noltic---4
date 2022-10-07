/**
 * Created by zekte on 03.10.2022.
 */

trigger FlightInfoTrigger on Flight_information__c (before insert, before update) {
    FlightInfoHandler.handler(Trigger.operationType, Trigger.new);
//    List <Flight_information__c> fiList = [SELECT Aircraft_lookup__c FROM Flight_information__c];
//    Decimal count = 0;
//    for(Flight_information__c f:fiList) {
//        if (Trigger.new[0].Aircraft_lookup__c == f.Aircraft_lookup__c) {
//            count++;
//        }
//
//        if(count>1) {
//            Trigger.new[0].addError('Aircraft unavailable');
//        }
//    }
}