import processing.video.*;
import processing.serial.*;
import java.util.Map;
import java.util.HashMap;
import java.util.List;

// Step 1. define an object of Movie
Movie movie; 
Serial port;
static int cmd_val = 0; // get the value from arduino
float start_t, end_t;
String str_tmp;

// use array to store Movie time
float[][] time_arr = {
                      {0.1, 0.2}, // movie clip 0
                      {0.2, 0.3}, // movie clip 1
                      {0.3, 0.4}, // movie clip 2
                      {0.4, 0.5}, // movie clip 3
                      {0.5, 0.6}, // movie clip 4
                      {0.6, 0.7}, // movie clip 5
                      {0.7, 0.8}, // movie clip 6
                      {0.5, 0.6}, // movie clip 7
                      {0.5, 0.6}, // movie clip 8
                      {0.5, 0.6}, // movie clip 9
                      {0.5, 0.6}, // movie clip 10
                      {0.5, 0.6}, // movie clip 11                   
                    };

void setup() {
  size(1024, 768);
  
  port = new Serial(this, "COM1", 9600);
  
  port.bufferUntil('\n'); // buffer until meet '\n', then call the event listener
  
  // Step 2. create an instance of Movie
  movie = new Movie(this, "2.mov"); 

  // Step 3. 
  movie.loop();
}

// Step 4.
//*
void movieEvent(Movie movie) {
  movie.read();
}
//*/

void draw() {

  // get value from arduino

  int video_f = 1;
  if (video_f == 1)
  {
    // get the length of movie
    float md = movie.duration();
    start_t = md * time_arr[cmd_val][0];
    end_t = md * time_arr[cmd_val][1];
    //start_t = md * 0.1;
    //end_t = md * 0.2;
    println("start time: ", start_t);
    println("end time", end_t);
    movie_loop(start_t, end_t);
    
  } else
  {
    movie.jump(0);
  }

  // Step 5.
  image(movie, 0, 0);
}

// loop movie from start_time to end_time
void movie_loop(float start_time, float end_time)
{
    // get the value of current time
    float mt = movie.time();
    println("current time: ", mt);
    if (mt < start_time || mt > end_time)
    {
      movie.jump(start_time);
    }
}

//*
void serialEvent(Serial port) {
  String inString = port.readString(); // read all the data include '\n'
  String[] list = split(inString, '\n');
  cmd_val = int(list[0]);
  println("cmd_val: ", cmd_val);
}//*/
