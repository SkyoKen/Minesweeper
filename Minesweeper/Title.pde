//┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
//┃タイトル                                                                  　　         　┃
//┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
public class Title {
  private Button startbtn;        //BACK ボタン
  private Button rankingbtn;      //RANKING ボタン
  private Button exitbtn;      //EXIT ボタン
  //-----------------------------------------------------------------------------
  //「初期化」タスク生成時に１回だけ行う処理
  //-----------------------------------------------------------------------------

  public Title() {
    this.startbtn=new Button(200, 500, 120, 40, "START");            //BACK　ボタンの生成
    this.rankingbtn=new Button(200, 550, 120, 40, "RANKING");        //RANKING　ボタンの生成
    this.exitbtn=new Button(200, 600, 120, 40, "EXIT");        //EXIT　ボタンの生成
  }
  //-----------------------------------------------------------------------------
  //「実行」１フレーム毎に行う処理
  //------------------------------------------------------------------------------
  public void update() {
    startbtn.update();
    //ランキングボタン
    rankingbtn.update();
    exitbtn.update();
    //  if(key =='a'&&pressKey){Task=GAME;keyBack();}
  }
  public void key() {
    if (keyCode==112)game.reStart();
  }
  public void btn() {
    if (startbtn.clicked())game.reStart();
    if (rankingbtn.clicked())Task=RANKING;
    if (exitbtn.clicked())exit();
  }
}