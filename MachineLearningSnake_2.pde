//From Coding Challenge #3: The Snake Game by Daniel Shiffman, https://www.youtube.com/watch?v=AaGK-fj-BAM

Snake snake;
Food food;
Astar graph;
float scl = 20; //scale
int COLS = 20;
int ROWS = 20;


void setup(){
  size(600, 600);
  graph = new Astar();
  graph.setupSearch();
  frameRate(10);
  
  snake = new Snake(0, 0, 1, 0); //x, y, xspeed, yspeed
  food = pickFoodLocation();
  graph.search(snake, food);
}


void draw(){
  background(51);
  
  if(snake.eat(food)){
    food = pickFoodLocation();
    graph.search(snake, food);
  }
  
  //snake.death();
  snake.boundaries();
  snake.update();
  //snake.seek(food);
  
  snake.show();
  food.show();
}

public Food pickFoodLocation(){
  int col = floor(width/scl);
  int row = floor(height/scl);
  PVector foodVector = new PVector(floor(random(col)), floor(random(row)));
  food = new Food(foodVector);
  foodVector.mult(scl);
  return food;
}
