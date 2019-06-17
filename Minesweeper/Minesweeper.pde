//-----------------------------------------------------------------------------
//タイトル：  マインスイーパー (マウス操作)    
//作成日：    2017/09/04
//修正日：    2018/11/15
//-----------------------------------------------------------------------------
//一言
//★HTMLの場合は、ファイルに記録を書き込めない（pdeで実行する場合、異常なし）
//★ranking.CSV


PFont font;                  //文字フォント
int Task;

final int TITLE =0;
final int GAME=1;
final int ENDING=2;
final int RANKING=3;
boolean pressKey=false;
boolean pressMouse=false;
Title title=new Title();
Game game=new Game();
Ending ending=new Ending();
Ranking ranking;//=new Ranking();
//-----------------------------------------------------------------------------
//「初期化」タスク生成時に１回だけ行う処理
//-----------------------------------------------------------------------------
void setup() {
  size(540, 720);           //ウインドウ設定
  fill(0, 0, 0);              //塗りつぶし初期値
  font = createFont("MS Gothic", height*0.1, true);
  textFont(font);
  //noStroke();
  ranking=new Ranking();
  Task=TITLE;
}

//-----------------------------------------------------------------------------
//「実行」１フレーム毎に行う処理
//-----------------------------------------------------------------------------
void draw() {
  background(0);            // 背景の初期化(フラッシュ)
  update();
}

//-----------------------------------------------------------------------------
//「キーボードから指が離れたときに呼び出される関数」
//-----------------------------------------------------------------------------
void keyReleased() {
  pressKey=!pressKey;
 switch(Task) {
  default:
    break;
  case RANKING:
    ranking.key();
    break;
  case ENDING:
    ending.key();
    break;
  case GAME:
    game.key();
    break;
  case TITLE:
    title.key();
    break;
  }
 pressKey=false;
}
//-----------------------------------------------------------------------------
//「マウスボタンから指が離れたときに呼び出される関数」
//-----------------------------------------------------------------------------

void mouseReleased() {
  pressMouse=!pressKey;
  switch(Task) {
  default:
    break;
  case RANKING:
    ranking.btn();
    break;
  case ENDING:
    ending.btn();
    break;
  case GAME:
    game.btn();
    break;
  case TITLE:
    title.btn();
  }
  pressMouse=false;
}

void update() {
  switch(Task) {
  case TITLE:
    title.update();
    break;
  case GAME:
    game.update();
    break;
  case ENDING:
    ending.update();
    break;
  case RANKING:
    ranking.update();
    break;
  default:
    break;
  }
}
