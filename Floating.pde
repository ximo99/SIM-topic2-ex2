// Author:
// Ximo Casanova

// Description of the problem:
// Floating particle

// Display values:
final boolean FULL_SCREEN = false;
final int DRAW_FREQ = 50;    // Draw frequency (Hz or Frame-per-second)
int DISPLAY_SIZE_X = 1000;   // Display width (pixels)
int DISPLAY_SIZE_Y = 600;    // Display height (pixels)

// Parameters of the numerical integration:
final float SIM_STEP = 0.06;   // Simulation time-step (s)

// Draw values:
final int [] BACKGROUND_COLOR = {200, 200, 255};

// Parameters of the problem: 
final float Gc    = 9.801;  // Gravity constant (m/(s*s))
final PVector G   = new PVector(0.0, Gc);  // Acceleration due to gravity (m/(s*s))

PVector origin;  // Initial position

// Classes:
Ball ball;

void settings()
{
  size(DISPLAY_SIZE_X, DISPLAY_SIZE_Y);
}

void setup()
{
  initSimulation();
}

void initSimulation()
{
  background(BACKGROUND_COLOR[0], BACKGROUND_COLOR[1], BACKGROUND_COLOR[2]);
  
  origin = new PVector(width/2.0, height/4.0);
  ball = new Ball(origin);
}

void draw() {
  background(BACKGROUND_COLOR[0], BACKGROUND_COLOR[1], BACKGROUND_COLOR[2]);
  
  ball.run();
  drawStaticEnvironment();
}

// Water
void drawStaticEnvironment()
{
  fill(0);
  textSize(20);
  text("Pulse R para reiniciar el sistema. ", 50, 50);
  
  noStroke();
  fill(0, 196, 255, 100);
  rect(0, height/2, width, height);
}

// Modify the simulation by pressing the indicated keys
void keyPressed()
{
  switch(key)
  {  
    case 'r':
    case 'R':
      reset();
    break;
      
    default:
      break;
  }
}

// System reset
void reset()
{
  ball = new Ball(origin);
}

// Stop system
void stop()
{
  exit();
}
