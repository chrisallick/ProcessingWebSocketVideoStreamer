/*
	Simple WebSocketServer Example
	http://github.com/muthesius/WebSocketP5
 */

import muthesius.net.*;
import org.webbitserver.*;

WebSocketP5 socket;

void setup() {
  socket = new WebSocketP5( this, 8080 );
}

void draw() {}

void stop(){
	socket.stop();
}

void mousePressed(){
  socket.broadcast("hello from processing!");
}

void websocketOnMessage(WebSocketConnection con, String msg){
	println(msg);
}

void websocketOnOpen(WebSocketConnection con){
  println("A client joined");
}

void websocketOnClosed(WebSocketConnection con){
  println("A client left");
}
