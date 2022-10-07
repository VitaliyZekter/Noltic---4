/**
 * Created by zekte on 23.09.2022.
 */

public with sharing class TicketTriggerHandler {
    public static void handler(TriggerOperation opType, List<Ticket__c> recordNew) {
        switch on opType {
            when AFTER_INSERT {
                TicketService.increaseBookedSeats(recordNew);
                TicketService.increaseNumberOfMiles(recordNew);
                TicketService.decreaseNumberOfMiles(recordNew);
            }

            when AFTER_UPDATE {
                TicketService.increaseBookedSeats(recordNew);
                TicketService.increaseNumberOfMiles(recordNew);
                TicketService.decreaseNumberOfMiles(recordNew);
            }


        }
    }
}