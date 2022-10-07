/**
 * Created by zekte on 23.09.2022.
 */

public with sharing class TicketService {
    public static void increaseBookedSeats(List <Ticket__c> recordNew) {

        Set <Id> infoId = new Set<Id>();

        for (Ticket__c t : recordNew) {
            infoId.add(t.Flight_information__c);
        }

        Map <Id, Flight_information__c> tickets = new Map<Id, Flight_information__c>([SELECT Id, Number_of_booked_seats_Economy__c, Number_of_booked_seats_Business__c, (SELECT Ticket_Type__c, Status__c FROM Tickets__r) FROM Flight_information__c WHERE Id IN :infoId]);

        Decimal tempBusiness = 0;
        Decimal tempEconomy = 0;
        for (Id i : tickets.keySet()) {

            for (Ticket__c t : tickets.get(i).Tickets__r) {

                if (t.Status__c == 'Booked' && t.Ticket_Type__c == 'Economy') {
                    tempEconomy += 1;
                }

                if (t.Status__c == 'Booked' && t.Ticket_Type__c == 'Business') {
                    tempBusiness += 1;
                }
            }
            Flight_information__c temp = tickets.get(i);
            temp.Number_of_booked_seats_Economy__c = tempEconomy;
            temp.Number_of_booked_seats_Business__c = tempBusiness;
            tickets.put(i, temp);
        }

    }

    public static void increaseNumberOfMiles(List <Ticket__c> recordNew) {
        Set <Id> contactsIds = new Set<Id>();
        for (Ticket__c t : recordNew) {
            contactsIds.add(t.Contact__c);
        }

        Map <Id, Contact> ticketsByIds = new Map<Id, Contact>([SELECT Id, Miles_traveled__c, (SELECT Id, Status__c, Ticket_Type__c, Flight_distance__c FROM Tickets__r) FROM Contact WHERE Id IN :contactsIds]);

        Decimal tempMilesBusiness = 0;
        Decimal tempMilesEconomy = 0;
        for (Id i : ticketsByIds.keySet()) {
            for (Ticket__c t : ticketsByIds.get(i).Tickets__r) {
                if (t.Status__c == 'Completed' && t.Ticket_type__c == 'Economy') {
                    tempMilesEconomy += t.Flight_distance__c * 0.1;
                }
                if (t.Status__c == 'Completed' && t.Ticket_type__c == 'Business') {
                    tempMilesBusiness += t.Flight_distance__c * 0.3;
                }
            }

            Contact temp = ticketsByIds.get(i);
            temp.Miles_traveled__c = tempMilesBusiness + tempMilesEconomy;
            ticketsByIds.put(i, temp);
        }
        update ticketsByIds.values();
    }


    public static void decreaseNumberOfMiles(List <Ticket__c> recordNew) {
        Set <Id> contactsIds = new Set<Id>();
        for (Ticket__c t : recordNew) {
            contactsIds.add(t.Contact__c);
        }

        Map <Id, Contact> ticketsByIds = new Map<Id, Contact>([SELECT Id, Miles_traveled__c, (SELECT Id, Status__c, Ticket_Type__c, Flight_distance__c FROM Tickets__r) FROM Contact WHERE Id IN :contactsIds]);

        Decimal tempMilesBusiness = 0;
        Decimal tempMilesEconomy = 0;
        for (Id i : ticketsByIds.keySet()) {
            for (Ticket__c t : ticketsByIds.get(i).Tickets__r) {

                if (t.Status__c == 'Returned' && t.Ticket_type__c == 'Economy') {
                    tempMilesEconomy += t.Flight_distance__c * 0.1;
                }
                if (t.Status__c == 'Returned' && t.Ticket_type__c == 'Business') {
                    tempMilesBusiness += t.Flight_distance__c * 0.3;
                }
            }
            Contact temp = ticketsByIds.get(i);
            temp.Miles_traveled__c = -tempMilesBusiness - tempMilesEconomy;
            ticketsByIds.put(i, temp);
        }
    }



}