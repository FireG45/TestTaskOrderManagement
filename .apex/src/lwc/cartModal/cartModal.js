import {LightningElement, api, track} from 'lwc';

export default class CartModal extends LightningElement {
    @track isModalOpen = false;

    @api products = []

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