import processing.core.*; 
import processing.xml.*; 

import ddf.minim.analysis.*; 
import ddf.minim.*; 
import ddf.minim.signals.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class SinePiano extends PApplet {




 
Minim minim;
AudioOutput out;

public void setup()
{
  size(512, 200, P3D);
 
  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO);
}
 
public void draw()
{
  background(0);
  stroke(255);
  for(int i = 0; i < out.bufferSize() - 1; i++)
  {
    float x1 = map(i, 0, out.bufferSize(), 0, width);
    float x2 = map(i+1, 0, out.bufferSize(), 0, width);
    line(x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
    line(x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
  }
}
 
public void keyPressed()
{
  SineWave mySine;
  MyNote newNote;

  float pitch = 0;
  switch(key) {
    case 'z': pitch = 262; break;
    case 's': pitch = 277; break;
    case 'x': pitch = 294; break;
    case 'd': pitch = 311; break;
    case 'c': pitch = 330; break;
    case 'v': pitch = 349; break;
    case 'g': pitch = 370; break;
    case 'b': pitch = 392; break;
    case 'h': pitch = 415; break;
    case 'n': pitch = 440; break;
    case 'j': pitch = 466; break;
    case 'm': pitch = 494; break;
    case ',': pitch = 523; break;
    case 'l': pitch = 554; break;
    case '.': pitch = 587; break;
    case ';': pitch = 622; break;
    case '/': pitch = 659; break;
  }
  
   if (pitch > 0) {
      newNote = new MyNote(pitch, 0.2f);
   }
}

public void stop()
{
  out.close();
  minim.stop();
 
  super.stop();
}

class MyNote implements AudioSignal
{
     private float freq;
     private float level;
     private float alph;
     private SineWave sine;
     
     MyNote(float pitch, float amplitude)
     {
         freq = pitch;
         level = amplitude;
         sine = new SineWave(freq, level, out.sampleRate());
         alph = 0.9f;
         out.addSignal(this);
     }

     public void updateLevel()
     {
         level = level * alph;
         sine.setAmp(level);
         
         if (level < 0.01f) {
             out.removeSignal(this);
         }
     }
     
     public void generate(float [] samp)
     {
         sine.generate(samp);
         updateLevel();
     }
     
    public void generate(float [] sampL, float [] sampR)
    {
        sine.generate(sampL, sampR);
        updateLevel();
    }

}





  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#F0F0F0", "SinePiano" });
  }
}
