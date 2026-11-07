package com.yiTian.view.modules.KuaFuPaiDui
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.Panel;
   
   public class View_KuaFuPaiDui_explainMenu extends Panel
   {
      
      private static var _instance:View_KuaFuPaiDui_explainMenu;
      
      public function View_KuaFuPaiDui_explainMenu()
      {
         super();
         init();
      }
      
      public static function get instance() : View_KuaFuPaiDui_explainMenu
      {
         if(!_instance)
         {
            _instance = new View_KuaFuPaiDui_explainMenu();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getBitmap("Back_WXTS",this,{
            "x":0,
            "y":3
         },Global.KFPDdm);
         ComponentUtil.getBitmap("Title_WFSM",this,{
            "x":116,
            "y":0
         },Global.KFPDdm);
         CloseButton = ComponentUtil.getButton("","Button_GuanBi",this,{
            "x":303,
            "y":1,
            "textColor":16771436
         },Global.KFPDdm);
         var txt:MyTextField = ComponentUtil.getTextField("",this,{
            "x":19,
            "y":26,
            "color":16383744,
            "size":12,
            "leading":1
         });
         txt.multiline = true;
         txt.htmlText = "1．跨服分40-89，90级以上两个等级段<br/>" + "2．跨服派对每分钟可获得丰厚的经验奖励加成<br/>" + "3．跨服派对期间有情侣舞玩法<br/>" + "4．每次情侣舞有三分钟活动时间，结束后三分钟冷却<br/>" + "5．情侣舞中，每次输入舞步中均有经验加成<br/>" + "6．进入情侣舞要选好舞伴，中途出现更换舞伴时，<br/>" + "    默契度将会清零<br/>" + "7．默契度前十名的玩家将获得礼包奖励";
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

