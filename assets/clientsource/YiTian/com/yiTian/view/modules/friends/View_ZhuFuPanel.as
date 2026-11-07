package com.yiTian.view.modules.friends
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FriendCGMessage;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class View_ZhuFuPanel extends Panel123
   {
      
      public static const SELFLV:int = 20;
      
      public static const TARGETLV:int = 20;
      
      private var _bg:DisplayObjectContainer;
      
      private var _infoVec:Vector.<blessVo>;
      
      private var _selectedList:SelectedList;
      
      private var _curVo:blessVo;
      
      private var _tfInfo:MyTextField;
      
      private var btn_simpleBless:Button;
      
      private var btn_blessLv1:Button;
      
      private var btn_blessLv2:Button;
      
      private var btn_blessLv3:Button;
      
      private var gridVec:Vector.<View_Grid>;
      
      private var lastTime:int;
      
      private var openFlag:Boolean = false;
      
      private var isUIInit:Boolean = false;
      
      public function View_ZhuFuPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var infoArr:Array = null;
         var i:int = 0;
         var grid:View_Grid = null;
         var vo_i:Vo_item = null;
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
         move = new Rectangle(0,0,400,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":384,
            "y":6,
            "textColor":16184781
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
         this._selectedList.y = 46;
         addChild(this._selectedList);
         this.btn_simpleBless = ComponentUtil.getButton(LangConfig.getWord("23220",2),"Button_Four",this,{
            "x":310,
            "y":295,
            "textColor":11904647
         },Global.Img_Cdm);
         this.btn_blessLv1 = ComponentUtil.getButton("","Button_SendGift",this,{
            "x":205,
            "y":165,
            "textColor":16777062,
            "textOverColor":16777062
         },Global.Img_Cdm);
         this.btn_blessLv1.label = LangConfig.getWord("23221",2);
         this.btn_blessLv2 = ComponentUtil.getButton("","Button_SendGift",this,{
            "x":205,
            "y":210,
            "textColor":16777062,
            "textOverColor":16777062
         },Global.Img_Cdm);
         this.btn_blessLv2.label = LangConfig.getWord("23222",2);
         this.btn_blessLv3 = ComponentUtil.getButton("","Button_SendGift",this,{
            "x":205,
            "y":255,
            "textColor":16777062,
            "textOverColor":16777062
         },Global.Img_Cdm);
         this.btn_blessLv3.label = LangConfig.getWord("23223",2);
         infoArr = [[46364,160,165],[46365,160,208],[46366,160,251]];
         this.gridVec = new Vector.<View_Grid>();
         i = 0;
         while(i < infoArr.length)
         {
            grid = new View_Grid();
            grid.isAutoLoad = false;
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            vo_i = new Vo_item();
            vo_i.id = infoArr[i][0];
            vo_i.Init_lib();
            grid.vo = vo_i;
            grid.x = infoArr[i][1];
            grid.y = infoArr[i][2];
            addChild(grid);
            this.gridVec.push(grid);
            i++;
         }
         this._infoVec = new Vector.<blessVo>();
         regResource("lang/ch/FriendShip_Imgs.swf","FriendShip_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         this.initT();
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.btn_simpleBless.callBack = this.sbClickHandle;
         this.btn_blessLv1.callBack = this.b1ClickHandle;
         this.btn_blessLv2.callBack = this.b2ClickHandle;
         this.btn_blessLv3.callBack = this.b3ClickHandle;
         this._selectedList.addEventListener(SelectedEvent.ITEM_SELECTED,this.itemSelectedCB);
      }
      
      private function sbClickHandle(evt:MouseEvent) : void
      {
         this.sendProtocol(this._curVo,0);
      }
      
      private function sendProtocol(vo:blessVo, type:int) : void
      {
         var now:int = getTimer();
         if(now - this.lastTime > 200)
         {
            this.lastTime = now;
            FriendCGMessage.CG_SEND_BLESSING(type,vo.targetId,vo.targetLv,vo.date);
         }
      }
      
      private function b1ClickHandle(evt:MouseEvent) : void
      {
         this.sendProtocol(this._curVo,1);
      }
      
      private function b2ClickHandle(evt:MouseEvent) : void
      {
         this.sendProtocol(this._curVo,2);
      }
      
      private function b3ClickHandle(evt:MouseEvent) : void
      {
         this.sendProtocol(this._curVo,3);
      }
      
      private function itemSelectedCB(evt:SelectedEvent) : void
      {
         this.setShowVo(evt.vo);
      }
      
      public function setShowVo(vo:blessVo) : void
      {
         var fontSize:int = 0;
         var myLv:int = 0;
         var nameStr:String = null;
         var lvStr:String = null;
         var expStr:String = null;
         var lastLvStr:String = null;
         var str:String = null;
         this._curVo = vo;
         if(vo == null)
         {
            this._tfInfo.text = "";
            this.lvBtnVisible = false;
            this.btn_simpleBless.visible = false;
            this._selectedList.setSelected(null);
         }
         else
         {
            this._selectedList.setSelected(vo);
            fontSize = 12;
            myLv = GameUnitManager.hero.level;
            nameStr = vo.targetName.toString();
            lvStr = vo.targetLv.toString();
            expStr = vo.rewardExp.toString();
            lastLvStr = vo.lastLv.toString();
            nameStr = Model_heFu.repNameByHero(nameStr);
            str = LangConfig.getWord("23161",2,nameStr,lvStr,expStr);
            if(vo.lastBless > 0)
            {
               str += LangConfig.getWord("23162",2,lastLvStr,Enum_Friend.LIBAOTXT[vo.lastBless]);
            }
            this._tfInfo.multiline = true;
            this._tfInfo.htmlText = str;
            this.btn_simpleBless.visible = true;
            if(vo.targetLv >= TARGETLV)
            {
               this.lvBtnVisible = true;
            }
            else
            {
               this.lvBtnVisible = false;
            }
         }
      }
      
      private function set lvBtnVisible(value:Boolean) : void
      {
         this.btn_blessLv1.visible = value;
         this.btn_blessLv2.visible = value;
         this.btn_blessLv3.visible = value;
         this.gridVec[0].visible = value;
         this.gridVec[1].visible = value;
         this.gridVec[2].visible = value;
      }
      
      override public function set visible(value:Boolean) : void
      {
         var g:View_Grid = null;
         if(value)
         {
            this.setSelectedIndex(0);
            if(!this.openFlag)
            {
               for each(g in this.gridVec)
               {
                  g.beginLoad();
                  g.isAutoLoad = true;
                  this.openFlag = true;
               }
            }
         }
         super.visible = value;
      }
      
      private function initT() : void
      {
         ComponentUtil.getBitmap("Title_Gift",this._bg,{
            "x":129,
            "y":5
         },Global.FriendShip_Imgsdm);
         this.isUIInit = true;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this._bg.width) / 2;
         y = (Global.stage.stageHeight - this._bg.height) / 2;
      }
      
      public function needBless() : Boolean
      {
         if(!this._infoVec || !this._infoVec.length)
         {
            return false;
         }
         return true;
      }
      
      private function setSelectedIndex(index:int) : void
      {
         if(index < 0 || this._infoVec.length <= index)
         {
            this.setShowVo(null);
            return;
         }
         var vo:blessVo = this._infoVec[index];
         this.setShowVo(vo);
      }
      
      public function setInfo(vec:Vector.<blessVo>) : void
      {
         var vo:blessVo = null;
         for each(vo in vec)
         {
            this._selectedList.addItem(vo);
            this._infoVec.push(vo);
         }
         this._selectedList.sortPos();
      }
      
      public function addInfo(vo:blessVo, index:int = -1, isSort:Boolean = true) : void
      {
         this._selectedList.addItem(vo);
         this._infoVec.push(vo);
         if(isSort)
         {
            this._selectedList.sortPos();
         }
      }
      
      public function delInfoByIdLv(id:Number, lv:int) : void
      {
         var i:int = this._infoVec.length - 1;
         while(i >= 0)
         {
            if(this._infoVec[i].targetId == id && this._infoVec[i].targetLv == lv)
            {
               this.removeInfo(this._infoVec[i]);
            }
            i--;
         }
      }
      
      public function removeInfo(vo:blessVo) : void
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
            if(UIManager.mainUiBtnContainer.hasBTN(View_ZhuFuATip.instance))
            {
               UIManager.mainUiBtnContainer.removeBTN(View_ZhuFuATip.instance);
            }
            UIManager.zhufuPanel.visible = false;
         }
      }
   }
}

import com.ui.constants.ScrollAutoType;
import com.ui.containers.Canvas;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.data.model.Model_heFu;
import com.yiTian.view.modules.friends.blessVo;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

class SelectedEvent extends Event
{
   
   public static const ITEM_SELECTED:String = "itemSelected";
   
   private var _vo:blessVo;
   
   public function SelectedEvent(vo:blessVo)
   {
      super(ITEM_SELECTED);
      if(vo == null)
      {
         throw new Error("vo cannot be null");
      }
      this._vo = vo;
   }
   
   public function get vo() : blessVo
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
      super(107,277);
      scrollAutoType = ScrollAutoType.REMAIN;
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
   
   public function setSelected(vo:blessVo) : void
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
   
   public function addItem(vo:blessVo) : void
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
   
   public function removeItem(vo:blessVo) : void
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
   
   private var _vo:blessVo;
   
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
   
   public function set vo(value:blessVo) : void
   {
      var color:int = 0;
      this._vo = value;
      value.targetName = Model_heFu.repNameByHero(value.targetName);
      this._tfName.htmlText = value.targetName.toString() + "<font>";
      switch(value.lastBless)
      {
         case 1:
            color = 2872653;
            break;
         case 2:
            color = 3394815;
            break;
         case 3:
            color = 14566855;
            break;
         default:
            color = 0;
      }
      if(color != 0)
      {
         this._tfName.color = color;
      }
   }
   
   public function get vo() : blessVo
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
