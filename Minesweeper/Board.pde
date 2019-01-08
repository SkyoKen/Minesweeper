//┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
//┃ゲーム盤                                                                             　┃
//┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
public class Board { 
  private int[][] data;
  private int[][] cap;
  private int sizeX, sizeY;
  private int size;
  private int mineMax;

  //-----------------------------------------------------------------------------
  //「初期化」タスク生成時に１回だけ行う処理
  //-----------------------------------------------------------------------------
  public Board(int sizeX, int sizeY, int mineMax, int size) {
    //sizeの初期化
    this.sizeX=sizeX;
    this.sizeY=sizeY;
    this.size=size;   
    this.mineMax=mineMax;              //地雷最大値
    set();
  }

  //-----------------------------------------------------------------------------
  //ボードの広さと地雷数を指定してるボードを初期化
  //-----------------------------------------------------------------------------
  public void set() {
    //data配列情報の初期化(boardをクリア)
    this.data=new int[this.sizeY][this.sizeX];
    for (int y=0; y<this.sizeY; y++) {
      for (int x=0; x<this.sizeX; x++) {
        this.data[y][x]=0;
      }
    }
    //埋雷·
    int num=0;
    for (int y=0; y<this.sizeY; y++) {
      for (int x=0; x<this.sizeX; x++) {
        if (num<this.mineMax) {
          this.data[y][x]=9;
          num++;
        }
      }
    }
    //シャッフルして地雷をばらけさせる
    for (int y=0; y<this.sizeY; y++) {
      for (int x=0; x<this.sizeX; x++) {
        int xr=(int)random(this.sizeX);
        int yr=(int)random(this.sizeY);
        int temp=this.data[y][x];
        this.data[y][x]=this.data[yr][xr];
        this.data[yr][xr]=temp;
      }
    }

    //隣接地雷数の書きこみを行う
    for (int y=0; y<this.sizeY; y++) {
      for (int x=0; x<this.sizeX; x++) {
        if (this.data[y][x]==0) {
          this.data[y][x]=cntMine(x, y);
        }
      }
    }

    //cap配列情報の初期化
    this.cap=new int[this.sizeY][this.sizeX];
    for (int y=0; y<this.sizeY; y++) {
      for (int x=0; x<this.sizeX; x++) {
        this.cap[y][x]=1;
      }
    }
  }

  //-----------------------------------------------------------------------------
  //「実行」１フレーム毎に行う処理
  //-----------------------------------------------------------------------------
  public void update() {
    //背景
    fill(107, 142, 35);
    rect(32, 32*3, 32*15, 32*18);
    //描画
    draw2D();
  }
  //-----------------------------------------------------------------------------
  //「２Ｄ描画」１フレーム毎に行う処理
  //-----------------------------------------------------------------------------
  private void  draw2D()
  {
    //文字の色設定
    color[] c=new color[10];
    c[0]=color(255);
    c[1]=color(0, 0, 255);
    c[2]=color(30, 144, 255);
    c[3]=color(152, 251, 152);
    c[4]=color(107, 142, 35);
    c[5]=color(189, 183, 107);
    c[6]=color(255, 69, 0);
    c[7]=color(220, 20, 60);
    c[8]=color(240, 230, 140);
    c[9]=color(255, 215, 0);

    //書き込みからの座標
    int sx=size+6;
    int sy=4*size-4;

    //１２３４５６７８と地雷の表示
    for (int y = 0; y < this.sizeY; ++y) {
      for (int x = 0; x < this.sizeX; ++x) {
        if (this.data[y][x]!=0 && this.data[y][x]!=9) {
          textSize(this.size);
          fill(c[this.data[y][x]]);
          text(this.data[y][x], sx+x*this.size, sy+y*this.size);
        }
        if (this.data[y][x]==9) {
          fill(0);
          ellipse(x*this.size+45, y*this.size+115, 20, 20);
          fill(255);
          ellipse(x*this.size+47, y*this.size+110, 5, 5);
          fill(255, 0, 0);
          text("*", x*this.size+47, y*this.size+120);
        }
      }
    }

    //書き込みからの座標
    sx=this.size;
    sy=this.size*3;

    //cap表示
    for (int y = 0; y < sizeY; ++y) {
      for (int x = 0; x < sizeX; ++x) {
        switch(cap[y][x]) {
        case 0:
          break;
        case 1:
          fill(255, 255, 255);
          rect(sx+x*size, sy+y*size, size-1, size-1);
          break;
        case 2:
          fill(255, 255, 255);
          rect(sx+x*size, sy+y*size, size-1, size-1);
          fill(255, 0, 0);
          triangle(sx+x*size+10, sy+y*size+5, sx+x*size+10, sy+y*size+20, sx+x*size+25, sy+y*size+10);
          fill(218, 165, 32);
          rect(sx+x*size+8, sy+y*size+5, 2, 25);
          break;
        case 3:
          fill(255, 255, 255);
          rect(sx+x*size, sy+y*size, size-1, size-1);
          fill(0);
          text("?", sx+x*size+8, sy+y*size+28);
          break;
        }
      }
    }
  }

  //-----------------------------------------------------------------------------
  //隣接8マスの地雷数を返す
  //-----------------------------------------------------------------------------
  public int cntMine(int x_, int y_) {

    PVector m[]=new PVector[8];
    m[0]=new PVector(-1, -1); 
    m[1]=new PVector(0, -1); 
    m[2]=new PVector(+1, -1);
    m[3]=new PVector(-1, 0);                         
    m[4]=new PVector(+1, 0);
    m[5]=new PVector(-1, +1); 
    m[6]=new PVector(0, +1); 
    m[7]=new PVector(+1, +1);
    for (int i=0; i<8; i++) {
      m[i].x+=x_;
      m[i].y+=y_;
    }

    //地雷数を調べる
    int cnt=0;
    for (int i=0; i<8; i++) {
      //範囲外チェック
      /*if(m[i].x<0){continue;}
       if(m[i].y<0){continue;}
       if(m[i].x>sizeX){continue;}
       if(m[i].y>sizeY){continue;}
       */
      if (m[i].x>=0 && m[i].x<this.sizeX &&
        m[i].y>=0 && m[i].y<this.sizeY) {
        if (this.data[(int)m[i].y][(int)m[i].x]==9) {
          cnt++;
        }
      }
    }
    return cnt;
  }

  //-----------------------------------------------------------------------------
  //隣接する８マスを地雷数を数える
  //-----------------------------------------------------------------------------
  public int checkMine(int x_, int  y_) {

    //隣接する８マスを再帰で調べる
    PVector m[]=new PVector[8];
    m[0]=new PVector(-1, -1); 
    m[1]=new PVector(0, -1); 
    m[2]=new PVector(+1, -1);
    m[3]=new PVector(-1, 0);                         
    m[4]=new PVector(+1, 0);
    m[5]=new PVector(-1, +1); 
    m[6]=new PVector(0, +1); 
    m[7]=new PVector(+1, +1);

    for (int i=0; i<8; i++) {
      m[i].x+=x_;
      m[i].y+=y_;
    }

    //地雷数を調べる
    int cnt=0;
    for (int i=0; i<8; i++) {
      //範囲チェック
      if (m[i].x>=0 && m[i].x<this.sizeX &&
        m[i].y>=0 && m[i].y<this.sizeY) {
        if (this.cap[(int)m[i].y][(int)m[i].x]==2 && this.data[(int)m[i].y][(int)m[i].x]==9) {
          cnt++;
        }
      }
    }
    return cnt;
  }

  //------------------------------------------------------------------------------
  //開封する
  //-----------------------------------------------------------------------------
  public void SearchAndOpen(PVector pos_) {
    SearchAndOpen_Sub((int)pos_.x, (int)pos_.y);
  }

  //------------------------------------------------------------------------------
  //隣接する８マスを開封する
  //------------------------------------------------------------------------------
  public void SearchAndOpen_Sub(int x_, int y_) {

    //探す終了
    if (this.cap[y_][x_]==0) {
      return;
    }

    //足元のcapを開封
    this.cap[y_][x_]=0;

    //足元が空白以外なら探す終了
    if (this.data[y_][x_]!=0) {
      return;
    }

    //隣接する８マスを再帰で調べる
    PVector m[]=new PVector[8];
    m[0]=new PVector(-1, -1); 
    m[1]=new PVector(0, -1); 
    m[2]=new PVector(+1, -1);
    m[3]=new PVector(-1, 0);                         
    m[4]=new PVector(+1, 0);
    m[5]=new PVector(-1, +1); 
    m[6]=new PVector(-1, +1); 
    m[7]=new PVector(+1, +1);

    for (int i=0; i<8; i++) {
      m[i].x+=x_;
      m[i].y+=y_;
    }

    for (int i=0; i<8; i++) {
      //範囲チェック
      if (m[i].x>=0 && m[i].x<this.sizeX &&
        m[i].y>=0 && m[i].y<this.sizeY) {
        SearchAndOpen_Sub((int)m[i].x, (int)m[i].y);
      }
    }
  }

  //------------------------------------------------------------------------------
  //作弊大法好
  //------------------------------------------------------------------------------
  public void SearchAndOpenAgian(int x_, int y_) {

    //隣接する８マスを再帰で調べる
    PVector m[]=new PVector[8];
    m[0]=new PVector(-1, -1); 
    m[1]=new PVector(0, -1); 
    m[2]=new PVector(+1, -1);
    m[3]=new PVector(-1, 0);                         
    m[4]=new PVector(+1, 0);
    m[5]=new PVector(-1, +1); 
    m[6]=new PVector(-1, +1); 
    m[7]=new PVector(+1, +1);

    for (int i=0; i<8; i++) {
      m[i].x+=x_;
      m[i].y+=y_;
    }

    for (int i=0; i<8; i++) {
      //範囲チェック
      if (m[i].x>=0 && m[i].x<this.sizeX &&
        m[i].y>=0 && m[i].y<this.sizeY) {
        if (this.data[(int)m[i].y][(int)m[i].x]!=9) {
          if (this.cap[(int)m[i].y][(int)m[i].x]==1) {
            this.cap[(int)m[i].y][(int)m[i].x]=0;
          }
        }
      }
    }
  }
  //------------------------------------------------------------------------------
  //·クリア判定
  //------------------------------------------------------------------------------
  public boolean checkClear() {

    for (int y=0; y<this.sizeY; y++) {
      for (int  x=0; x<this.sizeX; x++) {
        //地雷あり、FLAGを立ててある
        if (this.data[y][x] == 9 && this.cap[y][x] == 2) { 
          continue;
        }
        //地雷なく、開封済みである
        if (this.data[y][x] != 9 && this.cap[y][x] == 0) { 
          continue;
        }
        return false;
      }
    }
    return true;
  }
  //------------------------------------------------------------------------------
  //オーバー判定
  //------------------------------------------------------------------------------
  public boolean checkOver() {
    for (int y = 0; y < this.sizeY; ++y) {
      for (int x = 0; x < this.sizeX; ++x) {
        //地雷あり、開封済みである
        if (this.data[y][x] == 9 && this.cap[y][x] == 0) { 
          return true;
        }
      }
    }
    return false;
  }
  public void L(PVector masu) {
    if (this.cap[(int)masu.y][(int)masu.x]==1) {
      //開封
      SearchAndOpen(masu);
    }
  }
  public void C(PVector masu) {
    //指定座標のcapを変える(開封ではない)
    if (this.cap[(int)masu.y][(int)masu.x]==0) {
      if (this.data[(int)masu.y][(int)masu.x]==cntMine((int)masu.x, (int)masu.y)) {
        //開封
        SearchAndOpenAgian((int)masu.x, (int)masu.y);
      }
    }
  }
  public void R(PVector masu) {
    //指定座標のcapを変える(開封ではない)
    if (this.cap[(int)masu.y][(int)masu.x]!=0) {
      //cap
      if (this.cap[(int)masu.y][(int)masu.x]!=3) {
        this.cap[(int)masu.y][(int)masu.x]++;
      } else {
        this.cap[(int)masu.y][(int)masu.x]=1;
      }
      //data(作用忘れた)
      if (this.data[(int)masu.y][(int)masu.x]==9) {
        if (this.cap[(int)masu.y][(int)masu.x]==2) {
          game.setMineNum(-1);
        }
        if (this.cap[(int)masu.y][(int)masu.x]==3) {
          //   game.setMineNum(1);//?????
        }
      }
    }
  }
}