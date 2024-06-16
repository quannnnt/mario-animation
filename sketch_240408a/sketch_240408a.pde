int marioWidth, marioHeight, mariox, marioy, yoshix, yoshiy, pipeWidth,
pipeHeight, pipex, speedPipe, frameCountm, yoshiWidth, yoshiHeight, 
yoshixMount, yoshiyMount, mountedMarioWidth, mountedMarioHeight, mountedMariox,
mountedMarioy, frameCountmount, speedYoshi, mountTime;
float cloud1x, cloud2x, speedCloud;
PImage currentFrame, run1, run2, run3, jump, fall, clouds, ground, pipe, mount1, 
mount2, mount3, mount4, yoshiHead, yoshiRun1, yoshiRun2, yoshiRun3, yoshiJump, currentFrameYoshi,
currentFrameMount, yoshiFall, yoshiTime;
boolean jumping = false, falling = false, mount = false;
PFont marioFont;

void setup() {
  size(350, 300);
  
  marioFont = createFont("../SuperMario256.ttf", 20);
  
  //scenery
  pipeWidth = 30;
  pipeHeight = 30;
  pipex = 0 - pipeWidth;
  speedPipe = 2;
  pipe = loadImage("../pipe.png");
  cloud1x = 0;
  cloud2x = -width;
  speedCloud = 0.4;
  clouds = loadImage("../clouds.png");
  ground = loadImage("../ground.png");

  marioWidth = 30;
  marioHeight = 53;
  mariox = 3*width/4 - marioWidth/2;
  marioy = 4*height/5 - marioHeight;
  run1 = loadImage("../run1.png");
  run2 = loadImage("../run2.png");
  run3 = loadImage("../run3.png");
  jump = loadImage("../jump.png");
  fall = loadImage("../fall.png");
  currentFrame = run1;
  
  //yoshi
  yoshiHead = loadImage("../yoshiHead.png");
  yoshiRun1 = loadImage("../yoshiRun1.png");
  yoshiRun2 = loadImage("../yoshiRun2.png");
  yoshiRun3 = loadImage("../yoshiRun3.png");
  yoshiJump = loadImage("../yoshiJump.png");
  yoshiFall = loadImage("../yoshiFall.png");
  yoshiTime = loadImage("../yoshiTime.png");
  yoshiWidth = 30;
  yoshiHeight = 30;
  yoshixMount = 3*width/4 - yoshiWidth/2;
  yoshiyMount = 4*height/5 - yoshiHeight;
  currentFrameYoshi = yoshiRun1;
  //static
  yoshix = -width * 5 - width/2 - yoshiWidth/2;
  yoshiy = 4*height/5 - yoshiHeight;
  speedYoshi = 2;
  mountTime = 0;
  
  //mounted mario
  mount1 = loadImage("../mount1.png");
  mount2 = loadImage("../mount2.png");
  mount3 = loadImage("../mount3.png");
  mount4 = loadImage("../mount4.png");
  mountedMarioWidth = 30;
  mountedMarioHeight = 42;
  mountedMariox = 3*width/4 - mountedMarioWidth/2 + 5;
  mountedMarioy = 4*height/5 - mountedMarioHeight - yoshiHeight/2;
  currentFrameMount = mount1;
}

// ---------------------------------- scenery ----------------------------------------
void fillBackground() {
  noStroke();
  fill(173, 213, 248);
  rect(0, 0, width, height);
}
void clouds() {
  //1
  image(clouds, cloud1x, 10, width, 2*height/5);
  //2
  image(clouds, cloud2x, 10, width, 2*height/5);
  moveClouds();
}
void ground() {
  image(ground, 0, 4*height/5, width, height/5);
}
void pipe() {
  image(pipe, pipex, 4*height/5 - pipeHeight, pipeWidth, pipeHeight);
}

// ---------------------------------- character --------------------------------------
void mario() {
  if (mount) {
    //yoshi
    image(yoshiHead, yoshixMount - 3*yoshiWidth/5, yoshiyMount - yoshiHeight, 
    yoshiWidth, yoshiHeight);
    image(currentFrameYoshi, yoshixMount, yoshiyMount, yoshiWidth, yoshiHeight);
    //mounted mario
    image(currentFrameMount, mountedMariox, mountedMarioy, mountedMarioWidth,
    mountedMarioHeight);
  }
  else {
    image(currentFrame, mariox, marioy, marioWidth, marioHeight);
  }
}
void yoshi(){
  if(!mount){
    image(yoshiHead, yoshix - 3*yoshiWidth/5, yoshiy - yoshiHeight, yoshiWidth,
    yoshiHeight);
    image(yoshiRun1, yoshix, yoshiy, yoshiWidth, yoshiHeight);
    yoshix += speedYoshi;
  }
}

// ---------------------------------- animations -------------------------------------
void jump() {
  if (mariox <= pipex + pipeWidth + 30 && mariox >= pipex + pipeWidth + 26
  || yoshixMount - 3*yoshiWidth/5 <= pipex + pipeWidth + 30 
  && yoshixMount - 3*yoshiWidth/5 >= pipex + pipeWidth + 26) {
    jumping = true;
  }
  if (jumping) {
    if(mount){
      mountedMarioy -= 2;
      yoshiyMount -= 2;
      if(yoshiyMount - yoshiHeight <= 4*height/5 - yoshiHeight * 2 * 2.5){
        jumping = false;
        falling = true;
      }
    }
    else{
      marioy -= 2;
      if (marioy <= 4*height/5 - marioHeight * 2.5) {
        jumping = false;
        falling = true;
      }
    }
  }
  if (falling) {
    if(mount){
      mountedMarioy += 2;
      yoshiyMount += 2;
      if (yoshiyMount + yoshiHeight >= 4*height/5) {
        falling = false;
        currentFrameMount = mount1;
      }
    }
    else{
      marioy += 2;
      if (marioy + marioHeight >= 4*height/5) {
        falling = false;
      }
    }
  }
}
void movePipe() {
  pipex += speedPipe;
  if (pipex >= width + pipeWidth) {
    pipex = 0 - pipeWidth;
  }
}
void moveClouds(){
  cloud1x += speedCloud;
  cloud2x += speedCloud;
  if (cloud1x >= width) {
    cloud1x = -width;
  }
  if (cloud2x >= width) {
    cloud2x = -width;
  }
}
void ride(){
  if(mariox <= yoshix + yoshiWidth && mariox >= yoshix + yoshiWidth - 2){
    mount = true;
  }
}

// --------------------------------- image frames ------------------------------------
void marioStatus() {
  if (!mount) {
    if (!jumping || !falling) {
      if (frameCountm == 60) {
        if (currentFrame == run1) {
          currentFrame = run2;
        }
        else if(currentFrame == run2){
          currentFrame = run3;
        }
        else{
          currentFrame = run1;
        }
        frameCountm = 0;
      }
    }
    if (jumping) {
      currentFrame = jump;
    }
    if (falling) {
      currentFrame = fall;
    }
  }
  if (mount) {
    yoshiStatus();
  }
  frameCountm += 10;
  frameCountmount += 10;
}
void yoshiStatus(){
  if(frameCountm == 60){
    //yoshi
    if(!jumping || !falling){
      if(currentFrameYoshi == yoshiRun1){
        currentFrameYoshi = yoshiRun2;
      }
      else if(currentFrameYoshi == yoshiRun2){
        currentFrameYoshi = yoshiRun3;
      }
      else{
        currentFrameYoshi = yoshiRun1;
      }
    }
    if(jumping){
        currentFrameMount = mount4;
        currentFrameYoshi = yoshiJump;
      }
      if(falling){
        currentFrameMount = mount3;
        currentFrameYoshi = yoshiFall;
      }
    frameCountm = 0;
  }
}
void mountExpire(){
  if(mount){
    mountTime += 1;
    if(mountTime >= 1800){
      mount = false;
      mountTime = 0;
    }
  }
}
void textMountTime() {
  if(mount){
    fill(0);
    noStroke();
    textFont(marioFont);
    for (float i = -1.5; i <= 1.5; i++) {
      for (float j = -1.5; j <= 1.5; j++) {
        text(1800/60 - mountTime/60, 147 + i, height - 18 + j);
      }
    }
    image(yoshiTime, 10, height - 40, 137, 30);
    fill(255);
    text(1800/60 - mountTime/60, 147, height - 18);
  }
}

void draw() {
  fillBackground();
  clouds();
  ground();
  pipe();
  mario();
  yoshi();
  ride();
  marioStatus();
  movePipe();
  jump();
  mountExpire();
  textMountTime();
}
