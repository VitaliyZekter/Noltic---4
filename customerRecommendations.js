import {LightningElement, api, wire} from 'lwc';
import getDiary from '@salesforce/apex/GetRelatedDairies.getDairies'
import createNote from '@salesforce/apex/GetRelatedDairies.createNote'
import {deleteRecord} from "lightning/uiRecordApi";
import {refreshApex} from "@salesforce/apex";
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class CustomerRecommendations extends LightningElement {
    @api recordId;
    @wire(getDiary, {diaryId: '$recordId'})
    dairies;

    showFormValue = false;

    showForm() {
        this.showFormValue = !this.showFormValue;
    }

    noteOnChange(event) {
        this.noteValue = event.target.value;
    }

    noteOnChangeTitle(event) {
        this.noteValueTitle = event.target.value;
    }

    createNewNote() {
        createNote({contactId: this.recordId, noteValue: this.noteValue,title:this.noteValueTitle})
            .then(data => {
                // alert('Added');
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record added',
                        variant: 'success'
                    })
                )
                refreshApex(this.dairies);
            })
            .catch(error =>{
                // alert(error)
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
        this.template.querySelector('lightning-input[data-name="reset"]').value = null;
        this.template.querySelector('lightning-input[data-name="reset1"]').value = null;
    }


    deleteNote(event) {
        const noteId = event.target.dataset.recordid;
        deleteRecord(noteId)
            .then(data => {
                refreshApex(this.dairies);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record deleted',
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                alert(error)
            })

    }
}