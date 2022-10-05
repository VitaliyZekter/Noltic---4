/**
 * Created by zekte on 26.09.2022.
 */

public with sharing class GetFlightInfoByTicketId {
    @AuraEnabled
    public static Boolean addTicket(Id contact, String ticketName, String status, Id rec) {
        List<Flight_information__c> flightInfo = [SELECT Id FROM Flight_information__c WHERE Name = :ticketName];

        if (flightInfo.size() != 0) {
            insert new Ticket__c(Contact__c = contact, Name = ticketName, Status__c = status, RecordTypeId = rec, Flight_information__c = flightInfo.get(0).Id);
            return true;
        } else {
            return false;
        }
    }



    @AuraEnabled(Cacheable=true)
    public static List<Contact> getContactDiscount(Id contactId) {
        return [SELECT Discount__c FROM Contact WHERE Id = :contactId];
    }
}