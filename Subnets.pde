/* @pjs font="CourierNewPS-BoldMT-24.vlw"; */

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
  PFont f = loadFont("CourierNewPS-BoldMT-24.vlw");
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
    if(subnet.charAt(i) == '1')
      numOnes++;
  text("/" + numOnes + " Subnet Mask ",width/2,20);
  try{
    String decimal = octetConvert(subnet.substring(0,8)) + "." + 
      octetConvert(subnet.substring(9,17)) + "." + 
      octetConvert(subnet.substring(18,26)) + "." + 
      octetConvert(subnet.substring(27,35));

    text(subnet,width/2,60); 
    text(decimal,width/2,100);
  }
  catch(Exception e){
  }

  if(calculateHosts() == -1)
    text("Invalid Subnet Mask",width/2,150);
  else
    text("Number of valid host addresses = " + (int(calculateHosts())),width/2,150);
  //text("Class A subnets " + (classAsubnets()),width/2,180);
  //text("Class B subnets " + (classBsubnets()),width/2,200);
  //text("Class C subnets " + (classCsubnets()),width/2,220);
  if(!isCursor)
    line(xPos,25,xPos,75);
}
void mouseMoved()
{
  cursor();
  isCursor = true;
  int num1s = (mouseX - 99)/14;
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
    if(subnet.charAt(i) == '0')
      numZeros++;

  if(numZeros < 1 || numZeros > 31)
    return -1;
  else 
    return (float)(Math.pow(2,numZeros) - 2);
}

int octetConvert(String octet)
{
  int num = Integer.parseInt(octet,2);
  return num;
}

float classCsubnets()
{
  int numOnes = 0;
  for(int i = 27; i < subnet.length(); i++)
    if(subnet.charAt(i) == '1')
      numOnes++;
  return (float)(Math.pow(2,numOnes));
}
float classBsubnets()
{
  int numOnes = 0;
  for(int i = 18; i < subnet.length(); i++)
    if(subnet.charAt(i) == '1')
      numOnes++;
  return (float)(Math.pow(2,numOnes));
}
float classAsubnets()
{
  int numOnes = 0;
  for(int i = 9; i < subnet.length(); i++)
    if(subnet.charAt(i) == '1')
      numOnes++;
  return (float)(Math.pow(2,numOnes));
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