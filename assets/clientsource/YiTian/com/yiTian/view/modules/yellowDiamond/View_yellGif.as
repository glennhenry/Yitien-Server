package com.yiTian.view.modules.yellowDiamond
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.YellowDiaManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.chat.EffecObj;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_yellGif extends Panel
   {
      
      private static var i:int;
      
      private static var txtDescrip:Array;
      
      private static var gridPool:Array = [];
      
      private var grid:View_Grid;
      
      private var btnVec:Vector.<Button> = new Vector.<Button>();
      
      private var tfVec:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var posArr:Array = [[72,95],[255,98],[250,137],[90,260]];
      
      private var widthArr:Array = [168.2,130.2,175.2,319.2];
      
      private var back:ScaleBitmap;
      
      private var funcArr:Array = [];
      
      private var source:Array = ["Button_HZKT","Button_HZXF","Button_LZKT","Button_LZXF"];
      
      private var bmp:Bitmap;
      
      private var bmpVo:BmpItem;
      
      private var beginL:int;
      
      private var isFirstOpen:Boolean = true;
      
      private var bmTitle:Bitmap = new Bitmap();
      
      public function View_yellGif()
      {
         super();
      }
      
      private static function getGrid() : View_Grid
      {
         var grid:View_Grid = new View_Grid(true);
         grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         grid.set_bmp_over(true,null);
         grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
         grid.set_tf_count(true,false,false);
         return grid;
      }
      
      override protected function initStaticView() : void
      {
         var _id:int;
         var st:String;
         var vo:Vo_item = null;
         var btn:Button = null;
         var tf:MyTextField = null;
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":512,
            "height":374
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":464,
            "height":324
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,38);
         this.bmp = new Bitmap();
         addChild(this.bmp);
         this.bmp.x = 26;
         this.bmp.y = 42;
         this.bmpVo = new BmpItem();
         addChild(this.bmpVo);
         this.bmpVo.x = 63;
         this.bmpVo.y = 128;
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":478,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         vo = new Vo_item();
         _id = Global.pf == "qqgame" ? 46460 : 46418;
         vo.id = _id;
         vo.Init_lib();
         this.bmpVo.addEventListener(MouseEvent.MOUSE_OVER,function():void
         {
            TipManager.update(vo);
            TipManager.view_tip.x = Global.stage.mouseX;
            TipManager.view_tip.y = Global.stage.mouseY;
         });
         this.bmpVo.addEventListener(MouseEvent.MOUSE_OUT,function():void
         {
            TipManager.hide();
         });
         this.funcArr.push(function():void
         {
            View_hzTribute.sendType = "self";
            YellowDiaManager.buy();
         });
         st = Global.pf == "qqgame" ? LangConfig.getWord("60135",6) : LangConfig.getWord("60138",6);
         txtDescrip = ["" + LangConfig.getWord("998",0),LangConfig.getWord("999",0,st),LangConfig.getWord("1000",0,st,st),"     " + LangConfig.getWord("1001",0,st,st)];
         this.beginL = Global.pf == "qqgame" ? 2 : 0;
         i = this.beginL;
         while(i < this.beginL + 2)
         {
            btn = ComponentUtil.getButton("",this.source[i],this,{
               "x":79 + 184 * int(i != this.beginL),
               "y":317
            });
            btn.addEventListener(MouseEvent.CLICK,this.funcArr[0]);
            this.btnVec.push(btn);
            ++i;
         }
         i = 0;
         while(i < 4)
         {
            tf = ComponentUtil.getTextField("",this,{
               "x":this.posArr[i][0],
               "y":this.posArr[i][1],
               "realWidth":this.widthArr[i]
            });
            tf.multiline = true;
            tf.wordWrap = true;
            tf.htmlText = txtDescrip[i];
            this.tfVec.push(tf);
            ++i;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var bgST:String = null;
         var str:String = null;
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               if(!this.bmp.bitmapData)
               {
                  str = Global.pf == "qqgame" ? "lan00" : "Img";
                  Utils.getLoadBitmap("resource/image/shouchong/" + str + ".jpg",this.bmp);
               }
               this.bmpVo.Init();
               bgST = Global.pf == "qqgame" ? "Title_BuleGift" : "Title_DiamondGift";
               Utils.loadTitle("lang/ch/Diamond_Imgs.swf",bgST,new Bitmap(),{
                  "x":176,
                  "y":5
               },this);
            }
            if(Boolean(this.bmpVo))
            {
               EffecObj.getEffec(this.bmpVo);
            }
         }
         else if(Boolean(this.bmpVo))
         {
            EffecObj.removeEffect(this.bmpVo);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
   }
}

import com.yiTian.Global;
import com.yiTian.utils.Utils;
import flash.display.Sprite;

class BmpItem extends Sprite
{
   
   public function BmpItem()
   {
      super();
   }
   
   public function Init() : void
   {
      var s:String = Global.pf == "qqgame" ? "Gift_BagBule" : "Icons";
      addChild(Utils.getLoadBitmap("resource/image/shouchong/" + s + ".png"));
   }
}
