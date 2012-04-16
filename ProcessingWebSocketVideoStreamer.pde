import processing.video.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import javax.imageio.ImageIO;

import muthesius.net.*;
import org.webbitserver.*;
import jcifs.util.Base64;

WebSocketP5 socket;
Capture myCapture;

void setup() {
	size( 320, 240 );
	socket = new WebSocketP5( this, 8080 );
	myCapture = new Capture( this, width, height, 30 );
}

byte[] int2byte(int[]src) {
	int srcLength = src.length;
	byte[]dst = new byte[srcLength << 2];
    
	for (int i=0; i<srcLength; i++) {
		int x = src[i];
		int j = i << 2;
		dst[j++] = (byte) (( x >>> 0 ) & 0xff);           
		dst[j++] = (byte) (( x >>> 8 ) & 0xff);
		dst[j++] = (byte) (( x >>> 16 ) & 0xff);
		dst[j++] = (byte) (( x >>> 24 ) & 0xff);
	}
	return dst;
}

void captureEvent(Capture myCapture) {
	myCapture.read();

	BufferedImage buffimg = new BufferedImage( width, height, BufferedImage.TYPE_INT_RGB);
	buffimg.setRGB( 0, 0, width, height, myCapture.pixels, 0, width );
  
	ByteArrayOutputStream baos = new ByteArrayOutputStream();
	try {
    	ImageIO.write( buffimg, "jpg", baos );
  	} catch( IOException ioe ) {
	}
  
	String b64image = Base64.encode( baos.toByteArray() );
	socket.broadcast( b64image );
}

void draw() {
	image(myCapture, 0, 0);
}

void stop(){
	socket.stop();
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