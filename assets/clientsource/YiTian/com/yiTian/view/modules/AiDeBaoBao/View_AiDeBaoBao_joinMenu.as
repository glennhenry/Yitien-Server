package com.yiTian.view.modules.AiDeBaoBao
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_AiDeBaoBao_joinMenu extends Panel123
   {
      
      private static var _instance:View_AiDeBaoBao_joinMenu;
      
      private var joinBtn:Button;
      
      private var closeBtn:Button;
      
      public function View_AiDeBaoBao_joinMenu()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/ADBB_Imgs.swf","ADBB_Imgsdm");
      }
      
      public static function get instance() : View_AiDeBaoBao_joinMenu
      {
         if(!_instance)
         {
            _instance = new View_AiDeBaoBao_joinMenu();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         move = new Rectangle(44,40,484,30);
         ComponentUtil.getBitmap("Back_Join",this,{
            "x":0,
            "y":0
         },Global.ADBB_Imgsdm);
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":532,
            "y":48,
            "textColor":16184781
         },Global.ADBB_Imgsdm);
         var txt1:MyTextField = ComponentUtil.getTextField("",this,{
            "x":110,
            "y":280,
            "color":16777215,
            "size":12,
            "leading":4
         });
         txt1.multiline = true;
         txt1.htmlText = "1.进入场景后，通过<font color=\'#ffff00\'>寻找搭档</font>功能寻找自己的搭档！\n" + "2.赛跑过程中男方和女方之间要相互配合，灵活使用各种辅助技能。\n" + "3.各种欢乐，各种恶搞，赶快抱起心爱的她，共同奔向爱情的终点吧！";
         var txt2:MyTextField = ComponentUtil.getTextField("",this,{
            "x":110,
            "y":355,
            "color":16776960,
            "size":12,
            "leading":4
         });
         txt2.multiline = true;
         txt2.htmlText = "<font color=\'#00ff00\'>活动开放时间：周三21:30-22:00 周日 20:30-21:00</font><br/>" + "海量经验和奖励等着你来拿！";
         this.joinBtn = ComponentUtil.getButton("","Button_Join",this,{
            "x":418,
            "y":356,
            "textColor":16184781
         },Global.ADBB_Imgsdm);
         this.joinBtn.callBack = this.join;
         this.closeBtn.callBack = this.closeMenu;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.closeMenu);
      }
      
      private function closeMenu(e:*) : void
      {
         this.visible = false;
      }
      
      private function join(e:MouseEvent = null) : void
      {
         View_AiDeBaoBao_serverMenu.instance.visible = true;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

