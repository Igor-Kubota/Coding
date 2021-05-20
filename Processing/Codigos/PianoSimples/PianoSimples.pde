import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.signals.*;

Minim minim;
AudioOutput out;

void setup(){
  size(512,200,P3D);

  minim = new Minim(this);
  
  out = minim.getLineOut(Minim.STEREO);

}

void draw(){
 background(0);
 stroke(255);
 for(int i = 0; i < out.bufferSize() - 1; i++){
 float x1 = map(i, 0 , out.bufferSize(), 0, width);
 float x2 = map(i+1, 0 , out.bufferSize(), 0, width);  
 line(x1, 50 + out.left.get(i)*50, x2, 50 + out.right.get(i+1)*50);
 line(x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
 
 } 
}

void keyPressed(){
 
  SineWave mySine;
  KSNote newNote; 
  
  float pitch = 0;
  
  switch(key){
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
  
  if(pitch > 0){
    newNote = new KSNote(pitch, 0.2);
  }
}


void stop(){
  out.close();
  minim.stop();
  
  super.stop();
  
}


class KSNote implements AudioSignal{
  private float freq;
  private float level;
  private float alph;
  private float[] buffer;
  private int length;
  private int pointer;
  private float elapsed;
  private int average_halfwin = 2;
  private float max_duration = 5.0;
  
  KSNote(float pitch, float amplitude){
      freq = pitch;
      level = amplitude;
    
    
     length = Math.round(out.sampleRate()/pitch);
     buffer = new float[length];
     float sum = 0;
     for(int i = 0; i<length; i++){
       buffer[i] = level*((float)Math.random()-0.5);
       sum += buffer[i];
     }
       sum = sum/length;
     for(int i =0; i<length; i++){
       buffer[i] -= sum;
     }
   
       pointer = 0;
   
       elapsed = 0;
   
       out.addSignal(this);
     }
   
   void generate(float [] samp){
     
     for(int i = 0; i < samp.length; i++){
       float newval = 0;
       samp[i] = buffer[pointer];
       
       for (int j = -average_halfwin; j<= average_halfwin; j++){
         newval = newval + buffer[(pointer+j+length) % length];
       }
       newval = newval/(2*average_halfwin + 1);
       buffer[pointer] = newval;
       
       pointer = (pointer + 1)% length;
     }
     
     elapsed += samp.length/out.sampleRate();
     if (elapsed > max_duration){
       out.removeSignal(this);
     }
   }
   
   
   void generate(float [] sampL, float [] sampR){
     generate(sampL);
     
     System.arraycopy(sampL,0 ,sampR,0,sampR.length);
   }
}

         
    
    
  
  
  
  
  
