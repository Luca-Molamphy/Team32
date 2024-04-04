class Screen {
  ArrayList screenWidgets;
 
  Screen() {
    screenWidgets=new ArrayList();
  }

  void add(Widget w) {
    screenWidgets.add(w);
  }

  void refresh() {
    for (int i = 0; i < screenWidgets.size(); i++) {
      Widget aWidget = (Widget) screenWidgets.get(i);
      aWidget.mouseNotOver();
    }
  }

  void draw() {
    for (int i = 0; i<screenWidgets.size(); i++) {
      Widget aWidget = (Widget)screenWidgets.get(i);
      aWidget.draw();
    }
  }

  void mouseMoved(int mouseX, int mouseY) {
    int event;
    for (int i = 0; i < screenWidgets.size(); i++) {
      Widget aWidget = (Widget) screenWidgets.get(i);
      event = aWidget.getEvent(mouseX, mouseY);
      if (event != EVENT_NULL) {
        aWidget.mouseOver();
      } else
        aWidget.mouseNotOver();
    }
  }

  int mousePressed(int mouseX, int mouseY) {
    return getEvent(mouseX, mouseY);
  }

  int getEvent(int mx, int my) {
    for (int i = 0; i < screenWidgets.size(); i++) {
      Widget aWidget = (Widget) screenWidgets.get(i);
      int event = aWidget.getEvent(mx, my);
      if (event != EVENT_NULL) {
        return event;
      }
    }
    return EVENT_NULL;
  }
  void filter() {
  }
  void mouseWheel(MouseEvent event) {
  }
}
