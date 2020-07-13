/* 



Click to start, left and right arrow keys to move, up arrow to shoot.






IT'S DONE!! WOOOOOOOOOOOO!!!!!!!!
Still having alien speed change probs, but oh well. 

The next few saves will make this more like the real game. 
 1: Colors depend on current y-location (top 2 green, then 2 blue, then 2 purple, then 2 yellow, then 2 red, then u die, lol)
    Check
 2: SPEED DOES NOT DEPEND ON ROW, IT DEPENDS ON THE AMOUNT OF SPACE INVADERS REMAINING!!
    Workin' on it....
 3: Resize the screan to be more horizontal maybe?
    Check
 4: The aliens do not all move at once, each row moves over the course of one second-ish
    Skipping, too much work
 5: The aliens shoot at you.
    Check



Lindsey Herman
11/29/17

Time Estimate so far: 21.5 hours
*/




int time = 0;

//  Making this larger makes the aliens go further to the side each move. Making it smaller makes them not move over as much.
//  Was 20
int alienXMove = 20;

//  Making this number smaller will make the aliens move more frequently. Making it larger makes them move less frequently.
//  Was 60
int alienSpeed = 60;

int alienYMove = 50;
int screenWidth = 800;
int screenHeight = 550;


int whP1 = 40;
int xP1 = (screenWidth / 2) - (whP1 / 2);
int yP1 = screenHeight - whP1;
int xP1Change = 10;


boolean shootingLaser = false;
int xLaser = 2000;
int yLaser = screenHeight;
int wLaser = 2;
int hLaser = 20;

//  Making this larger makes the player-controlled laser shoot faster. Making it smaller makes it shoot slower.
//  Was 15
int laserSpeed = 15;



int numRows = 5;
int numColumns = 11;
int[][] alienFleetSize = new int[numRows][numColumns];
int[][] alienData = new int [numRows * numColumns][2];
boolean[][] alienDown = new boolean[numRows * numColumns][1];



int numColors = 5;
color[] alienColors = new color[numColors];



int xAlien1 = 0;
int yAlien1 = 200;
int whAlien1 = 40;



int furthestLeft;  //  x
int furthestRight;  //  x
int furthestDown;  //  y


boolean gameOver = false;
boolean won = false;
boolean introTime = true;


int alienShootingLaser1;
int alienShootingLaser2;
int[][] alienLasers = new int[numRows * numColumns][2];
boolean[][] isAlienShooting = new boolean[numRows * numColumns][1];

//  Making this larger makes the alien lasers move faster. Making it smaller makes them move slower.
//  Was 5
int alienLaserSpeed = 1;


//  End of changable variables


void setup()
{
  size(800, 550);
  background(0);
  
  
  for (int currentRow = 0; currentRow < numRows; currentRow++)
  {
    for(int currentColumn = 0; currentColumn < numColumns; currentColumn++) 
    {
      
      alienData[(currentRow * 11) + currentColumn][0] = xAlien1 + (50 * currentColumn);
      alienData[(currentRow * 11) + currentColumn][1] = yAlien1 - (50 * currentRow);
      alienDown[(currentRow * 11) + currentColumn][0] = false;
    }
  }
  
  //  The x-value of the bottom-left alien
  furthestLeft = alienData[0][0];
  //  The x-value of the bottom-right alien
  furthestRight = alienData[10][0];
  //  The y-value of the bottom-left alien
  furthestDown = alienData[0][1];
  
  
  //  Going from green to red here
  //  Grean
  alienColors[0] = color (0, 255, 0);
  //  Blue
  alienColors[1] = color (0, 255, 255);
  //  Purple
  alienColors[2] = color (255, 0, 255);
  //  Yellow
  alienColors[3] = color (255, 255, 0);
  //  Red
  alienColors[4] = color (255, 0, 0);
  
  
  for (int currentRow = 0; currentRow < numRows; currentRow++)
  {
    for(int currentColumn = 0; currentColumn < numColumns; currentColumn++) 
    {
      alienLasers[(currentRow * 11) + currentColumn][0] = 0;
      alienLasers[(currentRow * 11) + currentColumn][1] = 0;
      isAlienShooting[(currentRow * 11) + currentColumn][0] = false;
    }
  }
  
  
  
}




void draw()
{
  if (introTime == true)
  {
    showIntro();
  }
  
  
  else
  {
    
    alienShootingLaser1 = (int)(random(0, 55));
    //  Commenting out to make easier
    //alienShootingLaser2 = (int)(random(0, 55)); 
    
    
    background(0);
    drawP1Ship();
    //checkAlienSpeed();
    checkLaser();
    checkAlienLaser();
    won = checkIfWon();
    checkGameOver(gameOver);
    
    if (gameOver == false && won == false)
    {
      if (time == alienSpeed)
      {
        
        furthestLeft = furthestLeft + alienXMove;
        furthestRight = furthestRight + alienXMove;
 
        if (furthestLeft + alienXMove <= 0 || furthestRight + alienXMove >= screenWidth)
         {
            alienXMove = alienXMove * -1;
            //  Below should fix
            furthestLeft = furthestLeft + (alienXMove * 2);
            furthestRight = furthestRight + (alienXMove * 2);
            
            for (int currentRow = 0; currentRow < numRows; currentRow++)
            {
              for(int currentColumn = 0; currentColumn < numColumns; currentColumn++) 
              {
                alienData[(currentRow * 11) + currentColumn][1] = alienData[(currentRow * 11) + currentColumn][1] + alienYMove;
              }
            }
            
            furthestDown = furthestDown + alienYMove;
            
            if (furthestDown >= 500)
            {
              gameOver = true;
            }
          }
          
        
        
        
          for (int currentRow = 0; currentRow < numRows; currentRow++)
          {
            for(int currentColumn = 0; currentColumn < numColumns; currentColumn++) 
            {
              alienData[(currentRow * 11) + currentColumn][0] = alienData[(currentRow * 11) + currentColumn][0] + alienXMove;
              
              
              //  Fixes the ghost laser glitch, but less shooting
              if ((currentRow * 11) + currentColumn == alienShootingLaser1 && alienDown[(currentRow * 11) + currentColumn][0] == false)
              {
                shootAlienLaser(alienShootingLaser1);
              }
              //if ((currentRow * 11) + currentColumn == alienShootingLaser2 && alienDown[(currentRow * 11) + currentColumn][0] == false)
              //{
                //shootAlienLaser(alienShootingLaser2);
              //}
              
              
              
              time = 0;
            }
          }
      }
      
      
      
      for (int currentRow = 0; currentRow < numRows; currentRow++)
      {
        for(int currentColumn = 0; currentColumn < numColumns; currentColumn++) 
        {
          if (alienDown[(currentRow * 11) + currentColumn][0] == false)
          {
            drawAlien(alienData[(currentRow * 11) + currentColumn][0], alienData[(currentRow * 11) + currentColumn][1], whAlien1);
            
            
            
          }
        }
      }
     
     
      time++;
    }

    
    
    if (won == true)
    {
      winScreen();
    }
  }
}




 void keyPressed()
{
  if (key == CODED)
  {
    
    if (keyCode == LEFT)
    {
      if (xP1 >= 10)
      {
        xP1 = xP1 - xP1Change;
      }
    }
    
    else if (keyCode == RIGHT)
    {
      if (xP1 <= ((screenWidth - 10) - whP1))
      {
        xP1 = xP1 + xP1Change;
      }
    }
    
    else if (keyCode == UP)
    {
        shootLaser();
    } 
    
  }
} 



void drawP1Ship()
{
  stroke(alienColors[2]);
  fill(alienColors[2]);
  rect(xP1, yP1, whP1, whP1);
}


void shootLaser()
{
  if (shootingLaser == false)
    {
      shootingLaser = true;
      yLaser = yP1 - laserSpeed;
      xLaser = xP1 + hLaser - wLaser;
    }
}



void moveLaser()
{
  stroke(alienColors[2]);
  fill(alienColors[2]);
  rect(xLaser, yLaser, wLaser, hLaser);
  yLaser = yLaser - laserSpeed;
}



void checkLaser()
{
  boolean alienDown = checkIfShotAlien();
  if (yLaser < 0 || alienDown == true)
  {
    shootingLaser = false;
    xLaser = 2000;
    yLaser = screenHeight;
  }
  else if (shootingLaser == true)
  {
    moveLaser();
  }
}



void drawAlien(int x, int y, int wh)
{
  color currentAlienColor = chooseColor(y);
  stroke(currentAlienColor);
  fill(currentAlienColor);
  rect(x, y, wh, wh);
}


color chooseColor(int y)
{
  if (y <= 450 && y >= 400)
  {
    return alienColors[4];
  }
  else if (y <= 350 && y >= 300)
  {
    return alienColors[3];
  }
  else if (y <= 250 && y >= 200)
  {
    return alienColors[2];
  }
  else if (y <= 150 && y >= 100)
  {
    return alienColors[1];
  }
  else 
  {
    return alienColors[0];
  }
}



void checkGameOver(boolean gameOver)
{
  if (gameOver)
  {
    textSize(50);
    fill(alienColors[4]);
    text("Game Over!", 250, 250);
  }
}


boolean checkIfShotAlien()
{
  for (int currentRow = 0; currentRow < numRows; currentRow++)
  {
    for(int currentColumn = 0; currentColumn < numColumns; currentColumn++) 
    {
      if (yLaser <= alienData[(currentRow * 11) + currentColumn][1] + whAlien1 && xLaser >= alienData[(currentRow * 11) + currentColumn][0] && xLaser <= alienData[(currentRow * 11) + currentColumn][0] + whAlien1 && alienDown[(currentRow * 11) + currentColumn][0] == false)
      {
        alienDown[(currentRow * 11) + currentColumn][0] = true;
        checkAlienSpeed();
        
        
        
        if (alienData[(currentRow * 11) + currentColumn][0] == furthestLeft)
        {
          changeFurthestLeft((currentRow * 11) + currentColumn);
        }
        
        
        if (alienData[(currentRow * 11) + currentColumn][0] == furthestRight)
        {
          changeFurthestRight((currentRow * 11) + currentColumn);
        }
        
        
        if (alienData[(currentRow * 11) + currentColumn][1] == furthestDown)
        {
          //changeFurthestDown((currentRow * 11) + currentColumn);
          //  Changing this made the first row work, but has probs when moving up the columns.
          changeFurthestDown(0);
        }
        
        
        //System.out.println("true");
        return true;
      }
    }
  }
  return false;
}


boolean checkIfWon()
{
  for (int currentRow = 0; currentRow < numRows; currentRow++)
  {
    for(int currentColumn = 0; currentColumn < numColumns; currentColumn++) 
    {
      if (alienDown[(currentRow * 11) + currentColumn][0] == false)
      {
        return false;
      }
    }
  }
  return true;
}


void winScreen()
{
    textSize(50);
    fill(alienColors[0]);
    text("You Win!", 300, 250);
}


void showIntro()
{
    textSize(50);
    fill(alienColors[2]);
    text("Space Imitators", 200, 250);
}


void mouseClicked()
{
  introTime = false;
}


void changeFurthestLeft(int alienNumber)
{
  int columnCounter = 0;
  //  Go up, then over, use a while loop.
  while(alienDown[alienNumber][0] == true && alienNumber < 54)
  {
    alienNumber = alienNumber + 11;
    if (alienNumber >= 55)
    {
      columnCounter++;
      alienNumber = 0 + columnCounter; 
    }
  }
  furthestLeft = alienData[alienNumber][0];
  println("l = " + alienNumber);
}


void changeFurthestRight(int alienNumber)
{
  int columnCounter = 0;
  //  Go up, then over-backwards, use a while loop.
  while(alienDown[alienNumber][0] == true && alienNumber != 44)
  {
    alienNumber = alienNumber + 11;
    if (alienNumber >= 55)
    {
      columnCounter++;
      alienNumber = 10 - columnCounter; 
    }
  }
  furthestRight = alienData[alienNumber][0];
  println("r = " + alienNumber);
}



void changeFurthestDown(int alienNumber)
{
  //int startingNumber = alienNumber;
  int rowCounter = 0;
  //  Go across to the right, then up, use a while loop.
  //while(alienDown[alienNumber][0] == true && furthestDown != furthestUp)
  while(alienDown[alienNumber][0] == true && alienNumber < 54)
  {
    alienNumber = alienNumber + 1;
    if (alienNumber >= 11 + (11 * rowCounter))
    {
      //alienNumber = 0;
      rowCounter++;
      if (rowCounter < 5)
      {
        alienNumber = 0 + (11 * rowCounter);
      }
      else 
      {
        rowCounter = 0;
        alienNumber = 0;
      }
    }
    //if (alienNumber == (startingNumber + (rowCounter * 11)))
    //{
      //rowCounter++;
      //alienNumber = 0 + (11 * rowCounter);
    //}
  }
  furthestDown = alienData[alienNumber][1];
  //println("d " + furthestDown);
  println("d = " + alienNumber);
}


void checkAlienSpeed()
{
  int aliensRemaining = 0;
  for (int currentAlien = 0; currentAlien < 55; currentAlien++)
  {
    if (alienDown[currentAlien][0] == false)
    {
      aliensRemaining++;
    }
  }
  //System.out.println(aliensRemaining);
  
  
  
  //  Conditionals for the alienSpeed
  if (aliensRemaining >= 41)
  {
    alienSpeed = 60;
  }
  else if (aliensRemaining < 41 && aliensRemaining >= 28)
  {
    alienSpeed = 55;
  }
  else if (aliensRemaining < 28 && aliensRemaining >= 14)
  {
    alienSpeed = 50;
  }
  else if (aliensRemaining < 14 && aliensRemaining >= 9)
  {
    alienSpeed = 45;
  }
  else if (aliensRemaining < 9 && aliensRemaining >= 6)
  {
    alienSpeed = 40;
  }
  else if (aliensRemaining < 6 && aliensRemaining >= 4)
  {
    alienSpeed = 35;
  }
  else if (aliensRemaining < 4 && aliensRemaining >= 3)
  {
    alienSpeed = 30;
  }
  else if (aliensRemaining < 3 && aliensRemaining >= 2)
  {
    alienSpeed = 25;
  }
  else if (aliensRemaining < 2 && aliensRemaining >= 1)
  {
    alienSpeed = 20;
  }
  else
  {
    alienSpeed = 120;
  }
  System.out.println(alienSpeed);
  System.out.println(furthestLeft + " " + furthestRight + " " + furthestDown);
}


void shootAlienLaser(int alienNumber)
{
  //System.out.println(alienNumber);
      isAlienShooting[alienNumber][0] = true;
      alienLasers[alienNumber][1] = alienData[alienNumber][1] + whAlien1;
      alienLasers[alienNumber][0] = alienData[alienNumber][0] + (whAlien1 / 2);
      //moveAlienLaser(alienNumber);
}


void moveAlienLaser(int alienNumber)
{
  color currentLaserColor = chooseColor(alienLasers[alienNumber][1]);
  //stroke(alienColors[0]);
  //fill(alienColors[0]);
  stroke(currentLaserColor);
  fill(currentLaserColor);
  rect(alienLasers[alienNumber][0], alienLasers[alienNumber][1], wLaser, hLaser);
  alienLasers[alienNumber][1] = alienLasers[alienNumber][1] + alienLaserSpeed;
}


void checkAlienLaser()
{
  for (int currentRow = 0; currentRow < numRows; currentRow++)
  {
    for(int currentColumn = 0; currentColumn < numColumns; currentColumn++) 
    {
      
      
      boolean p1Down = checkIfShotP1((currentRow * 11) + currentColumn);
      if (p1Down == true)
      {
        gameOver = true;
      }
      
      
      //boolean hit = checkIfP1Down();
      if (alienLasers[(currentRow * 11) + currentColumn][1] > screenHeight)
      {
        isAlienShooting[(currentRow * 11) + currentColumn][0] = false;
        alienLasers[(currentRow * 11) + currentColumn][1] = 0;
        alienLasers[(currentRow * 11) + currentColumn][0] = 0;
      }
      else if (isAlienShooting[(currentRow * 11) + currentColumn][0] == true)
      {
        moveAlienLaser((currentRow * 11) + currentColumn);
      }
    }
  }
}


boolean checkIfShotP1(int alienLaser)
{
  //return false;
  if (alienLasers[alienLaser][1] >= yP1 && alienLasers[alienLaser][0] >= xP1 && alienLasers[alienLaser][0] <= xP1 + whP1)
  {
    return true;
  }
  else 
  {
    return false;
  }
}