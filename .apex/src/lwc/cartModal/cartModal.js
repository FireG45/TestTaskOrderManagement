import {api, LightningElement, track} from 'lwc';
import checkout from "@salesforce/apex/OrderManagementController.checkout";

const columns = [
    {label: 'Name', fieldName: 'Name'},
    {label: 'Description', fieldName: 'Description__c'},
    {label: 'Type', fieldName: 'Type__c'},
    {label: 'Family', fieldName: 'Family__c',},
    {label: 'Price', fieldName: 'Price__c', type: 'currency'},
];

export default class CartModal extends LightningElement {
    @track isModalOpen = false;

    @api products = []
    @api account;

    data = [];
    columns = columns;

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
        checkout({cart: this.products, accountId: this.account}).then(() => {
            window.open(
                'https://test20-dev-ed.develop.lightning.force.com/lightning/r/Account/' + this.account
                + '/related/Orders1__r/view',"_self"
            )
        })
    }
}