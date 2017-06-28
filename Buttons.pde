void setupButtons() {
    PImage[] run_imgs = {loadImage("run_button1.png"),loadImage("run_button2.png"),loadImage("run_button3.png")};
    PImage[] stop_imgs = {loadImage("stop_button1.png"),loadImage("stop_button2.png"),loadImage("stop_button3.png")};
    PImage[] togs = {loadImage("tog_button1.png"),loadImage("tog_button2.png"),loadImage("tog_button3.png")};
 cp5 = new ControlP5(this);  
 
    loadFile = cp5.addButton("loadFile")
     .setPosition(20,20)
     .setSize(60,20)
                       .setLabel("Load File")
//    .setImages(run_imgs)
   ;
    saveFile = cp5.addButton("SaveFile")
     .setPosition(120,20)
     .setSize(60,20)
//    .setImages(run_imgs)
   ;
   
}

void loadFile(){
     selectInput("Select a data file:", "fileToLoad");
}

void fileToLoad(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
     xVal = new float[10][0];  
     yVal = new float[10][0];
    String[] file2str = loadStrings(selection.getAbsolutePath());
    headers = split(file2str[0],',');  // split the first line
    println(headers[0]);
    String[] sText = split(file2str[1],','); 
    voltams = sText.length/2-1;
    println("number of voltammagrams: "+voltams);
    for (int p = 0; p< voltams; p++){
     sFileName[p] = sText[2*p+1];
     println("File name "+p+": "+sFileName[p]);
    }
    int points = file2str.length;
 //   println("buttons 40");
    for (int j = 0; j<points-4; j++){  // j-4 due to ,,, at end of data
       println(file2str[j+3]);
       String[] tokens = split(file2str[j+3],',');
/*       println("tokens split");
       println("number of tokens; "+tokens.length);
       println("voltammagrams: "+voltams);
       println("tokens[0]: "+tokens[0]);*/
         for(int m = 0; m<voltams; m++){
           int x = 2*m;
           int y = x+1;
           if(tokens[x] == null){
             println("empty thing");
           }
           else{
      xVal[m] = append(xVal[m],Float.parseFloat(tokens[x]));
           }
           if (tokens[y] == null){           
             println("empty thing");
           }
           else{
      yVal[m] = append(yVal[m],float(tokens[y])); 
           }
       print("voltammagram "+sFileName[m]);
       print(", x points: "+xVal[m].length);
       println(", y points: "+yVal[m].length);
      }  
 //     println("");
 /*     for(int p = 0; p<points-3; p++){
       println(xVal[0][p]); 
      }*/
    }
 //   String[] tokens2 = split(file2str[4],',');
  //  strDia = tokens2[1];
  }
//  setupTxtFields();
//  reCalc();
for (int i=0; i<voltams; i++){
  selectBox[i] = true;
}
}