/* LineChart tab, WheeStat6_0 GUI sketch
 chartsSetup() -- initiallizes charts
 --called in setup loop
 displayCharts() -- sets up and displays charts
 -- called in draw loop
 setLimits() -- sets limits on x and y displays
 */

void chartsSetup() {
  
  for (int y = 0; y<voltams; y++) {
    lineChart[y] = new XYChart(this);
    lineChart[y].setPointColour(color(red[y], green[y], blue[y]));
    lineChart[y].setPointSize(5);
    lineChart[y].setLineWidth(2);
  }
  int[] lWidth = {1,4};
  int[] lColor = {0,#E59615};
    for (int y = 0; y<2; y++) {
    fitChart[y] = new XYChart(this);
//    lineChart[y].setPointColour(color(red[y], green[y], blue[y]));
    fitChart[y].setPointSize(1);
    fitChart[y].setLineWidth(lWidth[y]);
    fitChart[y].setLineColour(lColor[y]);
  }
}    // end of charts setup


void displayCharts() {
  firstChartSetup();
    chartXMax = 0;
    chartYMax = 0;
    chartXMin = 0;
    chartYMin = 0;

 for (int q = 0; q<voltams; q++){
   lineChart[q].setData(xVal[q], yVal[q]);                    // data set for all charts
   if(selectBox[q]== true){
     float xValMin = min(xVal[q]);
      float xValMax = max(xVal[q]);
      float yValMin = min(yVal[q]);
      float yValMax = max(yVal[q]);
    chartXMax = max(chartXMax, xValMax)+20;  //xVal[q]);
    chartYMax = max(chartYMax, yValMax)+5;  //yVal[q]);
    chartXMin = min(chartXMin, xValMin)-20;  //xVal[q]);
    chartYMin = min(chartYMax, yValMin)-5;  //yVal[q]);
   }
  }
    if(displayFlag == true){
displayLines();
  }
  
 boolean firstChart = true;
 for (int p = 0; p<voltams; p++){      // need to determine limits (above) before setting limits
   if(selectBox[p]== true){
     setLimits(lineChart[p]);
/*     if(firstChart == true){
      lineChart[p].showXAxis(true);
      lineChart[p].showYAxis(true);
       lineChart[p].draw(250, 70, 430, 420);
       firstChart = false;
    }else{ */
    //   if(p !=0){
      lineChart[p].draw(c0, c2-c3, c1, c3);  //old values: 270, 80, 400, 400

  //  }else{
      
   // }
 }
 }  // end of for int p loop
  axes();
}
//}
void setLimits(XYChart thing) {
  if(zoomed == false){
  thing.setMaxX(chartXMax);
  thing.setMaxY(chartYMax);
  thing.setMinX(chartXMin);
  thing.setMinY(chartYMin);
  }
  else{
  thing.setMaxX(zoomXMax);
  thing.setMaxY(zoomYMax);
  thing.setMinX(zoomXMin);
  thing.setMinY(zoomYMin);
  }
}


void firstChartSetup(){
  fill(#EADFC9);               // background color
  int chartPosX = 200;        // position of background rectangle
  int chartPosY = 70;
  int chartSzX = 475;         // size of background rectangle
  int chartSzY = 450;
  translate(chartPosX, chartPosY);
  //  rect(200, 70, 475, 450);    // chart background 
  rect(0, 0, chartSzX, chartSzY);    // chart background 
  fill(0, 0, 0);
  int posX = 20; //220;  // x position for center of y axis
  int posY = chartSzY/2; //260;  // y position for center of y axis
  translate(posX, posY);
  rotate(3.14159*3/2);
  textAlign(CENTER);
  text("Current  (microamps)", 0, 0);
  rotate(3.14159/2);        // return orientation and location
  translate(-posX, -posY);
  translate(-chartPosX, -chartPosY);  

  if (chartMode==4) { 
    xChartLabel = "Time (milliseconds)";
  } else {
    xChartLabel = "Voltage (mV)";
  }

  posX = 475;
  posY = 515;
  translate(posX, posY);
  textAlign(CENTER);
  text(xChartLabel, 0, 0);
  translate(-posX, -posY); 
}
  ///////////////// end of chart setup //////////////////
  
  void displayLines(){
   
    float[][] xFit = {{chartXMin,xVal[selVal][points[0]],xVal[selVal][points[1]], chartXMax},{x_peak, x_peak}};
    float[][] yFit = {{y_zero, yVal[selVal][points[0]],iCalcAtPeak, y_end} ,{iCalcAtPeak, y_peak}};


    for(int j = 0; j<2; j++){
     setLimits(fitChart[j]);
     fitChart[j].setData(xFit[j],yFit[j]);
    fitChart[j].draw(c0, c2-c3, c1, c3);
    }
  }
  
  void axes(){
    int deltaX;
    int deltaY;
    if(zoomed == false){
    deltaX = int(chartXMax - chartXMin);  // total chart width
    deltaY = int(chartYMax - chartYMin);  // total chart height
    }else{
    deltaX = int(zoomXMax - zoomXMin);  // total chart width
    deltaY = int(zoomYMax - zoomYMin);  // total chart height
    }
    int ticksX;                           // number of ticks
    int ticksY = 5;
    int diffX = 2;                            // mV between ticks
    float diffY = 4;
    int[] compX = {1000,500,200,100,50,20,0};
    int[] deX   = {100,50,20,10,5,2};
    float[] compY = {100,50,20,10,5,2,1,.5,.1};
    float[] deY = {20,10,5,2,1,.5,.2,.1};
    for (int r = 0; r<8; r++){
      if(deltaY > 100){
      diffY = 20;
    }
      if(deltaY >= compY[r+1] && deltaY < compY[r]){
       diffY = deY[r]; 
      }
    }
    for (int j = 0; j<6; j++){
      if(deltaX > 1000){
        diffX = 200;
      }
    if(deltaX > compX[j+1] && deltaX <= compX[j]){
      diffX = deX[j];    
      
    }
  }
//   println("diffX = "+diffX);
   int xInit = 285;
   int xTotal = 400;
   int yTotal = 400;
   int yInit = 490;
          ticksX = deltaX/diffX+1;
          ticksY = int(deltaY/diffY)+1;
          for (int p = 0; p<ticksX; p++){
            int xValue = p*diffX + int(chartXMin);
            int xPos = p*xTotal/ticksX + xInit;
          fill(0);
          stroke(0);
          text( xValue,xPos,yInit);
          line(xPos,yInit-30,xPos,yInit-20);
           fill(255);
           stroke(255);
          }
    pushMatrix();
    translate(xInit-40,yInit-50);
    rotate(3*PI/2);
    for (int e = 0; e<ticksY; e++){
      float yValue = e*diffY + chartYMin;
      int yPos = e*yTotal/ticksY; // + yInit;
      fill(0);
      stroke(0);
      text(yValue,yPos,0);
      line(yPos,+30,yPos,+20);
      fill(255);
      stroke(255);
    }
    popMatrix();
          
  }