package com.yiTian.view.modules.horse
{
   import Layout.GridGroup;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class Child_horseCardLib extends Sprite
   {
      
      private var _itemsGi:GridGroup;
      
      private var _items:Array = [];
      
      private var _bgCont:Sprite;
      
      private var _btnCont:Sprite;
      
      private var _tfPage:MyTextField;
      
      private var _tipSp:Sprite = new Sprite();
      
      private var _maxPage:int;
      
      private var _infos:Array;
      
      private var _pageIndex:int = -1;
      
      public function Child_horseCardLib()
      {
         var data:Array = null;
         super();
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
         ComponentUtil.getBitmap("Icons_Prompt",this._tipSp,{
            "x":660,
            "y":-30
         },Global.Img_Cdm);
         TipManager.bind(this._tipSp,"<font color=\'#66ff66\'>已激活的坐骑卡片属性值全部<br>都会累计到人物属性中</font>");
         addChild(this._tipSp);
         this._infos = [];
         var datas:Array = Data_lib.zqtj.toArray();
         for each(data in datas)
         {
            if(data[HorseConfig.LIB_HORSE_TYPE + 1] == 2)
            {
               this._infos.push(data);
            }
         }
         this._maxPage = this._infos.length / 6;
         if(this._infos.length % 6 == 0)
         {
            this._maxPage -= 1;
         }
      }
      
      private function leftClickHd(e:MouseEvent) : void
      {
         this.setPage(this._pageIndex - 1);
      }
      
      private function rightClickHd(e:MouseEvent) : void
      {
         this.setPage(this._pageIndex + 1);
      }
      
      public function update() : void
      {
         var it:DisplayObject = null;
         var num:int = 0;
         var idx:int = 0;
         var i:int = 0;
         var item:LibItem = null;
         var index:int = this._pageIndex * 6;
         for each(it in this._items)
         {
            it.visible = false;
         }
         num = Math.min(6,this._infos.length - this._pageIndex * 6);
         idx = 0;
         while(idx < num)
         {
            i = idx + index;
            item = this._items[idx];
            if(!item)
            {
               item = this._items[i] = new LibItem();
               item.btn.x = 83 + 226 * (idx % 3);
               item.btn.y = 187 + 215 * int(idx / 3);
               item._bg.x = 18 + 226 * (idx % 3);
               item._bg.y = 14 + 215 * int(idx / 3);
               addChild(item);
               this._bgCont.addChild(item._bg);
               this._btnCont.addChild(item.btn);
               this._itemsGi.appendItem(item);
            }
            item.visible = true;
            item.id = this._infos[i][0];
            item.horseModel.modelId = this._infos[i][HorseConfig.LIB_MODELID + 1];
            item.tfName.text = this._infos[i][HorseConfig.LIB_HORSE_NAME + 1];
            idx += 1;
         }
         this.updateInfos();
         addChild(this._btnCont);
         this.setChildIndex(this._tipSp,this.numChildren - 1);
         this._itemsGi.align();
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            this.setPage(0);
            this.updateInfos();
         }
         super.visible = value;
      }
      
      public function setPage(index:int) : void
      {
         if(index < 0)
         {
            index = 0;
         }
         if(index > this._maxPage)
         {
            index = this._maxPage;
         }
         if(index == this._pageIndex)
         {
            return;
         }
         this._pageIndex = index;
         this.update();
         this._tfPage.text = (index + 1).toString() + "/" + (this._maxPage + 1).toString();
      }
      
      public function tapperShowMethod(info:Object) : Boolean
      {
         Global.control.registerCallBack(HorseConfig.HorseLibPanelFrame,this.onFrame);
         return true;
      }
      
      public function tapperHideMethod(info:Object) : Boolean
      {
         Global.control.removeCallBack(HorseConfig.HorseLibPanelFrame,this.onFrame);
         return true;
      }
      
      private function onFrame(i:int) : void
      {
         var item:LibItem = null;
         for each(item in this._items)
         {
            if(item.horseModel.modelId != 0)
            {
               if(item.visible)
               {
                  item.horseModel.onFrame(i);
               }
            }
         }
      }
      
      public function updateInfos() : void
      {
         var item:LibItem = null;
         var needItemId:int = 0;
         var o:Object = Model_horse.libInfos;
         if(!o)
         {
            return;
         }
         var curRider:int = Model_horse.myRidder;
         var i:int = 0;
         for(; i < this._items.length; i += 1)
         {
            if(!this._items[i].visible)
            {
               continue;
            }
            item = this._items[i];
            item.setBmVis(curRider == item.id);
            TipManager.unBind(item.btn);
            if(!(Boolean(o[item.id]) && o[item.id] > 0))
            {
               needItemId = int(Data_lib.zqtj[item._id][HorseConfig.LIB_ENABLE_ITEMID_REQUIRE]);
               item.btn.label = LangConfig.getWord("29484",2);
               item.state = 2;
               item.btn.LabelResize(32,3);
               item.btn.visible = true;
               item.btn.enabled = true;
               TipManager.bind(item.btn,LangConfig.getWord("29483",2) + Enum_BroadCastTool.instance.getItemText(needItemId));
               continue;
            }
            item.btn.enabled = true;
            switch(o[item.id])
            {
               case 1:
                  item.btn.visible = false;
                  item.state = 1;
                  break;
               case 3:
                  item.btn.label = LangConfig.getWord("29480",2);
                  item.state = 3;
                  item.btn.LabelResize(20,3);
                  item.btn.visible = true;
                  break;
               default:
                  item.btn.visible = true;
                  item.btn.enabled = true;
                  item.btn.label = LangConfig.getWord("29481",2);
                  item.btn.LabelResize(26,3);
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
import com.yiTian.data.config.valuable.Enum_lib_item;
import com.yiTian.gameUnit.config.Action;
import com.yiTian.manager.CommandManager;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.TipManager;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.HorseCGMessage;
import com.yiTian.view.modules.horse.HorseConfig;
import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.utils.getTimer;

class LibItem extends Sprite
{
   
   public static var _last:int;
   
   private var tipArea:Sprite;
   
   public var tfName:MyTextField;
   
   public var btn:Button;
   
   public var horseModel:Child_tianTiUnit;
   
   private var _mask:Shape;
   
   public var _id:int;
   
   private var bmRidder:Bitmap;
   
   public var _state:int;
   
   public var _bg:DisplayObject;
   
   public var tfAtb:TextField;
   
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
      var _temp_1:* = this.horseModel;
      this.horseModel.scaleY = 0.8;
      _temp_1.scaleX = 0.8;
      this.horseModel._state = Action.RUN;
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
         "y":126
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
   
   public function set state(v:int) : void
   {
      var c2:String = null;
      this._state = v;
      if(this._state == 3)
      {
         c2 = "#33ff33";
         c2 = "";
      }
      else
      {
         c2 = "#888888";
         c2 = LangConfig.getWord("29481",2);
      }
   }
   
   public function get state() : int
   {
      return this._state;
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
      if(Boolean(this._bg.parent))
      {
         this._bg.parent.removeChild(this._bg);
      }
   }
   
   public function set id(v:int) : void
   {
      this._id = v;
      this.enableHorseTip();
      this.amendYAxis();
   }
   
   public function get id() : int
   {
      return this._id;
   }
   
   public function amendYAxis() : void
   {
      this.horseModel.x = 110;
      this.horseModel.y = this.horseModel.jumpBindY = 155 + Data_lib.zqtj[this._id][HorseConfig.LIB_YAXISAMENDMENT];
      this.horseModel.jumpPixel = Data_lib.zqtj[this._id][HorseConfig.LIB_JUMPPIXEL];
   }
   
   public function enableHorseTip() : void
   {
      TipManager.bind(this.tipArea,Data_lib.equip[this.id][Enum_lib_equip.STR_DESCRIBE]);
   }
   
   override public function set visible(value:Boolean) : void
   {
      super.visible = value;
      this.btn.visible = value;
      this._bg.visible = value;
   }
   
   private function btnClickHd(e:MouseEvent) : void
   {
      var now:int = 0;
      var itemId:int = 0;
      var count:int = 0;
      if(this.state > 0 && this.id > 0)
      {
         if(this.state == 2)
         {
            itemId = int(Data_lib.zqtj[this._id][HorseConfig.LIB_ENABLE_ITEMID_REQUIRE]);
            count = 1;
            if(CommandManager.get_bag_count(itemId) < count)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29485",2,count,Data_lib.item[itemId][Enum_lib_item.STR_NAME]));
               return;
            }
         }
         now = getTimer();
         if(now - _last < 1500)
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
