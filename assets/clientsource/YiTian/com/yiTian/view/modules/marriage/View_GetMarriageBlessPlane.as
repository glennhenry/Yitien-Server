package com.yiTian.view.modules.marriage
{
   import com.ui.controls.*;
   import com.utils.*;
   import com.yiTian.*;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.*;
   import com.yiTian.net.handler.MarriageHandler;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class View_GetMarriageBlessPlane extends Panel
   {
      
      public static const SELFLV:int = 20;
      
      public static const TARGETLV:int = 20;
      
      private var _bg:DisplayObjectContainer;
      
      private var _infoVec:Vector.<MarriageVo>;
      
      private var _selectedList:SelectedList;
      
      private var _curVo:MarriageVo;
      
      private var _tfInfo:MyTextField;
      
      private var btn_simpleBless:Button;
      
      private var btn_blessLv1:Button;
      
      private var btn_blessLv2:Button;
      
      private var btn_blessLv3:Button;
      
      private var gridVec:Vector.<View_Grid>;
      
      public var bless_costList:Array;
      
      public var bless_idList:Array;
      
      public var cashGift_idList:Array;
      
      private var lastTime:int;
      
      private var openFlag:Boolean = false;
      
      private var isUIComplete:Boolean = false;
      
      public function View_GetMarriageBlessPlane()
      {
         this.bless_costList = MarriageConfig.bless_costList;
         this.bless_idList = MarriageConfig.bless_idList;
         this.cashGift_idList = MarriageConfig.cashGift_idList;
         super();
      }
      
      public function getLength() : int
      {
         return this._infoVec.length;
      }
      
      override protected function initStaticView() : void
      {
         super.initStaticView();
         this._bg = new Sprite();
         this._bg.mouseEnabled = false;
         addChild(this._bg);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this._bg,{
            "x":0,
            "y":0,
            "width":418,
            "height":340
         },Global.Img_Cdm);
         move = new Rectangle(0,0,400,38);
         CloseButton = ComponentUtil.getButton("","NPC_Close",this,{
            "x":384,
            "y":4
         },Global.Img_Cdm);
         this._tfInfo = ComponentUtil.getTextField("",this,{
            "x":159,
            "y":50,
            "realWidth":217.75
         });
         this._tfInfo.leading = 4;
         this._tfInfo.wordWrap = true;
         this._selectedList = new SelectedList();
         this._selectedList.x = 34;
         this._selectedList.y = 51;
         addChild(this._selectedList);
         this._infoVec = new Vector.<MarriageVo>();
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this._selectedList.addEventListener(SelectedEvent.ITEM_SELECTED,this.itemSelectedCB);
      }
      
      private function sbClickHandle(evt:MouseEvent) : void
      {
         this.sendProtocol(this._curVo,0);
      }
      
      private function sendProtocol(vo:MarriageVo, type:int) : void
      {
         var index:int = this._infoVec.indexOf(vo);
         var now:int = getTimer();
         if(now - this.lastTime > 200)
         {
            this.lastTime = now;
            MarriageHandler.CG_MARRIAGE_BLESS_RESEND(vo.targetId,type,vo.targetType,index);
         }
      }
      
      private function b1ClickHandle(evt:MouseEvent) : void
      {
         if(GameUnitManager.hero.money < this.bless_costList[0])
         {
            Model_Marriage.showAlert(106);
         }
         else
         {
            this.sendProtocol(this._curVo,1);
         }
      }
      
      private function b2ClickHandle(evt:MouseEvent) : void
      {
         if(GameUnitManager.hero.money < this.bless_costList[1])
         {
            Model_Marriage.showAlert(106);
         }
         else
         {
            this.sendProtocol(this._curVo,2);
         }
      }
      
      private function b3ClickHandle(evt:MouseEvent) : void
      {
         if(GameUnitManager.hero.money < this.bless_costList[2])
         {
            Model_Marriage.showAlert(106);
         }
         else
         {
            this.sendProtocol(this._curVo,3);
         }
      }
      
      private function itemSelectedCB(evt:SelectedEvent) : void
      {
         this.setShowVo(evt.vo);
      }
      
      public function setShowVo(vo:MarriageVo) : void
      {
         var fontSize:int = 0;
         var type:int = 0;
         var itemColor:String = null;
         var itemName:String = null;
         var str:String = null;
         this._curVo = vo;
         if(vo == null)
         {
            this._tfInfo.text = "";
            this.btn_simpleBless.visible = false;
            this._selectedList.setSelected(null);
         }
         else
         {
            this._selectedList.setSelected(vo);
            fontSize = 12;
            type = vo.targetType;
            itemColor = Model_Marriage.getColorStrByVoColor(type + 1);
            itemName = this.gridVec[type - 1].vo.str_name;
            str = LangConfig.getWord("1072",0,vo.targetName,itemColor,itemName);
            this._tfInfo.multiline = true;
            this._tfInfo.htmlText = str;
            this.btn_simpleBless.visible = true;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var arr:Array = null;
         if(value)
         {
            if(!this.isUIComplete)
            {
               if(!Global.HunLi_Imgs)
               {
                  arr = [];
                  arr.push(["lang/ch/HunLi_Imgs.swf",function(info:Object):void
                  {
                     Global.HunLi_Imgs = info.applicationDomain;
                  },LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
                  View_loading.instance.load(arr,function():void
                  {
                     initT();
                     View_loading.instance.visible = false;
                     visible = true;
                  });
                  return;
               }
               this.initT();
            }
            this.setSelectedIndex(0);
         }
         super.visible = value;
      }
      
      private function initT() : void
      {
         var infoArr:Array = null;
         var i:int = 0;
         var grid:View_Grid = null;
         var vo_i:Vo_item = null;
         ComponentUtil.getBitmap("Title_HunLiZhuFu",this._bg,{
            "x":129,
            "y":5
         },Global.HunLi_Imgs);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this._bg,{
            "x":149,
            "y":40,
            "width":245,
            "height":290
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this._bg,{
            "x":24,
            "y":40,
            "width":120,
            "height":290
         },Global.Img_Cdm);
         this.isUIComplete = true;
         infoArr = [[46364,160,165],[46365,160,208],[46366,160,251]];
         var idArr:Array = [46447,46448,46449];
         this.gridVec = new Vector.<View_Grid>();
         i = 0;
         while(i < infoArr.length)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            vo_i = new Vo_item();
            vo_i.id = idArr[i];
            vo_i.Init_lib();
            grid.vo = vo_i;
            grid.x = infoArr[i][1];
            grid.y = infoArr[i][2];
            addChild(grid);
            this.gridVec.push(grid);
            i++;
         }
         this.btn_simpleBless = ComponentUtil.getButton(LangConfig.getWord("1071",0),"Button_Four",this,{
            "x":310,
            "y":295,
            "textColor":11904647
         },Global.Img_Cdm);
         this.btn_blessLv1 = ComponentUtil.getButton(LangConfig.getWord("1068",0,this.bless_costList[0]),"Button_SendGift",this,{
            "x":205,
            "y":165,
            "textColor":16777062
         },Global.Img_Cdm);
         this.btn_blessLv2 = ComponentUtil.getButton(LangConfig.getWord("1069",0,this.bless_costList[1]),"Button_SendGift",this,{
            "x":205,
            "y":210,
            "textColor":16777062
         },Global.Img_Cdm);
         this.btn_blessLv3 = ComponentUtil.getButton(LangConfig.getWord("1070",0,this.bless_costList[2]),"Button_SendGift",this,{
            "x":205,
            "y":255,
            "textColor":16777062
         },Global.Img_Cdm);
         this.btn_simpleBless.callBack = this.sbClickHandle;
         this.btn_blessLv1.callBack = this.b1ClickHandle;
         this.btn_blessLv2.callBack = this.b2ClickHandle;
         this.btn_blessLv3.callBack = this.b3ClickHandle;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this._bg.width) / 2;
         y = (Global.stage.stageHeight - this._bg.height) / 2;
      }
      
      private function setSelectedIndex(index:int) : void
      {
         if(index < 0 || this._infoVec.length <= index)
         {
            this.setShowVo(null);
            return;
         }
         var vo:MarriageVo = this._infoVec[index];
         this.setShowVo(vo);
      }
      
      public function setInfo(vec:Vector.<MarriageVo>) : void
      {
         var vo:MarriageVo = null;
         for each(vo in vec)
         {
            this._selectedList.addItem(vo);
            this._infoVec.push(vo);
         }
         this._selectedList.sortPos();
      }
      
      public function addInfo(vo:MarriageVo, index:int = -1) : void
      {
         this._selectedList.addItem(vo);
         this._selectedList.sortPos();
         this._infoVec.push(vo);
      }
      
      public function delInfoById(id:int) : void
      {
         var i:int = this._infoVec.length - 1;
         while(i >= 0)
         {
            if(this._infoVec[i].targetId == id)
            {
               this.removeInfo(this._infoVec[i]);
               break;
            }
            i--;
         }
      }
      
      public function delAllInfo() : void
      {
         var i:int = this._infoVec.length - 1;
         while(i >= 0)
         {
            this.removeInfo(this._infoVec[i]);
            i--;
         }
      }
      
      public function removeInfo(vo:MarriageVo) : void
      {
         var index:int = this._infoVec.indexOf(vo);
         this._selectedList.removeItem(vo);
         this._infoVec.splice(index,1);
         if(vo != this._curVo)
         {
            return;
         }
         if(this._infoVec.length == 0)
         {
            this.setShowVo(null);
         }
         else if(this._infoVec.length - 1 >= index)
         {
            this.setShowVo(this._infoVec[index]);
         }
         else
         {
            this.setShowVo(this._infoVec[index - 1]);
         }
         if(this._infoVec.length == 0)
         {
            if(UIManager.mainUiBtnContainer.hasBTN(View_MarriageBlessTip.instance))
            {
               UIManager.mainUiBtnContainer.removeBTN(View_MarriageBlessTip.instance);
            }
            this.visible = false;
         }
      }
   }
}

import com.ui.constants.ScrollAutoType;
import com.ui.containers.Canvas;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.view.modules.marriage.MarriageVo;
import com.yiTian.view.modules.marriage.Model_Marriage;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

class SelectedEvent extends Event
{
   
   public static const ITEM_SELECTED:String = "itemSelected";
   
   private var _vo:MarriageVo;
   
   public function SelectedEvent(vo:MarriageVo)
   {
      super(ITEM_SELECTED);
      if(vo == null)
      {
         throw new Error("vo cannot be null");
      }
      this._vo = vo;
   }
   
   public function get vo() : MarriageVo
   {
      return this._vo;
   }
}

class SelectedList extends Canvas
{
   
   private var itemVec:Vector.<SelectedItem> = new Vector.<SelectedItem>();
   
   private var _bm_bg:Bitmap;
   
   private const OFFSETY:Number = 20;
   
   public function SelectedList()
   {
      super(107,267);
      scrollAutoType = ScrollAutoType.TO_TOP;
      this._bm_bg = ComponentUtil.getBitmap("ZFPlayer_Select",this,{"x":-10});
      addEventListener(MouseEvent.CLICK,this.clickHandle);
   }
   
   private function clickHandle(evt:MouseEvent) : void
   {
      var target:SelectedItem = null;
      evt.stopPropagation();
      if(evt.target is SelectedItem)
      {
         target = evt.target as SelectedItem;
         dispatchEvent(new SelectedEvent(target.vo));
         this.setSelected(target.vo);
      }
   }
   
   public function setSelected(vo:MarriageVo) : void
   {
      var item:SelectedItem = null;
      if(vo == null)
      {
         if(Boolean(this._bm_bg.parent))
         {
            this._bm_bg.parent.removeChild(this._bm_bg);
            return;
         }
      }
      for each(item in this.itemVec)
      {
         if(item.vo === vo)
         {
            item.addChild(this._bm_bg);
         }
      }
   }
   
   public function addItem(vo:MarriageVo) : void
   {
      var item:SelectedItem = new SelectedItem();
      item.vo = vo;
      this.itemVec.push(item);
      addChild(item);
   }
   
   public function sortPos() : void
   {
      var length:int = int(this.itemVec.length);
      var i:int = 0;
      while(i < length)
      {
         this.itemVec[i].y = i * this.OFFSETY;
         i++;
      }
      align();
   }
   
   public function removeAllItem() : void
   {
      var item:SelectedItem = null;
      var length:int = int(this.itemVec.length);
      var i:int = length - 1;
      while(i >= 0)
      {
         item = this.itemVec[i];
         removeChild(item);
         item.dispose();
         i--;
      }
      this.itemVec.splice(0,length);
   }
   
   public function removeItem(vo:MarriageVo) : void
   {
      var item:SelectedItem = null;
      for each(item in this.itemVec)
      {
         if(item.vo === vo)
         {
            removeChild(item);
            this.itemVec.splice(this.itemVec.indexOf(item),1);
            this.sortPos();
            item.dispose();
            return;
         }
      }
   }
}

class SelectedItem extends Sprite
{
   
   private var _tfName:MyTextField;
   
   private var bm_bg:DisplayObject;
   
   private var _vo:MarriageVo;
   
   public function SelectedItem()
   {
      super();
      var sp:Shape = new Shape();
      sp.graphics.beginFill(16777215,0);
      sp.graphics.drawRect(0,0,200,20);
      sp.graphics.endFill();
      addChild(sp);
      this.bm_bg = sp;
      this._tfName = ComponentUtil.getTextField("",this,{"realWidth":85});
   }
   
   public function set vo(value:MarriageVo) : void
   {
      this._vo = value;
      var color:String = Model_Marriage.getColorStrByVoColor(value.targetType + 1);
      this._tfName.htmlText = "<font color = \'" + color + "\'>" + value.targetName.toString() + "</font>";
   }
   
   public function get vo() : MarriageVo
   {
      return this._vo;
   }
   
   public function dispose() : void
   {
      graphics.clear();
      (this.bm_bg as Shape).graphics.clear();
      removeChild(this.bm_bg);
      removeChild(this._tfName);
      this._tfName.dispose();
      this._tfName = null;
      this._vo = null;
      this.bm_bg = null;
   }
}
