import { LightningElement, api } from 'lwc';
import restaurants from '@salesforce/resourceUrl/restaurants';

export default class ForGetNearbyPlaces extends LightningElement {
    @api namesFormula;
    @api restaurantsUrl = restaurants;
    items = [];

    connectedCallback(){
        const data = this.namesFormula;
        const cleanedData = data.replace(/[\[\]]/g, '').split(',');//parantezleri kaldir virgullerden bol.
        this.items = cleanedData.map(item => item.trim());//basta ve sondaki bosluklari kaldir.
    }
}