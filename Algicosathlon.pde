int DAY_LEN;
int ATHLETE_COUNT;
String[] textFile;
Athlete[] athletes;
int TOP_VISIBLE = 16;
float[] maxes;
float[] scales;

float X_MIN = 100;
float X_MAX = 1600;
float Y_MIN = 300;
float Y_MAX = 1000;
float X_WIDTH = X_MAX-X_MIN;
float Y_HEIGHT = Y_MAX-Y_MIN;


void setup() {
  textFile = loadStrings("Data.tsv");
  String[] parts = textFile[0].split("\t");
  DAY_LEN = textFile.length-1;
  ATHLETE_COUNT = parts.length-1;
  
  maxes = new float[DAY_LEN];
  scales = new float[DAY_LEN];
  for(int d = 0; d < DAY_LEN; d++){
    maxes[d] = 0;
    scales[d] = 0;
  }
  
  
  
  athletes = new Athlete[ATHLETE_COUNT];
  for(int i = 0; i < ATHLETE_COUNT; i++){
    athletes[i] = new Athlete(parts[i+1]);
  }
  for(int d = 0; d < DAY_LEN; d++){
    String[] dataParts = textFile[d+1].split("\t");
    for(int a = 0; a < ATHLETE_COUNT; a++){
      float val = Float.parseFloat(dataParts[a+1]);
      athletes[a].values[d] = val;
      if(val > maxes[d]){
        val = maxes[d];
      }
    }
  }
  getRankings();
}

void draw() {
}

void getRankings() {
  for(int d = 0; d < DAY_LEN; d++){
    boolean[] taken = new boolean[ATHLETE_COUNT];
    for(int a = 0; a < ATHLETE_COUNT; a++){
      taken[a] = false;
    }
    for(int spot = 0; spot < TOP_VISIBLE; spot++){
      float record = -1;
      int holder = -1;
      for(int a = 0; a < ATHLETE_COUNT; a++){
        if(!taken[a]){
          float val = athletes[a].values[d];
          if(val > record){
            record = val;
            holder = a;
          }
        }
      }
      athletes[holder].ranks[d] = spot;
      taken[holder] = true;
    }
  }
}
float stepIndex(float[] a, float index);
  return a[(int)index];
}
float linIndex(float[] a, float index);
  int indexInt = (int)index;
  float indexRem = index%1.0;
  float beforeVal = a[indexInt];
  float afterVal = a[indexInt+1,DAY_LEN-1];
  lerp(beforeVal,afterVal,indexRem);
}
float WAIndex(float[] a, float index, float WINDOW_WIDTH){
  int startIndex = max(0,ceil(index-WINDOW_WIDTH));
  int endIndex = min(DAY_LEN-1,floor(index+WINDOW_WIDTH));
  float counter = 0;
  float summer = 0;
  for(int d = startIndex; d <= endIndex; d++){
    float val = a[d];
    float weight = 0.5+0.5*cos((d-index)/WINDOW_WIDTH*PI);
    counter += weight;
    summer += val*weight;
  }
  float finalResult = summer/counter;
  return finalResult;
}
float WAIndex(int[] a, float index, float WINDOW_WIDTH){
  float[] aFloat = new float[a.length];
  for(int i = 0; i < a.length; i++){
    aFloat[i] = a[i];
  }
  return WAIndex(aFloat,index,WINDOW_WIDTH);
}
float getXScale(float d){
}

float valueToX(){
  
}
float rankToY(float rank){
  float y = Y_MIN+rank*(Y_HEIGHT/TOP_VISIBLE);
  return y;
}
