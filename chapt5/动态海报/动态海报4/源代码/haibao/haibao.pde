import ddf.minim.*;//引用minim
Minim minim;
AudioPlayer player;//申明audioplayer

Particle[] particles;     //粒子类数组
Particle2[] par;
float alpha;           //透明度
PImage diao; // 载入的图像
PImage diao2; // 载入的图像
boolean img1on = true;
boolean img2on = false;
PFont f; // 载入的字体
Float voice;

void setup() {
  minim = new Minim(this);
  player = minim.loadFile("m.mp3", 2048);//导入音乐
  player.play();//开始播放
  player.loop();//循环播放

  size(735, 891);//画布大小
  background(0);//背景颜色
  noStroke();//不勾边
     par = new Particle2[50]; // 创建50个对象
  for (int i = 0; i < 50; i++) {
    par[i] = new Particle2();
  }
  diao = loadImage("diao.png"); // 载入图片
  diao2 = loadImage("diao2.png"); // 载入图片
  f = loadFont("LiSu-120.vlw"); //调取字体
  textFont(f, 120); //指定字体
  setParticles();        //放置粒子
}

void draw() {

    voice=player.mix.level();//获取当前帧音量
stroke(40, mouseY, mouseX);//勾边
fill(40, mouseY, mouseX,20);//填充
strokeWeight(1);//粗细
ellipse(width/2,height/2-200,voice*4000,voice*4000);//音乐控制圆



  frameRate(20);
  alpha = map(mouseX, 0, width, 5, 35);  //透明值由鼠标的X值来映射
  fill(0, alpha);           //设定一定透明度的填色，决定粒子刷新的速度
  rect(0, 0, width, height);

  loadPixels();            //读取像素
  for (Particle p : particles) {   //遍历每个粒子
    p.move();
  }
  updatePixels();          //更新像素

  fill(2, 214, 122);  //填充
  textSize(100);//字体大小
  text("THE WORLD ONLY", 25, 130); //显示文本内容，文本x，y坐标

  textSize(100);//字体大小
  text("BEHIND YOU", 100, 230); //显示文本内容，文本x，y坐标

//////
  if (img1on) {
    image(diao, 50, -50, 650, 900); // 如果1状态是显示，绘制载入的图片    
  }
  if (img2on) {
    image(diao2, 50, -50, 650, 900); //如果2状态是显示，绘制载入的图片   
  } 

  fill(255);  //填充
  textSize(23);//字体大小
  text("I HEARD THE WIND WITH A KIND OF SLEEPINESS AND DREAMED", 75, 800); //显示文本内容，文本x，y坐标
  text("IN A BEAUTIFUL SPRING FULL OF FLOWERS", 180, 830); //显示文本内容，文本x，y坐标

  fill(255);  //填充
  textSize(19);//字体大小
  text("LOOK FORWARD TO", 300, 35); //显示文本内容，文本x，y坐标
  text("YOUR COMING IN THE FUTURE", 250, 50); //显示文本内容，文本x，y坐标

  fill(255);  //填充
  textSize(15);//字体大小
  text("Love a person's eyes are", 20, 245); //显示文本内容，文本x，y坐标
  text("not hidden", 20, 265);//显示文本内容，文本x，y坐标
  text("No one but you", 20, 285);//显示文本内容，文本x，y坐标
  
  
    for (int i = 0; i < 50; i++) {
    par[i].drawParticle(); // 绘制每个粒子
  }
}

class Particle2 {// 定义Particle2类
  float xPosition; 
  float yPosition;
  float size;// 粒子的坐标和大小

  float speedX;// 粒子的运动速度和颜色
  float speedY;
  float col;

  Particle2() {// 随机位置和速度
    xPosition = random(0, width);
    yPosition = random(0, height);

    speedX = random(-3, 3);
    speedY = random(-3, 3);

    size = random(5, 10);// 随机大小和颜色
    col = random(100, 255);
  }

  void drawParticle() {
    fill(col - 15, 255, col - 15); // 设置随机颜色
    ellipse(xPosition, yPosition, size, size); // 绘制圆形粒子

    xPosition += speedX;// 重做粒子的位置
    yPosition += speedY;

    if (yPosition > height) { // 粒子y轴方向上碰到边界反弹
      yPosition = height;
      speedY = -1 * speedY;
    }

    if (yPosition < 0) {
      yPosition = 0;
      speedY = -1 * speedY;
    }

    if (xPosition > width) {// 粒子x轴方向上碰到边界反弹
      xPosition = width;
      speedX = -1 * speedX;
    }

    if (xPosition < 0) {
      xPosition = 0;
      speedX = -1 * speedX;
    }

    if (mousePressed) {// 鼠标按下
      float xdist = xPosition - mouseX;
      float ydist = yPosition - mouseY;

      xPosition -= xdist * 0.1;//在x轴上回到鼠标
      yPosition -= ydist * 0.1;//在y轴上回到鼠标
    }
  }
  
}


void setParticles() {         //添加粒子
  particles = new Particle[6000];  //初始化数组
  for (int i = 0; i < 6000; i++) {     //让所有的粒子
    float x = random(width);     //随机放置在画布中的一个位置
    float y = random(height);
    float adj = map(y, 0, height, 255, 0); //根据粒子所在y位置将颜色c的绿色通道设值
    int c = color(40, 255, adj);    //设置颜色
    particles[i]= new Particle(x, y, c);   //加载每一颗粒子
  }
}


class Particle {                 //粒子类
  float posX, posY, incr, theta;    //x位置，y位置，旋转角度theta，用于得到theta的incr
  color  c;                   //颜色c

  Particle(float xIn, float yIn, color cIn) {  //准备所有元素
    posX = xIn;
    posY = yIn;
    c = cIn;
  }

  public void move() { //打包一下所有的粒子行为。
    update();
    wrap();
    display();
  }

  void update() {     //更新位置
    incr +=  .08;
    //取到的值平缓变化
    theta = noise(posX * .006, posY * .004, incr*0.09) * TWO_PI;
    //噪声函数
    posX += 3 * cos(theta);
    posY += 2 * sin(theta);
    //由于三角函数的计算，粒子位置在发生圆润的变化
  }
  void display() {
    if (posX > 0 && posX < width && posY > 0  && posY < height) {
      pixels[(int)posX + (int)posY * width] =  c;
      //当粒子位置在画布中的时候，设置粒子所在像素颜色为c
    }
  }
  void wrap() {   //粒子遇到边缘则转移
    if (posX < 0) posX = width;
    if (posX > width ) posX =  0;
    if (posY < 0 ) posY = height;
    if (posY > height) posY =  0;
  }
}

void mouseClicked() {//检测鼠标点击
  if (mouseX >= 0 && mouseX < width && mouseY >= 0 && mouseY < height) {
    img1on = !img1on;//ture-false
    img2on = !img2on;//状态变化
  }
}
