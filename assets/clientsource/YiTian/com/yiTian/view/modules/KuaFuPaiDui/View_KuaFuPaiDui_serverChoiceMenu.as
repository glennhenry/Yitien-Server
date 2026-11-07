package com.yiTian.view.modules.KuaFuPaiDui
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KuaFuPaiDuiCGMessage;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class View_KuaFuPaiDui_serverChoiceMenu extends Panel
   {
      
      private static var _instance:View_KuaFuPaiDui_serverChoiceMenu;
      
      private var serverBtn1:Button;
      
      private var serverBtn2:Button;
      
      private var serverBtn3:Button;
      
      private var serverBtn4:Button;
      
      private var serverBtn5:Button;
      
      private var serverBtn6:Button;
      
      private var autoServerBtn:Button;
      
      private var allBtn:Array;
      
      private var delayTime:int = 0;
      
      public function View_KuaFuPaiDui_serverChoiceMenu()
      {
         super();
         init();
      }
      
      public static function get instance() : View_KuaFuPaiDui_serverChoiceMenu
      {
         if(!_instance)
         {
            _instance = new View_KuaFuPaiDui_serverChoiceMenu();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getBitmap("Back_JRTD",this,{
            "x":0,
            "y":3
         },Global.KFPDdm);
         ComponentUtil.getBitmap("Title_JRTD",this,{
            "x":128,
            "y":0
         },Global.KFPDdm);
         ComponentUtil.getBitmap("Text_ZDSD",this,{
            "x":26,
            "y":43
         },Global.KFPDdm);
         CloseButton = ComponentUtil.getButton("","Button_GuanBi",this,{
            "x":328,
            "y":1,
            "textColor":16771436
         },Global.KFPDdm);
         this.autoServerBtn = ComponentUtil.getButton("推荐服务器","Button_PingDao",this,{
            "x":99,
            "y":39,
            "textColor":16771436
         },Global.KFPDdm);
         this.serverBtn1 = ComponentUtil.getButton("服务器1","Button_PingDao",this,{
            "x":99,
            "y":93,
            "textColor":16771436
         },Global.KFPDdm);
         this.serverBtn2 = ComponentUtil.getButton("服务器2","Button_PingDao",this,{
            "x":206,
            "y":93,
            "textColor":16771436
         },Global.KFPDdm);
         this.serverBtn3 = ComponentUtil.getButton("服务器3","Button_PingDao",this,{
            "x":99,
            "y":126,
            "textColor":16771436
         },Global.KFPDdm);
         this.serverBtn4 = ComponentUtil.getButton("服务器4","Button_PingDao",this,{
            "x":206,
            "y":126,
            "textColor":16771436
         },Global.KFPDdm);
         this.serverBtn5 = ComponentUtil.getButton("服务器5","Button_PingDao",this,{
            "x":99,
            "y":159,
            "textColor":16771436
         },Global.KFPDdm);
         this.serverBtn6 = ComponentUtil.getButton("服务器6","Button_PingDao",this,{
            "x":206,
            "y":159,
            "textColor":16771436
         },Global.KFPDdm);
         ComponentUtil.getTextField("（系统默认最流畅的服务器）",this,{
            "x":170,
            "y":48,
            "color":8643072,
            "size":12,
            "leading":0
         });
         this.serverBtn1.callBack = this.enter;
         this.serverBtn2.callBack = this.enter;
         this.serverBtn3.callBack = this.enter;
         this.serverBtn4.callBack = this.enter;
         this.serverBtn5.callBack = this.enter;
         this.serverBtn6.callBack = this.enter;
         this.autoServerBtn.callBack = this.enter;
         this.allBtn = [];
         this.allBtn.push(this.autoServerBtn);
         this.allBtn.push(this.serverBtn1);
         this.allBtn.push(this.serverBtn2);
         this.allBtn.push(this.serverBtn3);
         this.allBtn.push(this.serverBtn4);
         this.allBtn.push(this.serverBtn5);
         this.allBtn.push(this.serverBtn6);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.closeMenu);
      }
      
      private function closeMenu(e:*) : void
      {
         this.visible = false;
      }
      
      private function enter(e:MouseEvent) : void
      {
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg("只有主城地图能进入此场景");
            return;
         }
         if(Model_team.hasTeam())
         {
            UIManager.centerBroadcast.addMsg("组队状态不能进入此场景");
            return;
         }
         if(Boolean(GameUnitManager.hero.paoBiao))
         {
            UIManager.centerBroadcast.addMsg("跑镖状态不能进入此场景");
            return;
         }
         switch(e.currentTarget)
         {
            case this.autoServerBtn:
               KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_SERVER_CHOICE(0);
               break;
            case this.serverBtn1:
               KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_SERVER_CHOICE(1);
               break;
            case this.serverBtn2:
               KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_SERVER_CHOICE(2);
               break;
            case this.serverBtn3:
               KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_SERVER_CHOICE(3);
               break;
            case this.serverBtn4:
               KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_SERVER_CHOICE(4);
               break;
            case this.serverBtn5:
               KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_SERVER_CHOICE(5);
               break;
            case this.serverBtn6:
               KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_SERVER_CHOICE(6);
         }
      }
      
      public function delayJoin() : void
      {
         if(this.delayTime == 1)
         {
            this.delayTime = 0;
            KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_ENTER();
         }
         else
         {
            ++this.delayTime;
            this.setAllBtn(false);
            setTimeout(function():void
            {
               setAllBtn(true);
            },3000);
         }
      }
      
      private function setAllBtn(value:Boolean) : void
      {
         var i:* = undefined;
         for(i in this.allBtn)
         {
            this.allBtn[i].enabled = value;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

