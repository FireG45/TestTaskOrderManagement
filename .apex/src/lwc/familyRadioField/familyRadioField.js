import {LightningElement} from 'lwc';

export default class FamilyRadioField extends LightningElement {
    value = '';

    get options() {
        return [
            {label: 'None', value: ''},
            {label: 'Family1', value: 'Family1'},
            {label: 'Family2', value: 'Family1'},
            {label: 'Family3', value: 'Family1'},
        ];
    }
}