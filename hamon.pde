// 音楽ファイルを使うためのライブラリ
import ddf.minim.*;

// 音楽ファイル準備用
Minim minim;
AudioPlayer bgm;
AudioPlayer sound;

// 波紋の座標を格納する配列（最大10個入る）
float[] x = new float[10];
float[] y = new float[10];
// 波紋の大きさを格納する配列（最大10個入る）
int[] w = new int[10];
int[] h = new int[10];

// 次の新しい波紋を作る場所（番号）
int new_hamon = 1;
// 「新しい波紋作っていいですか」のフラグ（）初期値は「だめですよ」
int new_hamon_flag = 0; 

void setup() 
{
  //　ウィンドウサイズ
  size(1500, 850);
  // 背景色
  background(0);
  // フレームレート
  frameRate(60);
  
  // 音楽ファイル読み込み
  minim = new Minim( this );
  bgm = minim.loadFile( "river.mp3" );
  sound = minim.loadFile("suiteki2.mp3");
  bgm.loop();
}

void draw()
{
  // 黒の背景色でリセット
  background(0);
  
  // 1/70の確立で水滴が落ちる
  if((int)random(0, 70) == 0){
    // 「新しい波紋作っていいですか」のフラグを「いいですよ」にする
    new_hamon_flag = 0;
    // 水滴音を一旦リセットして再生する
    sound.rewind();
    sound.play();
  }
  
  // 波紋は10個用意しており、for文で表示
  for(int hamon_num = 0; hamon_num <= 9; hamon_num++){
    // 波紋の描画関数を実行
    make_hamon(x[hamon_num], y[hamon_num], w[hamon_num], h[hamon_num]);
    // 波紋が広がっていく
    w[hamon_num] += 20;
    h[hamon_num] += 20;
    
    // 新しい波紋作っていいですか」のフラグが「いいですよ」ならば
    if(new_hamon_flag == 0){
      // 波紋の座標を生成
      x[new_hamon] = random(0, 1500);
      y[new_hamon] = random(0, 850);
      w[new_hamon] = 0;
      h[new_hamon] = 0;
      // 次の波紋の番号を用意しておく
      new_hamon++;
      if(new_hamon > 9)  new_hamon = 0;
      // 「新しい波紋作っていいですか」のフラグを「だめですよ」にする
      new_hamon_flag = 1;
    }
  }
}

// 音楽ファイルの停止
void stop()
{
  bgm.close();
  minim.stop();
  super.stop();
}

// 波紋の描画関数
// 引数は座標と円の大きさ
void make_hamon(float x, float y, int w, int h){
  // 塗りつぶさない
  noFill();
  // 色は水色
  stroke(150, 150, 255);
  // 太さは1
  strokeWeight(1);
  // 円を描画
  ellipse(x, y, w, h);
}
