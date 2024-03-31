import {LightningElement} from 'lwc';

export default class TypeRadioField extends LightningElement {
    value = '';

    get options() {
        return [
            {label: 'None', value: ''},
            { label: 'Type1', value: 'Type1' },
            { label: 'Type2', value: 'Type2' },
            { label: 'Type3', value: 'Type3' },
        ];
    }
}