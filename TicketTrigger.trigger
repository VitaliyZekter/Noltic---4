/**
 * Created by zekte on 23.09.2022.
 */

trigger TicketTrigger on Ticket__c (after update, after insert, after delete ) {
    TicketTriggerHandler.handler(Trigger.operationType, Trigger.new);
}