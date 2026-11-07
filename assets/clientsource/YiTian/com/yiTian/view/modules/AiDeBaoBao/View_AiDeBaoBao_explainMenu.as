package com.yiTian.view.modules.AiDeBaoBao
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.Panel;
   import flash.geom.Rectangle;
   
   public class View_AiDeBaoBao_explainMenu extends Panel
   {
      
      private static var _instance:View_AiDeBaoBao_explainMenu;
      
      private var checkBtn:Button;
      
      private var closeBtn:Button;
      
      public function View_AiDeBaoBao_explainMenu()
      {
         super();
         init();
      }
      
      public static function get instance() : View_AiDeBaoBao_explainMenu
      {
         if(!_instance)
         {
            _instance = new View_AiDeBaoBao_explainMenu();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         var txt:MyTextField;
         move = new Rectangle(282,33,305,30);
         ComponentUtil.getBitmap("Back_Teach",this,{
            "x":0,
            "y":0
         },Global.ADBB_Imgsdm);
         txt = ComponentUtil.getTextField("",this,{
            "x":335,
            "y":89,
            "color":16777215,
            "size":12,
            "leading":8
         });
         txt.multiline = true;
         txt.htmlText = "详细攻略<br/>" + "1、玩家可以通过<font color=\'#ffff00\'>寻找搭档</font>功能选择匹配。<br/>" + "2、匹配成功后激活搭档关系，等待比赛开始，搭<br/>" + "档匹配时间为<font color=\'#ffff00\'>10分钟</font>。<br/>" + "3、比赛开始后，拥抱者负责操作前进，被拥抱者<br/>" + "则负责释放辅助技能（一定要把握好使用技能的时<br/>" + "机哦）跑过中场后，点击NPC拥抱者与被拥抱者交<br/>" + "换位置，继续跑完下半场。<br/>" + "4、在规定的比赛时间内，全力向前冲刺，到达终<br/>" + "点即代表完成比赛（赛跑时间为<font color=\'#ffff00\'>20分钟</font>）。<br/>" + "5、比赛用时越短，奖励越丰厚！也可以返回起点，<br/>" + "协助他人完成比赛哦（协助可获得额外鲜花<br/>" + "奖励）。";
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":596,
            "y":48,
            "textColor":16184781
         },Global.ADBB_Imgsdm);
         this.closeBtn.callBack = function():void
         {
            visible = false;
         };
         this.checkBtn = ComponentUtil.getButton("","Button_CKJL",this,{
            "x":484,
            "y":378,
            "textColor":16184781
         },Global.ADBB_Imgsdm);
         this.checkBtn.callBack = function():void
         {
            View_AiDeBaoBao_prizeMenu.instance.visible = !View_AiDeBaoBao_prizeMenu.instance.visible;
         };
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

