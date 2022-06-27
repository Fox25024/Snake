import java.util.*;  
int d=15;
int l=15;
boolean czystart=false;
boolean lvl=false;
int trudnosc=1;
PImage newgame,poziom,wyjscie;
PImage newgame2,poziom2,wyjscie2;
PImage easy,normal,hard;
PImage easy2,normal2,hard2;
PImage tlo,murr;
PImage menu;
PImage punkt,end;
PImage nowa_gra,powrot,zapisz;
PImage nowa_gra2,powrot2,zapisz2;


class jedzenie{
  float x;
  float y;
  int xx;
  int yy;
  PImage ja=loadImage("snejk2/jedzenie.png");
  public jedzenie(){
     x=random(30)+1;
     y=random(30)+1;
     xx = (int)x;
     yy = (int)y;
     xx*=20;
     yy*=20;
     yy+=100;
  }
  public void show()
  {
    image(ja,xx,yy);
  }
};
class element{
  int x;
  int y;
  public void pok()
  {
    fill(255);
    rect(x,y,20,20);
  }
};
public class glowa extends element{ 
  public glowa(){
  x=320;
  y=400;
  
  }
  
  
};
class waz{
  Vector <element> vec = new Vector<element>(2);
  int punkty=0;
  glowa g;
  waz()
  {
    g=new glowa();
    element temp=new element();
    temp.x=340;
    temp.y=400;
    vec.add(temp);
    element tempP=new element();
    tempP.x=360;
    tempP.y=400;
    vec.add(tempP);   
  }
  void cialo(int tempx, int tempy)
  {
    Vector <element> tempv = new Vector<element>(vec.capacity()); 
    int temptx=0;
    int tempty=0;
    for(int i=0; i<punkty+2; i++)
    {
      element t=(element)vec.get(i);   
      if(i==0)
      {
        temptx=t.x;
        tempty=t.y;
        t.x=tempx;
        t.y=tempy;
        tempv.add(t);
      }
      else if(i>0)
      {
        int tx=t.x;
        int ty=t.y;
        t.x=temptx;
        t.y=tempty;
        temptx=tx;
        tempty=ty;
        tempv.add(t);
      }
    }
    vec=tempv;
  }
  void ruch(int r)
  {
    int tempx=g.x;
    int tempy=g.y;
    switch(r)
    {
      case 0:
      {
        g.y+=20;
        cialo(tempx,tempy);
        break;
      }
      case 1:
      {
        g.y-=20;
        cialo(tempx,tempy);
        break;
      }
      case 2:
      {
        g.x-=20;
        cialo(tempx,tempy);
        break;
      }
      case 3:
      {
        g.x+=20;
        cialo(tempx,tempy);
        break;
      }
    }  
  }
  void rysuj()
  {
    g.pok();  
    for(int i=0; i<punkty+2; i++)
    {
      element t=(element)vec.get(i);
      t.pok();    
    }   
  }
  boolean zjedzone(int xx, int yy)
  {
    if(g.x==xx && g.y==yy)
    {
      punkty++;
      element temp=new element();
      temp.x=g.x;
      temp.y=g.y;
      vec.add(0,temp);
      return true;
    }
    return false;
  }
  boolean spr_jedzenie(int xx, int yy)
  {
    if(g.x==xx && g.y==yy)return true;
    for(int i=0; i<punkty+2; i++)
    {
      element t=(element)vec.get(i);
      if(t.x==xx && t.y==yy)return true;    
    }
    return false;
  }
  boolean kolizja()
  {
    if(g.x==0 || g.x==640 || g.y==100 || g.y==740)
    {
      return true;
    }
    for(int i=0; i<punkty+2; i++)
    {
      element t=(element)vec.get(i);
      if(g.x==t.x && g.y==t.y)
      {
        return true;  
      }
    }
    return false;
  }
};
void load_grafika()
{
  newgame=loadImage("grafika/newGame.png");
  poziom=loadImage("grafika/level.png");
  wyjscie=loadImage("grafika/exit.png");
  newgame2=loadImage("grafika/newGame2.png");
  poziom2=loadImage("grafika/level2.png");
  wyjscie2=loadImage("grafika/exit2.png");
  easy=loadImage("grafika/easy.png");
  easy2=loadImage("grafika/easy2.png");
  normal=loadImage("grafika/medium.png");
  normal2=loadImage("grafika/medium2.png");
  hard=loadImage("grafika/hard.png");
  hard2=loadImage("grafika/hard2.png");
  tlo=loadImage("snejk2/background.png");
  murr=loadImage("snejk2/mur.png");
  punkt=loadImage("snejk2/puk.png");
  menu=loadImage("snejk2/main_menu.png");
  end=loadImage("snejk2/end.png");
  nowa_gra=loadImage("snejk2/new_game.png");
  powrot=loadImage("snejk2/game_exit.png");
  zapisz=loadImage("snejk2/save_score.png");
  nowa_gra2=loadImage("snejk2/new_game2.png");
  powrot2=loadImage("snejk2/game_exit2.png");
  zapisz2=loadImage("snejk2/save_score2.png");

}
jedzenie j;
waz w;
void setup() { 
  size(660, 760);
  load_grafika();
  j=new jedzenie();
  w=new waz();
}
int x;
void obslugamenue()
{
  if(wyniki)
  {
    if(mouseY>=600 && mouseX<=650)
    {
      if(mouseX>=40 && mouseX<=240)
      {
        image(nowa_gra,40,600);
      }
      if(mouseX>=240 && mouseX<=440)
      {
        image(powrot,240,600);
      }
      if(mouseX>440 && mouseX<=640)
      {
        image(zapisz,440,600);
      }
    }
  }
  else if(mouseX>=230 && mouseX<=430)
  {
    if(!lvl)
    {
    if(mouseY>=240 && mouseY<=290 && !koniec)
    {
      image(newgame2, 230,240);
    }
    else if(mouseY>=330 && mouseY<=380 && !koniec )
    {
      image(poziom2, 230,330);
    }
    else if(mouseY>=420 && mouseY<=470 && !koniec)
    {
      image(wyjscie2, 230,420);
    }
    }
    else
    {
      if(mouseY>=240 && mouseY<=290)
    {
      image(easy2, 230,240);
    }
    else if(mouseY>=330 && mouseY<=380)
    {
      image(normal2, 230,330);
    }
    else if(mouseY>=420 && mouseY<=470)
    {
      image(hard2, 230,420);
    }
    }
  }
}
boolean wyniki=false;
int punkty_do_zapisu;
void reset()
{
  j=new jedzenie();
  punkty_do_zapisu=w.punkty;
  w=new waz();
  zapis=4;
  wyniki=true;
  zapisano=false;
  
}
void generuj_jedzenie()
{
  if(w.zjedzone(j.xx,j.yy) || w.spr_jedzenie(j.xx,j.yy))
    {
      j=new jedzenie();
    }
}
void draw()
{
  if(czystart)
  {
    if(trudnosc==0)
  {
    frameRate(4);
  }
  else if(trudnosc==1)
  {
    frameRate(8);
  }
  else if(trudnosc==2)
  {
    frameRate(30);
  }
  if(!wyniki)
  {
    background(0);
    image(punkt,0,0);
    image(tlo, 0,100); 
    for(int i=0; i<33; i++)
    {
      image(murr,i*20,100);
      image(murr,i*20,740);
      if(i>0 && i<32)
      {
        image(murr,0,(i*20)+100);
        image(murr,640,(i*20)+100);
      }
    }     
    textSize(32);
    fill(0);
    text("Punkty: "+w.punkty, 20, 40);    
    if(w.kolizja())
    {
      reset();
    }
    generuj_jedzenie();
    j.show();
    w.ruch(zapis);
    w.rysuj(); 
  }
  else///tabela wyników
  {
    image(end,0,0);
    image(nowa_gra2,40,600);
    image(powrot2,240,600);
    image(zapisz2,440,600);
    if(!zapisano)
    {
    text("Podaj swój nick:",200,550);
    for(int i=0; i<pozycja; i++)
    {
      text(nick[i],200+i*20,590);
    }
    }
    else 
    {
      text("Wynik został zapisany",200,550);
      text("5 najlepszych wyników",200,40);
      odczyt();
      if(raz)
      {
      String [] strArr = new String [ilosc_lini];
      for(int i=0; i<ilosc_lini; i++)
        strArr[i]=plik.get(i);
      for(int i=1; i<ilosc_lini;i+=2)
      {
        for(int j=1; j<ilosc_lini; j+=2)
        {
          if(int(strArr[i])>int(strArr[j]))
          {
            String t1=strArr[i];
            String t2=strArr[j];
            String t11=strArr[i-1];
            String t22=strArr[j-1];
            strArr[i]=t2;
            strArr[i-1]=t22;
            strArr[j]=t1;
            strArr[j-1]=t11;
          }
        }
      }
      output = createWriter("wyniki"+trudnosc+".txt");

        for(int i=0; i<strArr.length;i++)
        {  
          if(i==10)break;
          output.println(strArr[i]);
          output.flush();
        }
        output.close();
        raz=false;
      }
           
      
      
      if(ilosc_lini>10)
      ilosc_lini=10;
      for(int i=0; i<ilosc_lini;i++)
      {
          String t=(String)plik.get(i);  
          text(t,200,140+i*40);
          i++;
          String tt=(String)plik.get(i);
          text(tt,400,140+(i-1)*40);
      }
      ilosc_lini=0;
      
    }
    obslugamenue();
  }
  }
  else
  {
    background(0);
    if(!lvl)
    {
    image(menu,0,0);
    if(koniec)
    {
      textSize(32);
      text("Autor projektu:",140,140);
      text("Bartosz Lisiecki",140,240);
      textSize(16);
      text("Aby zakończyć kliknij lewy przycisk myszy",140,440);
      ex=true;
    }
    else
    {
    image(newgame, 230,240);
    image(poziom, 230,330);
    image(wyjscie, 230,420);
    }
    }
    else if(lvl)
    {
      image(menu,0,0);
      image(easy, 230,240);
      image(normal, 230,330);
      image(hard, 230,420);
    }
    obslugamenue();
  }
}
boolean raz=false;
char nick[]= new char [12];
boolean ex=false;
int zapis=4;
boolean zmiana=false;
int pozycja=0;
void keyPressed()
{
  x=keyCode;
  if(x==DOWN && zapis!=1 && zapis!=0)
  {
    zapis=0;
    if(trudnosc==2)w.ruch(0);
  }
  else if(x==UP && zapis!=0 && zapis!=1)
  {
    zapis=1;
    if(trudnosc==2)w.ruch(1);
  }
  else if(x==LEFT && zapis!=3 && zapis!=2)
  {
    zapis=2;
   if(trudnosc==2) w.ruch(2);
  }
  else if(x==RIGHT && zapis!=2&& zapis!=3) 
  {
    if(zapis!=4)
    {
      zapis=3;
    }
    
    if(trudnosc==2)w.ruch(3);
  }
  if(wyniki)
  {
    if(x==8)
    {
      if(pozycja>0)
      pozycja--;
    }
    else if(pozycja<12)
    {
      nick[pozycja]=char(x);
      pozycja++;
    }
    
  }
}
int ilosc_lini=0;
Vector <String> plik = new Vector<String>();
void odczyt() {
  plik.clear();
  // Open the file from the createWriter() example
  BufferedReader reader = createReader("wyniki"+trudnosc+".txt");
  String line = null;
  try {
    while ((line = reader.readLine()) != null) {
      plik.add(line);
      ilosc_lini++;
    }
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
}
PrintWriter output;
boolean koniec=false;
boolean zapisano=false;
void mouseClicked()
{
  if(wyniki)
  {
    if(mouseY>=600 && mouseX<=650)
    {
      if(mouseX>=40 && mouseX<=240)
      {
        wyniki=false;
      }
      else if(mouseX>=240 && mouseX<=440)
      {
        wyniki=false;
        czystart=false;
      }
      else if(mouseX>440 && mouseX<=640 && !zapisano)
      {
        
        odczyt();
        output = createWriter("wyniki"+trudnosc+".txt");
        String k="";
        for(int i=0; i<pozycja; i++)
        {
          k+=Character.toString(nick[i]);
        }
        for(int i=0; i<ilosc_lini;i++)
        {
          
          String t=(String)plik.get(i);
          output.println(t);
          output.flush();
        }
        output.println(k);
        output.flush(); 
        String s=String.valueOf(punkty_do_zapisu);
        output.println(s);
        output.flush(); 
        output.close();
        pozycja=0;
        zapisano=true;
        ilosc_lini=0;
        raz=true;
      }
      else text("Już zapisałes swój wynik",200,590);
    }
  }
  if(ex)
  {
    exit();
  }
  if(!lvl)
  {
    if(mouseY>=240 && mouseY<=290)
    {
      czystart=true;
      
      return;
    }
    if(mouseY>=420 && mouseY<=470)
    {
      koniec=true;
      
      
    }
    if(mouseY>=330 && mouseY<=380)
    {
      lvl=true;
    }
  }
  else if(lvl)
  {
    if(mouseY>=240 && mouseY<=290)
    {
      lvl=false;
      trudnosc=0;
    }
    if(mouseY>=420 && mouseY<=470)
    {
      lvl=false;
      trudnosc=2;
    }
    if(mouseY>=330 && mouseY<=380)
    {
      lvl=false;
      trudnosc=1;
    }
  }
}
