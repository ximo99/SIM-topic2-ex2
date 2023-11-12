class Ball {
  PVector s; // Position
  PVector v; // Velocity
  PVector a; // Accelaration
  PVector f; // Force
  
  float m = 10.0;      // Mass
  float r = 30.0;     // Radius
  float d = 0.0002;  // Color
  float vS;           // Exit velocity
  
  float Kd1 = 0.15; // Friction constant in air
  float Kd2 = 0.30; // Friction constant in water

  Ball(PVector s0) {
    s = s0.get();
    v = new PVector(0, 0);
    a = new PVector(0, 0);
  }

  void run() {
    update();
    display();
  }

  // Update values using Symplectic Euler
  void update() {
    updateForce();
    
    v = PVector.add(PVector.mult(a, SIM_STEP), v);
    s = PVector.add(PVector.mult(v, SIM_STEP), s);
    
    a.set(0.0, 0.0);
  }
  
  // Calculate all the forces
  void updateForce() { 
    PVector fG = PVector.mult(G, m);
    PVector fB = new PVector(0.0, 0.0);
    PVector fR = new PVector(0.0, 0.0);
    PVector Ft = new PVector(0.0, 0.0);
    
    // Submerged, but not totally
    if (s.y > height/2-r && s.y < height/2+r) 
    {
      float h = s.y + r - height/2;
      float a = sqrt(2 * h * r - h * h);
      
      vS = (3 * a * a + h * h) * PI * h/6.0;
      fR = new PVector(0.0, -Kd2 * v.y);
    }
    // Submerged
    else if (s.y > height/2+r)
    {
      vS = 4.0 * PI * r * r * r / 3.0;
      fR = new PVector(0.0, -Kd2 * v.y);
    }
    // Not submerged
    else
    {
      vS = 0;
      fR = new PVector(0.0, -Kd1 * v.y);
    }
    
    fR = new PVector(0.0, -d * G.y * vS);
    
    applyForce(fG);
    applyForce(fB);
    applyForce(fR);
  }
  
  // Apply forces
  void applyForce(PVector force) {
    PVector f = force.get();
    f.div(m);
    a.add(f);
  }

  // Method to display
  void display() {
    fill(0);
    ellipse(s.x, s.y, r, r);
  }
}
