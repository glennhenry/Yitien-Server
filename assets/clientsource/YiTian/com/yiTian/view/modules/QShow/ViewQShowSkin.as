package com.yiTian.view.modules.QShow
{
   import com.ui.controls.Button;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ViewQShowSkin extends Panel123
   {
      
      public static var instance:ViewQShowSkin = new ViewQShowSkin();
      
      private var back:ScaleBitmap;
      
      private var giftBtn:Button;
      
      private var _getSaveType:int;
      
      private var _btnStatus:int;
      
      private var hongZuanBtn:Button;
      
      private var giftVec:Vector.<int> = new <int>[1,46410,1,1,46402,1,1,43002,1,1,43012,1];
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var showVec:Vector.<ItemShow>;
      
      private var _lastBtnStatus:int;
      
      private var isfirstEnter:Boolean = false;
      
      public function ViewQShowSkin()
      {
         super();
         super.init();
      }
      
      override protected function initStaticView() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":757,
            "height":486
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":this.back.width - 37,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width - 52,38);
      }
      
      private function initShowSkin() : void
      {
         var i:int = 0;
         var j:int = 0;
         var grid:View_Grid = null;
         var vo:Vo_item = null;
         var item:ItemShow = null;
         this.showVec = new Vector.<ItemShow>(8,true);
         ComponentUtil.getBitmap("Title_YTQX",this,{
            "x":298,
            "y":5
         },Global.QQXdm);
         ComponentUtil.getBitmap("BG_QX",this,{
            "x":25,
            "y":39
         },Global.QQXdm);
         ComponentUtil.getBitmap("BG_T",this,{
            "x":542,
            "y":238
         },Global.QQXdm);
         this.giftBtn = ComponentUtil.getButton("","BT_LQLB",this,{
            "x":572,
            "y":259,
            "textColor":16771436
         },Global.QQXdm);
         this.giftBtn.callBack = this.giftHandle;
         ComponentUtil.getTextField(LangConfig.getWord("30138",3),this,{
            "x":547,
            "y":61,
            "color":15724479,
            "size":14,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("30139",3),this,{
            "x":558,
            "y":319,
            "color":15724479,
            "size":14,
            "leading":0
         });
         this.hongZuanBtn = ComponentUtil.getButton("","bt_HongZuan",this,{
            "x":552,
            "y":361,
            "textColor":16771436
         },Global.QQXdm);
         ComponentUtil.getBitmap("logo",this,{
            "x":602,
            "y":410,
            "alpha":0.7
         },Global.QQXdm);
         this.hongZuanBtn.callBack = this.hongZunaBtnHandle;
         i = 0;
         while(i < int(this.giftVec.length / 3))
         {
            grid = new View_Grid(true);
            grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
            grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
            grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_tf_count();
            addChild(grid);
            if(int(this.giftVec[i * 3]) == 1)
            {
               vo = new Vo_item();
               vo.id = int(this.giftVec[i * 3 + 1]);
               vo.count = int(this.giftVec[i * 3 + 2]);
               vo.Init_lib();
               grid.vo = vo;
            }
            grid.x = 553 + int(i / 2) * 75;
            grid.y = 89 + int(i % 2) * 73;
            this.gridVec.push(grid);
            i++;
         }
         j = 0;
         while(j < 8)
         {
            item = new ItemShow();
            item.x = 45 + int(j % 4) * 120;
            item.y = 57 + int(j / 4) * 200;
            item.init(int(j + 1));
            addChild(item);
            this.showVec[j] = item;
            j++;
         }
         this.setGiftBtnStatus();
      }
      
      private function giftHandle(evt:MouseEvent) : void
      {
         QShowSkinCGMessage.CG_SHOWSKIN_GIFT();
      }
      
      private function hongZunaBtnHandle(evt:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://pay.qq.com/qqshow/index.shtml?aid=show.vip.yitian.coper"),"_blank");
      }
      
      private function setGiftBtnStatus() : void
      {
         var t:ItemShow = null;
         if(this._getSaveType == 0)
         {
            this.giftBtn.mouseEnabled = false;
            this.giftBtn.enabled = false;
            return;
         }
         for each(t in this.showVec)
         {
            if(t._type == this._getSaveType)
            {
               t.setStatus(false);
            }
            else
            {
               t.setStatus(true);
            }
         }
         if(this._getSaveType >= 1 && this._getSaveType <= 8)
         {
            this.showVec[this._getSaveType - 1].setStatus(false);
         }
         if(this._btnStatus == 1)
         {
            if(this._lastBtnStatus == this._btnStatus)
            {
               return;
            }
            this._lastBtnStatus = this._btnStatus;
            this.disableGiftBtn();
         }
         else if(this._btnStatus == 0)
         {
            this.giftBtn.mouseEnabled = true;
            this.giftBtn.enabled = true;
         }
      }
      
      public function disableGiftBtn() : void
      {
         if(!this.giftBtn)
         {
            return;
         }
         this.giftBtn.mouseEnabled = false;
         this.giftBtn.enabled = false;
         this.giftBtn.style = "BT_LQLB2";
      }
      
      public function update(type:int, btnStatus:int) : void
      {
         this._getSaveType = type;
         this._btnStatus = btnStatus;
         if(Boolean(this.giftBtn))
         {
            this.setGiftBtnStatus();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.isfirstEnter)
            {
               this.isfirstEnter = true;
               SingleLoader.add("lang/ch/QQX.swf",function(info:Object):void
               {
                  Global.QQXdm = info.applicationDomain;
                  initShowSkin();
               });
            }
            QShowSkinCGMessage.CG_SHOWSKIN_ICON();
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
   }
}

import com.ui.controls.Button;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.manager.LangConfig;
import com.yiTian.utils.YTJSONParser;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.external.ExternalInterface;

class ItemShow extends Sprite
{
   
   public var _type:int;
   
   private var itemBtn:Button;
   
   private var selBit:Bitmap;
   
   public function ItemShow()
   {
      super();
   }
   
   public function init(type:int) : void
   {
      this._type = type;
      ComponentUtil.getBitmap("BG_" + String(this._type),this,{
         "x":0,
         "y":0
      },Global.QQXdm);
      this.selBit = ComponentUtil.getBitmap("BG_FG",this,{
         "x":0,
         "y":0
      },Global.QQXdm);
      this.selBit.visible = false;
      this.itemBtn = ComponentUtil.getButton(LangConfig.getWord("30140",3),"BT_BQ",this,{
         "x":0,
         "y":172,
         "textColor":16771436
      },Global.QQXdm);
      this.itemBtn.callBack = this.btnClkHandle;
   }
   
   private function btnClkHandle(evt:MouseEvent) : void
   {
      Global._curQShowSkinType = this._type;
      this.askPhpQShow();
   }
   
   private function askPhpQShow() : void
   {
   }
   
   private function qShowReturn(evt:Event) : void
   {
      var s:String = unescape((evt.target.data as String).replace(/\\u/g,"%u"));
      var obj:Object = YTJSONParser.instance.parseStringToObject(s);
      if(Boolean(obj))
      {
         if(obj.ret == 0)
         {
            ExternalInterface.call("qShowSkin",obj.picid);
         }
      }
   }
   
   public function setStatus(boo:Boolean) : void
   {
      this.itemBtn.enabled = boo;
      this.itemBtn.mouseEnabled = boo;
      this.selBit.visible = !boo;
   }
}
