//From Coding Challenge 51.1: A* Pathfinding Algorithm - Part 1 and 2
//https://www.youtube.com/watch?v=aKYlikFAV4k&index=6&list=PLRqwX-V7Uu6bePNiZLnglXUp2LXIjlCdb

class Astar {
  //The open and closed set could be tree strucures instead to speed up search
  ArrayList<Node> openSet;
  ArrayList<Node> closedSet;
  ArrayList<Node> path;
  //Node start;
  //Node end;
  //Node current;
  boolean newPath = false;
  int wdth = width / COLS;
  int hght = height / ROWS;
 
  Node[][] grid = new Node[ROWS][COLS];
  
  public Astar(){
    openSet = new ArrayList<Node>();
    closedSet = new ArrayList<Node>();
    path = new ArrayList<Node>();
  }
  
 
  public void createGrid() {
    for(int i = 0; i < COLS; i++) {
      for(int j = 0; j < ROWS; j++) {
        System.out.println(i + " " + j);
        grid[i][j] = new Node(i, j);
      }
    }
  }
  
  public void addNeighbors(){
     for(int i = 0; i < COLS; i++) {
      for(int j = 0; j < ROWS; j++) {
        System.out.println(i + " " + j);
        grid[i][j].addNeighbors(grid);
      }
    }
  }
  
  public void drawGrid(){
   for(int i = 0; i < COLS; i++){
     for(int j = 0; j < ROWS; j++){
       grid[i][j].show(color(255));
     }
   }
  }
  
  //public void drawOpenSet(){
  // for(int i = 0; i < openSet.size(); i++){
  //   openSet.get(i).show(color(0,255,0));
  // }
  //}
  
  //public void drawClosedSet(){
  // for(int i = 0; i < closedSet.size(); i++){
  //   closedSet.get(i).show(color(255,0,0));
  // }
  //}
  
  //public void drawPath(){
  // for(int i = 0; i < path.size(); i++){
  //   path.get(i).show(color(0,0,255));
  // }
  //}
  
  public float heuristic(Node a, Node b){
    //euclidian distance
    float dist = dist(a.x, a.y, b.x, b.y);
    
    //float dist = abs(a.x-b.x) + abs(a.y-b.y);
    return dist;
  }
  

 void setupSearch(){
   size(600, 600);
   System.out.println("Create grid");
   createGrid();
   addNeighbors();
   drawGrid();
   //start = grid[0][0];
   //end = grid[COLS-1][ROWS-1];
   //start.wall = false;
   //end.wall = false;
   
   //openSet.add(start);
 }
 
 void search(Snake snake, Food food){
   Node start = new Node(snake.location.x, snake.location.y);
   Node end = new Node(food.location.x, food.location.y);
   
   openSet.add(start);
   
   if(openSet.size() > 0){
     while(!openSet.isEmpty()){
       int lowestIndex = 0;
       for(int i = 0; i < openSet.size(); i++){
         if(openSet.get(i).f < openSet.get(lowestIndex).f){
           lowestIndex = i;
         }
       }
       Node current = openSet.get(lowestIndex);
       
       //Check if we're finished
       if(openSet.get(lowestIndex) == end){
         //find the path
         Node temp = current;
         path.add(temp);
         while(temp.previous != null){
           path.add(temp.previous);
           temp = temp.previous;
         }
         noLoop();
         System.out.println("DONE");
       }
       //Best option moves from openSet to closedSet
       openSet.remove(current);
       closedSet.add(current);
       
       for(int i = 0; i < current.neighborsList.size(); i++){
         Node neighbor = current.neighborsList.get(i);
         
         if(!closedSet.contains(neighbor) && !neighbor.wall){
           float tempG = current.g + 1;
           
           //Is this a better path?
           if(openSet.contains(neighbor)){
             if(tempG < neighbor.g){
               neighbor.g = tempG;
               newPath = true;
             }
           }else {
             neighbor.g = tempG;
             newPath = true;
             openSet.add(neighbor);
           }
           //Yes, it's a better path
           if(newPath == true){
             neighbor.h = heuristic(neighbor, end);
             neighbor.f = neighbor.g + neighbor.h;
             neighbor.previous = current;
           }
         }
       }
     }
   }else{
     //no solution
     System.out.println("No solution");
     noLoop();
     return;
   }
  }
  
}
