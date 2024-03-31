import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class orderManagementButton extends NavigationMixin(LightningElement) {
    @api recordId;

    handleClick(evt) {
        evt.preventDefault();
        evt.stopPropagation();
        console.log("ACC ID:" + this.recordId);

        this.orderManagementPageRef = {
            type: 'standard__component',
            attributes: {
                componentName: 'c__orderManagementWrapper'
            },
            state: {
                c__recordId: this.recordId,
            }
        };

        this[NavigationMixin.GenerateUrl](this.orderManagementPageRef).then(url => { window.open(url) })
    }
}