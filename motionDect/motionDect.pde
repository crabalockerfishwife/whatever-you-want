

/**
 * Background Subtraction 
 * by Golan Levin. 
 *
 * Detect the presence of people and objects in the frame using a simple
 * background-subtraction technique. To initialize the background, press a key.
 */


import processing.video.*;


boolean look = false;
int numPixels;
int[] backgroundPixels;
Capture video;
Blobject[] blobs;

void setup() {
  size(640, 480); 
  
  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  //video = new Capture(this, 160, 120);
  video = new Capture(this, width, height);
  
  // Start capturing the images from the camera
  video.start();  
  
  numPixels = video.width * video.height;
  // Create array to store the background image
  backgroundPixels = new int[numPixels];
  // Make the pixels[] array available for direct manipulation
  rect(100,100,100,100);
  loadPixels();
}

void draw() {
  if (video.available()) {
    video.read(); // Read a new video frame
    video.loadPixels(); // Make the pixels of video available
    // Difference between the current frame and the stored background
    int presenceSum = 0;
    //for (int i = 0; i < numPixels; i++) { // For each pixel in the video frame...}
    updatePixels(); // Notify that the pixels[] array has changed
    println(presenceSum); // Print out the total amount of movement
  }
}


float[] COG (ArrayList<Float> x, ArrayList<Float> y) {
  float[] ans = new float[2];
  for (int h = 0; h < x.length; x++) {
    ans[0] += x[h];
  }
  for (int c = 0; c < y.length; y++) {
    ans[1] += y[c];
  }
  ans[0] = ans[0]/x.length;
  ans[1] = ans[1]/y.length;
  return ans;
}


