//import processing.pdf.*;//导入processing的PDF库

import processing.sound.*;//导入processing的sound库

SoundFile song;//声明一个soundFile对象song

PImage photo;//声明一个变量photo
PImage cicle;//声明一个变量cicle
PImage wenzi;//声明一个变量wenzi
PVector origin;//声明一个PVector对象origin
int maxParticles = 90;//声明一个整数，控制粒子的数量
int particleSize = 2;//声明一个整数，控制粒子的大小
float particleSpeed = 10; //声明一个整数，控制粒子的速度


float time = 0;//声明浮点数，控制时间
float dt = 0.005;//时间步长
float amplitudeScale = 100; // 振幅缩放系数
PFont f;//声明了一个PFont对象f
String message = "EATING HEALTHY";//一个字符串变量message，导入文字
float voice;//声明一个浮点型变量voice
void setup() {
  song=new SoundFile(this,"music.MP3");//加载音乐
    song.loop();//播放音乐循环
  smooth();//平滑模式
    noFill();//不填充
  f = createFont("Cambria Math", 60, true);//创建一个指定字体名称、大小和是否粗体的字体对象f
  size(700, 900);//设置画布大小
  background(#145374);//背景颜色设置
   photo = loadImage("ground.png");//加载名为"ground.png"的图像文件
 
  image(photo, 0, 0);//使用image函数在画布上显示图像
   
  colorMode(HSB);//设置颜色模式为HSB色彩模式

}

void draw() {
 //引用了一段给的参考代码
if(mousePressed){
    pushMatrix();//使用pushMatrix函数来保存坐标系的变换状态
    translate(width/2,height/2);//translate()函数将坐标系的原点移到画布中心

    int circleResolution = (int)map(mouseY+100,0,height,2, 10);//鼠标的位置映射出圆的分辨率circleResolution
    float radius = mouseX-width/2 + 0.5;//计算出半径radius
    float angle = TWO_PI/circleResolution;//计算出角度

    strokeWeight(0.15);//定义线条粗细
    stroke(#FA5656);//线条颜色
 beginShape();//使用beginShape()函数开始定义形状
    for (int i=0; i<=circleResolution; i++){
      float x = 0 + cos(angle*i) * radius;
      float y = 0 + sin(angle*i) * radius;
      vertex(x, y);//使用vertex()函数将点添加到形状
    }//for 循环函数，通过循环计算每个点的坐标
    endShape();//使用endShape()函数结束形状的定义
    
    popMatrix();//使用popMatrix函数恢复坐标系的变换状态
  }
 
  // 绘制波浪型状
  time += dt;//增加dt来推进时间
  stroke(#27CBAC, 40);//线条颜色
  strokeWeight(2);//线条粗细
  noFill();//不填充

  float startY = height / 20;//定义起始点
  float endY = height;//结束点
  float offset = map(time, 0, 10, 0, width);//根据时间计算出横向的偏移量offset

  beginShape();//使用beginShape()函数开始定义形状
  for (float x = 0; x <= width; x += 10) {
    float waveX = x + offset;
    float y = map(waveX, 0, width, startY, endY);
    float drift = (noise(waveX / 100, y / 300, time) - 0.5) * 520;
    vertex(x, y + drift - startY);//for循环计算每个点的坐标，并根据Perlin噪声函数计算出纵向的漂移量drift
  }
  
  vertex(width, height);//使用vertex()函数
  vertex(0, height);//使用vertex()函数
  endShape(CLOSE);//endShape(CLOSE)函数结束形状的定义，并将最后一个点与起始点连接起来，形成闭合的形状
  
  // 检查波浪是否到达画布的高边缘
  if (offset >= width) {
    startY = endY; // 重置起始点为结束点
  }
  
   // 文本绘制
  //fill(0);
  //textFont(f, 12);
 // textSize(60);
 // text(message, 10, 10, 290, 290);
 cicle = loadImage("c.png");//加载名为"c.png"，并以cicle命名

image(cicle,0.2,5,cicle.width,cicle.height);//调整位置
wenzi = loadImage("wenzi.png");//加载名为"wenzi.png"，并以wenzi命名
image(wenzi,0.2,5,wenzi.width,wenzi.height);//调整这个图片的位置
}
   
 

  
  
  
