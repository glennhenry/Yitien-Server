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
   
   public class DRKFjoinPanel extends Panel123
   {
      
      private static var _instance:DRKFjoinPanel;
      
      private var joinBtn:Button;
      
      private var back:ScaleBitmap;
      
      private var storeBtn:Button;
      
      private var tf:MyTextField;
      
      private var timetf:MyTextField;
      
      private var questBtn:Button;
      
      private var rankBtn:Button;
      
      public function DRKFjoinPanel()
      {
         super();
         regResource("lang/ch/DRKF_Imgs.swf","DRKF_Imgsdm");
      }
      
      public static function get instance() : DRKFjoinPanel
      {
         if(!_instance)
         {
            _instance = new DRKFjoinPanel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":568,
            "height":490
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":520,
            "height":440
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":534,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.questBtn = ComponentUtil.getButton("","Button_Quest",this,{
            "x":510,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.questBtn.visible = false;
         CloseButton.callBack = this.close;
         ComponentUtil.getBitmap("Enter_Back",this,{
            "x":34,
            "y":50
         },Global.DRKF_Imgsdm);
         this.joinBtn = ComponentUtil.getButton("","Button_Enter",this,{
            "x":361,
            "y":365,
            "textColor":16184781
         },Global.DRKF_Imgsdm);
         this.storeBtn = ComponentUtil.getButton("","Button_Store",this,{
            "x":229,
            "y":365,
            "textColor":16184781
         },Global.DRKF_Imgsdm);
         this.rankBtn = ComponentUtil.getButton("","Button_Rank",this,{
            "x":97,
            "y":365,
            "textColor":16184781
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Title_DRKFJingJi",this,{
            "x":204,
            "y":5
         },Global.DRKF_Imgsdm);
         this.tf = ComponentUtil.getTextField("",this,{
            "x":162,
            "y":220,
            "color":16764206,
            "size":12,
            "leading":6
         });
         this.timetf = ComponentUtil.getTextField("",this,{
            "x":178,
            "y":330,
            "color":16764206,
            "size":12,
            "leading":6
         });
         this.tf.multiline = true;
         this.tf.htmlText = "      团队跨服竞技场所，在这里你能够体验到<br>前所未有的快感，可以面对一些从未碰面过的<br>江湖中人，可是大家又在同一个江湖中，不一<br>样的倚天，不一样的江湖。";
         this.timetf.htmlText = "<font color = \'#ff0000\'>每日的16:00-17:00 / 22:00-24:00进入</font>";
         this.joinBtn.addEventListener(MouseEvent.CLICK,this.joinClick);
         this.storeBtn.addEventListener(MouseEvent.CLICK,this.storeClick);
         this.questBtn.addEventListener(MouseEvent.CLICK,this.queseClick);
         this.rankBtn.addEventListener(MouseEvent.CLICK,this.rankClick);
      }
      
      private function queseClick(e:MouseEvent) : void
      {
         Global.delegate.dosomething(UIManager.drkfjs,UIManager.drkfjs.show);
      }
      
      private function rankClick(e:MouseEvent) : void
      {
         if(Boolean(DRKFRank.instance.combobox))
         {
            DRKFRank.instance.combobox.select(int(GameUnitManager.hero.level / 10 - 3));
         }
         KuaFuJingJiChangCGMessage.CG_STAR_PAIHANG(int(GameUnitManager.hero.level / 10 - 3));
      }
      
      private function joinClick(e:MouseEvent) : void
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
         KuaFuJingJiChangCGMessage.CG_KUAFUJJC_CLICK(2);
      }
      
      private function close(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function storeClick(e:MouseEvent) : void
      {
         KuaFuJingJiChangCGMessage.CG_PALYER_VALUE();
         Global.delegate.dosomething(UIManager.xyShop,UIManager.xyShop.show);
      }
      
      public function show() : void
      {
         if(visible)
         {
            this.visible = false;
         }
         else
         {
            this.visible = true;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

