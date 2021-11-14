#include <ADUC841.H>
org 000
	start:
1	jb p3.2 , start ;Butona basilmamissa bekle,butona basilmissa bir alt satira ge�.
	bas:
	jnb p3.2 , bas  ;Butona basilmissa bekle, buton off konumuna ge�ince bir alt satira devam et.

    acall altprog 	;Alt programa git
	jmp start
	
	
	 altprog:
	mov r0 , p1		;P1 den alinan veri r0 a kaydedildi.
	mov a  , r0     ;Subb islemi i�in r0, A' ya atanir
	subb a , #9d	;r0-9 yapilir. Eger r0>9 ise cy biti 0 olur. Aksi takdirde cy=1 olacaktir.
	      
	jc kucuk        ; cy=1 ise yani r0<9 ise r0kucuk altprogramina atlar.
    acall r0buyuk   ; cy=0 yani r0>9 ise r0buyuk altprogramina atlar.
	jnc buyuk       ; cy=0 yani r0>9 ise r0buyuk' ten d�d�nkten sonra r0kucuk programina girmemesi gerektiginden alt programin sonuna gider.
	kucuk:
	acall r0kucuk
	buyuk:	
    ret
	
	r0buyuk:
	//Burada bir tam tur saga dogru d�nd�rme yapilacaktir.
	mov A , p2		; p2 verisi daha sonra islem yapilmak �zere A saklayicisina aktarilir.
	mov b , #8d     ; Bir bitin  bir tam tur saga dogru d�nd�r�lmesi 8 adimda ger�eklesir.
	say:            ;D�nd�rme islemi baslangici
	rr A            ;A yi saga bir adim d�nd�r�r.
	mov p2,A        ;D�nd�r�lm�s veriyi p2 de g�sterir.
	djnz b , say    ;b=8 olarak baslamisti.Her adimda 1 azalir.Nihayet bir tam tur sonunda 0 olur olmaz d�ng�den �ikar.
	;r0>9 durumu i�in alt program bitti
	ret
	
	

	
	
	r0kucuk:
	
	mov DPTR,#Tablo
	mov a,r0
	movc a,@a+DPTR
    mov p2,a
	
	
	ret

Tablo: db 1d,2d,3d,4d,5d,6d,7d,8d,9d,10d	

end