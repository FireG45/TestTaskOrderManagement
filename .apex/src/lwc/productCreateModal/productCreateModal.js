import {api, LightningElement} from 'lwc';
import getTypes from "@salesforce/apex/OrderManagementController.getTypes";
import getFamilies from "@salesforce/apex/OrderManagementController.getFamilies";
import createProduct from "@salesforce/apex/OrderManagementController.createProduct";
import getNewImageLink from "@salesforce/apex/OrderManagementController.getNewImageLink";

export default class CartModal extends LightningElement {
    isModalOpen = false;

    @api account;

    submitted = false;

    name = '';
    desc = '';
    type = '';
    family = '';
    image = '';
    price = 0;

    types = []
    families = []

    setName(evt) {
        this.name = evt.target.value;
    }

    setDesc(evt) {
        this.desc = evt.target.value;
    }

    setType(evt) {
        this.type = evt.target.value;
    }

    setFamily(evt) {
        this.family = evt.target.value;
    }

    setImage(evt) {
        this.image = evt.target.value;
    }

    setPrice(evt) {
        this.price = evt.target.value;
    }

    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }

    connectedCallback() {
        getFamilies()
            .then((result) => {
                this.families = [
                    {label: 'None', value: ''},
                ]
                for (let i = 0; i < result.length; i++) {
                    this.families.push({label: result[i], value: result[i]});
                }
            })

        getTypes()
            .then((result) => {
                this.types = [
                    {label: 'None', value: ''},
                ]
                for (let i = 0; i < result.length; i++) {
                    this.types.push({label: result[i], value: result[i]});
                }
            })
    }

    insertProduct() {
        createProduct({
            product: {
                Name: this.name,
                Description__c: this.desc,
                Type__c: this.type,
                Family__c: this.family,
                Image__c: this.image,
                Price__c: this.price
            }
        }).then(() => {
            window.location.reload();
        });
    }

    submitDetails() {
        if (!this.image || this.image.length === 0) {
            getNewImageLink({product: this.name})
                .then((result) => {
                    const obj = JSON.parse(result);
                    if (obj.data[0]) {
                        this.image = obj.data[0].imageurl;
                        this.insertProduct();
                    }
                })
        } else {
            this.insertProduct();
        }
    }
}