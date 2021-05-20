import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.signals.*;
import arb.soundcipher.*;
import arb.soundcipher.constants.*;


Minim minim;
AudioOutput out;

char[] keys = {'q','2','w','3','e','r','5','t','6','y','7','u','i','9','o','0','p'};
int[] black_key_indexes = {1,3,6,8,10,13,15}; 
int[] white_key_indexes = {0,2,4,5,7,9,11,12,14,16}; 
int[] highlightFrames = new int[keys.length];
SoundCipher sc;

void setup(){
  background(0);
  size(800,600);
  minim = new Minim(this);
  sc = new SoundCipher(this);

  out = minim.getLineOut(Minim.STEREO);

}

void draw(){
 
 background(0);
 stroke(255);
 for(int i = 0; i < out.bufferSize() - 1; i++){
 float x1 = map(i, 0 , out.bufferSize(), 0, width);
 float x2 = map(i+1, 0 , out.bufferSize(), 0, width);  
 line(x1, 50 + out.left.get(i)*50, x2, 50 + out.right.get(i+1)*50);
 //line(x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
 }
  int w_index = 0; 
    int b_index = 0; 
    for(int j = 0; j < 10; j++) {
        int white_j = white_key_indexes[w_index];
        fill(255); 
        if(highlightFrames[white_j] > 0){
          highlightFrames[white_j]-= 30;
          fill(23,133,23); 
        }
        rect(55+j*70,120,60,400);
        w_index++;
        if(j == 1 || j == 2 || j == 4 || j == 5 || j == 6 || j == 8 || j == 9){  
          //convert to index in array 
         int black_i =  black_key_indexes[b_index];
         fill(0); 
         if(highlightFrames[black_i] > 0){
            highlightFrames[black_i]-= 30;
            fill(23,133,23); 
        }
         rect(55+j*70-20,120,30,320);
         b_index++; 
        }
    }
 
 
}

void keyPressed(){
 
  SineWave mySine;
  KSNote newNote; 
  
  float pitch = 0;
  
  switch(key){
    case 'q': pitch = 262; break;
    case '2': pitch = 277; break;
    case 'w': pitch = 294; break;
    case '3': pitch = 311; break;
    case 'e': pitch = 330; break;
    case 'r': pitch = 349; break;
    case '5': pitch = 370; break;
    case 't': pitch = 392; break;
    case '6': pitch = 415; break;
    case 'y': pitch = 440; break;
    case '7': pitch = 466; break;
    case 'u': pitch = 494; break;
    case 'i': pitch = 523; break;
    case '9': pitch = 554; break;
    case 'o': pitch = 587; break;
    case '0': pitch = 622; break;
    case 'p': pitch = 659; break;
  }
  
  if(pitch > 0){
    newNote = new KSNote(pitch, 0.2);
  }
    int k = (int)((char)key), index = -1;
  for(int i = 0; i < keys.length; i++) {
    int curKey = (int)keys[i];
    if(curKey == k) {
      sc.playNote(i + 60, 100, 0.5);
      highlightFrames[i] = 300; 
    }
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

         
    
    
  
  
  
  
  
