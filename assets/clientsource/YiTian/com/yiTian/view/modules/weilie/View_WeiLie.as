package com.yiTian.view.modules.weilie
{
   import com.ui.controls.Button;
   import com.ui.controls.MaskProgressBar2;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_WeiLie;
   import com.yiTian.data.vo.Vo_WeiLie;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.WeiLieCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class View_WeiLie extends Panel123
   {
      
      private static var isMoving:Boolean;
      
      private static var MAX:int = 10;
      
      public static const STAND:int = 1;
      
      public static const SHOT:int = 2;
      
      public static const JT_X:int = 500;
      
      public static const JT_Y:int = 292;
      
      private var lastPer:Number;
      
      private var timeFlag:int;
      
      private var currentIndex:int;
      
      private var gridVec:Vector.<Child_Guoshi>;
      
      private var tf_vec:Vector.<Child_WLItem>;
      
      private var ppVec:Vector.<Point>;
      
      private var tipBm:Bitmap;
      
      private var tipTF:MyTextField;
      
      private var Button_Close:Button;
      
      private var tfCon:Sprite;
      
      private var tfMask:Shape;
      
      private var tt:MyTextField;
      
      private var countTF:MyTextField;
      
      private var progressBar:MaskProgressBar2;
      
      public var getBtn:Button;
      
      private var cc:Child_Shoter;
      
      private var barMask:Shape;
      
      public var jiantou:JianTou;
      
      private var tfMap:Bitmap;
      
      private var _title:String = "Title_QXWL";
      
      public function View_WeiLie()
      {
         super();
      }
      
      public static function get instance() : View_WeiLie
      {
         return Singleton.getInstance(View_WeiLie);
      }
      
      public function loadlib() : void
      {
         regResource("lang/ch/QXWL.swf","QXWLdm");
      }
      
      override protected function initUI2() : void
      {
         var bitmap:BitmapData;
         var bgBar:Sprite = null;
         var countSpr:Sprite = null;
         var grid:Child_Guoshi = null;
         var vo:Vo_item = null;
         var data:Array = null;
         var i:int = 0;
         var arr:Array = null;
         this.ppVec = new Vector.<Point>();
         this.ppVec.push(new Point(98,129));
         this.ppVec.push(new Point(93,241));
         this.ppVec.push(new Point(218,209));
         this.ppVec.push(new Point(167,158));
         this.ppVec.push(new Point(218,88));
         this.ppVec.push(new Point(275,123));
         this.ppVec.push(new Point(352,122));
         this.ppVec.push(new Point(416,170));
         this.ppVec.push(new Point(427,102));
         this.ppVec.push(new Point(494,110));
         this.ppVec.push(new Point(545,149));
         this.ppVec.push(new Point(591,100));
         this.gridVec = new Vector.<Child_Guoshi>();
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":888,
            "height":568
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":838,
            "height":518
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":814,
            "height":494
         },Global.QXWLdm);
         ComponentUtil.getBitmap(this._title,this,{
            "x":364,
            "y":5
         },Global.QXWLdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":853,
            "y":6,
            "textColor":16771436,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_QXWL",this,{
            "x":44,
            "y":59
         },Global.QXWLdm);
         ComponentUtil.getBitmap("Back_HuoDeZhe",this,{
            "x":44,
            "y":415
         },Global.QXWLdm);
         ComponentUtil.getBitmap("Back_JDTDH",this,{
            "x":734,
            "y":78
         },Global.QXWLdm);
         bgBar = new Sprite();
         this.addChild(bgBar);
         this.barMask = ComponentUtil.getShape(99,478);
         bgBar.addChild(this.barMask);
         bgBar.mask = this.barMask;
         ComponentUtil.setPropertie(bgBar,{
            "x":734,
            "y":78
         });
         ComponentUtil.getBitmap("Back_JDTD2",bgBar,{
            "x":0,
            "y":0
         },Global.QXWLdm);
         this.progressBar = new MaskProgressBar2(ComponentUtil.getBitmap("Back_JDT",this,{
            "x":100,
            "y":37
         },Global.QXWLdm));
         addChild(this.progressBar);
         this.progressBar.x = 750;
         this.progressBar.y = 550;
         this.progressBar.rotation = 270;
         this.getBtn = ComponentUtil.getButton("","Button_SheLie",this,{
            "x":756,
            "y":460,
            "textColor":16771436
         },Global.QXWLdm);
         countSpr = new Sprite();
         this.addChild(countSpr);
         this.tipBm = ComponentUtil.getBitmap("cishu_tis",countSpr,{
            "x":2,
            "y":2
         },Global.New_Imgsdm);
         this.jiantou = new JianTou();
         this.jiantou.visible = false;
         ComponentUtil.setPropertie(this.jiantou,{
            "x":JT_X,
            "y":JT_Y
         });
         this.addChild(this.jiantou);
         this.countTF = ComponentUtil.getTextField("",countSpr,{
            "size":11,
            "color":16771584,
            "x":this.tipBm.x + this.tipBm.width / 2 - 2.5,
            "y":5
         },"center");
         ComponentUtil.setPropertie(countSpr,{
            "x":817,
            "y":480
         });
         this.tt = ComponentUtil.getTextField("100/5555555552000",this,{
            "x":761,
            "y":280,
            "color":65535,
            "size":12,
            "visible":false,
            "leading":0,
            "rotation":-90
         });
         bitmap = new BitmapData(this.tt.width + 1,this.tt.height + 1,true,16777215);
         bitmap.draw(this.tt);
         this.tfMap = new Bitmap(bitmap);
         addChild(this.tfMap);
         this.tfMap.x = this.tt.x + 20;
         this.tfMap.y = this.tt.y + 30;
         this.tfMap.rotation = -90;
         data = Model_WeiLie.ins(this._title)._lib.toArray();
         data.sortOn("3",Array.NUMERIC);
         i = 0;
         while(i < 12)
         {
            grid = Child_Guoshi.item;
            grid.x = this.ppVec[i].x;
            grid.y = this.ppVec[i].y;
            grid.index = data[i][0];
            arr = data[i][1].split("_");
            grid.setVo(arr[2],arr[1]);
            this.addChild(grid);
            this.gridVec.push(grid);
            i++;
         }
         this.tf_vec = new Vector.<Child_WLItem>();
         this.tfCon = new Sprite();
         this.tfCon.x = 50;
         this.tfCon.y = 440;
         this.addChild(this.tfCon);
         this.tfMask = ComponentUtil.getShape(258,100);
         this.tfCon.addChild(this.tfMask);
         this.tfCon.mask = this.tfMask;
         move = new Rectangle(0,0,840,30);
         this.cc = new Child_Shoter();
         ComponentUtil.setPropertie(this.cc,{
            "x":650,
            "y":372
         });
         this.cc.title = this._title;
         this.addChild(this.cc);
         this.cc.show();
         this.getBtn.callBack = function():void
         {
            if(GameUnitManager.hero.level < 30)
            {
               UIManager.centerBroadcast.addGirdMsg("等级不足，无法射猎");
               return;
            }
            if(Model_WeiLie.ins(_title).isRunning)
            {
               return;
            }
            Model_WeiLie.ins(_title).isRunning = true;
            WeiLieCGMessage.CG_WEILIE_SHOT(_title);
         };
      }
      
      public function updateNameTxt() : void
      {
         var i:int;
         var addItem:Function;
         var len:int = 0;
         this.dispose();
         len = int(Model_WeiLie.ins(this._title).data_log.length);
         i = 0;
         if(Boolean(len))
         {
            addItem = function(_index:int):void
            {
               var _len:int;
               var vo:Vo_WeiLie = null;
               var tf:Child_WLItem = null;
               var __ttY:int = 0;
               var _y:int = 0;
               if(_index >= len)
               {
                  return;
               }
               if(!visible)
               {
                  return;
               }
               vo = Model_WeiLie.ins(_title).data_log[_index];
               tf = Child_WLItem.getTF();
               ComponentUtil.setPropertie(tf,{"y":120});
               tfCon.addChild(tf);
               _len = int(tf_vec.length);
               if(_len > 0)
               {
                  __ttY = tf_vec[_len - 1].y + tf_vec[_len - 1].height;
               }
               else
               {
                  __ttY = 20 * _index;
               }
               _y = __ttY;
               tf.visible = true;
               tf.setdata(vo,_title);
               tf_vec.push(tf);
               Tween.to(tf,300,{"y":[tf.y,_y]},function():void
               {
                  addItem(++_index);
               });
            };
            addItem(0);
         }
      }
      
      private function popInTxt() : void
      {
         var len:int;
         var tf:Child_WLItem = null;
         var _y:int = 0;
         var i:int = 0;
         var tempT:Child_WLItem = null;
         var gapLen:int = 0;
         var __y:int = 0;
         var _tf:Child_WLItem = null;
         tf = Child_WLItem.getTF();
         this.tfCon.addChild(tf);
         ComponentUtil.setPropertie(tf,{"y":120});
         tf.visible = true;
         tf.setdata(Model_WeiLie.ins(this._title).nowVo,this._title);
         len = int(this.tf_vec.length);
         if(len >= 5)
         {
            _y = this.tf_vec[len - 1].y;
            Tween.to(tf,300,{"y":[tf.y,_y]},function(temTf:Child_WLItem):void
            {
               var tt:Child_WLItem = tf_vec.shift();
               if(Boolean(tt) && Boolean(tt.parent))
               {
                  tfCon.removeChild(tt);
               }
            });
            i = 0;
            while(i < len)
            {
               tempT = this.tf_vec[i];
               if(i == 0)
               {
                  gapLen = 20;
               }
               else
               {
                  gapLen = this.tf_vec[i - 1].height;
               }
               Tween.to(tempT,300,{"y":[tempT.y,tempT.y - gapLen]});
               i++;
            }
            this.tf_vec.push(tf);
         }
         else
         {
            if(len > 0)
            {
               _tf = this.tf_vec[len - 1];
               __y = _tf.y + _tf.height;
            }
            else
            {
               __y = 0;
            }
            Tween.to(tf,300,{"y":[tf.y,__y]},function(temTf:Child_WLItem):void
            {
               tf_vec.push(tf);
            });
         }
      }
      
      private function playEnd() : void
      {
         Model_WeiLie.ins(this._title).isRunning = false;
         this.getBtn.enabled = Model_WeiLie.ins(this._title).time != 0;
         this.tt.htmlText = Model_WeiLie.ins(this._title).currentXF + "/" + Model_WeiLie.ins(this._title).maxXF;
         this.tfMap.bitmapData.dispose();
         var bitmap:BitmapData = new BitmapData(150,22,true,16777215);
         bitmap.draw(this.tt);
         this.tfMap.bitmapData = bitmap;
         this.getBtn.enabled = Model_WeiLie.ins(this._title).time != 0;
         this.countTF.htmlText = Model_WeiLie.ins(this._title).time + "";
         this.jiantou.visible = false;
         ComponentUtil.setPropertie(this.jiantou,{
            "x":JT_X,
            "y":JT_Y
         });
         this.popInTxt();
         var ind:int = Model_WeiLie.ins(this._title).index;
         ind = Model_WeiLie.ins(this._title)._lib[ind][2] - 1;
         this.gridVec[ind].moviePlay();
      }
      
      public function setdata() : void
      {
         var findex:int = 0;
         this.getBtn.enabled = Model_WeiLie.ins(this._title).time != 0;
         this.tt.htmlText = Model_WeiLie.ins(this._title).currentXF + "/" + Model_WeiLie.ins(this._title).maxXF;
         this.tfMap.bitmapData.dispose();
         var bitmap:BitmapData = new BitmapData(150,22,true,16777215);
         bitmap.draw(this.tt);
         this.tfMap.bitmapData = bitmap;
         this.countTF.htmlText = Model_WeiLie.ins(this._title).time + "";
         this.setBar();
         var arr:Array = Model_WeiLie.ins(this._title).datalog.split("_");
         if(Model_WeiLie.ins(this._title).datalog == "")
         {
            arr = [];
         }
         var len:int = int(arr.length);
         var i:int = 0;
         while(i < len)
         {
            findex = Model_WeiLie.ins(this._title)._lib[arr[i]][2] - 1;
            this.gridVec[findex].setfilter(true);
            i++;
         }
         this.updateNameTxt();
      }
      
      private function setBar() : void
      {
         var alginBG:int = 0;
         if(Model_WeiLie.ins(this._title).currentPer == 0)
         {
            this.barMask.height = 0;
         }
         else if(Model_WeiLie.ins(this._title).currentPer >= 1)
         {
            this.barMask.height = 478;
            this.barMask.y = 0;
         }
         else
         {
            alginBG = Model_WeiLie.ins(this._title).currentPer * 285 + 106;
            this.barMask.height = alginBG;
            this.barMask.y = 478 - alginBG;
         }
         this.progressBar.persent = Model_WeiLie.ins(this._title).currentPer;
      }
      
      public function biubiubiu() : void
      {
         Model_WeiLie.ins(this._title).nowVo.job = GameUnitManager.hero.job;
         Model_WeiLie.ins(this._title).nowVo.index = Model_WeiLie.ins(this._title).index;
         Model_WeiLie.ins(this._title).nowVo.roleName = GameUnitManager.hero.name;
         this.setBar();
         this.cc.startPos = new Point(JT_X,JT_Y);
         var ind:int = Model_WeiLie.ins(this._title).index;
         ind = Model_WeiLie.ins(this._title)._lib[ind][2] - 1;
         this.cc.endPos = this.getPos(ind);
         this.cc.way = SHOT;
         this.cc.callBack = this.playEnd;
      }
      
      public function getPos(index:int) : Point
      {
         var p:Point = new Point();
         p.x = this.ppVec[index].x;
         p.y = this.ppVec[index].y;
         return p;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.cc.show();
         }
         else
         {
            this.dispose();
            this.cc.dispose();
         }
      }
      
      private function dispose() : void
      {
         var tempC:Child_WLItem = null;
         while(Boolean(this.tf_vec.length))
         {
            tempC = this.tf_vec.shift();
            if(Boolean(tempC) && Boolean(tempC.parent))
            {
               tempC.parent.removeChild(tempC);
            }
         }
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      public function set title(value:String) : void
      {
         this._title = value;
      }
   }
}

import com.yiTian.gameUnit.magic.Effect;
import com.yiTian.manager.EffectManager;
import flash.display.Sprite;

class JianTou extends Sprite
{
   
   private var eff:Effect;
   
   public var times:int = 500;
   
   public function JianTou()
   {
      super();
   }
   
   override public function set x(value:Number) : void
   {
      super.x = value;
      this.rotationAngle();
   }
   
   override public function set y(value:Number) : void
   {
      super.y = value;
      this.rotationAngle();
   }
   
   override public function set visible(value:Boolean) : void
   {
      super.visible = value;
      if(!value)
      {
         this.rotation = 0;
         EffectManager.removeEffect(this.eff);
      }
      else
      {
         this.eff = EffectManager.addEffect("56918",this,this.times,0,0);
      }
   }
   
   private function rotationAngle() : void
   {
   }
}
