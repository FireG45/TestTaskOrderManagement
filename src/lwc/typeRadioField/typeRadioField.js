import {LightningElement} from 'lwc';

export default class TypeRadioField extends LightningElement {
    value = '';

    get options() {
        return [
            { label: 'Type1', value: '1' },
            { label: 'Type2', value: '2' },
            { label: 'Type3', value: '3' },
        ];
    }
}