@RestResource(UrlMapping='/contact/*')
global with sharing class ContactRest {


    @HttpGet
    global static void getContactsGet() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;

        String contactId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);

        if (String.isBlank(contactId)) {

            List <Contact> contacts = [SELECT LastName, FirstName FROM Contact];

            response.headers.put('Content-type', 'application/json');
            response.responseBody = Blob.valueOf(JSON.serializePretty([
                    SELECT LastName, FirstName
                    FROM Contact
            ]));

        }

        else {
            response.headers.put('Content-type', 'application/json');
            response.responseBody = Blob.valueOf(JSON.serialize([
                    SELECT Id, FirstName, LastName
                    FROM Contact
                    WHERE Id = :contactId
            ]));
        }
    }

    @HttpPost
    global static void createContactsPOST(String LastName, String title, String email) {
        RestResponse response = RestContext.response;

        Contact createContact = new Contact(Title = title, LastName = LastName, Email = email);
        insert createContact;

        response.headers.put('Content-type', 'application/json');
        response.responseBody = Blob.valueOf(JSON.serialize(createContact));
    }

    @HttpPatch
    global static void updateContacts(String firstName, String email, String title) {
        RestResponse response = RestContext.response;
        RestRequest request = RestContext.request;

        String contactId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);

        if (String.isBlank(contactId)) {
            response.statusCode = 400;
            response.responseBody = Blob.valueOf('Id is missing');

            return;
        }

        List <Contact> contactList = [SELECT FirstName, Title, Email FROM Contact WHERE Id = :contactId];

        if (contactList.isEmpty()) {
            response.statusCode = 404;
            response.responseBody = Blob.valueOf('Contact not found');

            return;
        }

        Contact contact = contactList.get(0);

        contact.FirstName = firstName;
        contact.Email = email;
        contact.Title = title;
        update contact;

        response.headers.put('Content-type', 'application/json');
        response.responseBody = Blob.valueOf(JSON.serialize(contact));
    }

    @HttpDelete
    global static void deleteContacts() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;

        String contactId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);

        if (String.isBlank(contactId)) {
            response.statusCode = 400;
            response.responseBody = Blob.valueOf('Id is missing');

            return;
        }

        List <Contact> contacts = [SELECT Id FROM Contact WHERE Id = :contactId];

        if (contacts.isEmpty()) {
            response.statusCode = 404;
            response.responseBody = Blob.valueOf('Contact not found');

            return;
        }

        delete contacts;

        response.responseBody = Blob.valueOf('Deleted');
    }
}