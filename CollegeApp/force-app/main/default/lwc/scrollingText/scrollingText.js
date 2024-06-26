import { LightningElement, track } from 'lwc';

export default class ScrollingText extends LightningElement {
    @track message =' 🌟 Our college aims to provide students with a future filled with values and offers a comprehensive education program that supports academic success.🎨🏀👩‍🏫 The happiness and safety of our students are our priority, and we provide an environment that supports character development. 🌱✨';

    connectedCallback() {
        const container = this.template.querySelector('.container');  
        const text = this.template.querySelector('.scrolling-text');

        if (container && text) {
            this.startAnimation(container, text);
        }
    }

    startAnimation(container, text) {
        const containerWidth = container.offsetWidth;//containerin genisligi(sag sol bosluklar ve cerceve genisligi dahil)
        const textWidth = text.offsetWidth;//textin genisligi

        let position = containerWidth;//metnin baslangic pozisyonunun containerin genisligi ile ayni olmasini saglar.

        const animate = () => {
            position -= 1; //sola dogru 1 er kayiyor

            if (position < -textWidth) {//metnin ekran disina cikip cikmadigini kontrol ediyor.
                position = containerWidth;//eger boyleyse geri dondurur.
            }

            text.style.left = position + 'px';//pozisyon degiskeni artip azaldiginda textin sol kenari da ayni yonde hareket eder.
            requestAnimationFrame(animate);//animasyonun devamliligi icin yuksek performasnli animasyonlarin surekli olarak guncellenmesinde kullanilir.
        };

        animate();//bir kez burada baslatilir sonra requestAnimationFrame tarafindan devam ettirilir.
    }
}