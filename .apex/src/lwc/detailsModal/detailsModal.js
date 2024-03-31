import {LightningElement, track, api} from 'lwc';

export default class DetailsModal extends LightningElement {
    @track isModalOpen = false;

    @api record;

    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }

    submitDetails() {
        this.isModalOpen = false;
    }
}