#include <aduc841.h>
org 0000h
sjmp basla
org 0003h
sjmp arttirma					//arttirma vektörüdür.
org 0013h
sjmp azaltma					//azaltma vektörüdür.

basla:
	setb ex0					//interrupt 0 aktif 
	setb ex1					//interrupt 0 aktif 
	mov adccon1,10000000b		//adc ve dac enerjilendirildi.
	mov daccon,#00011011b 		//12bit , rng1, vref, clr1, read
	mov dptr,#2048d				//dac gerilimi 1.25 v (4096 2,5 V a tekabul eder.)
	mov dac1h,dph				//dptr degerleri ataniyor
	mov dac1l,dpl
	mov dac0h,dph
	mov dac0l,dpl
	mov r0,#61d 				//daha sonra  1 artirilarak üzere arttirma isleminde kullanilacak
	mov r1,#61d 				//daha sonra 1 eksiltilerek  azaltma isleminde kullanilacak
	setb ea						//tum kesmeler aktif
	orl daccon,#00000100b		//sync biti setleniyor.
	
	
dongu:
	
	anl daccon,#11111011b		// sync	biti temizleniyor.
	jmp dongu

arttirma:
	mov dac0h,#00h				//önceki gelen deger sifirlaniyor
	mov a,r0					//toplamak için r0 degeri akümülatöre ataniyor.
	add a,#02h					//1mv karsilik deger 1.638 gelmektedir 2 olarak yuvarlandi
	mov r0,a					//toplam sobuç
	cjne r0,#00h,x				
	inc dac0h					//dac0h degeri 1 arttirilir.
	mov dac0l,r0				//toplam  dac0l'a yaziliyor.
	orl daccon,#00000100b		//sync biti setleniyor.
	reti						//cjne dogruysa  x'e yaziliyor
x:	mov dac0l,r0				//toplam dac0l ataniyor.
	orl daccon,#00000100b		//sync biti setleniyor.
	reti		
azaltma:
	mov dac1h,#00h				//önceki gelen deger sifirlaniyor
	mov a,r1					//r1 deger akümülatöre ataniyor.
	subb a,#02h					//çikarma islemi yapiliyor.
	mov r1,a					//islemin sonucu r1'e ataniyor.
	cjne r1,#00h,y			
	dec dac1h					
	mov dac1l,#0ffh				
								//0ffh degerinden baslamasi için yazilmistir.
	orl daccon,#00000100b		//sync biti setleniyor.
	reti
							    //yukaridaki cjne dogruysa  çikarma isleminin sonucu dac1l degerine ataniyor.
y:	mov dac1l,r1				
	orl daccon,#00000100b		//sync biti setleniyor.
	reti




end
