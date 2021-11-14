#include <ADUC841.H>
	org 0000h
	sjmp start
    
	org 0013h 
	sjmp haricikesme
	
	org 001Bh
 SJMP timerkesme
		
start:
	;Timer ve kesme ayarlari
              
    mov tmod , #10010000b  ;Timer 1, mod1
	mov dptr , #65535d    ;65535-1ms/90.4ns=65535-11062=54473
	mov tl1 , dpl         ;54473 sayisinin low kismi
    mov th1 , dph         ;54473 sayisinin high kismi
    setb ex1              ;Harici kesme aktif
	setb et1			  ;Timer kesmesi aktif
	setb it1              ;Düsen kenar tetikleme
	setb ea	              ;Tüm kesmeler aktif
	setb tr1              ;Timer1 basladi
	
	x: sjmp x             ;Tf1 bayragi yanana kadar bekler.
	
		timerkesme:
;her 1ms de bir uzunluk ölçer ve 30h a kaydeder.

	
	mov tl1,dpl	          ;Timer sayaci eski halinbe ayarla (low)         
	mov th1,dph           ;Timer sayaci eski halinbe ayarla (high)
	
	inc 30h               ;boy sayacini 1 cm artirir
	mov a,30h
	cjne a,#250d,t	
    clr tf1               ;Tasim sonraki kesmede kullanilmak üzre 0 lanir.
	
	reti

t: reti
		
		haricikesme:
	mov a , #100d         ;100cm
	subb a , 30h          ;Eger 30h daki veri 100 degilse 
	jnz p00yakson          ;p0yakson'a git
	mov tl1,dpl			  ;Timer sayaci eski halinbe ayarla (low)
	mov th1,dph           ;Timer sayaci eski halinbe ayarla (high)
	mov 30h,#00h		  ;Uzunluk alanini sifirla
	reti

		p00yakson:
;p0.0 i logic 1 yapar ve270 ns sonra logic 0 yapar.
    setb p0.0				
	nop 				  ;nop komutunun gerçeklesmesi yaklasik 90ns zaman alir. 
	nop					  ;o yüzden kabaca 270ns için 3 kere nop komutu çalistirdim
	nop
	clr p0.0
	clr p3.3
	mov tl1,dpl	          ;Timer sayaci eski halinbe ayarla (low)         
	mov th1,dph 
	mov 30h,#00h	
	reti
	

		


end