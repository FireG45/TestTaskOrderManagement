import {LightningElement, wire, track} from 'lwc';
import Id from "@salesforce/user/Id";
import {CurrentPageReference} from 'lightning/navigation';
import getAccountInfo from "@salesforce/apex/OrderManagementController.getAccountInfo";
import getAllWithSearchAndFilter from "@salesforce/apex/OrderManagementController.getAllWithSearchAndFilter";
import getTypes from "@salesforce/apex/OrderManagementController.getTypes";
import getFamilies from "@salesforce/apex/OrderManagementController.getFamilies";
import isUserManager from "@salesforce/apex/OrderManagementController.isUserManager";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class orderManagement extends LightningElement {
    @track currentPageReference;

    @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        this.currentPageReference = currentPageReference;
    }

    setQuery(evt) {
        this.query = evt.target.value;
        this.loadProducts();
    }

    setType(evt) {
        this.type = evt.target.value;
        this.loadProducts();
    }

    setFamily(evt) {
        this.family = evt.target.value;
        this.loadProducts();
    }

    loadProducts() {
        getAllWithSearchAndFilter({query: this.query, type: this.type, family: this.family})
            .then((result) => {
                this.products = result;
            })
    }

    userId = Id;
    recordId = '';
    accountInfo = {};

    @track
    products = [];

    types= [
        {label: 'None', value: ''},
    ]

    families = [
        {label: 'None', value: ''},
    ]

    @track
    type = '';
    @track
    family = '';
    @track
    query = ''

    @track
    cart = []

    isManager = false;

    openDetails = false;
    detailsId;

    addToCart(e) {
        this.cart.push(e.target.value)

        const evt = new ShowToastEvent({
            title: 'Product added',
            message: '\"' + e.target.value.Name + '\" is successfully added to cart',
            variant: "success",
        });
        this.dispatchEvent(evt);
    }

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

            getFamilies()
                .then((result) => {
                    this.families = [
                        {label: 'Any', value: ''},
                    ]
                    for (let i = 0; i < result.length; i++) {
                        this.families.push({label: result[i], value: result[i]});
                    }
                })

            getTypes()
                .then((result) => {
                    this.types = [
                        {label: 'Any', value: ''},
                    ]
                    for (let i = 0; i < result.length; i++) {
                        this.types.push({label: result[i], value: result[i]});
                    }
                })

            isUserManager({id: this.userId})
                .then((result) => {
                    this.isManager = result;
                })

            this.loadProducts();
        }
    }
}