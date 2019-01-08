
//┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
//┃エンディング                                                                         　┃
//┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
//ランキング
public class Ending {
  private Button backbtn;            //BACK ボタン
  private Button rankingbtn;      //RANKING ボタン
  private Button recordbtn;          //RECORD ボタン
  final int nameMax=7;
  private String[] name=new String[this.nameMax];
  private int nameNum;
  private int timeCnt;
  //-----------------------------------------------------------------------------
  //「初期化」タスク生成時に１回だけ行う処理
  //-----------------------------------------------------------------------------
  public Ending() {
    this.backbtn=new Button(200, 550, 120, 40, "BACK");                //BACK　ボタンの生成
    this.rankingbtn=new Button(200, 500, 120, 40, "RANKING");        //RANKING　ボタンの生成
    this.recordbtn=new Button(200, 450, 120, 40, "RECORD");                 //RECORD ボタンの生成
    reStart();
  }

  //-----------------------------------------------------------------------------
  //「実行」１フレーム毎に行う処理
  //------------------------------------------------------------------------------
  public void update() {
    println(game.checkOver()+" "+game.checkClear());

    //メッセージ
    information();
    //BACKボタン
    backbtn.update();
    //RECORDボタン
    recordbtn.update();
    //ランキングボタン
    rankingbtn.update();
  }
  //------------------------------------------------------------------------------
  //メッセージ（時間と名前）
  //------------------------------------------------------------------------------
  private void information() {
    //背景
    fill(255, 255, 255, 125);
    rect(32, 32*3, 32*15, 32*18);
    //文字サイズと色設定
    fill(255, 0, 0);
    textSize(64);
    //状態表示
    if (game.checkClear()) {
      text("GAMECLEAR", 125, 200);
    }        //ゲームクリア
    else {
      text("GAMEOVER", 125, 200);
    }                       //ゲームオーバー

    //時間表示
    text(timeCnt+"s", 175, 300);

    //名前表示

    showName();
  }
  private void showName() {
    //書き込みからの座標
    int sx=120;
    int sy=400;
    String name_="";
    for (String sth : this.name) {
      name_+=sth;
    } 
    text(name_, sx+(32+18), sy);
  }
  public void changeName() {
    if (key==BACKSPACE) {
      this.name[this.nameNum]="?";
      this.nameNum=max(0, --this.nameNum);
    }
    if (!((key>='a'&&key<='z')||(key>='A'&&key<='Z')||(key>='0'&&key<='9')||key==' '))return;
    this.name[this.nameNum]=String.valueOf(key);
    this.nameNum=min(this.nameMax-1, ++this.nameNum);
  }
  public void key() {
    if (keyCode==112) {
      Task=TITLE;
    }
    changeName();
  }
  public void btn() {
    if (backbtn.clicked())Task=TITLE; //nextTask(TITLE);
    if (recordbtn.clicked()&& game.checkClear()) {
      writeRanking();
    }
    if (rankingbtn.clicked())Task=RANKING;
  }
  public void writeRanking() {
    String name="";
    for (String sth : this.name) {
      name+=sth;
    }
    ranking.wirte(name, this.timeCnt);
    Task=RANKING;
  }
  public void setTimeCnt(int timeCnt) {
    this.timeCnt=timeCnt;
  }
  public void reStart() {
    for (int i=0; i<this.nameMax; i++) {
      name[i]="?";
    }
    this.nameNum=0;
    this.timeCnt=9999;
  }
}