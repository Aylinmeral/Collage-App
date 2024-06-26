import { LightningElement} from 'lwc';
import header1 from '@salesforce/resourceUrl/homepageheader1';
import header2 from '@salesforce/resourceUrl/homepageheader2';
import header3 from '@salesforce/resourceUrl/homepageheader3';
import header4 from '@salesforce/resourceUrl/homepageheader4';
import header5 from '@salesforce/resourceUrl/homepageheader5';
import header6 from '@salesforce/resourceUrl/homepageheader6';


export default class CarouselStaticResources extends LightningElement {  
    headerUrlOne=header1;
    headerUrlTwo=header2;
    headerUrlThree=header3;
    headerUrlFour=header4;
    headerUrlFive=header5;
    headerUrlSix=header6;    
}