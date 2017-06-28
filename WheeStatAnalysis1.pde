//  User interface for WheeStat data analysis

import org.gicentre.utils.stat.*;    // For chart classes.
import controlP5.*;
import processing.serial.*;
import java.io.*;                        // this is needed for BufferedWriter
import java.util.*;


//////// classes ///////////
ControlP5 cp5, cp5b, cp5c;
XYChart[] lineChart = new XYChart[10];
XYChart[] fitChart = new XYChart[2];
Button loadFile, saveFile, runButton, savRun, setA, setB, setC, read, reCalc, pause, readPh;
Slider slider0;
PFont font18, font16, font14, font12;

int[] red = {  255, 0, 0, 85, 0, 170, 0, 170, 85, 85}; //color parameters for data
int[] green = {  0, 0, 255, 0, 85, 85, 170, 0, 170, 85};
int[] blue = {  0, 255, 0, 170, 170, 0, 85, 85, 0, 85};

ArrayList xDataL = new ArrayList();
ArrayList yDataL = new ArrayList();
float[][] xRecover = new float[10][0];  
float[][] yRecover = new float[10][0];
float[][] xVal = new float[10][0];  
float[][] yVal = new float[10][0];
String[] sFileName = new String[10];
int runCount = 0;  // experiment count
String[] headers;
int voltams = 0;  // number of voltammagrams

boolean[] showChart = new boolean[10];
boolean[] hideChart = new boolean[10];
//boolean[] selectBox = new boolean[10];
//boolean zoomed = false;
float chartXMax;
float chartXMin;
float chartYMax;
float chartYMin;
float zoomXMax;
float zoomXMin;
float zoomYMax;
float zoomYMin;
boolean firstChart = true;
int c0= 265;
int c1= 400;
int c2 = 466;
int c3 = 382;

int[] xZoom = {c0,c0+c1,200,400};
int[] yZoom = {c2,c2-c3,100,400};
 int[] xZoomLim = {270,670,270,670};
 int[] yZoomLim = {473,75,473,75};
 int[] xBox = {270,670};
 int[] yBox = {473,75};
 float[] fBox = {1.0,1.0,1.0,1.0};
 boolean zoomed = false;
 float[] oldChartLim = {0,1,0,1};


String[] file1 = new String[0];
boolean[] selectBox = {false,false,false,false,false,false,false,false,false,false};
int chartMode;  // 0 is ramp, 1 is cv, 2 is diff pulse, 3 is cyclic pulse, 4 is CA
String xChartLabel;
String yChartLabel;
int bkgnd = #5E7B89;
  int deltaY = 20;
  int yOff = 100;
  int xOff = 50;
int sel = #E59615;
int selVal = 0;     // which voltammagram to process
String selTxt = "None selected";
float[] linearX = {0,0,0};      // positions for model
float[] linearY = {0,0,0};
boolean selected =false;
boolean mouse0 = false;  // is box zero being dragged?
boolean[] peakSel = new boolean[10];
boolean errorFlag;
String errorTxt;
int[] points = {0,0};  // indices for baseline and peak points
float fract;  // output from slider
    float slope;   // slope and intercept for baseline
    float interc;
    boolean displayFlag = false;
  float x_base;   // baseline x and y values
  float y_base;
  float x_peak;   // peak x and y values
  float y_peak;
  float x_end; 
    float y_end;     // y values for baseline at two ends of chart
    float y_zero;
    float iPeak;
    boolean currentTxt = false;
    float iCalcAtPeak;   // calculated value of baseline at peak voltage
    
void setup(){
    size(900, 550); 
    font18 = createFont("ArialMT-48.vlw",18);
    font16 = createFont("ArialMT-48.vlw",16);
  setupZoom();    // in mouse tab
//    chartsSetup();
    setupButtons();
    setupProcess();
    for(int o = 0; o<10; o++){
     peakSel[o] = false; 
    }
    
    
}

void draw(){
  background(bkgnd);
  textFont(font16);
    text(selTxt,140,80);
  if(voltams!=0){
  chartsSetup();
  displayCharts();

  for(int u = 0; u<voltams; u++){
    if(selectBox[u] == true){
      fill(sel);
    } else{
      fill(0);
    }
  text(sFileName[u],xOff,u*deltaY+yOff);
  
  }
    if(zoomed == false){
    stroke(0);
  line(xZoom[0],yZoom[0],xZoom[0],yZoom[1]);
  line(xZoom[0],yZoom[0],xZoom[1],yZoom[0]);
  line(xZoom[1],yZoom[1],xZoom[1],yZoom[0]);
  line(xZoom[1],yZoom[1],xZoom[0],yZoom[1]);
  
  noFill();
  rectMode(CENTER);
  rect(xZoom[0],yZoom[0],10,-10);
  fill(229,120,21,100);              // semi-transparent yellow box
  
  rect(xZoom[1],yZoom[1],-10,10);
  fill(255);
  rectMode(CORNER);
  stroke(255);
  }

  //////// end of zoom box
  }
  if(errorFlag == true){
      text(errorTxt,800,110);
    }
    if(currentTxt == true){
     text("Peak current: ",800,160);
     text(iPeak+" microAmps",800,185);
    }
}
  
  