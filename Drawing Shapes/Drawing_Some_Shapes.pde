void setup() {
  size(500, 500);
}

void draw() {
  background(255);
  int house_height = 100;
  int house_width = 120;
  int top_of_house = 200;
  int bottom_of_house = top_of_house + house_height;
  int house_center_x = width/2;
  int house_left = house_center_x - house_width/2;
  int house_right = house_center_x + house_width/2;
  
  int door_width = 30;
  int door_height = 60;
  //Draw the field
  noStroke();
  fill(0,127,0);
  rect(0,210,width,height - 210);
  
  stroke(1);
  //Draw roof
  fill(255, 0, 0);
  triangle(house_left, top_of_house, (house_left+house_right)/2, top_of_house - 50, house_right, top_of_house);
  
  //Draw actual house
  fill(127, 80, 0);
  rect(house_left, top_of_house, house_width, house_height);
  
  //Draw door
  fill(230, 120, 0);
  rect(house_right - door_width - 10, bottom_of_house - door_height,door_width,door_height);
  
  //Draw door handle
  fill(120,120,0);
  circle(house_right - door_width + 10,bottom_of_house - 30,10);
  
  
  
}
