class barGraphScreen extends Screen {
 // origin, distance, date
 PImage bargraphBg;
 
 barGraphScreen() {
   bargraphBg = loadImage("barchart-bg.jpg");
   add(new Widget(800, 58, 80, 40, "Return", stdFont, EVENT_RETURN));
   add(new Widget(200, 250, 120, 40, "Date Range", stdFont, EVENT_RETURN));
   add(new Widget(400, 250, 150, 40, "Distance Range", stdFont, EVENT_RETURN));
   add(new Widget(600, 250, 150, 40, "Popular Origin", stdFont, EVENT_RETURN));
 }
 
 void draw() {
  background(bargraphBg);
  textSize(64);
  text("Select filter for barchart:", 450, 150);
   
   
   super.draw();
 }
}
