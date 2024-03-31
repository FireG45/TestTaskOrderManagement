import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import { NavigationMixin } from 'lightning/navigation';
export default class orderManagementButton extends NavigationMixin(LightningElement) {
    @api accountId;
    accountData;

    @wire(getRecord, { recordId: '$accountId', fields: [ACCOUNT_OBJECT.Name, ACCOUNT_OBJECT.AccountNumber] })
    account;

    get accountName() {
        return this.account.data ? getFieldValue(this.account.data, ACCOUNT_OBJECT.Name) : '';
    }

    get accountNumber() {
        return this.account.data ? getFieldValue(this.account.data, ACCOUNT_OBJECT.AccountNumber) : '';
    }

    connectedCallback() {
        this.accountData = {name : this.accountName, number : this.accountNumber}
        this.orderManagementPageRef = {
            type: 'standard__component',
            attributes: {
                componentName: 'c__orderManagementWrapper'
            },
            state: {
                c__recordId: this.accountId,
                c__accountData: this.accountData,
            }
        };
    }

    handleClick(evt) {
        evt.preventDefault();
        evt.stopPropagation();
        this[NavigationMixin.GenerateUrl](this.orderManagementPageRef).then(url => { window.open(url) })
    }
}