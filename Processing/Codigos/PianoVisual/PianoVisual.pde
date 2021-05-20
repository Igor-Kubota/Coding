import arb.soundcipher.*;
import arb.soundcipher.constants.*;
char[] keys = {'q','2','w','3','e','r','5','t','6','y','7','u','i','9','o','0','p'};
int[] black_key_indexes = {1,3,6,8,10,13,15}; 
int[] white_key_indexes = {0,2,4,5,7,9,11,12,14,16}; 
int[] highlightFrames = new int[keys.length];

SoundCipher sc;
void setup() {
  background(0);
  size(800,600);
  sc = new SoundCipher(this);
}

void draw() {
    int w_index = 0; 
    int b_index = 0; 
    for(int i = 0; i < 10; i++) {
        int white_i = white_key_indexes[w_index];
        fill(255); 
        if(highlightFrames[white_i] > 0){
          highlightFrames[white_i]-= 30;
          fill(23,133,23); 
        }
        rect(55+i*70,120,60,400);
        w_index++;
        if(i == 1 || i == 2 || i == 4 || i == 5 || i == 6 || i == 8 || i == 9){  
          //convert to index in array 
         int black_i =  black_key_indexes[b_index];
         fill(0); 
         if(highlightFrames[black_i] > 0){
            highlightFrames[black_i]-= 30;
            fill(23,133,23); 
        }
         rect(55+i*70-20,120,30,320);
         b_index++; 
        }
    }
}
void keyPressed() {
  int k = (int)((char)key), index = -1;
  for(int i = 0; i < keys.length; i++) {
    int curKey = (int)keys[i];
    if(curKey == k) {
      sc.playNote(i + 60, 100, 0.5);
      highlightFrames[i] = 300; 
    }
  }
}
