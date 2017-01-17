import processing.video.*;
import processing.serial.*;
import java.util.Map;
import java.util.HashMap;
import java.util.List;

// Step 1. define an object of Movie
Movie movie; 
Serial port;
int cmd_val = 0; // get the value from arduino
float start_t, end_t;
//Map<int, List<float>> movie_clip_map;

// use array to store Movie time
float[][] time_arr = {
                      {0, 1}, // movie clip 0
                      {1, 2}, // movie clip 1
                      {0, 1}, // movie clip 2
                      {1, 2}, // movie clip 3
                      {0, 1}, // movie clip 4
                      {1, 2}, // movie clip 5
                      {0, 1}, // movie clip 6
                      {1, 2}, // movie clip 7
                      {0, 1}, // movie clip 8
                      {1, 2}, // movie clip 9
                      {0, 1}, // movie clip 10
                      {1, 2}, // movie clip 11                   
                    };

/*
void initMovieClipMap() {
  movie_clip_map = new HashMap<int, List<float>>();
  int map_len = time_arr.length();
  List<float> list_tmp = new ArrayList<float>();
  for (int i = 0; i < map_len; i++)
  {
    list_tmp.add(time[i][0]);
    list_tmp.add(time[i][1]);
    movie_clip_map.put(i+1, list_tmp); // start i from 1
    list_tmp.remove();
  }
}
//*/

void setup() {
  size(1024, 768);

  //initMovieClipMap();
  
  //port = new Serial(this, "COM1", 9600);
  
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
  /*
  if(port.available() > 0) {
    cmd_val = port.read();
  }//*/

  int video_f = 1;
  if (video_f == 1)
  {
    // get the length of movie
    float md = movie.duration();
    start_t = md * 0.3;
    end_t = md * 0.33;
    println("start time: ", start_t);
    println("end time", end_t);
    movie_loop(start_t, end_t);
    
  } else
  {
    movie.jump(0);
  }

/*
  if (movie.available())
  {
    movie.read();
  }
  //*/
  
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

