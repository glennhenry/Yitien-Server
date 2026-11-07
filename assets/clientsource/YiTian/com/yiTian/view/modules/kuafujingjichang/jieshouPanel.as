package com.yiTian.view.modules.kuafujingjichang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KuaFuJingJiChangCGMessage;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class jieshouPanel extends Panel123
   {
      
      private static var _instance:jieshouPanel;
      
      private var back:ScaleBitmap;
      
      private var queDingBtn:Button;
      
      private var quXiaoBtn:Button;
      
      private var tf:MyTextField;
      
      public function jieshouPanel()
      {
         super();
         regResource("lang/ch/DuoRenKuaFu_Imgs.swf","DuoRenKuaFu_Imgsdm");
      }
      
      public static function get instance() : jieshouPanel
      {
         if(!_instance)
         {
            _instance = new jieshouPanel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":300,
            "height":110
         },Global.Img_Cdm);
         this.tf = ComponentUtil.getTextField("",this,{
            "x":40,
            "y":40,
            "color":13421772,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Title_Invite",this,{
            "x":69,
            "y":5
         },Global.DuoRenKuaFu_Imgsdm);
         this.queDingBtn = ComponentUtil.getButton("确定","Button_Four",this,{
            "x":65,
            "y":70,
            "textColor":16774871
         },Global.Img_Cdm);
         this.quXiaoBtn = ComponentUtil.getButton("取消","Button_Four",this,{
            "x":165,
            "y":70,
            "textColor":16774871
         },Global.Img_Cdm);
         this.queDingBtn.addEventListener(MouseEvent.CLICK,this.queDingClick);
         this.quXiaoBtn.addEventListener(MouseEvent.CLICK,this.quXiaoClick);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":265,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.callBack = this.quXiaoClick;
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      public function show() : void
      {
         this.tf.text = KuaFuJJCVO.playername + "邀请你加入多人跨服竞技场";
         this.visible = true;
      }
      
      private function queDingClick(e:MouseEvent) : void
      {
         if(UIManager.mainUiBtnContainer.curFuBenType != 0)
         {
            UIManager.centerBroadcast.addMsg("该场景不支持进入多人跨服");
            return;
         }
         if(GameUnitManager.hero.paoBiao != 0)
         {
            UIManager.centerBroadcast.addMsg("跑镖状态不支持进入多人跨服");
            return;
         }
         if(Model_team.hasTeam())
         {
            UIManager.centerBroadcast.addMsg("组队状态不支持进入多人跨服");
            return;
         }
         if(TeamPanel.instance.visible || DRKFlawPanel.instance.visible || DRKFlistPanel.instance.visible)
         {
            UIManager.centerBroadcast.addMsg("正在多人跨服");
            return;
         }
         var type:int = int(GameUnitManager.hero.level / 10) - 3;
         KuaFuJingJiChangCGMessage.CG_YAOQING_TONGYI(KuaFuJJCVO.teamid,type);
      }
      
      private function quXiaoClick(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
   }
}

