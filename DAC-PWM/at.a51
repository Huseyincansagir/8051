#include <at89c51.H>


	org 0000h
	sjmp ayar
ayar:
	
	
	mov r0,#00h
	mov acc,cfg841
	setb acc.2     
	mov cfg841,acc   //B�lme fakt�r� 64 olarak ayarlandi 
	mov dptr,#tablo  // Tablo dptr olarak ayarlandi
	
	mov pwm0h,#12d  //(pwm1h-pwm0h)*5=35 olmali
	mov pwm1l,#20d //Her iki PWM isaretinin ��z�n�rl�g� ve periyodu belirlenir. 20=16Mhz/12.5Khz/64
	mov pwm1h,#05h // �eyrek periyot i�in 20/4=5
	
	mov pwmcon ,#00100001b // fosc/B�lme fakt�r� ayarlandi
	

	
	z:
	mov a,r0
	movc a,@a+dptr
	mov pwm0l,a
	inc r0                     //Tablodan sonraki degerin se�ilmesi i�in r0 degeri 1 artirilir
	x:                        //p2.0 basilip �ekilince diger bir sonraki dutycycle �alisir.
	jb p2.0,x    
y:	jnb p2.0,y
	
sjmp z		

tablo:db 2,19,4,17,6,15,8,13,10,3	//dptr+8=20/100*65=13 ve dptr+10=20/100*15=13
	
end
