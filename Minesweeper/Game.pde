//┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
//┃ゲーム本編                                                                  　　         　┃
//┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
public class Game {
  private Board board;                //ゲーム盤
  private Button restartbtn;              //リセット　ボタン
  private boolean gameover, gameclear;
  private int mineMax, mine;
  private int sizeX, sizeY;
  private int timeCnt;
  private int size;
  //-----------------------------------------------------------------------------
  //「初期化」タスク生成時に１回だけ行う処理
  //-----------------------------------------------------------------------------
  public Game() {
    this.gameover=false;          //ゲームオーバーフラグ
    this.gameclear=false;         //ゲームクリアフラグ
    this.mineMax=15;              //地雷最大値
    this.mine=mineMax;            //残り地雷の値
    this.size=32;
    this.sizeX=15;
    this.sizeY=18;
    //ゲーム盤の生成
    this.board = new Board(this.sizeX, this.sizeY, mineMax, this.size);
    this.restartbtn=new Button(50, 30, 120, 40, "RESTART");
  }
  //-----------------------------------------------------------------------------
  //「実行」１フレーム毎に行う処理
  //-----------------------------------------------------------------------------
  public void update() {
    //ゲーム盤
    this.board.update();
    //ゲーム情報
    showInfo();
    this.restartbtn.update();

    timeCnt++;
    //エンディング

    if (gameover|| gameclear)ending();
  }
  private void showInfo() {
    //文字サイズ変更
    textSize(32);
    //時間表示
    text(timeCnt/60+"s", 100, 700);
    //地雷数表示
    text("地雷総数:"+mineMax+"  残り:"+mine, 200, 32*2);
  }
  private void ending() {
    ending.setTimeCnt(this.timeCnt/60);
    Task=ENDING;
  }
  //-----------------------------------------------------------------------------
  //「ゲームリセット」
  //-----------------------------------------------------------------------------
  public void reStart() {
    board.set();             //ゲーム盤リセット
    this.gameover=false;          //ゲームオーバー
    this.gameclear=false;         //ゲームクリア
    this.mine=mineMax;            //残り地雷
    this.timeCnt=0;            //時間
    ending.reStart();
    ranking.reStart();
    Task=GAME;
  }
  public void key() {
    if (keyCode==112) {
      ending();
    }
  }
  public void btn() {
    //リセットボタンが押されたらゲームリセットする
    if (this.restartbtn.clicked()) {
      reStart();
    }  
    if ( mouseButton == RIGHT) {
      R();
    }
    if ( mouseButton == LEFT) {
      L();
    }
    if (mouseButton == CENTER) {
      C();
    }  

    gameclear=board.checkClear();
    gameover=board.checkOver();
  }
  private void L() {
    //範囲確認 
    int sx=28;
    int sy=98;
    PVector pos=new PVector(mouseX, mouseY);
    if (pos.x >= 0+sx && pos.x < this.size*this.sizeX+sx &&
      pos.y >= 0+sy && pos.y < this.size*this.sizeY+sy) {
      //マス単位の座標に変える
      PVector masu = new PVector((pos.x-sx)/this.size, (pos.y-sy)/this.size);
      //指定座標のcapを変える(開封ではない)
      board.L(masu);
    }
  }
  private void C() {
    //範囲確認
    int sx=28;
    int sy=98;

    PVector pos=new PVector(mouseX, mouseY);
    if (pos.x >= 0+sx && pos.x <this.size*this.sizeX+sx &&
      pos.y >= 0+sy && pos.y < this.size*this.sizeY+sy) {
      //マス単位の座標に変える
      PVector masu = new PVector((pos.x-sx)/this.size, (pos.y-sy)/this.size);
      board.C(masu);
    }
  }
  private void R() {

    //範囲確認
    int sx=28;
    int sy=98;
    PVector pos=new PVector(mouseX, mouseY);
    if (pos.x >= 0+sx && pos.x < this.size*this.sizeX+sx &&
      pos.y >= 0+sy && pos.y < this.size*this.sizeY+sy) {
      //マス単位の座標に変える
      PVector masu = new PVector((pos.x-sx)/this.size, (pos.y-sy)/this.size);
      //指定座標のcapを変える(開封ではない)
      board.R(masu);
    }
  }
  public boolean checkOver() {
    return this.gameover;
  }
  public boolean checkClear() {
    return this.gameclear;
  }
  public void setMineNum(int index) {
    this.mine+=index;
  }
}