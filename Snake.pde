
class Snake {
  //float x;
  //float y;
  float xspeed;
  float yspeed;
  int total;
  PVector locationTemp;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  float maxForce;


  Snake[] tail = new Snake[100];
  
  public Snake(float x, float y, float xspeed, float yspeed){
    this.locationTemp = new PVector();
    this.location = new PVector(x,y);
    this.velocity = new PVector(xspeed * scl, yspeed * scl);
    //this.acceleration = new PVector();
    //this.xspeed = xspeed;
    //this.yspeed = yspeed;
    this.total = 0;
    this.maxSpeed = 10;
    this.maxForce = 0.1;
  }
  
  void update(){
    
    for(int i = 0; i < tail.length-1; i++){
       tail[i] = tail[i+1];
    }

    if(total >= 1){
      tail[total-1] = new Snake(location.x, location.y, xspeed, yspeed);
    }
      
    location.add(velocity);
  }
  
  //void seek(Food food){
    
  //  PVector desired = PVector.sub(food.location, location);
  //  //Normalize desired and scale to maximun speed
  //  desired.normalize();
  //  //desired.mult(maxSpeed);
  //  desired.setMag(maxSpeed);
  //  //Steering = desired - velocity
  //  PVector steer = PVector.sub(desired, velocity);
  //  steer.limit(maxForce);
  //  applyForce(steer);
  //  update();
  //}
  
  void seek(Food food){
    PVector desired = PVector.sub(food.location,location);
    float d = desired.mag();
    if(d < 100){
      float m = map(d, 0, 100, 0, maxSpeed);
      desired.setMag(m);
    }else{
      desired.setMag(maxSpeed);
    }
    
    //Steering = desired - velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
    update();
  }
  
  void applyForce(PVector force){
    //PVector f = PVector.div(force,mass);
    velocity.add(force);
  }
  
  
  
  void boundaries(){
    if(location.x > width){
      location.x = 0;
    }else if(location.x < 0){
      location.x = width;
    }else if(location.y > height){
      location.y = 0;
    }else if(location.y < 0){
      location.y = height;
    }
  }
  
  boolean eat(Food food){
    float d = dist(location.x, location.y, food.location.x, food.location.y);
    if(d < 1){
      total++;
      return true;
    }else{
      return false;
    }
  }
  

  void death(){
    for(int i = 0; i < tail.length; i++){
      Snake s = tail[i];
      if(s != null){
        float d = dist(location.x, location.y, s.location.x, s.location.y);
        if(d < 1){
          total = 0;
          tail = new Snake[100];
        }
      }
    }
  }
  
  void show(){
    fill(255);
    for(int i = 0; i < tail.length; i++){
      if(tail[i] != null){
        rect(tail[i].location.x, tail[i].location.y, scl, scl);
      }
    }
    rect(location.x, location.y,scl,scl);
  }
  
  //void dir(float x, float y){
  //  xspeed = x;
  //  yspeed = y;
  //}
  
}
