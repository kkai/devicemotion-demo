/*
The demo on the FETF event used data from the Family and Friends dataset,
in this version I replaced the dataset with randomized values, due to potential
privacy concerns.

This is terrible, pasted code based on a great demo by Josue Page ;-)
Remember I hacked this in a couple of hours. 

"3d Processing world" by Josue Page, licensed under Creative Commons Attribution-Share Alike 3.0 and GNU GPL license.
Work: http://openprocessing.org/visuals/?visualID= 19216	
License: 
http://creativecommons.org/licenses/by-sa/3.0/
http://creativecommons.org/licenses/GPL/2.0/

*/

import processing.net.*;
HashMap activeCubes;

int count=120,fl=0;
Cube[] a1 = new Cube[count];


color col=0, cal=255;
color back = color(0);

color[] cubecolor= {color(197,253,245),color(98,190,157), color(10,68,68)};

color activec = color(95,189,72);	

float t=0.1,n=2;
float x = 0;
float y = 0;

Server myServer;
byte interesting = 10;


void setup()
{
  PFont fontA = loadFont("HelveticaNeue-48.vlw");
  
  activec = color(211,48,24); //red
  activeCubes =  new HashMap();
  //size(1920,1080,P3D);
  size(866,668,P3D);
  background(back);
  translate(width,0,0);
    for(int e=0;e<count;e++)
  {
    a1[e] = new Cube(int(random(-width,width)),int(random(-height,height)),int(random(-width,width)),cubecolor[0],random(120)+100);
  }
  myServer = new Server(this, 10002); 
   
}

void draw2(){

}

void draw()
{
  //number of hit count

  background(0);

  x += 0.07;
  y += 0.08;
  
  
 translate(width/2,height/2,width/2-2000);
  
  rotateX(map(x,0,height,-2*PI,2*PI));
  rotateY(map(y,0,width,-2*PI,2*PI));
  

  try { 
    //println("starting");     
    Client thisClient = myServer.available();
    
    //println(thisClient.available());
    if (thisClient != null) {
        if (thisClient.available() > 0) {
          String a = thisClient.readStringUntil(interesting);
          String s = a.substring(0,a.length()-1);
          a = thisClient.readStringUntil(interesting); 
          a = a.substring(0,a.length()-1);
          float act = Float.parseFloat(a); 
          //println( act);
          //println(s);        
          if (activeCubes.containsKey(s)) {
           punkt p = (punkt) activeCubes.get(s);
           p.activity(act);
           p.setnotactive(0);
          }else{
            punkt p = new punkt(int(random(-width,width)),int(random(-height,height)),int(random(-width,width)),activec,random(120)+100,act);
            p.setnotactive(0);           
            activeCubes.put(s,p); 
          }
          
        }
      }
    } catch(Exception e) { 
      println("error reading stream: "+e.getMessage()); 
    }
   Iterator i = activeCubes.values().iterator();
   
   while (i.hasNext()) { 
      punkt p = (punkt) i.next();
      p.drawing();
      p.setnotactive(p.notactive()+1);
      if(p.notactive > 100){
         p.setnotactive(0);
         i.remove(); 
      }
   }  
   for(int u=0;u<count;u++)
  {
    a1[u].move();
    a1[u].drawing();
      for(int v=0;v<count;v++)
      {
        
         // if(random(2)> 1.99)
          if(abs(a1[u].z-a1[v].z)<width/6)
          if(abs(a1[u].x-a1[v].x)<width/6)
          if(abs(a1[u].y-a1[v].y)<width/6)
          {
            stroke(230,50);
            beginShape(LINES);
            vertex(a1[u].x,a1[u].y,a1[u].z);
            vertex(a1[v].x,a1[v].y,a1[v].z);
            endShape();
          }
      }
     i = activeCubes.values().iterator();
      
      while (i.hasNext()) { 
        punkt p = (punkt) i.next();
        if(abs(a1[u].z-p.z)<width/4)
          if(abs(a1[u].x-p.x)<width/4)
          if(abs(a1[u].y-p.y)<width/4)
          {
            stroke(230,50);
            beginShape(LINES);
            vertex(a1[u].x,a1[u].y,a1[u].z);
            vertex(p.x,p.y,p.z);
            endShape();
          }
      }
      
    a1[u].change();
   
  }

}


class punkt
{
  float act;
  int x,y,z;
  float tem;
  color fil;
  int notactive = 0;
  
  punkt(int q,int w,int te,color a,float e,float ac)
  {
    x=q;
    y=w;
    z=te;
    fil=a;
    tem=e;
    act =ac;
    n = random(-1,1);
  }
  
  int notactive(){
    return notactive;
  }
  
  void setnotactive(int na){
    notactive = na;
  }
  
  void activity(float a)
  {
    act =a;
  }
   
  void drawing()
  {
    if (act > 14){
      fill(255,0,0, 50);
      tem = 250;
    }else if(act > 8){
      fill(0,255,0, 50);
      tem = 200;
    }else{
      fill(255,50);
      tem=80;
    }
    if (tem > 250){
      tem =100;
    }
    noStroke();
    pushMatrix();
    translate(x,y,z);
    box(tem);
    //sphere(tem);
    fill(fil);
    box(40);
    popMatrix();
    tem+=n;
    if(tem>=50||tem<=1)
    {
      n*=-1;
    }
  }
  
}

class Cube
{
  int x,y,z;
  float tem;
  color fil;
  int count;
  float active;
  float vx,vy,vz;
  
  Cube(int q,int w,int te,color a,float e)
  {
    count = 0;
    x=q;
    y=w;
    z=te;
    fil=a;
    tem=e;
    active = random(20) + 10;
    n = random(-1,1);
    vx = random(-1,1);
    vy = random(-1,1);
    vz = random(-1,1);
  }
  
  void move()
  {
    /*if (x > 2*width)
      vx= -1;
    if (x < -2*width)
      vx= +1;
     if (y > 2*height)
      vy= -2;
    if (y < -2*height)
      vy= +2;  	
    if (z > 2*width)
      vz= -1;
    if (z < -2*width)
      vz= +1;   
    x +=vx;
    y +=vy;
    z +=vz; */
  }
   
  void drawing()
  {
    fill(cubecolor[0],50);
    noStroke();
    pushMatrix();
    translate(x,y,z);
    box(tem);
    //sphere(tem);
    fill(fil);
    box(40);
    popMatrix();
    tem+=n;
    if(tem>=70||tem<=1)
    {
      n*=-1;
    }
  }
  
  void change()
  {
    if( count >active){
      count = 0;
      //active = random(100);
      if(random(10) <2){
        fil = cubecolor[1];
      }else{
        fil = cubecolor[0];
      }
    }
    count ++;
   
  }
}

