class Node {
  
  int x; 
  int y;
  int wdth = width / COLS;
  int hght = height / ROWS;
  
  ArrayList<Node> neighborsList = new ArrayList<Node>();
  
  public Node(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void addNeighbors(Node[][] grid){
    if(x < COLS-1){
      neighborsList.add(grid[x+1][y]);
    }
    if(x > 0){
      neighborsList.add(grid[x-1][y]);
    }
    if(y < ROWS-1){
      neighborsList.add(grid[x][y+1]);
    }
    if(y > 0){
      neighborsList.add(grid[x][y-1]);
    }
    //if(i > 0 && j > 0){
    //  neighborsList.add(grid[i-1][j-1]);
    //}
    //if(i < COLS-1 && j > 0){
    //  neighborsList.add(grid[i+1][j-1]);
    //}
    //if(i > 0 && j < ROWS-1){
    //  neighborsList.add(grid[i-1][j+1]);
    //}
    //if(i < COLS-1 && j < ROWS-1){
    //  neighborsList.add(grid[i+1][j+1]);
    //}
  }
  
  public ArrayList<Node> getNeighborsList(){
    return new ArrayList<Node>(neighborsList);
  }
  
  void draw(color col){
    //System.out.println("Show spot");
    fill(col);
    stroke(0);
    rect((this.x * wdth), (this.y * hght), wdth, hght);
    //System.out.println("x: " + (this.x * wdth) + " y: " + (this.y * hght) + " w: " + (wdth) + " h: " + (hght));
  }
  
  void show(color col){
    draw(col);
  }
}
