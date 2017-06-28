// process tab
void setupProcess() {
   cp5c = new ControlP5(this); 
  cp5c.addButton("display")
    .setPosition(30, 65)
      .setSize(45, 20)
        //   .setImages(imgs)
        //    .updateSize()
        ; 
 cp5c.addButton("select_points")
    .setPosition(750, 65)
      .setSize(65, 20)
        //   .setImages(imgs)
        //    .updateSize()
        ; 
 /*cp5c.addButton("peak_calc")
    .setPosition(750, 95)
      .setSize(65, 20)
        //   .setImages(imgs)
        //    .updateSize()
        ; */
        
 cp5c.addSlider("slider0")
    .setPosition(690, 75)
      .setSize(5, 400)
      .setRange(0,1)
 //     .setNumberOfTickMarks(20)
      .setValue(0.500)
      
      ;
       
         
}

void display(){
 for(int y = 0; y<voltams; y++){
   selectBox[y] = true;
 }
  selTxt = "None selected";
  selected = false;
}

void select_points(){
  if(selected == true){
     println("points selection");
     
     float iDx = xBox[1] - xBox[0];
     float iDy = yBox[1] - yBox[0];
     float xZ0 = xZoom[0]- xBox[0];
     float yZ0 = yZoom[1]- yBox[0];
     float xZ1  = xZoom[1]- xBox[0];
     float yZ1 = yZoom[0]- yBox[0];
//     println("x shifts: "+xZ0+", "+xZ1);
     
     float f0 = xZ0/iDx;
//     println("f0 calculated: "+xZ0+" / "+iDx+" = "+f0);
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
   
/*   println("delta x: "+deltaX+" delta y: "+deltaY);
   println("x fractions: "+fBox[0]+", "+fBox[2]);
      println("y fractions: "+fBox[1]+", "+fBox[3]);*/
   println("x(0): "+zoomXMin+", y(0): "+zoomYMin);
   println("x(1): "+zoomXMax+ ", y(1): "+zoomYMax);
  
  // search for points ////
  float[] mins = {9999,9999};
  float[] delta = {0,0};
//  points;
//  println("selected voltammagram: "+selVal);
  for (int r = 0; r<xVal[selVal].length; r++){
      delta[0] = abs(zoomXMin - xVal[selVal][r])+abs(zoomYMin - yVal[selVal][r]);
      delta[1] = abs(zoomXMax - xVal[selVal][r])+abs(zoomYMax - yVal[selVal][r]);
      for (int s = 0; s<2; s++){
        if(delta[s] < mins[s]){
       mins[s] = delta[s] ;
       points[s] = r;
//       println("trial");
      }
      }
  }
  println("minimized differences for point 0, r: "+points[0]);
    println("minimized differences for point 1, r: "+points[1]);
  println("voltammagram: "+ selVal);
  println("coords for point 0: "+xVal[selVal][points[0]]+", "+yVal[selVal][points[0]]);
    println("coords for point 1: "+xVal[selVal][points[1]]+", "+yVal[selVal][points[1]]);
    //  zoomed = true;  
    // displayCharts();  
   //  println("past charts displayed");
peakSel[selVal] = true;
errorFlag = false;
   }
  else{
    errorFlag = true;
    errorTxt = "select voltammagram";
    println("error 1");
  }
  peak_calc();
}

void peak_calc(){
  if(selected == true && peakSel[selVal]== true){
  x_base = xVal[selVal][points[0]];   // baseline x and y values
  y_base = yVal[selVal][points[0]];
  x_peak = xVal[selVal][points[1]];   // peak x and y values
  y_peak = yVal[selVal][points[1]];
  x_end = chartXMax;
  println("base point coords: "+x_base+", "+y_base);
  
  y_end = fract*(chartYMax-chartYMin)+chartYMin;
   println("end point coords: "+chartXMax+", "+y_end);
  slope = (y_end-y_base)/(x_end-x_base);
  interc = slope*x_base;
  interc = y_base-interc;
  y_zero = slope*chartXMin+interc;
  println("slope: "+slope+", intercept: "+interc);
  displayFlag = true;
  iCalcAtPeak=  slope*x_peak + interc;
  iPeak = y_peak - iCalcAtPeak;
  currentTxt = true;

  }
  /*else{
    errorTxt= "select points";
    errorFlag = true;
    println("error 2");
  }*/
}

void slider0(float fraction){
  fract = fraction;
  println("fraction: "+fract);
  if(currentTxt == true){
   peak_calc(); 
  }
}