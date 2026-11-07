package com.yiTian.view.modules.kuafujingjichang
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.vo.Vo_unit;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.net.message.cg.KuaFuJingJiChangCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.friends.Model_Friends;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class YaoQingPanel extends Panel123
   {
      
      private static var _instance:YaoQingPanel;
      
      private var back:ScaleBitmap;
      
      public var can:Canvas;
      
      private var HYbtn:TabButton;
      
      private var DTbtn:TabButton;
      
      private var BHbtn:TabButton;
      
      private var YQIndex:int;
      
      public function YaoQingPanel()
      {
         super();
         regResource("lang/ch/DuoRenKuaFu_Imgs.swf","DuoRenKuaFu_Imgsdm");
      }
      
      public static function get instance() : YaoQingPanel
      {
         if(!_instance)
         {
            _instance = new YaoQingPanel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         bindParent = GameScene.modalLayer;
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":432,
            "height":368
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Receive",this,{
            "x":136,
            "y":5
         },Global.DuoRenKuaFu_Imgsdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":384,
            "height":318
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":70,
            "width":364,
            "height":280
         },Global.Img_Cdm);
         this.can = new Canvas(350,274);
         this.can.x = 35;
         this.can.y = 72;
         addChild(this.can);
         this.can.scrollAutoType = ScrollAutoType.REMAIN;
         this.HYbtn = ComponentUtil.getTabButton("好友邀请","TabButton_Four",this,{
            "x":44,
            "y":49,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.DTbtn = ComponentUtil.getTabButton("大厅邀请","TabButton_Four",this,{
            "x":198,
            "y":49,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.BHbtn = ComponentUtil.getTabButton("帮会邀请","TabButton_Four",this,{
            "x":121,
            "y":49,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":398,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.callBack = this.hide;
         this.HYbtn.addEventListener(MouseEvent.CLICK,this.HYClick);
         this.DTbtn.addEventListener(MouseEvent.CLICK,this.DTClick);
         this.BHbtn.addEventListener(MouseEvent.CLICK,this.BHClick);
         this.initDynamicView();
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      public function remove() : void
      {
         while(Boolean(this.can.numChildren))
         {
            this.can.removeChildAt(0);
         }
         this.invalidateAlign();
      }
      
      private function invalidateAlign() : void
      {
         Global.stage.invalidate();
         addEventListener(Event.RENDER,this._renA);
      }
      
      private function _renA(e:Event) : void
      {
         this.can.align();
         removeEventListener(Event.RENDER,this._renA);
      }
      
      public function updataFriend() : void
      {
         var ilv:int = 0;
         var ulv:int = 0;
         var u:Vo_unit = null;
         var friends:Array = Model_Friends.friendArr;
         KuaFuJJCVO.FriendArr = [];
         var lv:Array = [13,14,15,16];
         for each(u in friends)
         {
            ilv = int(GameUnitManager.hero.level / 10);
            ulv = int(u.level / 10);
            if(u.isOnline && (ilv == ulv || lv.indexOf(ilv) != -1 && lv.indexOf(ulv) != -1))
            {
               KuaFuJJCVO.FriendArr.push(u.id);
               KuaFuJJCVO.FriendArr.push(u.name);
               KuaFuJJCVO.FriendArr.push(u.level);
               KuaFuJJCVO.FriendArr.push(u.sex);
               KuaFuJJCVO.FriendArr.push(u.job);
            }
         }
         KuaFuJJCVO.YQlen = KuaFuJJCVO.FriendArr.length / 5;
         this.remove();
         this.updata();
      }
      
      public function updata() : void
      {
         var i:int = 0;
         var YQItem:YaoQingItem = null;
         i = 0;
         while(i < KuaFuJJCVO.YQlen)
         {
            YQItem = new YaoQingItem();
            YQItem.x = 10;
            YQItem.y = 10 + 34 * i;
            YQItem.id = KuaFuJJCVO.FriendArr[i * 5];
            YQItem.heroZhi.text = Enum_job.getMenPai(KuaFuJJCVO.FriendArr[i * 5 + 4],false);
            YQItem.heroname.text = KuaFuJJCVO.FriendArr[i * 5 + 1];
            YQItem.herolevel.text = KuaFuJJCVO.FriendArr[i * 5 + 2].toString();
            this.can.addChild(YQItem);
            i++;
         }
         this.invalidateAlign();
      }
      
      private function HYClick(e:MouseEvent) : void
      {
         if(this.HYbtn.index == 1)
         {
            return;
         }
         this.updataFriend();
         this.HYbtn.index = 1;
         this.BHbtn.index = 0;
         this.DTbtn.index = 0;
         this.HYbtn.transform.colorTransform = Util.colorWhite2;
         this.BHbtn.transform.colorTransform = Util.colorNomal;
         this.DTbtn.transform.colorTransform = Util.colorNomal;
      }
      
      private function BHClick(e:MouseEvent) : void
      {
         if(this.BHbtn.index == 1)
         {
            return;
         }
         this.HYbtn.index = 0;
         this.BHbtn.index = 1;
         this.DTbtn.index = 0;
         this.HYbtn.transform.colorTransform = Util.colorNomal;
         this.BHbtn.transform.colorTransform = Util.colorWhite2;
         this.DTbtn.transform.colorTransform = Util.colorNomal;
         this.YQIndex = 2;
         this.YQPanelCg();
      }
      
      private function DTClick(e:MouseEvent) : void
      {
         if(this.DTbtn.index == 1)
         {
            return;
         }
         this.HYbtn.index = 0;
         this.BHbtn.index = 0;
         this.DTbtn.index = 1;
         this.HYbtn.transform.colorTransform = Util.colorNomal;
         this.BHbtn.transform.colorTransform = Util.colorNomal;
         this.DTbtn.transform.colorTransform = Util.colorWhite2;
         this.YQIndex = 3;
         this.YQPanelCg();
      }
      
      private function YQPanelCg() : void
      {
         KuaFuJingJiChangCGMessage.CG_KUAFUTEAM_INVITED(this.YQIndex);
      }
      
      public function show() : void
      {
         ModalUIManager.POPUP(this,"center",false);
      }
      
      public function hide() : void
      {
         ModalUIManager.UNPOP();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.onAskSceneOk);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.onAskSceneOk);
         }
      }
      
      private function onAskSceneOk() : void
      {
         this.hide();
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN,arguments.callee);
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_SCENE,arguments.callee);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

