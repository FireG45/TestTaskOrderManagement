import {LightningElement, track} from 'lwc';
import getHello from '@salesforce/apex/HelloWorldController.getHello'

export default class MyHelloWorldLWC extends LightningElement {
    @track greet;

    connectedCallback() {
        getHello({'name' : 'GAY'})
            .then(result => {
                this.greet = result
            })
            .catch(error => {
                console.error(error);
            });
    }
}