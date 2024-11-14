#include <DS1302.h>    
#include <LiquidCrystal.h>
LiquidCrystal lcd(12, 11, 5, 4, 3, 2); 
//按钮设置
#define sett  A0   //settime
#define add  A1    //加
#define minus  A2  //减

#define Tone 13    //蜂鸣器

//DS1302端口
uint8_t CE_PIN= 8;
uint8_t IO_PIN= 9;
uint8_t SCLK_PIN= 10;

//创建对象
DS1302 rtc(CE_PIN, IO_PIN, SCLK_PIN);

unsigned long seconds;
int s = 0, m = 0, h = 0, d = 0, mon = 0, y = 0,chose=0;
int second = 0, minute = 0, hour = 0, day = 0, month = 0, year = 0;  //当前时间
int SECOND = 0, MINUTE = 0, HOUR = 0, DAY = 0, MONTH = 0, YEAR = 0;  //初始时间

void setup(){
    Serial.begin(9600);    
    for(int i = 2;i <= 13; i++){
        pinMode(i,OUTPUT); 
    }                
    digitalWrite(add, HIGH);
    digitalWrite(minus, HIGH);
    digitalWrite(sett, HIGH);
    //初始化  
    lcd.begin(16, 2);  
    set(rtc.year(), rtc.month(), rtc.date(), rtc.hour(), rtc.minutes(), rtc.seconds());
    //关闭  
    rtc.write_protect(false);
    rtc.halt(false);
}
//输出
void FormatDisplay(int col, int row,int num){
    lcd.setCursor(col, row); 
    lcd.print(num);   
}
//计算时间
void time() {  
    //计算秒  
    second = (SECOND + seconds) % 60;
    m = (SECOND + seconds) / 60;
    //计算分钟
    minute = (MINUTE + m) % 60;  
    h = (MINUTE + m) / 60;    
    //计算小时
    hour = (HOUR + h) % 24;   
    d = (HOUR + h) / 24; 
    lcd.setCursor(2, 1);   
    lcd.print(":");   
    lcd.setCursor(5, 1);   
    lcd.print(":"); 
    int temp0=0,temp1=0,temp2=0,temp3=0,temp4=0,temp5=0;
    temp0=hour/10,temp1=hour%10,temp2=minute/10,temp3=minute%10,temp4=second/10,temp5=second%10;
    FormatDisplay(0,1,temp0),FormatDisplay(1,1,temp1),FormatDisplay(3,1,temp2),FormatDisplay(4,1,temp3),FormatDisplay(6,1,temp4),FormatDisplay(7,1,temp5);
}
//计算天数
int Days(int year, int month){
    int days = 0;
    if (month != 2){
        switch(month){
            case 1: case 3: case 5: case 7: case 8: case 10: case 12: days = 31;  break;
            case 4: case 6: case 9: case 11:  days = 30;  break;
        }
    }else{  
        if(year % 4 == 0 && year % 100 != 0 || year % 400 == 0){
            days = 29;          
        }    
        else{
            days = 28;  
        }     
    }  
    return days;   
}
//计算天数
void Day(){     
    int days = Days(year,month);
    int days_up;
    if(month == 1){
        days_up = Days(year - 1, 12); 
    }   
    else{
        days_up = Days(year, month - 1);
    }  
    day = (DAY + d) % days;
    if(day == 0){
        day = days;  
    }     
    if((DAY + d) == days + 1 ){
        DAY -= days;
        mon++;
    }
    if((DAY + d) == 0){
        DAY += days_up;
        mon--;
    }
    FormatDisplay(8,0,day); 
}
//计算月份
void Month(){  
    month = (MONTH + mon) % 12;
    if(month == 0){
        month = 12;
    }  
    y = (MONTH + mon - 1) / 12;
    FormatDisplay(5,0,month); 
    lcd.setCursor(7, 0);   
    lcd.print('-'); 
}
//计算年份
void Year(){ 
    year = ( YEAR + y ) % 9999;
    if(year == 0){
        year = 9999;
    } 
    lcd.setCursor(0, 0); 
    if(year < 1000){ 
        lcd.print("0"); 
    }
    if(year < 100){ 
        lcd.print("0"); 
    }
    if(year < 10){ 
        lcd.print("0"); 
    }
    lcd.print(year);
    lcd.setCursor(4, 0);   
    lcd.print('-'); 
}
//计算星期
void Week(int y,int m, int d){           
    if(m == 1){
        m = 13;
    }
    if(m == 2){
        m = 14;
    } 
    int week = (d+2*m+3*(m+1)/5+y+y/4-y/100+y/400)%7+1; 
    String weekstr = "";
    switch(week){
        case 1: weekstr = "Mon. ";   break;
        case 2: weekstr = "Tues. ";  break;
        case 3: weekstr = "Wed. ";   break;
        case 4: weekstr = "Thur. ";  break;
        case 5: weekstr = "Fri. ";   break;
        case 6: weekstr = "Sat. ";   break;
        case 7: weekstr = "Sun. ";   break;
    }    
    lcd.setCursor(11, 0);  
    lcd.print(weekstr);
}
//显示
void Display() { 
    time();
    Day();  
    Month();
    Year();
    Week(year,month,day);  
}
//光标
void DisplayCursor(int rol, int row) {
    lcd.setCursor(rol, row);   
    lcd.cursor();
    delay(10);
    lcd.cursor();  
    lcd.noCursor();  
}
//初始
void set(int y, int mon, int d, int h, int m, int s){
    YEAR = y;
    MONTH = mon;
    DAY = d;  
    HOUR = h;
    MINUTE = m;
    SECOND = s;  
}
//按键设置
void Set_Time(int rol, int row, int &Time){
    DisplayCursor(rol, row); 
    if(digitalRead(add) == LOW){
        if(digitalRead(add) == LOW){
            Time ++;
        }           
        Display();      
    }  
    if(digitalRead(minus) == LOW){
        if(digitalRead(minus) == LOW){
            Time --; 
        }            
        Display();  
    }
}
//按钮选择
void Set_Clock(){
    if(digitalRead(sett)==LOW){  
        lcd.setCursor(9, 1);  
        lcd.print("SetTime");
        while(1){       
            if(digitalRead(sett) == LOW){
                if(digitalRead(sett) ==LOW){
                    chose++;  
                }             
            } 
            Display(); 
            //按一下设置小时
            if(chose == 1){
                Set_Time(1, 1, HOUR);      
            }
            //按两下设置分钟
            else if(chose == 2){ 
                Set_Time(4, 1, MINUTE);
            }
            //按三下设置秒数
            else if(chose == 3){
                Set_Time(7, 1, SECOND);
            }
            //按四下设置天数
            else if(chose == 4){
                Set_Time(9, 0, DAY);
            }
            //按五下设置月份
            else if(chose == 5){
                Set_Time(6, 0, MONTH);
            }
            //按六下设置年份
            else if(chose == 6){            
                Set_Time(3, 0, YEAR);
            }
            //再按一下退出设置
            else if(chose >= 7) {
                chose = 0; 
                break;
            }
        }
    }  
    lcd.setCursor(9, 1);  
    lcd.print("  lxh  ");
}
//整点蜂鸣
void Point_Time_Alarm(){
  if(minute==0&&second==0){
    tone(Tone,1000); 
    delay(5);
    noTone(Tone);  
  }
}

void loop() { 
    seconds = millis()/50;    //获取当前运行时间 
    Display();                //显示时间
    Set_Clock();              //设置时间  
    Point_Time_Alarm();       //整点蜂鸣
    Time t(year, month, day, hour, minute, second, 1);
    rtc.time(t);
}
