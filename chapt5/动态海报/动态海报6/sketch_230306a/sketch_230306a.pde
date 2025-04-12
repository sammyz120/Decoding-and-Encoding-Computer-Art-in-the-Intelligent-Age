PImage noon;
PImage night;
PImage yc;
Bar b; //声明有一个类Bar，对象为b
PFont f;
String message = "记录美好生活，OMG!又是喝多了的一天。";
float x = 400;   // 圆形的x轴位置    
float y = 75;     // 圆形的y轴位置    
float speed = 0;   // 圆形的速度    
float gravity = 0.2;  //用相对较小的数字 (0.1)，因为这种加速度会随着时间的推移而累积，从而提高速度
float sy = 900;//直线位置
float floorY = 800; //底部的 y 坐标
float L;
  void setup() {    
  size(800, 1000);
  smooth();
  f = createFont("Microsoft Yahei",36,true); 
  noon=loadImage("noon.jpg");
  night=loadImage("night.jpg");
  yc=loadImage("yc.png");
  b = new Bar(350, 600, 400, 15);//创建Bar对象并初始化
}      
void draw() {
  background(#F5EBEB);
  if (mousePressed){//点击进入黑夜
      image(night,50,50,700,750);
  }
  else {//否则白天
  image(noon,50,50,700,750);
  }
  image(yc,0,0,800,1000);
  fill(#A7A7A7); //文字
  textFont(f,36);  
  textSize(20);
  text(message,200,835,700,50);
  y = y + speed;  //添加速度改变y轴位置     
  speed = speed + gravity; //       
 
     b.draw();//调用Bar对象的draw函数绘制滑动条和控制点
  float m =255*b.ratio;
  fill(255,m,0);//控制圆球的颜色
  noStroke(); //取消描边
  float L = 400 * b.ratio; //根据Bar对象的ratio计算圆的直径
   if (y + L/2 >= floorY) {  //如果圆形到达底部返回    
    speed = speed * -0.95; //乘以 -0.95 而不是 -1 会在每次弹跳时减慢方块的速度（通过降低速度）    
 } 
 ellipse(x, y, L , L);
}
void mousePressed() {
  b.mousePressed(); //调用Bar对象的mousePressed函数处理鼠标按下事件
}

void mouseDragged() {
  b.mouseDragged();  //调用Bar对象的mouseDragged函数处理鼠标拖动事件
}

void mouseReleased() { 
  b.mouseReleased(); //调用Bar对象的mouseReleased函数处理鼠标释放事件
}
class Bar {
  boolean isDrag; // 判断是否在拖动
  boolean isActive;  // 判断鼠标是否在控制点之上
  float startX, endX; // 滑动条起始点与结束点的 x 坐标
  float x, y; // 滑动条的 x,y 坐标
  float w, r; // 滑动条的宽,控制点的半径
  float circleX; // 控制点的 x 坐标
  float ratio; // 比例

  Bar(float x_, float y_, float w_, float r_) {//构造函数
    x = x_; //初始化x坐标
    y = y_; //初始化y坐标
    w = w_; //初始化滑动条宽度
    r = r_; //初始化控制点半径
    circleX = x; //初始化控制点的x坐标为滑动条的起始点
    startX = x - w/2; //计算滑动条的起始点x坐标
    endX = x + w/2; //计算滑动条的结束点x坐标
  }

  void draw() { //绘制滑动条和控制点的函数
    if (isActive && isDrag) { //如果鼠标在控制点上且处于拖动状态
      circleX = mouseX; //更新控制点的x坐标为鼠标位置
      if (circleX > endX+50) { //如果控制点超出了滑动条的右端点
        circleX = endX+50; //将其限制在滑动条的右端点
      } else if (circleX < startX+50) { //如果控制点超出了滑动条的左端点
        circleX = startX+50; //将其限制在滑动条的左端点
      }
    }

    // 计算比率
    ratio = (circleX - startX)/w;

    // 绘制滑动条
    stroke(130); // 设置边框颜色
    strokeWeight(4); // 设置边框宽度
    line(startX+50, sy, endX+50, sy); // 绘制一条水平直线

    if (isActive) { // 如果鼠标在控制点之上
      fill(41, 238, 176); // 设置填充颜色
    } else { // 如果鼠标不在控制点之上
      fill(130); // 设置填充颜色
    }
    noStroke(); // 取消边框
    ellipse(circleX, sy, r * 2, r * 2); // 绘制控制点
  }

  void mousePressed() { // 鼠标按下时触发的事件
    if (dist(mouseX, mouseY, circleX, sy) < r) { // 判断鼠标是否在控制点之上
      isActive = true; // 设置鼠标在控制点之上
    } else {
      isActive = false; // 设置鼠标不在控制点之上
    }
  }

  void mouseDragged() { // 鼠标拖动时触发的事件
    isDrag = true; // 设置拖动状态
  }

  void mouseReleased() { // 鼠标松开时触发的事件
    isDrag = false; // 取消拖动状态
    isActive = false; // 取消控制点激活状态
  }
}
