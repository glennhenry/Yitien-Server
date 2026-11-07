package com.yiTian.view.modules.horse
{
   import Layout.GridGroup;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class Child_horseJinJieLib extends Sprite
   {
      
      private var _itemsGi:GridGroup;
      
      private var _items:Array = [];
      
      private var _btnCont:Sprite;
      
      private var _bgCont:Sprite;
      
      private var _tfPage:MyTextField;
      
      private var maxPage:int = 1;
      
      private var _pageIndex:int = 1;
      
      private var itemVec:Vector.<LibItem>;
      
      public function Child_horseJinJieLib()
      {
         var item:LibItem = null;
         var i:int = 0;
         var k:int = 0;
         super();
         this.itemVec = new Vector.<LibItem>();
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":0,
            "y":0,
            "width":709,
            "height":460
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back4",[3,3,1,1],this,{
            "x":9,
            "y":7,
            "width":690,
            "height":441
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":320,
            "y":532 - 68,
            "width":66,
            "height":23
         },Global.Img_Cdm);
         this._tfPage = ComponentUtil.getTextField("",this,{
            "x":348,
            "y":535 - 68,
            "color":14671839,
            "size":12,
            "leading":0
         });
         this._tfPage.autoSize = TextFieldAutoSize.CENTER;
         this._tfPage.text = "1/1";
         ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":294,
            "y":534 - 68,
            "textColor":16771436,
            "callBack":this.leftClickHd
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_PageRight",this,{
            "x":393,
            "y":534 - 68,
            "textColor":16771436,
            "callBack":this.rightClickHd
         },Global.Img_Cdm);
         this._bgCont = new Sprite();
         addChild(this._bgCont);
         this._itemsGi = new GridGroup(18,14,0,0,0,215,0,226,3);
         this._btnCont = new Sprite();
         i = 0;
         while(i < 6)
         {
            item = new LibItem();
            item._bg.visible = false;
            item.visible = false;
            item.btn.visible = false;
            addChild(item);
            this._bgCont.addChild(item._bg);
            this._btnCont.addChild(item.btn);
            item._bg.x = 18 + 226 * (i % 3);
            item._bg.y = 14 + 215 * int(i / 3);
            item.btn.x = 18 + 65 + 226 * (i % 3);
            item.btn.y = 14 + 173 + 215 * int(i / 3);
            this.itemVec.push(item);
            this._itemsGi.appendItem(item);
            i++;
         }
         addChild(this._btnCont);
         this._itemsGi.align();
         var index:int = 0;
         var infos:Array = HorseConfig.sequenceLib();
         var info:Array = [];
         for each(k in infos)
         {
            info = Data_lib.zqtj[k];
            if(info[HorseConfig.LIB_HORSE_TYPE] == 1)
            {
               index += 1;
            }
         }
         this.maxPage = Math.ceil(index / 6);
         this.setPage();
      }
      
      private function leftClickHd(evt:MouseEvent) : void
      {
         this.setPage(this._pageIndex - 1);
      }
      
      private function rightClickHd(evt:MouseEvent) : void
      {
         this.setPage(this._pageIndex + 1);
      }
      
      public function setPage(targetPage:int = 1) : void
      {
         var index:int = 0;
         var item:LibItem = null;
         var info:Array = null;
         var k:int = 0;
         if(targetPage > this.maxPage || targetPage < 1)
         {
            return;
         }
         var i:int = 0;
         while(i < 6)
         {
            item = this.itemVec[i];
            item._bg.visible = false;
            item.visible = false;
            item.btn.visible = false;
            i++;
         }
         this._pageIndex = targetPage;
         var infos:Array = HorseConfig.sequenceLib();
         index = 0;
         var flag:int = 0;
         this._items = [];
         for each(k in infos)
         {
            info = Data_lib.zqtj[k];
            if(info[HorseConfig.LIB_HORSE_TYPE] == 1)
            {
               flag++;
               if(!(flag <= 6 * (targetPage - 1) || flag > 6 * targetPage))
               {
                  item = this.itemVec[index];
                  item.visible = true;
                  item._bg.visible = true;
                  item.btn.visible = true;
                  item.tfAtb.htmlText = "";
                  item.horseModel.modelId = info[HorseConfig.LIB_MODELID];
                  item.id = int(k);
                  this._items.push(item);
                  item.tfName.text = Data_lib.zqtj[k][HorseConfig.LIB_HORSE_NAME];
                  index += 1;
               }
            }
         }
         this._tfPage.text = targetPage + "/" + this.maxPage;
         this.updateInfos();
      }
      
      public function tapperShowMethod(info:Object) : Boolean
      {
         return true;
      }
      
      public function tapperHideMethod(info:Object) : Boolean
      {
         return true;
      }
      
      private function onFrame(i:int) : void
      {
         var item:LibItem = null;
         for each(item in this._items)
         {
            if(item.horseModel.modelId != 0)
            {
               item.horseModel.onFrame(i);
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            Global.control.registerCallBack(HorseConfig.HorseLibPanelFrame,this.onFrame);
         }
         else
         {
            Global.control.removeCallBack(HorseConfig.HorseLibPanelFrame,this.onFrame);
         }
         super.visible = value;
      }
      
      public function updateInfos() : void
      {
         var item:LibItem = null;
         var o:Object = Model_horse.libInfos;
         if(!o)
         {
            return;
         }
         var curRider:int = Model_horse.myRidder;
         var i:int = 0;
         for(; i < this._items.length; i += 1)
         {
            item = this._items[i];
            item.setBmVis(curRider == item.id);
            TipManager.unBind(item.btn);
            if(!(Boolean(o[item.id]) && o[item.id] > 0))
            {
               item.btn.enabled = false;
               item.btn.label = LangConfig.getWord("29481",2);
               item.btn.LabelResize(26,3);
               item.btn.visible = true;
               item.btn.mouseEnabled = true;
               TipManager.bind(item.btn,LangConfig.getWord("29482",2));
               continue;
            }
            item.btn.enabled = true;
            switch(o[item.id])
            {
               case 1:
                  item.btn.visible = false;
                  item.state = 1;
                  break;
               case 2:
                  item.btn.label = LangConfig.getWord("29479",2);
                  item.state = 2;
                  item.btn.LabelResize(20,3);
                  item.btn.visible = true;
                  break;
               case 3:
                  item.btn.label = LangConfig.getWord("29480",2);
                  item.state = 3;
                  item.btn.LabelResize(20,3);
                  item.btn.visible = true;
                  break;
               default:
                  item.btn.visible = true;
                  item.btn.enabled = false;
                  item.btn.label = LangConfig.getWord("29481",2);
                  item.btn.LabelResize(26,3);
                  item.btn.mouseEnabled = true;
                  TipManager.bind(item.btn,LangConfig.getWord("29482",2));
            }
         }
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Data_lib;
import com.yiTian.data.config.valuable.Enum_lib_equip;
import com.yiTian.gameUnit.config.Action;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.TipManager;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.HorseCGMessage;
import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;
import flash.utils.getTimer;

class LibItem extends Sprite
{
   
   public static var _last:int;
   
   private var tipArea:Sprite;
   
   public var tfName:MyTextField;
   
   public var tfAtb:MyTextField;
   
   public var btn:Button;
   
   public var horseModel:Child_tianTiUnit;
   
   private var _mask:Shape;
   
   public var _id:int;
   
   private var bmRidder:Bitmap;
   
   public var state:int;
   
   public var _bg:DisplayObject;
   
   public function LibItem()
   {
      super();
      this._bg = ComponentUtil.getBitmap("ZQTuJian_Back",this,{
         "x":0,
         "y":0
      },Global.ZuoQi_c01_Imgsdm);
      this.horseModel = new Child_tianTiUnit();
      this.horseModel.type = Child_tianTiUnit.HORSE;
      this.horseModel._way = 5;
      this.horseModel.scaleX = this.horseModel.scaleY = 0.8;
      this.horseModel._state = Action.RUN;
      this.horseModel.x = 110;
      this.horseModel.y = this.horseModel.jumpBindY = 155;
      this.horseModel.setFrameInterval(100);
      this.horseModel.mouseEnabled = false;
      addChild(this.horseModel);
      this.tipArea = new Sprite();
      this.tipArea.graphics.beginFill(0,0);
      this.tipArea.graphics.drawRect(0,0,this._bg.width,this._bg.height);
      this.tipArea.graphics.endFill();
      addChild(this.tipArea);
      this.tfName = ComponentUtil.getTextField("",this,{
         "x":109,
         "y":17,
         "color":16776960,
         "size":14
      },TextFieldAutoSize.CENTER);
      this.tfAtb = ComponentUtil.getTextField("",this,{
         "x":109,
         "y":151
      },TextFieldAutoSize.CENTER);
      this.btn = ComponentUtil.getButton("","Button_TwoBule91",null,{
         "textColor":16771436,
         "callBack":this.btnClickHd
      },Global.ZuoQi_c01_Imgsdm);
      this.btn.enabled = false;
      this._mask = ComponentUtil.getShape(250,200,16776960,0.3);
      this.horseModel.addEventListener(MouseEvent.CLICK,this.onModelClick);
      this.bmRidder = ComponentUtil.getBitmap("Text_YShiYong",this,{
         "x":125,
         "y":-20
      },Global.ZuoQi_c01_Imgsdm);
   }
   
   public function removeForDisplayList() : void
   {
      if(Boolean(parent))
      {
         parent.removeChild(this);
      }
      if(Boolean(this.btn.parent))
      {
         this.btn.parent.removeChild(this);
      }
   }
   
   public function set id(v:int) : void
   {
      this._id = v;
      this.enableHorseTip();
   }
   
   public function get id() : int
   {
      return this._id;
   }
   
   public function enableHorseTip() : void
   {
      TipManager.bind(this.tipArea,Data_lib.equip[this.id][Enum_lib_equip.STR_DESCRIBE]);
   }
   
   private function btnClickHd(e:MouseEvent) : void
   {
      var now:int = 0;
      if(this.state > 0 && this.id > 0)
      {
         now = getTimer();
         if(now - _last < 2000)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29374",2));
            return;
         }
         _last = now;
         this.horseModel.maimengDefault();
         HorseCGMessage.CG_HORSE_LIB_ENABLE(this.id,this.state);
      }
   }
   
   private function onModelClick(e:MouseEvent) : void
   {
   }
   
   public function setBmVis(v:Boolean) : void
   {
      this.bmRidder.visible = v;
   }
}
