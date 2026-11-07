package com.yiTian.view.modules.yellowDiamond
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_twoEggs extends Panel123
   {
      
      public static var itemVec:Vector.<Item>;
      
      private static var LEN:int = 4;
      
      public static var strArr:Array = ["XRZF","SnowMan","Bottle","SDYB"];
      
      public static var strArr2:Array = ["List1","List_2","List_3","List4"];
      
      public static var posArr:Array = [{
         "x":461,
         "y":120
      },{
         "x":466,
         "y":197
      },{
         "x":461,
         "y":287
      },{
         "x":448,
         "y":369
      }];
      
      public static var backPosArr:Array = [{
         "x":360,
         "y":142
      },{
         "x":357,
         "y":224
      },{
         "x":352,
         "y":305
      },{
         "x":344,
         "y":385
      }];
      
      public function View_twoEggs()
      {
         super();
         regResource("lang/ch/TwoEgg_Imgs.swf","TwoEgg_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         var j:int;
         var i:int;
         var back:Back = null;
         var pro:Object = null;
         var item:Item = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":708,
            "height":480
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":660,
            "height":430
         },Global.Img_Cdm);
         move = new Rectangle(0,0,707,38);
         ComponentUtil.getBitmap("Title_TwoEgg",this,{
            "x":274,
            "y":5
         },Global.TwoEgg_Imgsdm);
         ComponentUtil.getBitmap("BG",this,{
            "x":29,
            "y":45
         },Global.TwoEgg_Imgsdm);
         j = 0;
         while(j < LEN)
         {
            back = new Back(j);
            pro = backPosArr[j];
            ComponentUtil.setPropertie(back,pro);
            addChild(back);
            j++;
         }
         itemVec = new Vector.<Item>();
         i = 0;
         while(i < LEN)
         {
            item = new Item(i);
            addChild(item);
            itemVec.push(item);
            i += 1;
         }
         ComponentUtil.getTextField("活动时间：2013年12月30号10:00-2014年01月02号24:00",this,{
            "x":275,
            "y":440,
            "filters":[],
            "color":0,
            "size":14,
            "leading":0,
            "bold":true
         });
         ComponentUtil.getButton("","Button_Close",this,{
            "x":674,
            "y":6,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Img_Cdm);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 708) / 2;
         y = (Global.stage.stageHeight - 480) / 2;
      }
   }
}

import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.Global;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.ChristmasWishCGMessage;
import com.yiTian.net.message.cg.NewYearCGMessage;
import com.yiTian.utils.Tween;
import com.yiTian.view.modules.christmas.ViewChristmasIcon;
import com.yiTian.view.modules.yellowDiamond.View_twoEggs;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

class Item extends Sprite
{
   
   private var stx:int;
   
   private var sty:int;
   
   private var bmp:Bitmap;
   
   private var _type:int;
   
   public function Item(type:int)
   {
      super();
      this._type = type;
      var utl:String = View_twoEggs.strArr[type];
      var property:Object = View_twoEggs.posArr[type];
      this.stx = property.x;
      this.sty = property.y;
      this.bmp = ComponentUtil.getBitmap(utl,this,property,Global.TwoEgg_Imgsdm);
      mouseEnabled = true;
      buttonMode = true;
      mouseChildren = true;
      addEventListener(MouseEvent.MOUSE_OVER,this.overHd);
      addEventListener(MouseEvent.MOUSE_OUT,this.outHd);
      addEventListener(MouseEvent.CLICK,this.cliHd);
      addEventListener(MouseEvent.MOUSE_DOWN,this.downHd);
      addEventListener(MouseEvent.MOUSE_UP,this.upHd);
   }
   
   private function downHd(e:MouseEvent) : void
   {
      Tween.stop(this.bmp);
      this.bmp.scaleY = 0.9;
      this.bmp.y = this.sty + 3;
   }
   
   private function upHd(e:MouseEvent) : void
   {
      this.bmp.scaleY = 1;
      this.bmp.y = this.sty;
   }
   
   private function overHd(e:MouseEvent) : void
   {
      Tween.to(this.bmp,300,{"y":[this.sty,this.sty - 5]});
      filters = Util.glowFFff00;
   }
   
   private function outHd(e:MouseEvent) : void
   {
      this.bmp.scaleY = 1;
      Tween.to(this.bmp,300,{"y":[this.bmp.y,this.sty]});
      filters = [];
   }
   
   private function cliHd(e:MouseEvent) : void
   {
      switch(this._type)
      {
         case 0:
            NewYearCGMessage.CG_NIANSHOUDATA();
            break;
         case 1:
            ViewChristmasIcon.instance.clickHandle();
            break;
         case 2:
            ChristmasWishCGMessage.CG_OPEN_WISH();
            break;
         case 3:
            UIManager.paoBiaoPanel.zhiBiaoHandler();
      }
   }
}

class Back extends Sprite
{
   
   private var _type:int;
   
   public function Back(type:int)
   {
      var utl1:String;
      var property:Object;
      var bm:Bitmap;
      super();
      utl1 = View_twoEggs.strArr2[type];
      property = View_twoEggs.posArr[type];
      bm = ComponentUtil.getBitmap(utl1,this,{
         "x":-2,
         "y":-17
      },Global.TwoEgg_Imgsdm);
      this._type = type;
      graphics.beginFill(0,0);
      graphics.drawRect(0,0,115,36);
      graphics.endFill();
      graphics.beginFill(0,0);
      graphics.drawRect(148,12,117,28);
      graphics.endFill();
      mouseEnabled = true;
      buttonMode = true;
      addEventListener(MouseEvent.MOUSE_OVER,this.overHd);
      addEventListener(MouseEvent.MOUSE_OUT,this.outHd);
      addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
      {
         View_twoEggs.itemVec[_type].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      });
      addEventListener(MouseEvent.MOUSE_DOWN,function(e:MouseEvent):void
      {
         View_twoEggs.itemVec[_type].dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
      });
      addEventListener(MouseEvent.MOUSE_UP,function(e:MouseEvent):void
      {
         View_twoEggs.itemVec[_type].dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
      });
   }
   
   private function overHd(e:MouseEvent) : void
   {
      View_twoEggs.itemVec[this._type].dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
   }
   
   private function outHd(e:MouseEvent) : void
   {
      View_twoEggs.itemVec[this._type].dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT));
   }
}
