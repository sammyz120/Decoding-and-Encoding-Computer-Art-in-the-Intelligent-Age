//引用老师给的代码
//导入音频库
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

/*-----------Processing小站------------------- */

/**
 * moving corners of rectangles in a grid//在网格中移动矩形角落
 * 	 
 * MOUSE //鼠标
 * position x          : corner position offset x //x位置：角落位置的x偏移量
 * position y          : corner position offset y //y位置：角落位置的y偏移量
 * left click          : random position //左键点击:随机位置
 * 
 * KEYS //键盘
 * s                   : save png //s保存为png
 * p                   : save pdf//p保存为pdf
 */

AudioPlayer player;//建立音频播放器
Minim minim;//定义音频对象

import processing.pdf.*;//导入pdf的库
import java.util.Calendar;//导入calendar库

boolean savePDF = false;//是否保存pdf
 
int tileCount = 20;//网格的行列数
int rectSize = 40;//矩形大小

int actRandomSeed = 0;
//设置整数变量actRandomSeed 初始值为0//设置种子

PImage photo1;//定义图片1
PImage photo2;//
PImage photo3;//
PImage photo4;//

void setup(){

size(500,700); //设置窗口尺寸为500*700

 minim = new Minim(this);//初始化minim对象
  player = minim.loadFile("001.mp3");//加载音乐文件
  
  player.play();//播放音乐

photo1=loadImage("11.png");//加载图片1
photo1.resize(width, height); //调整图片1位置
photo2=loadImage("22.png");//
photo2.resize(width, height);// 
photo3=loadImage("33.png");//
photo3.resize(width, height);// 
photo4=loadImage("44.png");//
photo4.resize(width, height);// 
}

void draw() {
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");
  //当 savePDF 变量为真时，Processing将开始记录绘制的图形，并将其保存为PDF文件
  colorMode(HSB, 360, 100, 100, 110);
 //设置颜色模式为HSB（色相，饱和度，亮度，透明度）
  background(360);//设置背景为白色
  smooth();//平滑绘制
  noStroke();//不描边
  fill(30,100,100,60);
   //设置绘图填充颜色（色相，饱和度，亮度，透明度）

  randomSeed(actRandomSeed);//设置随机数生成器的种子值

  for (int gridY=0; gridY<tileCount; gridY++) {//遍历每一行网格
    for (int gridX=0; gridX<tileCount; gridX++) {//遍历每一列网格
      
      int posX = width/tileCount * gridX;//计算矩形左上角的x坐标
      int posY = height/tileCount * gridY;//计算矩形左上角的y坐标

      float shiftX1 = mouseX/20 * random(-2, 2);//计算第一个角落的x偏移值
      float shiftY1 = mouseY/20 * random(-2, 2);//计算第一个角落的y偏移值
      float shiftX2 = mouseX/20 * random(-2, 2);//第二个
      float shiftY2 = mouseY/20 * random(-2, 2);//
      float shiftX3 = mouseX/20 * random(-2, 2);//第三个
      float shiftY3 = mouseY/20 * random(-2, 2);//
      float shiftX4 = mouseX/20 * random(-2, 2);//第四个
      float shiftY4 = mouseY/20 * random(-2, 2);//
     
      beginShape();//开始绘制形状
      vertex(posX+shiftX1, posY+shiftY1);//第一个角落的顶点
      vertex(posX+rectSize+shiftX2, posY+shiftY2);//第二个
      vertex(posX+rectSize+shiftX3, posY+rectSize+shiftY3);//第三个
      vertex(posX+shiftX4, posY+rectSize+shiftY4);//第四个
      endShape(CLOSE);//结束形状绘制，并封闭形状
      
      image(photo1,0,0);//在画布上绘制图片1
      image(photo2,0,0); //                                                                        
      image(photo3,0,0);//
      image(photo4,0,0);  //                                                                       
      
     // player.close();//关闭播放器
  //minim.stop();//停止音频
  //super.stop();
    }
  } 
  
  //如果变量 savePDF 的值为真，则执行保存图形为pdf文件的操作
  if (savePDF) {
    savePDF = false;
    //将变量 savePDF 的值设置为假（零），
    //通过将其设置为假，确保在完成保存PDF操作后，不会重复执行保存操作
    endRecord();
  }
}


void mousePressed() { //当鼠标按下时，mousePressed() 函数会被调用
  actRandomSeed = (int) random(100000);
  //生成一个随机数，并将其转换为整数类型，并将结果赋值给变量 actRandomSeed

}


void keyReleased(){
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  //当释放的按键为 's' 或 'S' 时，将当前帧保存为PNG图像文件，并使用时间戳作为文件名
  if (key == 'p' || key == 'P') savePDF = true;
  //当释放的按键为 'p' 或 'P' 时，将设置变量 savePDF 为真，表示需要保存图形为PDF文件
}

//通过调用这个 timestamp() 函数，可以获取一个表示当前日期和时间的时间戳字符串，
//用于命名文件、记录时间或其他需要时间标记的操作
String timestamp() {
  Calendar now = Calendar.getInstance();
  //通过 Calendar.getInstance()，我们可以获取一个 Calendar 对象，它表示当前的日期和时间
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
  //使用 String.format() 方法将日期和时间格式化为指定的字符串形式。
  //%1$ty：表示年份的后两位。
  //%1$tm：表示月份。
  //%1$td：表示日期。
  //_：下划线，用于分隔日期和时间部分。
  //%1$tH：表示小时（24小时制）。
  //%1$tM：表示分钟。
  //%1$tS：表示秒。
  //通过将这些格式化符号插入到字符串中
  //并将 now 对象作为参数传递给 String.format() 方法
  //将会生成一个类似于 "yymmdd_HHMMSS" 的时间戳字符串
}
