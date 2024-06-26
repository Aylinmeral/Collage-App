import { LightningElement ,api} from 'lwc';
import parks from '@salesforce/resourceUrl/parks';
export default class ForGetNearParks extends LightningElement {
    @api parkNamesFormula;
    @api parksUrl = parks;
    items = [];

    connectedCallback(){
        const data = this.parkNamesFormula;
        const cleanedData = data.replace(/[\[\]]/g, '').split(',');
        this.items = cleanedData.map(item => item.trim());
    }
}