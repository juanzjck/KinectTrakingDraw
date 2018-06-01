// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

//objetos
PWindow win;
PWindow win2;
KinectTracker tracker;
 Kinect kinect;

 float z;
int cellsize = 2; // Dimensions of each cell in the grid
int columns, rows;
PImage img;
boolean flag = false;
void settings() {
 size(640, 480,P3D); 
}
void setup() {
    background(255);
 // size(640, 520);
 win = new PWindow("hola.jpg");
 win2= new PWindow("hola.jpg");
 kinect = new Kinect(this);
 tracker = new KinectTracker();
 img = loadImage("hola.jpg");
 columns = img.width / cellsize; // Calculate # of columns
 rows = img.height / cellsize; // Calculate # of rows
  win.setTraker(tracker);
   win2.setTraker(tracker);
     win.setDireccion(-100,-100);
        win2.setDireccion(-100,100);
}

void draw() {
   
  if(flag==true){
   background(1);
   tracker.display();
  
  }else{
    
  // Run the tracking analysis
  tracker.track();
    // background(0);
    PVector v1 = tracker.getPos();
       
  fill(0);
  noStroke();
  ellipse(v1.x, v1.y, 10, 10);

  // Let's draw the "lerped" location
  PVector v2 = tracker.getLerpedPos();
  fill(0);
  noStroke();
  ellipse(v2.x, v2.y, 10, 10);
 

  // Display some info
  int t = tracker.getThreshold();
  fill(0);
    /*
      background(img);
      
      
      float xt = tracker.positionX();
      float yt= tracker.positionY();
      win.comunication(yt,xt);
      win2.comunication(-yt,-xt);
      tracker.track();
      //image(img, 0, 0, width, height);
      // Begin loop for columns
      for ( int i = 0; i < columns; i++) {
        // Begin loop for rows
        for ( int j = 0; j < rows; j++) {
          int x = i*cellsize + cellsize/2;  // x position
          int y = j*cellsize + cellsize/2;  // y position
          int loc = x + y*img.width;  // Pixel array location
          color c = img.pixels[loc];  // Grab the color
          // Calculate a z position as a function of mouseX and pixel brightness
          float z = (xt / float(width)) * brightness(img.pixels[loc]) - 20.0;
          // Translate to the location, set fill and stroke, and draw the rect
          pushMatrix();
          translate(x, y, z);
          fill(c, 204);
          noStroke();
          rectMode(CENTER);
          rect(0, 0, cellsize, cellsize);
          popMatrix();
        }
      }*/
      //fin
  }

}

// Adjust the threshold with key presses
void keyPressed() {
 int t = tracker.getThreshold();
 if (key == CODED) {
  if (keyCode == UP) {
   t += 5;
   tracker.setThreshold(t);
  } else if (keyCode == DOWN) {
   t -= 5;
   tracker.setThreshold(t);
  } else {
   if (keyCode == RIGHT) {
    flag = true;
   } else {
    flag = false;
   }
  }

 }
}