package com.yiTian.view.modules.AiDeBaoBao
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.AiDeBaoBaoCGMessage;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   
   public class View_AiDeBaoBao_serverMenu extends Panel
   {
      
      private static var _instance:View_AiDeBaoBao_serverMenu;
      
      private var serverBtn1:Button;
      
      private var serverBtn2:Button;
      
      private var serverBtn3:Button;
      
      private var serverBtn4:Button;
      
      private var serverBtn5:Button;
      
      private var serverBtn6:Button;
      
      private var autoServerBtn:Button;
      
      private var allBtn:Array;
      
      private var delayTime:int = 0;
      
      public function View_AiDeBaoBao_serverMenu()
      {
         super();
         super.init();
      }
      
      public static function get instance() : View_AiDeBaoBao_serverMenu
      {
         if(!_instance)
         {
            _instance = new View_AiDeBaoBao_serverMenu();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         move = new Rectangle(0,0,433,70);
         ComponentUtil.getBitmap("Back_JRTD",this,{
            "x":0,
            "y":0
         },Global.ADBB_Imgsdm);
         ComponentUtil.getBitmap("Text_ZDSD",this,{
            "x":89,
            "y":102
         },Global.ADBB_Imgsdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":378,
            "y":50,
            "textColor":16771436
         },Global.ADBB_Imgsdm);
         this.autoServerBtn = ComponentUtil.getButton("推荐服务器","Button_TDRK",this,{
            "x":163,
            "y":97,
            "textColor":16771436
         },Global.ADBB_Imgsdm);
         this.serverBtn1 = ComponentUtil.getButton("服务器1","Button_TDRK",this,{
            "x":163,
            "y":154,
            "textColor":16771436
         },Global.ADBB_Imgsdm);
         this.serverBtn2 = ComponentUtil.getButton("服务器2","Button_TDRK",this,{
            "x":270,
            "y":154,
            "textColor":16771436
         },Global.ADBB_Imgsdm);
         this.serverBtn3 = ComponentUtil.getButton("服务器3","Button_TDRK",this,{
            "x":163,
            "y":189,
            "textColor":16771436
         },Global.ADBB_Imgsdm);
         this.serverBtn4 = ComponentUtil.getButton("服务器4","Button_TDRK",this,{
            "x":270,
            "y":189,
            "textColor":16771436
         },Global.ADBB_Imgsdm);
         this.serverBtn5 = ComponentUtil.getButton("服务器5","Button_TDRK",this,{
            "x":163,
            "y":224,
            "textColor":16771436
         },Global.ADBB_Imgsdm);
         this.serverBtn6 = ComponentUtil.getButton("服务器6","Button_TDRK",this,{
            "x":270,
            "y":224,
            "textColor":16771436
         },Global.ADBB_Imgsdm);
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
         ComponentUtil.getTextField("（系统默认最流畅的服务器）",this,{
            "x":235,
            "y":105,
            "color":16776960,
            "size":12,
            "leading":0
         });
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
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_choiceServer(0);
               break;
            case this.serverBtn1:
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_choiceServer(1);
               break;
            case this.serverBtn2:
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_choiceServer(2);
               break;
            case this.serverBtn3:
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_choiceServer(3);
               break;
            case this.serverBtn4:
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_choiceServer(4);
               break;
            case this.serverBtn5:
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_choiceServer(5);
               break;
            case this.serverBtn6:
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_choiceServer(6);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      public function delayJoin() : void
      {
         if(this.delayTime == 1)
         {
            this.delayTime = 0;
            AiDeBaoBaoCGMessage.CG_AiDeBaoBao_JOIN();
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
   }
}

