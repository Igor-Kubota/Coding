void setup(){
  size(600,480);

}

void draw(){
  if (mousePressed){
  fill(125);
  }
  else{
    fill(255);
  }
  ellipse(mouseX, mouseY, 80,80);
}
