import insertTicket from '@salesforce/apex/GetFlightInfoByTicketId.addTicket'
import getTicketDiscountByContact from '@salesforce/apex/GetFlightInfoByTicketId.getContactDiscount'
import {LightningElement, api, wire} from 'lwc';
import {ShowToastEvent} from "lightning/platformShowToastEvent";

export default class ContactComponent extends LightningElement {
    @api recordId;
    @wire(getTicketDiscountByContact,{contactId:'$recordId'}) discount;
    showForm = false;
    ticketTypeId;

    showFormValue(){
        this.showForm =!this.showForm;
    }

    getTicketNameValue(event){
        this.nameValue = event.target.value;
    }

    getTicketType(event){
        this.ticketType = event.target.value;
        if(this.ticketType === 'Economy'){
            this.ticketTypeId = '0127R000000irXvQAI';
        }
        if(this.ticketType === 'Business'){
            this.ticketTypeId = '0127R000000irY0QAI';
        }
    }

    cleanLabels(){
        this.template.querySelector('.reset').value = null;

    }

    createNewTicket() {

        insertTicket({contact: this.recordId, ticketName: this.nameValue,status:'Booked',rec:this.ticketTypeId})
            .then(data => {
                if(data === true){
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Ticket added',
                            variant: 'success',

                        })
                    )
                }
                else{
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'Flight info was not found',
                            variant: 'error'
                        })
                    );
                }

            })

            .catch(error => {
                // alert(error)
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
        this.template.querySelector('lightning-input[data-name="reset"]').value = null;
        this.template.querySelector('lightning-input[data-name="reset1"]').value = null;
    }
}