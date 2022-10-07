@IsTest
private class TicketServiceTest {
    @IsTest
    static void increaseNumberOfSeats() {
        Aircraft__c a1 = new Aircraft__c(Name = 'Air1', Number_of_available_seats_Business__c = 5, Number_of_available_seats_Economy__c = 5);
        insert a1;
        Flight_information__c flight1 = new Flight_information__c(Name = 'flight1', Aircraft_lookup__c = a1.Id, Number_of_booked_seats_Economy__c = 0, Number_of_booked_seats_Business__c = 0);
        insert flight1;

        Ticket__c t1 = new Ticket__c(Name = 'ticket1', Flight_information__c = flight1.Id, Status__c = 'Booked');
        Ticket__c t2 = new Ticket__c(Name = 'ticket2', Flight_information__c = flight1.Id, Status__c = 'Booked', RecordTypeId = '0127R000000irY0QAI');
        List <Ticket__c> ticketList = new List<Ticket__c>();
        ticketList.add(t1);
        ticketList.add(t2);
        flight1.Number_of_booked_seats_Economy__c += 1;
        flight1.Number_of_booked_seats_Business__c += 1;

        Test.startTest();
        update flight1;
        insert ticketList;
        Test.stopTest();


        List<Aircraft__c> getAir = [SELECT Id, Number_of_available_seats_Economy__c FROM Aircraft__c];
        System.assertEquals(5, getAir.get(0).Number_of_available_seats_Economy__c);
        /*************************************************************************************/
        List <Flight_information__c> getFI = [SELECT Id, Name, Number_of_booked_seats_Business__c, Number_of_booked_seats_Economy__c FROM Flight_information__c WHERE Name = 'flight1'];
        System.assertEquals(1, getFI.size());
        System.assertEquals(1, getFI.get(0).Number_of_booked_seats_Economy__c);
        System.assertEquals(1, getFI.get(0).Number_of_booked_seats_Business__c);

    }

    @IsTest
    static void increaseNumberOfSeatsNegative() {
        Aircraft__c a1 = new Aircraft__c(Name = 'Air1', Number_of_available_seats_Business__c = 0, Number_of_available_seats_Economy__c = 5);
        insert a1;
        Flight_information__c flight1 = new Flight_information__c(Name = 'flight1', Aircraft_lookup__c = a1.Id, Number_of_booked_seats_Economy__c = 0, Number_of_booked_seats_Business__c = 0);
        insert flight1;

        Ticket__c t1 = new Ticket__c(Name = 'ticket1', Flight_information__c = flight1.Id, Status__c = 'Booked', RecordTypeId = '0127R000000irXvQAI');
        Ticket__c t2 = new Ticket__c(Name = 'ticket2', Flight_information__c = flight1.Id, Status__c = 'Booked', RecordTypeId = '0127R000000irY0QAI');
        List <Ticket__c> ticketList = new List<Ticket__c>();
        ticketList.add(t1);
        ticketList.add(t2);
        flight1.Number_of_booked_seats_Economy__c += 1;
        flight1.Number_of_booked_seats_Business__c += 1;
        Exception ex = null;


        Test.startTest();
        try {
            insert ticketList;
            update flight1;
        } catch (Exception e) {
            ex = e;
        }

        Test.stopTest();


        System.assertNotEquals(null,ex);

        List <Flight_information__c> getFI = [SELECT Id, Name, Number_of_booked_seats_Business__c, Number_of_booked_seats_Economy__c FROM Flight_information__c WHERE Name = 'flight1'];
        System.assertEquals(0, getFI.get(0).Number_of_booked_seats_Economy__c);
        System.assertEquals(0, getFI.get(0).Number_of_booked_seats_Business__c);

    }

    @IsTest
    static void increaseNumberOfMiles(){
        Aircraft__c a1 = new Aircraft__c(Name = 'Air1', Number_of_available_seats_Business__c = 5, Number_of_available_seats_Economy__c = 5);
        insert a1;

        Flight_information__c flight1 = new Flight_information__c(Name = 'flight1', Aircraft_lookup__c = a1.Id,Flight_distance__c = 100);
        insert flight1;

        Contact con = new Contact(LastName = 'Test', Miles_traveled__c = 0);
        insert con;

        Ticket__c t1 = new Ticket__c(Name = 'ticket1', Flight_information__c = flight1.Id, Status__c = 'Completed',Contact__c = con.Id);
        Ticket__c t2 = new Ticket__c(Name = 'ticket2', Flight_information__c = flight1.Id, Status__c = 'Completed',Contact__c = con.Id ,RecordTypeId = '0127R000000irY0QAI');
        List <Ticket__c> ticketList = new List<Ticket__c>();
        ticketList.add(t1);
        ticketList.add(t2);

        Decimal tempBusiness = flight1.Flight_distance__c * 0.3;
        Decimal tempEconomy = flight1.Flight_distance__c * 0.1;
        con.Miles_traveled__c = tempBusiness + tempEconomy;

        Test.startTest();
        update con;
        insert ticketList;
        Test.stopTest();

        List<Aircraft__c> getAir = [SELECT Id, Number_of_available_seats_Economy__c FROM Aircraft__c];
        System.assertEquals(5, getAir.get(0).Number_of_available_seats_Economy__c);
        /*************************************************************************************/
        List <Ticket__c> getTickets = [SELECT Id FROM Ticket__c WHERE Ticket_Type__c = 'Economy'];
        System.assertEquals(1,getTickets.size());
        List <Contact> getContact = [SELECT Miles_traveled__c FROM Contact];
        System.assertEquals(40,getContact.get(0).Miles_traveled__c);

    }


}