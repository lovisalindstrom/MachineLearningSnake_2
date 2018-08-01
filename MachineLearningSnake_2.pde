//From Coding Challenge #3: The Snake Game by Daniel Shiffman, https://www.youtube.com/watch?v=AaGK-fj-BAM

Snake snake;
Food food;
float scl = 20; //scale
int COLS = 20;
int ROWS = 20;

Node[][] grid = new Node[COLS][ROWS];

void setup(){
  size(600, 600);
  frameRate(10);
  drawGrid();
  snake = new Snake(0, 0, 1, 0); //x, y, xspeed, yspeed
  food = pickFoodLocation();
}


void draw(){
  background(51);
  
  if(snake.eat(food)){
    food = pickFoodLocation();
  }
  
  //snake.death();
  snake.boundaries();
  snake.update();
  snake.seek(food);
  
  snake.show();
  food.show();
}

public void drawGrid(){
  for(int x = 0; x < COLS-1; x++){
    for(int y = 0; y < ROWS; y++){
      grid[x][y] = new Node(x,y);
    }
  }
}

public Food pickFoodLocation(){
  int col = floor(width/scl);
  int row = floor(height/scl);
  PVector foodVector = new PVector(floor(random(col)), floor(random(row)));
  food = new Food(foodVector);
  foodVector.mult(scl);
  return food;
}
