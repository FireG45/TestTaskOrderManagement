import {api, LightningElement, track} from 'lwc';
import checkout from "@salesforce/apex/OrderManagementController.checkout";

const columns = [
    'Name',
    'Description__c',
    'Type__c',
    'Family__c',
    'Price__c',
];

export default class CartModal extends LightningElement {
    @track isModalOpen = false;

    @api products = []
    @api account;

    data = [];
    fields = columns;

    connectedCallback() {
        this.data = this.products;
    }

    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }

    submitDetails() {

    }
}