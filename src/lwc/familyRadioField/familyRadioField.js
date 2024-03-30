import {LightningElement} from 'lwc';

export default class FamilyRadioField extends LightningElement {
    value = '';

    get options() {
        return [
            { label: 'Family1', value: '1' },
            { label: 'Family2', value: '2' },
            { label: 'Family3', value: '3' },
        ];
    }
}