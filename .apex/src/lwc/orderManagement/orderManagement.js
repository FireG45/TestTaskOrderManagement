import {LightningElement, wire, track} from 'lwc';
import Id from "@salesforce/user/Id";
import {CurrentPageReference} from 'lightning/navigation';
import getAccountInfo from "@salesforce/apex/OrderManagementController.getAccountInfo";
import getAllProducts from "@salesforce/apex/OrderManagementController.getAllProducts";

export default class orderManagement extends LightningElement {
    @track currentPageReference;

    @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        this.currentPageReference = currentPageReference;
    }

    userId = Id;
    recordId = '';
    accountInfo = {};

    products = [];

    connectedCallback() {
        const pageReference = this.currentPageReference;
        this.recordId = pageReference.state.c__recordId;

        if (this.recordId) {
            getAccountInfo({accountId: this.recordId})
                .then((result) => {
                    this.accountInfo = result
                    console.log("ACC: " + this.accountInfo.Name);
                    console.log("res: " + result.Name);
            });

            getAllProducts()
                .then((result) => {
                    this.products = result;
                    console.log("P:" + this.products);
                    console.log("R:" + result);
                })
        }
    }
}