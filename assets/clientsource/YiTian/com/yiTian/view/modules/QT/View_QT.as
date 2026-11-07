package com.yiTian.view.modules.QT
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class View_QT extends Sprite
   {
      
      private static var _instance:View_QT;
      
      private var _icon:MainUIBtn;
      
      private var getBtn:Button;
      
      private var bm1:Sprite;
      
      private var bm2:Sprite;
      
      private var bm3:Sprite;
      
      private var bm1_big:Bitmap;
      
      private var bm2_big:Bitmap;
      
      private var bm3_big:Bitmap;
      
      public function View_QT()
      {
         super();
         this.initUI2();
      }
      
      public static function get instance() : View_QT
      {
         if(!_instance)
         {
            _instance = new View_QT();
         }
         return _instance;
      }
      
      protected function initUI2() : void
      {
         var downLoadTxt:MyTextField;
         var prizeArr:Array = null;
         var i:int = 0;
         var grid:View_Grid = null;
         var vo:Vo_item = null;
         var prize:Array = null;
         ComponentUtil.getBitmap("Back_QTHD",this,{
            "x":37,
            "y":52
         },Global.QTHDdm);
         this.bm1 = new Sprite();
         addChild(this.bm1);
         this.bm2 = new Sprite();
         addChild(this.bm2);
         this.bm3 = new Sprite();
         addChild(this.bm3);
         ComponentUtil.getBitmap("MMoneX",this.bm1,{
            "x":50,
            "y":321
         },Global.QTHDdm);
         ComponentUtil.getBitmap("MMtwoX",this.bm2,{
            "x":547,
            "y":121
         },Global.QTHDdm);
         ComponentUtil.getBitmap("MMfreeX",this.bm3,{
            "x":198,
            "y":63
         },Global.QTHDdm);
         this.bm1.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.bm2.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.bm3.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.bm1.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.bm2.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.bm3.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         ComponentUtil.getBitmap("Text_WCHL",this,{
            "x":123,
            "y":112
         },Global.QTHDdm);
         ComponentUtil.getBitmap("Icon_QT",this,{
            "x":138,
            "y":65
         },Global.QTHDdm);
         ComponentUtil.getBitmap("Icon_YiTian",this,{
            "x":49,
            "y":63
         },Global.QTHDdm);
         ComponentUtil.getBitmap("Text_ErCL",this,{
            "x":92,
            "y":192
         },Global.QTHDdm);
         ComponentUtil.getBitmap("Text_SanCL",this,{
            "x":92,
            "y":220
         },Global.QTHDdm);
         ComponentUtil.getBitmap("Text_SiCL",this,{
            "x":92,
            "y":270
         },Global.QTHDdm);
         ComponentUtil.getBitmap("Text_YiCL",this,{
            "x":92,
            "y":164
         },Global.QTHDdm);
         ComponentUtil.getBitmap("Text_WCHL",this,{
            "x":123,
            "y":112
         },Global.QTHDdm);
         this.getBtn = ComponentUtil.getButton("","Button_LJLQ",this,{
            "x":526,
            "y":351,
            "textColor":16771436
         },Global.QTHDdm);
         this.getBtn.callBack = function():void
         {
            navigateToURL(new URLRequest("http://qt.qq.com/go.html?roomid=5151&ADTAG=qtweb.yl.ghd21"));
         };
         ComponentUtil.getBitmap("Back_HDJLYL",this,{
            "x":198,
            "y":320
         },Global.QTHDdm);
         prizeArr = ["1_46255_1","1_46887_1","1_46221_1","1_44520_1","1_46570_1"];
         i = 0;
         while(i < 5)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.set_tf_count();
            grid.x = 198 + i * 62;
            grid.y = 349;
            addChild(grid);
            vo = new Vo_item();
            prize = (prizeArr[i] as String).split("_");
            vo.id = prize[1];
            vo.count = prize[2];
            vo.Init_lib();
            grid.vo = vo;
            i++;
         }
         ComponentUtil.getTextField("QT5151每5分钟抽取一次摇摇乐礼包。",this,{
            "x":157,
            "y":163,
            "color":16708081,
            "size":12,
            "leading":0,
            "filters":[]
         });
         ComponentUtil.getTextField("QT5151每晚7点半、8点半、9点半美女主播报题目，玩家抢答赢礼包。",this,{
            "x":157,
            "y":190,
            "color":16708081,
            "size":12,
            "leading":0,
            "filters":[]
         });
         ComponentUtil.getTextField("用户在QT5151每天停留5个小时可获得一张兑换券，集齐1、3、7、15张兑换卷可兑换QT特\n" + "权中心不同价值的礼包，最高价值500QB。",this,{
            "x":157,
            "y":219,
            "color":16708081,
            "size":12,
            "leading":4,
            "filters":[]
         });
         ComponentUtil.getTextField("每周五或周六，QT5151美女主播齐聚首，为玩家们带来倚天专题晚会，更有绝版礼\n" + "包发放，最高价值超过800QB哦！",this,{
            "x":157,
            "y":269,
            "color":16708081,
            "size":12,
            "leading":4,
            "filters":[]
         });
         ComponentUtil.getTextField("注：下载并安装QT，才能进入QT5151",this,{
            "x":49,
            "y":414,
            "color":15385075,
            "size":12,
            "leading":0,
            "filters":[],
            "bold":true
         });
         downLoadTxt = ComponentUtil.getTextField("",this,{
            "x":278,
            "y":414,
            "color":327424,
            "size":12,
            "leading":0,
            "filters":[],
            "bold":true,
            "underline":true
         });
         downLoadTxt.mouseEnabled = true;
         downLoadTxt.htmlText = HtmlUtil.makeLink("点击下载","http://qt.qq.com/download.php");
         this.bm1_big = ComponentUtil.getBitmap("MMone",this,{
            "x":115,
            "y":231
         },Global.QTHDdm);
         this.bm2_big = ComponentUtil.getBitmap("MMtwo",this,{
            "x":415,
            "y":186
         },Global.QTHDdm);
         this.bm3_big = ComponentUtil.getBitmap("MMfree",this,{
            "x":278,
            "y":143
         },Global.QTHDdm);
         this.bm1_big.visible = false;
         this.bm2_big.visible = false;
         this.bm3_big.visible = false;
      }
      
      private function onRollOver(e:MouseEvent) : void
      {
         switch(e.currentTarget)
         {
            case this.bm1:
               this.bm1_big.visible = true;
               Tween.to(this.bm1_big,500,{
                  "scaleX":[0.6,1],
                  "scaleY":[0.6,1],
                  "x":[50,115],
                  "y":[321,231]
               });
               break;
            case this.bm2:
               this.bm2_big.visible = true;
               Tween.to(this.bm2_big,500,{
                  "scaleX":[0.6,1],
                  "scaleY":[0.6,1],
                  "x":[547,415],
                  "y":[121,186]
               });
               break;
            case this.bm3:
               this.bm3_big.visible = true;
               Tween.to(this.bm3_big,500,{
                  "scaleX":[0.6,1],
                  "scaleY":[0.6,1],
                  "x":[198,278],
                  "y":[63,143]
               });
         }
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         switch(e.currentTarget)
         {
            case this.bm1:
               Tween.curTo(this.bm1_big,500,{
                  "scaleX":0.6,
                  "scaleY":0.6,
                  "x":50,
                  "y":321
               },this.onHide1);
               break;
            case this.bm2:
               Tween.curTo(this.bm2_big,500,{
                  "scaleX":0.6,
                  "scaleY":0.6,
                  "x":547,
                  "y":121
               },this.onHide2);
               break;
            case this.bm3:
               Tween.curTo(this.bm3_big,500,{
                  "scaleX":0.6,
                  "scaleY":0.6,
                  "x":198,
                  "y":63
               },this.onHide3);
         }
      }
      
      private function onHide1() : void
      {
         this.bm1_big.visible = false;
      }
      
      private function onHide2() : void
      {
         this.bm2_big.visible = false;
      }
      
      private function onHide3() : void
      {
         this.bm3_big.visible = false;
      }
      
      public function get icon() : MainUIBtn
      {
         return this._icon;
      }
   }
}

