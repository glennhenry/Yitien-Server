package com.yiTian.view.modules.friends
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FriendCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.utils.getTimer;
   
   public class View_inviteReward extends Panel123
   {
      
      private var bg:DisplayObjectContainer;
      
      private var itemVec:Vector.<item>;
      
      private var btn_invite:Button;
      
      private var lastTime:int;
      
      private var change:Boolean = false;
      
      private var point:Point;
      
      public var isGetObj:Boolean = false;
      
      private var isFinishVis:Boolean = false;
      
      private var isFirstOpen:Boolean = true;
      
      private var isUIComplete:Boolean = false;
      
      private var _itemInit:Boolean = false;
      
      public function View_inviteReward()
      {
         super();
         regResource("lang/ch/Invite_Imgs.swf","Invite_Imgsdm");
      }
      
      override protected function initStaticView() : void
      {
         var s:Sprite = null;
         this.bg = new Sprite();
         this.bg.mouseEnabled = false;
         addChild(this.bg);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.bg,{
            "x":0,
            "y":0,
            "width":620,
            "height":445
         },Global.Img_Cdm);
         move = new Rectangle(0,0,width,40);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":586,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60123",6),this,{
            "x":34,
            "y":50,
            "color":16773818,
            "size":16
         });
         var t:MyTextField = ComponentUtil.getTextField("",this,{
            "x":50,
            "y":400,
            "color":458496,
            "size":12,
            "leading":0
         });
         t.htmlText = HtmlUtil.createLink(LangConfig.getWord("60124",6));
         s = new Sprite();
         addChild(s);
         s.x = t.x;
         s.y = t.y;
         s.addChild(ComponentUtil.getShape(52,19,0,0));
         TipManager.bind(s,"<font color=\'#F4CD31\'><b>" + LangConfig.getWord("60125",6) + "</b></font><br><font color=\'#FFFFFF\' size=\'12\'>" + LangConfig.getWord("60126",6) + "<br>" + LangConfig.getWord("60127",6) + "<br>" + LangConfig.getWord("60128",6) + "</font>");
         t = ComponentUtil.getTextField("",this,{
            "x":155,
            "y":400,
            "color":12877056
         });
         t.type = TextFieldType.INPUT;
         t.selectable = false;
         t.restrict = "";
         t.htmlText = LangConfig.getWord("60129",6) + "<font color=\"#00CC00\"><u><a href=\"event:openFriendPanel\">" + LangConfig.getWord("60130",6) + "</a></u></font>" + LangConfig.getWord("60131",6);
         t.addEventListener(TextEvent.LINK,this.linkEvent);
         this.btn_invite = ComponentUtil.getButton(LangConfig.getWord("862",0),"Button_Orange",this,{
            "x":500,
            "y":50,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      protected function linkEvent(e:TextEvent) : void
      {
         if(!UIManager.friendPanel.visible)
         {
            UIManager.friendPanel.visible = true;
         }
         UIManager.friendPanel.showQFriend();
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.btn_invite.callBack = this.inviteClickHd;
      }
      
      private function inviteClickHd(... param) : void
      {
         ExternalInterface.call("inviteFriend");
      }
      
      public function btnEff(value:Boolean) : void
      {
         if(value)
         {
            this.lastTime = getTimer();
            GameScene.instance.addFrameCallBack(this.frame);
         }
         else
         {
            GameScene.instance.removeFrameCallBack(this.frame);
            this.btn_invite.transform.colorTransform = Util.colorNomal;
         }
      }
      
      private function frame(value:int) : void
      {
         if(!visible)
         {
            GameScene.instance.removeFrameCallBack(this.frame);
         }
         if(getTimer() - this.lastTime > 500)
         {
            this.lastTime = getTimer();
            this.change = !this.change;
            if(this.change)
            {
               this.btn_invite.transform.colorTransform = Util.colorWhite2;
            }
            else
            {
               this.btn_invite.transform.colorTransform = Util.colorNomal;
            }
         }
      }
      
      private function createItem() : void
      {
         var i:int = 0;
         var it:item = null;
         this.itemVec = new Vector.<item>();
         i = 0;
         while(i < 7)
         {
            it = new item();
            it.init(i);
            addChild(it);
            it.x = 39;
            it.y = 90 + 44 * i;
            this.itemVec.push(it);
            i += 1;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.bg.width) / 2;
         y = (Global.stage.stageHeight - this.bg.height) / 2;
      }
      
      public function getObj() : void
      {
         this.point = UIManager.special_btn.getPos(2);
         this.isGetObj = true;
      }
      
      private function comp() : void
      {
         super.visible = false;
         this.isFinishVis = false;
         UIManager.special_btn.getEff(2);
      }
      
      override protected function initUI2() : void
      {
         this.isUIComplete = true;
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.bg,{
            "x":24,
            "y":39,
            "width":572,
            "height":395
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.bg,{
            "x":34,
            "y":85,
            "width":552,
            "height":340
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Invite",this.bg,{
            "x":230,
            "y":5
         },Global.Invite_Imgsdm);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            this.initItem();
            super.visible = true;
            scaleX = 1;
            scaleY = 1;
            this.initItem();
            FriendCGMessage.CG_FRIENDS_INVITED_INTERFACE();
         }
         else
         {
            if(this.isFinishVis)
            {
               return;
            }
            if(!this.isGetObj)
            {
               this.getObj();
            }
            this.isFinishVis = true;
            Tween.to(this,300,{
               "scaleX":[1,0],
               "scaleY":[1,0],
               "x":[this.x,this.point.x],
               "y":[this.y,this.point.y]
            },this.comp);
         }
      }
      
      public function get isItemInit() : Boolean
      {
         return this._itemInit;
      }
      
      public function initItem() : void
      {
         var i:int = 0;
         var key:int = 0;
         var rewards:Array = null;
         if(!this.isItemInit)
         {
            this.createItem();
            this._itemInit = true;
            i = 0;
            while(i < 7)
            {
               key = i + 1;
               rewards = Util.splicObj(Data_lib.inviteRewards[key][1],",_") as Array;
               this.itemVec[i].rewards = rewards;
               i += 1;
            }
         }
      }
      
      public function checkPlayEff() : void
      {
         var isPlay:Boolean = false;
         var i:int = 0;
         if(Boolean(this.itemVec))
         {
            i = 0;
            while(i < 7)
            {
               if(this.itemVec[i].state == 1)
               {
                  isPlay = true;
                  break;
               }
               i++;
            }
         }
         UIManager.special_btn.joinIconEff(false);
         this.btnEff(false);
         if(isPlay)
         {
            UIManager.special_btn.joinIconEff(true);
         }
         if(visible && this.itemVec[0].state == 0)
         {
            this.btnEff(true);
         }
      }
      
      public function setRewardsAtIndex(index:int, arr:Array) : void
      {
         this.itemVec[index].rewards = arr;
      }
      
      public function setStateAtIndex(index:int, state:int) : void
      {
         this.itemVec[index].state = state;
      }
      
      public function showBezAt(index:int) : void
      {
         this.itemVec[index].showBez();
      }
      
      public function set inviteNum(value:int) : void
      {
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Const_png;
import com.yiTian.data.Data_lib;
import com.yiTian.data.vo.Vo_equip;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.manager.LangConfig;
import com.yiTian.net.message.cg.FriendCGMessage;
import com.yiTian.utils.ComboTweenStep;
import com.yiTian.view.comp.View_Grid;
import flash.display.Sprite;
import flash.text.TextFormatAlign;

class item extends Sprite
{
   
   private var gridVec:Array;
   
   private var btn_getReward:Button;
   
   private var _state:int;
   
   private var _id:int;
   
   public function item()
   {
      super();
   }
   
   public function init(id:int) : void
   {
      ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "x":0,
         "y":41,
         "width":542,
         "height":2
      },Global.Img_Cdm);
      ComponentUtil.getBitmap("Gift",this,{
         "x":5,
         "y":1
      },Global.Invite_Imgsdm);
      this._id = id;
      this.gridVec = new Array();
      this.gridVec = [];
      this.btn_getReward = ComponentUtil.getButton(LangConfig.getWord("29128",2),"Button_Four",this,{
         "x":460,
         "y":8
      },Global.Img_Cdm);
      this.btn_getReward.enabled = false;
      var t:MyTextField = ComponentUtil.getTextField("",this,{
         "x":60,
         "y":12,
         "color":14013822
      });
      t.realWidth = 215;
      t.align = TextFormatAlign.CENTER;
      t.text = Data_lib.inviteRewards[id + 1][0];
      this.btn_getReward.callBack = this.getClickHd;
   }
   
   private function getClickHd(... param) : void
   {
      FriendCGMessage.CG_GET_FRIENDS_INVITED(this._id);
   }
   
   public function set state(value:int) : void
   {
      switch(value)
      {
         case 0:
            this.btn_getReward.label = LangConfig.getWord("29128",2);
            this.btn_getReward.enabled = false;
            this.btn_getReward.textColor = 15080002;
            break;
         case 1:
            this.btn_getReward.label = LangConfig.getWord("29073",2);
            this.btn_getReward.enabled = true;
            this.btn_getReward.textColor = 16184781;
            break;
         case -1:
            this.btn_getReward.label = LangConfig.getWord("29075",2);
            this.btn_getReward.enabled = false;
            this.btn_getReward.textColor = 4504460;
            break;
         default:
            throw new Error("error state value=" + value.toString());
      }
      this._state = value;
   }
   
   public function get state() : int
   {
      return this._state;
   }
   
   public function set rewards(arr:Array) : void
   {
      var i:int = 0;
      var grid:View_Grid = null;
      var type:int = 0;
      var id:int = 0;
      var num:int = 0;
      var vo:Object = null;
      var offsetX:Number = 290;
      if(arr.length == 1)
      {
         offsetX = 394;
      }
      i = 0;
      while(i < arr.length)
      {
         grid = new View_Grid();
         grid.set_bmp_bg();
         grid.set_tf_count();
         grid.set_bmp_over(true,null);
         grid.x = offsetX + (Const_png.SIZE_GRID + 12) * i;
         grid.y = 5;
         addChild(grid);
         this.gridVec.push(grid);
         if(Boolean(arr[i]))
         {
            type = int(arr[i][0]);
            id = int(arr[i][1]);
            num = int(arr[i][2]);
            if(type == 1)
            {
               vo = new Vo_item();
            }
            else
            {
               vo = new Vo_equip();
            }
            vo.id = id;
            vo.count = num;
            vo.Init_lib();
            this.gridVec[i].vo = vo;
         }
         i += 1;
      }
   }
   
   public function showBez() : void
   {
      var i:int = 0;
      while(i < this.gridVec.length)
      {
         ComboTweenStep.toBag(this.gridVec[i]);
         i += 1;
      }
   }
}
