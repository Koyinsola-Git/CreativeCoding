int COLUMNS = 4;
int SIZE = 60;
int MAXRANDOMOFFSET = 7;
GraphNode[] nodes;
int maxTrains = -1000000000;
int minTrains = 1000000000;


DataRecord[] readRecords(String filename){
  String[] lines = loadStrings(filename);
  ArrayList<DataRecord> data = new ArrayList();
  for(String line:lines){
    String[] columns = line.split(",");
    if(columns.length >= 3){
      Date date = null;
      Status status = Status.Bad;
      int numberOfTrains = 0;
      for(int i =0;i<columns.length;i++){
        String column = columns[i].trim();
        if(!column.isEmpty()){
          if(i==0){
            if(column.length() != 6){
              println("Invalid date");
              return null;
            }
            String dayTxt = "";
            String monthTxt = "";
            String yearTxt = "";
            dayTxt = column.substring(0,2);
            monthTxt = column.substring(2,4);
            yearTxt = column.substring(4,6);
            try{
              int day = Integer.parseInt(dayTxt);
              int month = Integer.parseInt(monthTxt);
              int year = Integer.parseInt(yearTxt);
              date = new Date(day,month,year);
            }
            catch(NumberFormatException e){
              
              println("Invalid date "+dayTxt+"-"+monthTxt+"-"+yearTxt);
              return null;
            }
          }
          //Service Status
          if(i == 1){
            switch(column){
              case "G":
                status = Status.Good;
                break;
               case "M":
                 status = Status.Mid;
                 break;
               case "B":
                 status = Status.Bad;
                 break;
                default:
                 println("Bad status '"+column+"'.");
                 return null;
            }
          }
          
          if(i==2){
            boolean isValid = true;
            try {
              numberOfTrains = Integer.parseInt(column);
              if(numberOfTrains<0){
                isValid = false;
              }
            }
            catch(NumberFormatException e){
              isValid = false;
            }
            if(!isValid){
              println("Invalid number of trains");
              return null;
            }
            
          }
        }
      }
      maxTrains = max(numberOfTrains,maxTrains);
      minTrains = min(numberOfTrains,minTrains);
      DataRecord record = new DataRecord(date,status,numberOfTrains);
      data.add(record);
    }
  }
  DataRecord[] dataRecords = new DataRecord[data.size()];
  data.toArray(dataRecords);
  
  return dataRecords;
}
void setup(){
  size(400,400);
  textAlign(CENTER);
  DataRecord[] trainData = readRecords("TrainData.txt");
  if(trainData == null){
     trainData = new DataRecord[0];
  }
  nodes = new GraphNode[trainData.length];
  for(int i =0;i<trainData.length;i++){
    nodes[i] = new GraphNode(trainData[i]);
  }
  frameRate(60);
}
PVector getNodePosition(int i){
  
    int x = i % COLUMNS;
    int y = i/COLUMNS;
    
    int xPos = int(x *SIZE*1.5)+SIZE;
    int yPos = int(y*SIZE*1.5)+SIZE;
    return new PVector(xPos,yPos);
}

void drawNodes(){
  for(int i = 0;i<nodes.length;i++){
    GraphNode node = nodes[i];
    PVector currentPos = getNodePosition(i);
    float sizeScale = map(node.getData().getTrains(),minTrains,maxTrains,0.6,1);
    float size = SIZE * sizeScale;
    
    boolean isHovered = isMouseInRadius(currentPos.x,currentPos.y,size/2);
    if(isHovered){
      node.hoverFrameCount += 1;
    }
    else{
      node.hoverFrameCount = 0;
    }
    drawNode(node,(int)currentPos.x,(int)currentPos.y,size,isHovered);
    
  }

}
void drawRecordConnections(){
  stroke(5);
  for(int i =1 ;i<nodes.length;i++){
    if(nodes[i].getData().getDate().getMonth() == nodes[i-1].getData().getDate().getMonth()){
      PVector currentPos = getNodePosition(i);
        PVector oldPos = getNodePosition(i-1);
        line(oldPos.x,oldPos.y,currentPos.x,currentPos.y);
    }
  }
}
void draw(){
  randomSeed(10);
  background(127);
  drawRecordConnections();
  drawNodes();
}
color getStatusColor(Status status){
    color c;
    switch(status){
       case Good:
         c = color(0,200,0);
         break;
       case Bad:
         c = color(0,200,0);
         break;
       case Mid:
         c = color(255,102,0);
         break;
       default:
         c = color(200,0,200);
         break;
    }
    return c;
}

boolean isMouseInRadius(float xPos,float yPos,float radius){
  return (mouseX-xPos)*(mouseX-xPos) + (mouseY-yPos)*(mouseY-yPos)<=radius*radius;
}


void drawNode(GraphNode node,int xPos,int yPos,float size,boolean isHovered){
    noStroke();
    color c = getStatusColor(node.getData().getStatus());
    if(isHovered){
      float p = min(1.0,node.hoverFrameCount/15.0);
      fill(lerpColor(c,color(255),p*0.9));
      p = 3*p*p - 2*p*p*p;
      circle(xPos,yPos,size*(1.0+p*0.2));
      fill(0);
      text(node.getData().getDate().getFormatted(),xPos,yPos);
      text(node.getData().getTrains()+"",xPos,yPos+15);
      
    }
    else{
      fill(c);
      circle(xPos,yPos,size);
    }
}
