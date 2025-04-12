import ddf.minim.*;// 导入Minim库，用于音频处理

Minim minim;// Minim对象用于音频初始化
AudioPlayer player;// AudioPlayer对象用于播放音频文件
PImage backgroundImage; // PImage对象用于加载背景图像
float angle=0;// 角度变量，用于球体旋转
float angleIncrement=0.01;// 角度增量，用于控制球体旋转速度
float perspectiveAmount=0.005;// 透视量，用于控制透视效果的程度
int numBalls=70;//调整小球数量
float[] ballSize = new float[numBalls];  // 用于存储小球的大小
float[] ballX = new float[numBalls];  // 用于存储小球的X坐标
float[] ballY = new float[numBalls];  // 用于存储小球的Y坐标
float[] ballZ = new float[numBalls];  // 用于存储小球的Z坐标
float rotationX = 0;  // X轴旋转角度
float rotationY = 0;  // Y轴旋转角度
color startColor = color(255); // 起始颜色
color endColor = color(127,133,233); // 结束颜色

void setup() {
  size(600, 800,P3D); // 设置画布大小和渲染模式为3D
  backgroundImage=loadImage("ditu6.jpg");//设置背景图
  // 初始化Minim
  minim = new Minim(this); // 初始化Minim对象

  // 加载音乐文件
  player = minim.loadFile("music.mp3");

  // 播放音乐
  player.loop();// 循环播放音频
  float spacing=width/(numBalls+1);//计算小球之间的间距
  for (int i = 0; i < numBalls; i++) {
    // 随机初始化小球的大小和位置
  ballSize[i] = random(15, 20);  // 随机初始化小球的大小
    ballX[i] = (i + 1) * spacing - width / 2;  // 计算小球的X坐标
    ballY[i] = random(-height / 2, height / 2);  // 随机初始化小球的Y坐标
    ballZ[i] = random(-500, 500);  // 随机初始化小球的Z坐标
}
}

void draw() {
  image(backgroundImage, 0, 0, width, height);  // 绘制背景图像
  perspective(radians(60), float(width) / float(height), 0.1, 1000);  // 设置透视投影
  
  float newSize = map(mouseX, 0, width, 10, 100);  // 根据鼠标X坐标映射新的大小值
  float newX = map(mouseX, 0, width, -width / 2, width / 2);  // 根据鼠标X坐标映射新的X坐标值
  float newY = map(mouseY, 0, height, -height / 2, height / 2);  // 根据鼠标Y坐标映射新的Y坐标值

  translate(width / 2, height / 2);  // 平移画布中心
  rotationX = map(mouseY, 0, height, -PI, PI);  // 根据鼠标Y坐标映射旋转角度
  rotationY = map(mouseX, 0, width, -PI, PI);  // 根据鼠标X坐标映射旋转角度
  
  rotateX(rotationX);  // 绕X轴旋转
  rotateY(rotationY);  // 绕Y轴旋转
  
  for (int i = 0; i < numBalls; i++) {
    float zOffset = -ballSize[i] * perspectiveAmount;  // 计算小球在Z轴上的偏移量

    float distance = dist(mouseX, mouseY, width / 2 + ballX[i], height / 2 + ballY[i]);  // 计算鼠标位置和小球位置之间的距离
    float sizeFactor = map(distance, 0, width / 2, 1.0, 2.0);  // 根据距离映射尺寸因子
    float colorFactor = map(distance, 0, width / 2, 0.0, 1.0);  // 根据距离映射颜色因子
    color ballColor = lerpColor(startColor, endColor, colorFactor);  // 根据颜色因子获取渐变颜色

    pushMatrix();  // 保存当前坐标系状态
    translate(ballX[i], ballY[i], ballZ[i] + zOffset);  // 在Z轴上应用透视变换
    fill(72, 35, 200);  // 设置填充颜色
    stroke(ballColor);  // 设置边框颜色
    sphere(ballSize[i] * sizeFactor);  // 绘制小球
    popMatrix();  // 恢复之前的坐标系状态
  ballZ[i] += 2; // 将小球的Z坐标增加2，使其在多个平面上运动

if (ballZ[i] > 500) { // 如果小球的Z坐标超过500
  ballZ[i] = -500; // 将小球的Z坐标重置为-500，使其重新出现在屏幕上
}
}
}

void mousePressed() {
  resetBalls(); // 当鼠标按下时，调用resetBalls函数重置小球
}


void resetBalls() {
  float spacing = width / (numBalls + 1); // 计算小球之间的间距

  for (int i = 0; i < numBalls; i++) {
    ballSize[i] = random(15, 20); // 随机设置小球的大小
    ballX[i] = (i + 1) * spacing - width / 2; // 根据间距和索引设置小球的X坐标
    ballY[i] = random(-height / 2, height / 2); // 随机设置小球的Y坐标
    ballZ[i] = random(-500, 500); // 随机设置小球的Z坐标
  }
}

void stop() {
  // 关闭音乐播放器和Minim
  player.close();
  minim.stop();

  super.stop();
}
