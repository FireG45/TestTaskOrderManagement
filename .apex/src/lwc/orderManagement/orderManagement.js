import { LightningElement, wire, track } from 'lwc';
import Id from "@salesforce/user/Id";
import { CurrentPageReference } from 'lightning/navigation';

export default class orderManagement extends LightningElement {
    @track currentPageReference;
    @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        this.currentPageReference = currentPageReference;
    }
    userId = Id;
    recordId;
    accountData;

    products;

    loadProducts() {
        this.products = [
            {Name : "Product1", Description: "Description"},
            {Name : "Product2", Description: "Description"},
            {Name : "Product3", Description: "Description"},
            {Name : "Product4", Description: "Description"},
            {Name : "Product5", Description: "Description"},
            {Name : "Product6", Description: "Description"},
        ]
    }

    connectedCallback() {
        const pageReference = this.currentPageReference;
        this.recordId = pageReference.state.c__recordId;
        this.accountData = pageReference.state.c__accountData;
        this.loadProducts();
    }
}