package com.yiTian.view.modules.paoku.view
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.paoku.userCom.KuPaoMgr;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_DieMenu extends Sprite
   {
      
      public var hpView:MyTextField;
      
      public function Child_DieMenu()
      {
         super();
         this.init();
      }
      
      public static function get instance() : Child_DieMenu
      {
         return Singleton.getInstance(Child_DieMenu);
      }
      
      public function init() : void
      {
         ComponentUtil.getButton("返回游戏","Button_Four",this,{
            "x":100,
            "y":50,
            "callBack":this.returnClickHandler
         },Global.Img_Cdm);
      }
      
      private function returnClickHandler(e:MouseEvent) : void
      {
         KuPaoMgr.instance.paokuGlobalSM.changeState(KuPaoMgr.GST_STARTMENU,null);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
   }
}

