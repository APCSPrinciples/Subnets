

String subnet;
float numHosts;
int xPos = 357;


boolean isCursor = true;
/**
 * Move mouse horizontally or use left/right arrow keys to change number of bits in the network portion<br>
 * Mr. Simon, Lowell High School, San Francisco
 */
void setup()
{
  size(700,240);
  subnet = new String("11111111.11111111.00000000.00000000");
  PFont f = createFont("Courier New Bold", 24);
  textFont(f,24);
  textAlign(CENTER);
  noLoop();

}
void draw()
{
  background(0);
  fill(255);
  stroke(255);
  int numOnes = 0;
  for(int i = 0; i < subnet.length(); i++)
    if(subnet.substring(i,i+1).equals("1"))
      numOnes++;
  text("/" + numOnes + " Subnet Mask ",width/2,20);
    String decimal = octetConvert(subnet.substring(0,8)) + "." + 
      octetConvert(subnet.substring(9,17)) + "." + 
      octetConvert(subnet.substring(18,26)) + "." + 
      octetConvert(subnet.substring(27,35));

    text(subnet,width/2,60); 
    text(decimal,width/2,100);


  if(calculateHosts() == -1)
    text("Invalid Subnet Mask",width/2,150);
  else
    text("Number of valid host addresses = " + (int(calculateHosts())),width/2,150);

  if(!isCursor)
    line(xPos+15,25,xPos+15,75);
}
void mouseMoved()
{
  cursor();
  isCursor = true;
  int num1s = int((mouseX - 94)/14);
  subnet = new String();
  for(int nI = 0; nI < 35; nI++)
  {
    if(nI == 8 || nI ==  17 || nI == 26)
      subnet = subnet + ".";
    else if(nI < num1s)
      subnet = subnet + "1";
    else
      subnet = subnet + "0";
  }
  xPos = mouseX;
  redraw();
}
float calculateHosts()
{
  int numZeros = 0;
  for(int i = 0; i < subnet.length(); i++)
    if(subnet.substring(i,i+1).equals("0"))
      numZeros++;

  if(numZeros < 1 || numZeros > 31)
    return -1;
  else 
    return (float)(pow(2,numZeros) - 2);
}

int octetConvert(String octet)
{
  int num = 0;
  for(int i = 7; i>=0; i--)
  {
    if(octet.substring(i,i+1).equals("1"))
    {
     num += pow(2,7-i);
    }
  }
  return num;
}


void keyPressed()
{
  noCursor();
  isCursor = false;
  xPos = xPos - (xPos%14) + 5;
  if(keyCode == LEFT)
  {
    xPos-=14;
  }
  else if(keyCode == RIGHT)
  {
    xPos+=14;
  }
  subnet = new String();
  int num1s = (xPos - 96)/14;
  for(int nI = 0; nI < 35; nI++)
  {
    if(nI == 8 || nI ==  17 || nI == 26)
      subnet = subnet + ".";
    else if(nI < num1s)
      subnet = subnet + "1";
    else
      subnet = subnet + "0";
  }
  redraw();
}