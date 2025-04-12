//Chaosphere_6.0 mousePresse from KaijinQ 中间旋转的球球代码是从KaijinQ太太那里copy的，修改了大小位置颜色  代码来源：https://openprocessing.org/sketch/1592226

int N = 10000 ; //点的数量
float dROT = 0.01 ;//旋转增加量
int Qmax = 2 ; // 迭代次数
float Zmin = -sqrt(pow(280,2)-pow(250,2)) ;//最小Z值
float PA = 2*PI/3 ;//角度常量

float X[] = new float[N] ; //X坐标数组
float Y[] = new float[N] ; //Y坐标数组
float Z[] = new float[N] ;//Z坐标数组
int I ; //循环变量
float A ; //角度
float R ; //半径
float KA ; //KA变量
float Rot ;//旋转角度
int Q ;//迭代变量
float KX ;// KX变量
float KY ;//KY变量
float KZ ; //KZ变量
float T ;//T变量
float dT ; //dT变量
float dA ;//dA变量

PImage[] imgs;//图片数组

float yPosition;//设置Y坐标位置

import ddf.minim.*;
 
Minim minim;
AudioPlayer player;

boolean isFlash = false;//图片003是否闪烁
int flashDuration = 500;//图片003闪烁持续时间，单位为毫秒
int lastFlashTime = 0;//上次图片003闪烁时间

void setup(){
  size(600,900) ; //设置画布大小
  imgs=new PImage[4];//创建图片数组
  noSmooth() ; //关闭平滑效果
  fill(0,0,0,20) ;//设置填充颜色
  //加载图片
  imgs[0]= loadImage("000.jpg");
  imgs[1]= loadImage("001.png");
  imgs[2]= loadImage("002.png");
  imgs[3]= loadImage("003.png");
  
  //调整图片尺寸以适应画布大小
  imgs[2].resize(width,height);
  imgs[3].resize(width,height);
  
  lastFlashTime = millis();//初始化上次闪烁时间为当前时间
  
minim = new Minim(this);
  player = minim.loadFile("So Cute~.mp3");//放置插入的歌曲
  player.play();
  
  KX = random(+20,+200) ; //随机生成KX值
  //初始化点的坐标
  for ( I = 0 ; I < N ; I++ ){
    X[I] = KX+random(-10,+10) ;// 随机生成X坐标
    R = sqrt(pow(235,2)-pow(X[I],2)) ;// 根据X坐标计算半径R
    A = random(-PI,+PI) ;// 随机生成角度A
    Y[I] = R*cos(A) ;//根据角度A和半径R计算Y坐标
    Z[I] = R*sin(A) ;//根据角度A和半径R计算Z坐标
  }
}

void draw(){
  image(imgs[0],0,0);//绘制背景图片
  noStroke() ; 
  for ( I = 0 ; I < 100 ; I++ ){ fill(255,190,250-(125*I/100)) ; arc(320,230,400*(100-I)/100,400,PI/2,3*PI/2) ; }
  for ( I = 0 ; I < 100 ; I++ ){ fill(255,190,125*I/100) ; arc(320,230,400*(100-I)/100,400,-PI/2,+PI/2) ; }
  updatePixels(); //以上是更改球球的过渡颜色
  stroke(255) ; // 设置描边颜色为白色
  for ( Q = 0 ; Q < Qmax ; Q++ ){// 进行Qmax次迭代
  for ( I = 0 ; I < N ; I++ ){//遍历所有点
    A = atan(Y[I]/X[I]) ;  // 根据Y和Z坐标计算角度A
    R = sqrt(pow(X[I],2)+pow(Y[I],2)) ; // 根据X和Y坐标计算半径R
    if ( X[I] < 0 ){ A = A+PI ;// 如果X坐标小于0，调整角度A
  }
    if ( X[I] >= 0 && Y[I] < 0 ){ A = A+(2*PI) ; // 如果X坐标大于等于0且Y坐标小于0，调整角度A
  }
    T = 2*acos(-A/PI+1) ;// 根据角度A计算T值
  T = T+dT ; while ( T > 2*PI ){ T = T-(2*PI) ;// 如果T超过2PI，将其调整到0到2PI之间
}
    KA = (1-cos(T/2))*PI ;// 计算KA值
    X[I] = R*cos(KA) ; Y[I] = R*sin(KA) ; // 根据KA和半径R计算X和Y坐标
    A = atan(Y[I]/Z[I]) ;// 根据Y和Z坐标计算角度A
    R = sqrt(pow(Y[I],2)+pow(Z[I],2)) ;// 根据Y和Z坐标计算半径R
    if ( Z[I] < 0 ){ A = A+PI ; }//如果Z坐标小于0，调整角度A
    if ( Z[I] >= 0 && Y[I] < 0 ){ A = A+(2*PI) ; // 如果Z坐标大于等于0且Y坐标小于0，调整角度A
  }
    KA = A+dA ; // 更新角度KA
  while( KA > 2*PI ){ KA = KA-(2*PI) ; }// 如果KA超过2PI，将其调整到0到2PI之间
    Z[I] = R*cos(KA) ; Y[I] = R*sin(KA) ; // 根据KA和半径R计算Y坐标
    KX = (X[I]*cos(Rot)) - (Z[I]*sin(Rot)) ;// 根据旋转角度Rot更新KX
    KZ = (X[I]*sin(Rot)) + (Z[I]*cos(Rot)) ;// 根据旋转角度Rot更新KZ
    KY = Y[I] ;// 更新KY
    if ( KZ > Zmin ){ // 如果KZ大于Zmin，则绘制点
    stroke(-KX/2.5+160) ;// 根据KX计算描边颜色
  point(KX+320,KY+230) ; // 绘制点
}
  }//I
  }//Q
  dA = float(mouseY-500)/1000 + PI ;// 根据鼠标Y坐标更新dA
  dT = float(mouseX-500)/1000 + PI ;// 根据鼠标X坐标更新dT
  Rot = Rot+dROT ;// 更新旋转角度Rot
  
  //检查是否达到闪烁间隔（图片闪烁）
  if(millis() - lastFlashTime >= 600){
    isFlash = !isFlash;//切换闪烁的状态
    lastFlashTime = millis();//更新上次闪烁时间
  }
  // 如果闪烁标志为真，并且闪烁时间未超过闪烁持续时间，则在每个帧上显示图片
  if (isFlash && millis() - lastFlashTime <= flashDuration) {
    image(imgs[3], 0, 0);
  }
  
  image(imgs[1],0,0);//加载图片001
  
  yPosition += random(-10,10);//设置Y坐标位置在（-10,10）区间移动
  yPosition *= 0.45;//移动速度*0.45（降低）
  image(imgs[2],0,yPosition);//控制图片002上下移动
  
}

void mousePressed(){
KX = random(+20,+200) ; 
  for ( I = 0 ; I < N ; I++ ){
    X[I] = KX+random(-10,+10) ; R = sqrt(pow(235,2)-pow(X[I],2)) ;
    A = random(-PI,+PI) ; Y[I] = R*cos(A) ; Z[I] = R*sin(A) ;
    }
 }//点击重置球球状态（重复一遍代码）
