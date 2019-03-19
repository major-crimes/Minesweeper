

import de.bezier.guido.*;
public final static int rows = 20;
public final static int cols = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined
PFont zigBlack;
void setup ()
{
  size(400, 600);
  background(128, 0, 128);
  stroke(255, 0, 255);
  textAlign(CENTER, CENTER);
 zigBlack = createFont("Ziggurat-Black", 15);
  textFont(zigBlack);
  // make the manager
  Interactive.make( this );
  buttons = new MSButton[rows] [cols];
  //your code to initialize buttons goes here
  for (int r = 0; r < 20; r++)
    for (int c = 0; c<20; c++)
      buttons[r][c]= new MSButton(r, c);
  while (bombs.size() < 55) {
    setBombs();
  }
}
public void setBombs()
{ 
  int r = (int)(Math.random() *20);
  int c = (int)(Math.random() * 20);
  bombs.add(buttons[r][c]);
}

public void draw ()
{

  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{int num = 0;
for(int i = 0; i< bombs.size(); i++){
 if(bombs.get(i).isMarked()==true){
  num++; 
 }
 
}
if(num == 20)
 return true;
  return false;
}
public void displayLosingMessage()
{ 

 fill(0, 191, 255);
  textSize(100);
  text("Game", 200, 450);
  text("Over", 200, 510);
  fill(255, 105, 180);
  text("Game", 205, 455);
  text("Over", 205, 515);
 


}
public void displayWinningMessage()
{

 fill(0, 191, 255);
  textSize(100);
  text("You", 200, 450);
  text("Win", 200, 510);
  fill(255, 105, 180);
  text("You", 205, 455);
  text("Win", 205, 515);
 
}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;
  public MSButton ( int rr, int cc )
  {
    width = 400/cols;
    height = 400/rows;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager

  public void mousePressed () 
  {
    clicked = true;
    if (mouseButton == RIGHT) {
      marked = !marked;
    } else if (bombs.contains(this)) {
      displayLosingMessage();
    } else if (countBombs(r, c) > 0 ) {
      setLabel(""+countBombs(r, c));
    } else {

      if (isValid(r-1, c-1) == true && buttons[r-1][c-1].isClicked() == false)
        buttons[r-1][c-1].mousePressed();

      if (isValid(r-1, c) == true && buttons[r-1][c].isClicked() == false)
        buttons[r-1][c].mousePressed();

      if (isValid(r-1, c+1) == true && buttons[r-1][c+1].isClicked() == false)
        buttons[r-1][c+1].mousePressed();

      if (isValid(r, c-1) == true && buttons[r][c-1].isClicked() == false)
        buttons[r][c-1].mousePressed();

      if (isValid(r, c+1) == true && buttons[r][c+1].isClicked() == false)
        buttons[r][c+1].mousePressed();

      if (isValid(r+1, c-1) == true && buttons[r+1][c-1].isClicked() == false)
        buttons[r+1][c-1].mousePressed();

      if (isValid(r+1, c) == true && buttons[r+1][c].isClicked() == false)
        buttons[r+1][c].mousePressed();

      if (isValid(r+1, c+1) == true && buttons[r+1][c+1].isClicked() == false)
        buttons[r+1][c+1].mousePressed();
    }
  }
  public void draw () 
  {    
    if (marked)
      fill(0, 191, 255);//light blue for flags
    else if ( clicked && bombs.contains(this) ) 
      fill(0, 0, 139);//dark blue for bombs
    else if (clicked)
      fill(255, 105, 180);//light pink
    else 
    fill(255, 228, 225);//very light pink for all 

    rect(x, y, width, height);
    fill(148, 0, 211);
    textSize(15);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    fill(139, 0, 139);
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    if (r >=20 || c >=20)
      return false;
    else if (r < 0 || c < 0)
      return false;
    else
      return true;
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    if (isValid(row-1, col-1) == true && bombs.contains(buttons[row-1][col-1]) == true)
      numBombs++;
    if (isValid(row-1, col) == true && bombs.contains(buttons[row-1][col]) == true)
      numBombs++;
    if (isValid(row-1, col+1)==true&& bombs.contains(buttons[row-1][col+1]) == true)
      numBombs++;
    if (isValid(row, col-1)==true && bombs.contains(buttons[row][col-1])==true)
      numBombs++;
    if (isValid(row, col+1)==true && bombs.contains(buttons[row][col+1])==true)
      numBombs++;
    if (isValid(row+1, col-1)==true && bombs.contains(buttons[row+1][col-1])==true)
      numBombs++;
    if (isValid(row+1, col) == true && bombs.contains(buttons[row+1][col]) == true)
      numBombs++;
    if (isValid(row+1, col+1)==true&& bombs.contains(buttons[row+1][col+1])==true)
      numBombs++;
    return numBombs;
  }
}
