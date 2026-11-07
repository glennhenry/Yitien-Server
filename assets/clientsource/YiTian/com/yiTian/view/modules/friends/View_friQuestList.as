package com.yiTian.view.modules.friends
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FriendCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.mainUIBtnContainer.View_TipBtnContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_friQuestList extends Panel
   {
      
      private var _bg:Sprite;
      
      private var _btn_left:Button;
      
      private var _btn_right:Button;
      
      private var _tf_page:MyTextField;
      
      private var _btnQuickAccept:Button;
      
      private var _btnQuickUnaccept:Button;
      
      private var itemVec:Vector.<friListItem>;
      
      private const ITEM_LENGTH:int = 8;
      
      private var _curPage:int;
      
      private const X1:Number = 31;
      
      private const Y1:Number = 50;
      
      private const offsetY:Number = 55;
      
      private var isLoad:Boolean = false;
      
      public function View_friQuestList()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this._bg = new Sprite();
         addChild(this._bg);
         this._bg.mouseEnabled = false;
         move = new Rectangle(0,0,381,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":377,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this._tf_page = ComponentUtil.getTextField("1/1",this,{
            "x":300,
            "y":481,
            "color":16777215
         });
         this._btn_right = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":355,
            "y":480,
            "textColor":16184781
         },Global.Img_Cdm);
         this._btn_left = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":250,
            "y":480,
            "textColor":16184781
         },Global.Img_Cdm);
         this._btnQuickAccept = ComponentUtil.getButton("全部同意","Button_Four",this,{
            "x":40,
            "y":478
         },Global.Img_Cdm);
         this._btnQuickUnaccept = ComponentUtil.getButton("全部拒绝","Button_Four",this,{
            "x":135,
            "y":478
         },Global.Img_Cdm);
         this.itemVec = new Vector.<friListItem>();
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this._btn_left.callBack = this.leftClickHandle;
         this._btn_right.callBack = this.rightClickHandle;
         this._btnQuickAccept.callBack = this.quickAccept;
         this._btnQuickUnaccept.callBack = this.quickUnAccept;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      protected function leftClickHandle(evt:MouseEvent) : void
      {
         this.setPage(this._curPage - 1);
      }
      
      protected function rightClickHandle(evt:MouseEvent) : void
      {
         this.setPage(this._curPage + 1);
      }
      
      private function quickAccept(evt:MouseEvent) : void
      {
         var pIndex:int = 0;
         var _SafeStr_0:Vector.<Vo_friQuest> = null;
         var vo:Vo_friQuest = null;
         if(Boolean(Model_Friends.friQuestVec.length))
         {
            pIndex = this._curPage * this.ITEM_LENGTH;
            _SafeStr_0 = Model_Friends.friQuestVec.splice(pIndex,this.ITEM_LENGTH);
            for each(vo in _SafeStr_0)
            {
               if(vo.type == 0)
               {
                  FriendCGMessage.CG_ADD_FIR_B_CHOOSE(vo.id,1);
               }
               else
               {
                  FriendCGMessage.CG_ACCEPT_SERV_FRIEND(vo.id,vo.name,1);
               }
               Model_Friends.removeFriendQuest(vo.name);
            }
            this.updateByModel();
            _SafeStr_0.splice(0,_SafeStr_0.length);
         }
      }
      
      private function quickUnAccept(evt:MouseEvent) : void
      {
         var pIndex:int = 0;
         var _SafeStr_0:Vector.<Vo_friQuest> = null;
         var vo:Vo_friQuest = null;
         if(Boolean(Model_Friends.friQuestVec.length))
         {
            pIndex = this._curPage * this.ITEM_LENGTH;
            _SafeStr_0 = Model_Friends.friQuestVec.splice(pIndex,this.ITEM_LENGTH);
            for each(vo in _SafeStr_0)
            {
               if(vo.type == 0)
               {
                  FriendCGMessage.CG_ADD_FIR_B_CHOOSE(vo.id,2);
               }
               else
               {
                  FriendCGMessage.CG_ACCEPT_SERV_FRIEND(vo.id,vo.name,2);
               }
               Model_Friends.removeFriendQuest(vo.name);
            }
            this.updateByModel();
            _SafeStr_0.splice(0,_SafeStr_0.length);
         }
      }
      
      private function setPage(pIndex:int) : void
      {
         if(pIndex < 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29071",2));
            return;
         }
         var maxPage:int = this.getMaxPage();
         if(pIndex > maxPage)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29072",2));
            if(pIndex > maxPage + 1)
            {
               this.setPage(maxPage);
            }
            return;
         }
         this._curPage = pIndex;
         this.showItem(pIndex);
         this._tf_page.text = (this._curPage + 1).toString() + "/" + (maxPage + 1).toString();
      }
      
      public function get curPage() : int
      {
         return this._curPage;
      }
      
      private function getMaxPage() : int
      {
         var dataLeng:int = int(Model_Friends.friQuestVec.length);
         var maxPage:int = int(dataLeng / this.ITEM_LENGTH);
         if(dataLeng > 0 && dataLeng % this.ITEM_LENGTH == 0)
         {
            maxPage -= 1;
         }
         return maxPage;
      }
      
      private function showItem(pIndex:int) : void
      {
         var i:int = 0;
         var tvo:Vo_friQuest = null;
         var l1:int = 0;
         var l2:int = 0;
         var temp:friListItem = null;
         var sIndex:int = pIndex * this.ITEM_LENGTH;
         i = 0;
         while(i < this.ITEM_LENGTH)
         {
            try
            {
               this.itemVec[i];
            }
            catch(err:Error)
            {
               temp = new friListItem();
               temp.init();
               temp.x = X1;
               temp.y = Y1 + offsetY * i;
               addChild(temp);
               itemVec[i] = temp;
            }
            try
            {
               tvo = Model_Friends.friQuestVec[sIndex + i];
            }
            catch(error:Error)
            {
               tvo = null;
            }
            l1 = int(this.itemVec.length);
            l2 = int(Model_Friends.friQuestVec.length);
            this.itemVec[i].vo = tvo;
            i++;
         }
      }
      
      public function show() : void
      {
         this.visible = true;
         this.setPage(0);
         var container:View_TipBtnContainer = UIManager.tipBtnContainer;
         var tipIns:View_AddFriendTip = View_AddFriendTip.getInstance();
         if(container.hasItem(tipIns))
         {
            container.removeItem(tipIns);
         }
         Model_Friends.hasNewQuest = false;
      }
      
      public function updateByModel() : void
      {
         var data:Vector.<Vo_friQuest> = Model_Friends.friQuestVec;
         if(this.getMaxPage() < this._curPage)
         {
            this.setPage(this._curPage - 1);
         }
         else
         {
            this.setPage(this._curPage);
         }
         if(data.length == 0)
         {
            if(UIManager.tipBtnContainer.hasItem(View_AddFriendTip.getInstance()))
            {
               UIManager.tipBtnContainer.removeItem(View_AddFriendTip.getInstance());
            }
            this.visible = false;
         }
      }
      
      private function initTl() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this._bg,{
            "x":0,
            "y":0,
            "width":411,
            "height":514
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this._bg,{
            "x":24,
            "y":40,
            "width":363,
            "height":431
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this._bg,{
            "x":29,
            "y":45,
            "width":353,
            "height":421
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this._bg,{
            "x":273,
            "y":480,
            "width":80,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_JoinList",this._bg,{
            "x":125,
            "y":5
         },Global.FriendShip_Imgsdm);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(!this.isLoad)
            {
               SingleLoader.add("lang/ch/FriendShip_Imgs.swf",function(info:Object):void
               {
                  Global.FriendShip_Imgsdm = info.applicationDomain;
                  isLoad = true;
                  initTl();
                  visible = true;
               });
               return;
            }
            super.visible = true;
         }
         else
         {
            super.visible = false;
         }
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ColorConstant;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.data.model.Model_heFu;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.FriendCGMessage;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.view.modules.friends.Model_Friends;
import com.yiTian.view.modules.friends.Vo_friQuest;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.TextEvent;

class friListItem extends Sprite
{
   
   private var _vo:Vo_friQuest;
   
   private var _tf_info:MyTextField;
   
   private var _btn_agree:Button;
   
   private var _btn_refuse:Button;
   
   public function friListItem()
   {
      super();
   }
   
   public function init() : void
   {
      ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "x":0,
         "y":37,
         "width":348,
         "height":2
      },Global.Img_Cdm);
      this._tf_info = ComponentUtil.getTextField("",this,{
         "x":6,
         "y":10
      });
      this._tf_info.mouseEnabled = true;
      this._btn_agree = ComponentUtil.getButton(LangConfig.getWord("29031",2),"Button_Two64",this,{
         "x":206,
         "y":8,
         "textColor":16184781
      },Global.Img_Cdm);
      this._btn_refuse = ComponentUtil.getButton(LangConfig.getWord("29032",2),"Button_Two64",this,{
         "x":281,
         "y":8,
         "textColor":16184781
      },Global.Img_Cdm);
      this._tf_info.addEventListener(TextEvent.LINK,this.infoClickHandle);
      this._btn_agree.callBack = this.agreeClickHandle;
      this._btn_refuse.callBack = this.refuseClickhandle;
   }
   
   protected function agreeClickHandle(evt:MouseEvent) : void
   {
      if(this._vo.type == 0)
      {
         if(Model_Friends.getFriendVoById(this._vo.id) == null)
         {
            FriendCGMessage.CG_ADD_FIR_B_CHOOSE(this._vo.id,1);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("23106",2,this._vo.name));
         }
      }
      else
      {
         FriendCGMessage.CG_ACCEPT_SERV_FRIEND(this._vo.id,this._vo.name,1);
      }
      Model_Friends.removeFriendQuest(this._vo.name);
      UIManager.friQuestPanel.updateByModel();
   }
   
   protected function refuseClickhandle(evt:MouseEvent) : void
   {
      if(this._vo.type == 0)
      {
         FriendCGMessage.CG_ADD_FIR_B_CHOOSE(this._vo.id,2);
      }
      else
      {
         FriendCGMessage.CG_ACCEPT_SERV_FRIEND(this._vo.id,this._vo.name,2);
      }
      Model_Friends.removeFriendQuest(this._vo.name);
      UIManager.friQuestPanel.updateByModel();
   }
   
   protected function infoClickHandle(evt:TextEvent) : void
   {
      Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,this.vo.id);
   }
   
   public function set vo(value:Vo_friQuest) : void
   {
      var linkStr:String = null;
      this._vo = value;
      if(!value)
      {
         this._tf_info.text = "";
         visible = false;
         return;
      }
      if(value.type == 0)
      {
         linkStr = HtmlUtil.font(Model_heFu.repNameByHero(value.name),ColorConstant.getColorStr(ColorConstant.GREEN));
         linkStr = HtmlUtil.createLink(linkStr);
         this._tf_info.htmlText = LangConfig.getWord("23117",2,linkStr);
         visible = true;
      }
      else if(value.type == 1)
      {
         linkStr = HtmlUtil.font(value.name,ColorConstant.getColorStr(ColorConstant.GREEN));
         this._tf_info.htmlText = LangConfig.getWord("23117",2,linkStr);
         visible = true;
      }
   }
   
   public function get vo() : Vo_friQuest
   {
      return this._vo;
   }
}

/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_0 = "set"
 */
