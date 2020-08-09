/* COLORPALETTE ver 2.0
// generates a gradation of colors 

(and recolors certain amount of random squares with given color - wip)
// hue shifts <----> like this and brightness and saturation can shift vertically

** AKTracer | aktracer.com

KEYBOARD MAPPING:
q to save

HUE: up,down for hue speed change| left right for moving the hue itself
  w
a s d

SAT: up, down for saturation speed of change(vertical)
left right for moving the overall sat of the image, image starts at 60% sat by default , could step up or down
  t
f g h

BRI: up, down for brightness speed of change(vertical)
left, right for moving the overall bri of image. image starts at full brightness, 
pressing i or l first will cause the program to glitch. It is recoverable with j and k.
  i
j k l


// CAPS LOCK MUST BE OFF
 
*/

void setup(){
  size(960,1200);
}

int max_of_HSB = height;

int squares_per_row = 8; //how many columns of gradation do you want?


int recolor_squares = 0; //how many random squares do you want to recolor? 0 is allowed
// n queens problem
// need a traversal mechanism for x and y locations, row and column wise for recolor positions, recusion?
// a tiling problem, tesselation
color recolor_color = #FFD000; //hex color value for recolor

//speeds
float speed_of_hue = 1; 
float gradation_of_saturation = 0; // speed of saturation
float gradation_of_brightness = 0; // speed of brightness

//offsets
float hue_offset = 0;
float base_saturation = max_of_HSB*0.6; // 60% 
float base_brightness = max_of_HSB; // Starts at full brigtness


// ---------------------- //

int savenum = 1;

  
void draw(){
  background(255);
  noStroke();
  colorMode(HSB,max_of_HSB);


  int y = 0;
  
  float saturation_offset = 0;
  int rect_size = width/squares_per_row;
  
  for(int x=0; y < height ; x+=rect_size){
    if(x >= width) { // if x has traversed entire row, advance row and set x to 0
      y+=rect_size;
      x = 0;
    }
    
    /*
    Hue uses speed as base and offset is optional
    Sat and Bri uses offset as base, speed is optional
    */
    
    fill((x*speed_of_hue/500+ hue_offset)%(max_of_HSB+1), base_saturation + y*gradation_of_saturation/100, (base_brightness + y*gradation_of_brightness/100)%(max_of_HSB+1));  
    rect(x,y,rect_size,rect_size);
  }
  
}

void recolor(){
  
  //recoloring
  // wip function from older code, not meant to work at the moment
  
  /* Calculate recolor array here. could extract colors from images or swatches. many algos are possible
  
  could build color colonies.
  Prevent overwrite of recolor
  
  create PGraphics as a new layer on the canvas
  */
  
  // fill(recolor_color); //all array has constant recolor color 
  int rect_size = width/squares_per_row;
  // fill up the rectangles with recolor calculations
  for(int i = 0; i<recolor_squares; i++){
    //retrieve recolor color from array index
    
    fill(color(random(max_of_HSB),random(175,max_of_HSB)-175,random(50,max_of_HSB)-350)); //set fill color of rectangle
    //consider randomizing alpha as well
    int y=0;
    int x = Math.round(random(width));
    x = x - (x+rect_size)%rect_size; // remove offset of x from rect_size and align it to cols
    y = Math.round(random(max_of_HSB));
    y = y - (y + rect_size)%rect_size; // align y to rect_size offsets
    rect(x,y,rect_size,rect_size);
  }
}

void mousePressed(){
  
}

void keyPressed(){
  switch(key){
    case 'q':
    save("gradation_"+month()+day()+hour()+minute()+second()+savenum+".png");
    println("saved "+savenum);
    savenum++;
    break;
    
    case 'i':
    gradation_of_brightness += 1;
    redraw();
    break;
    case 'k':
    gradation_of_brightness -= 1;
    redraw();
    break;
    case 'j':
    base_brightness -= 1;
    redraw();
    break;    
    case 'l':
    base_brightness += 1;
    redraw();
    break;
    
    
    case 'h':
    base_saturation += 1; // -100 to 100, 0 for no vertical change
    redraw();
    break;
    case 'f':
    base_saturation -= 1; // -100 to 100, 0 for no vertical change
    redraw();
    break;  
    case 'g':
    gradation_of_saturation -= 1; // -100 to 100, 0 for no vertical change
    redraw();
    break;
    case 't':
    gradation_of_saturation += 1; // -100 to 100, 0 for no vertical change
    redraw();
    break;
    
    case 'd':
    hue_offset += 1; // shift hue by percent is not percent anymore
    redraw();
    break;
    case 'a':
    hue_offset -= 1;
    redraw();
    break;
    case 'w':
    speed_of_hue += 1;
    redraw();
    break;
    case 's':
    speed_of_hue -= 1;
    redraw();
    break;
   
    
  }
}
