
//┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
//┃ランキング                                                                           　┃
//┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
public class Ranking {
  private Button backbtn;
  private String[][]data=new String[5][2];
  private String fileName="./ranking.csv";
  private int y=5, x=2;
  private boolean change=false;
  //-----------------------------------------------------------------------------
  //「初期化」タスク生成時に１回だけ行う処理
  //-----------------------------------------------------------------------------
  public Ranking() {
    this.backbtn=new Button(200, 650, 120, 40, " BACK");                //BACK　ボタンの生成
    reStart();
  }

  //-----------------------------------------------------------------------------
  //記録ファイルの作成
  //-----------------------------------------------------------------------------
  public void createCSV() {
    println(this.fileName+"が存在しません。");
    println("ファイル生成中");
    noFill();
    PrintWriter output = createWriter(this.fileName);
    for (int y = 0; y < this.y; y++) {
      String rowStr = "???????,999";
      output.println(rowStr);
    }
    output.flush();
    output.close();
    println(fileName+"保存完了");
  }
  //-----------------------------------------------------------------------------
  //記録の読み込み
  //-----------------------------------------------------------------------------
  void update() {
    //背景
    fill(0);
    rect(0, 0, 540, 720);
    //"RANKING"表示
    fill(255, 0, 0);
    textSize(64);
    text("Rangking", 150, 200);
    //記録表示
    textSize(32);

    for (int  y= 0; y < this.y; y++) {
      text(String.format("%d.　%7s　%3ss", y+1, data[y][0], data[y][1]), 150, 200+75*(y+1));
    }
    backbtn.update();
  }
  void loadData() {
    if (loadStrings(this.fileName)==null)createCSV();
    String[] file = loadStrings(this.fileName);
    for (int y=0; y < this.y; y++) {
      String tmp[] = split(file[y], ',');
      for (int x=0; x < this.x; x++) {
        data[y][x] = tmp[x];
        print(data[y][x]+" ");
      }
      println();
    }
    println("loadfile sucessed");
  }
  public void key() {
    // if(keyCode==112){Task=ENDING;}
  }
  public void btn() {
    if (backbtn.clicked())Task=TITLE;
  }
  //-----------------------------------------------------------------------------
  //記録と比較する
  //-----------------------------------------------------------------------------
  boolean compare(int timeCnt) {
    for (int i = 0; i < this.y; i++) {
      if (timeCnt<Integer.parseInt(data[i][1]) )return true;
    }
    return false;
  }
  //-----------------------------------------------------------------------------
  //名次を得る
  //-----------------------------------------------------------------------------
  int getRanking(int timeCnt) {
    for (int i = 0; i < this.y; i++) {
      if (timeCnt<Integer.parseInt(data[i][1]) )return i;
    }
    return -1;
  }
  //-----------------------------------------------------------------------------
  //記録
  //-----------------------------------------------------------------------------
  void wirte(String name, int timeCnt) {
    //記録より早い場合
    if (!compare(timeCnt)||this.change) return;
    println("wirte");
    int i=getRanking(timeCnt);              //名次を得る
    String[]tmp={this.data[i][0], this.data[i][1]};
    this.change=true;                        //変更開始
    this.data[min(i+1, this.y)]=tmp;
    this.data[i][1]=String.valueOf(timeCnt);        //記録時間の変更
    //記録名前の変更
    this.data[i][0]=name;          

    PrintWriter output = createWriter(this.fileName);
    for (int y = 0; y < this.y; y++) {
      String rowStr = this.data[y][0]+","+this.data[y][1];
      output.println(rowStr);
    }
    output.flush();
    output.close();
    println(fileName+"保存完了");
  }
  public void reStart() {
    this.change=false;
    loadData();
  }
}