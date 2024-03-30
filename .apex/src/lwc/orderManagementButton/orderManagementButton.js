import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class orderManagementButton extends NavigationMixin(LightningElement) {

    connectedCallback() {
        this.orderManagementPageRef = {
            type: 'standard__component',
            attributes: {
                componentName: 'c__orderManagementWrapper'
            },
        };
    }

    handleClick(evt) {
        evt.preventDefault();
        evt.stopPropagation();

        this[NavigationMixin.GenerateUrl](this.orderManagementPageRef).then(url => { window.open(url) })

        //this[NavigationMixin.Navigate](this.orderManagementPageRef);
    }
}