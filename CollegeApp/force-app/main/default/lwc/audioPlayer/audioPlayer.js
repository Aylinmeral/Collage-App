import { LightningElement, api} from 'lwc';
import sound from '@salesforce/resourceUrl/homepagesound';
export default class AudioPlayer extends LightningElement {
    
    @api audioSrc=sound;
    
}