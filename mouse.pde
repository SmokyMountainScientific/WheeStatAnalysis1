// mouse tab

void setupZoom() {
   cp5b = new ControlP5(this); 
  cp5b.addButton("zoom")
    .setPosition(600, 20)
      .setSize(45, 20)
        //   .setImages(imgs)
        //    .updateSize()
        ;  
   cp5b.addButton("restore")
    .setPosition(650, 20)
      .setSize(45, 20)
        //   .setImages(imgs)
        //    .updateSize()
        ;  //
}

 void mousePressed(){
// selVal = 99;
boolean change = false;
 for (int q = 0; q<voltams; q++){
      int maxY = deltaY*q + yOff;          
   int minY = deltaY*q + yOff-14;
if (mouseX > xOff-40 && mouseX <xOff+100 && mouseY > minY && mouseY < maxY){  
  selVal = q;
  change = true;
  selected = true;

/*  selectBox[q] =! selectBox[q];
  print("file "+q);
  println(" selected, state = "+selectBox[q]);*/
  
}  // end of if statement

 }
 if(change == true){
   for (int p = 0; p<voltams; p++){
    if(p == selVal){
      selectBox[selVal] = true;
      selTxt = sFileName[p];
    }
    else{
      selectBox[p] = false;
    }
   }
 }
 for (int r = 0; r<voltams; r++) {
  if (selectBox[r] == true) {
   print("Select box = "+r);
  println(" is true."); 
  errorFlag = false;
  }

  else {
  print("Select box = "+r);
  println(" is false."); 
  }
 }
/* for (int s = 0; s<3; s++){
  if (mouseX > 20*s+810 && mouseX <20*s+830 && mouseY > 70 && mouseY < 82){ 
    iUnit = s;
  }*/
 //}
 }
 void mouseReleased(){
   mouse0 = false;
 }
 void mouseDragged(){
  if(mouseX > xZoom[0]-10 && mouseX < xZoom[0]+10 && mouseY >yZoom[0]-10 && mouseY < yZoom[0]+10){
   xZoom[0] = mouseX;
   yZoom[0] = mouseY;
   mouse0 = true;
  }
    if(mouseX > xZoom[1]-10 && mouseX < xZoom[1]+10 && mouseY >yZoom[1]-10 && mouseY < yZoom[1]+10&&mouse0==false){
   xZoom[1] = mouseX;
   yZoom[1] = mouseY;
  }
  if(xZoom[0] < xZoomLim[0]){
    xZoom[0] = xZoomLim[0];
 }
   if(xZoom[0] > xZoomLim[1]){
    xZoom[0] = xZoomLim[1];
   }
   
   if(xZoom[1] < xZoomLim[2]){
    xZoom[1] = xZoomLim[2];
 }
   if(xZoom[1] > xZoomLim[3]){
    xZoom[1] = xZoomLim[3];
 }
   if(yZoom[0] > yZoomLim[0]){
    yZoom[0] = yZoomLim[0];
 }
   if(yZoom[0] < yZoomLim[1]){
    yZoom[0] = yZoomLim[1];
   }
   
   if(yZoom[1] > yZoomLim[2]){
    yZoom[1] = yZoomLim[2];
 }
   if(yZoom[1] < yZoomLim[3]){
    yZoom[1] = yZoomLim[3];
 }
 }
 
 void zoom(){
  // if(runMode == false){
//   if(xData.length>10 && zoomed == false){
     if(zoomed == false){
     println("zooming");
     
     float iDx = xBox[1] - xBox[0];
     float iDy = yBox[1] - yBox[0];
     float xZ0 = xZoom[0]- xBox[0];
     float yZ0 = yZoom[1]- yBox[0];
     float xZ1  = xZoom[1]- xBox[0];
     float yZ1 = yZoom[0]- yBox[0];
     println("x shifts: "+xZ0+", "+xZ1);
     
     float f0 = xZ0/iDx;
     println("f0 calculated: "+xZ0+" / "+iDx+" = "+f0);
     fBox[0] = xZ0/iDx;  //(xBox[1]-xBox[0]);        //fraction x0
     fBox[1] = yZ0/iDy;  //(yBox[1]-yBox[0]);        // fraction y0
     fBox[2] = xZ1/iDx;  //(xBox[1]-xBox[0]);        // fraction x1
     fBox[3] = yZ1/iDy;  //(yBox[1]-yBox[0]);         // fraction y1
   //  fBox[1] = 1-fBox[1];
   //  fBox[3] = 1-fBox[3];
   println("x zoom values: "+xZoom[0]+", "+xZoom[1]); 
   println("box x dimensions: "+xBox[0]+", "+xBox[1]);
      println("y zoom values: "+yZoom[0]+", "+yZoom[1]);
    println("box y dimensions: "+yBox[0]+", "+yBox[1]);  
 /*  oldChartLim[0] = chartXMax;
    oldChartLim[1] = chartYMax;
    oldChartLim[2] = chartXMin;
    oldChartLim[3] = chartYMin ;*/
    float deltaX = chartXMax - chartXMin;
    float deltaY = chartYMax - chartYMin;
   
   zoomXMin = chartXMin +(fBox[0]*deltaX);
   zoomXMax = chartXMin +(fBox[2]*deltaX);
   zoomYMin = chartYMin +(fBox[3]*deltaY);
   zoomYMax = chartYMin +(fBox[1]*deltaY);
   
   println("delta x: "+deltaX+" delta y: "+deltaY);
   println("x fractions: "+fBox[0]+", "+fBox[2]);
      println("y fractions: "+fBox[1]+", "+fBox[3]);
   print("x min: "+zoomXMin);
   println("x max: "+zoomXMax);
   print("y min: "+zoomYMin);
   println("y max: "+zoomYMax);
      zoomed = true;  
     displayCharts();  
     println("past charts displayed");

   }
   //}
 }
 
 void restore(){
   zoomed = false;
   
 }