//file braker
//atention: this will corrupt the file

import drop.*;
import java.io.File;
import controlP5.*;

ControlP5 cp5;
SDrop drop;
int loadState;
byte[] in;
byte[] out;
String filename = "out.bin";
File path;
PImage background;
String message = "";
int selected = -1;

void setup() {
  size(400, 400);
  cp5 = new ControlP5(this);
  ButtonBar b = cp5.addButtonBar("bar")
     .setPosition(0, 20)
     .setSize(400, 20)
     .addItems(split("easy medium bad"," "));
  b.onMove(new CallbackListener(){
    public void controlEvent(CallbackEvent ev) {
      ButtonBar bar = (ButtonBar)ev.getController();
    }
  });
  drop = new SDrop(this);
  background = loadImage("space.jpg");
  background.resize(0, height);
  imageMode(CENTER);
  textSize(12);
  textAlign(CENTER, CENTER);
}

void bar(int n) {
  selected = n;
}

void draw() {
  stroke(255);
  image(background, width/2, height/2);
  textSize(12);
  switch (selected) {
    case -1:
      text("Select corruption mode", width/2, 10);
      break;
    case 0:
      text("S͡e̕l͞ect corr͝u̵p̶tioņ m͡oe", width/2, 10);
      break;
    case 1:
      text("Sͦe͌̒̀e͐̒̄c̒̏͒͝l̃̃̐̅҉e̐c̒̐ͫ̈́̽̆ ͟m̍̾pt̨̐oḋ̽̃͗͊eͯ̐", width/2, 10);
      break;
    case 2:
      text("S̝̞̬̝̬̆e͚͕͔͔̙̣̓le̓ͭ̉ͮc̝̝͖̉ͧ̿̓̆͌̒t ̺̰̭̬͓͊̿̑̀ͫc͉̙̖̣̉͗ͥ͗̉̀͂o̤̫͇͕̣̱̮̎ͥ̈́ͫ̄̑̊r̙̣̗͖͌ͤ̿ͭͅr̩̗̼͈̥̐ͩ͐ͣ̑̾ũ̙͉̤̙̗̙̈́p̮͍̲̜͈̥̿ͅt͚̟͈̠̗i̝̘̰͙̠̪ͦ͂õ͆̃̏n̘̬̬͖̗̼͙̋̐͗̔̎̀́ ̩̙̞̯͚͙͆ͪ͐͒m͖̖͓̽o͙̘̦̘̰͉̪͑ͦ̓ͯ̍d̙͚̅̅̏͊͒̋̀e͓̼͗͆̌̿̊̚", width/2, 10);
      break;
  }
  textSize(16);
  text("Drop file in window to fuck up", width/2, 55);
  textSize(12);
  text(message, width/2, 70);
}

void dropEvent(DropEvent theDropEvent) {
  if (theDropEvent.isFile()) {
    println("file dropped in window");
    if (selected < 0) {
      message = "No corruption mode selected";
      return;
    }
    message = "corrupting ...";
    path = theDropEvent.file();
    in = loadBytes(theDropEvent.file());
    out = new byte[in.length];
    float fuplevel;
    switch (selected) {
      case 0:
        fuplevel = 0.92;
        break;
      case 1:
        fuplevel = 0.6;
        break;
      case 2:
        fuplevel = 0.3;
        break;
      default:
        fuplevel = 0.92;
        break;
    }
    
    for (int i = 0; i < in.length; i++) {
      float level = random(0,1);
      if (level < fuplevel) {
        out[i] = in[i];
      } else {
        byte num = byte(floor(map(random(0,1), 0, 1, -127, 127)));
        out[i] = num;
      }
    }
    println("fucked up");
    String p = path.getAbsolutePath().substring(0, path.getAbsolutePath().lastIndexOf("\\")+1);
    p = p + filename;
    println(p);
    saveBytes(p, out);
    println("saved");
    message = "fucked up";
  } else {
    message = "Not a file";
  }
}
