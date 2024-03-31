import {LightningElement, wire, track} from 'lwc';
import Id from "@salesforce/user/Id";
import {CurrentPageReference} from 'lightning/navigation';
import getAccountInfo from "@salesforce/apex/OrderManagementController.getAccountInfo";
import getAllWithSearchAndFilter from "@salesforce/apex/OrderManagementController.getAllWithSearchAndFilter";
import getTypes from "@salesforce/apex/OrderManagementController.getTypes";
import getFamilies from "@salesforce/apex/OrderManagementController.getFamilies";

export default class orderManagement extends LightningElement {
    @track currentPageReference;

    @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        this.currentPageReference = currentPageReference;
    }

    setQuery(evt) {
        this.query = evt.target.value;
    }

    userId = Id;
    recordId = '';
    accountInfo = {};

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
                    console.log("FAMILIES RES:" + result)
                    this.families = [
                        {label: 'Any', value: ''},
                    ]
                    for (let i = 0; i < result.length; i++) {
                        this.families.push({label: result[i], value: result[i]});
                    }
                })

            getTypes()
                .then((result) => {
                    console.log("TYPES RES:" + result)
                    this.types = [
                        {label: 'Any', value: ''},
                    ]
                    for (let i = 0; i < result.length; i++) {
                        this.types.push({label: result[i], value: result[i]});
                    }
                })

            getAllWithSearchAndFilter({query: this.query, type: this.type, family: this.family})
                .then((result) => {
                    this.products = result;
            })
        }
    }
}