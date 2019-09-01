size(600, 150); background(0); 

char ch = 'р';
String s = "pi =" + PI + ", если оставить 2 знака после запятой, получится pi =" + nfc(PI, 2);

textSize(12); 
fill(255, 155, 0); textAlign(LEFT); text(s, 20, 40);  // не забываем про Reference
fill(0, 155, 255); textAlign(RIGHT);
text("ок" + ch + "углим, будет pi = " + round(PI), width - 20, 60);

PFont font = createFont("Tahoma", 12);   
textFont(font); textAlign(CENTER, CENTER);
fill(170); text("шрифт можно изменить", width / 2, 80);
textSize(22); text("и размер текста тоже", width / 2, 100);

