package com.yiTian.view.modules.baby.babyIcon
{
   import com.utils.ComponentUtil;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.view.modules.KFHomeland.EnterHomeControl;
   import com.yiTian.view.modules.baby.babyManager.Model_baby;
   import com.yiTian.view.modules.baby.babyPan.BabyPanGuide;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class BabyIcon
   {
      
      private static var icon:MainUIBtn;
      
      public static var hasIcon:Boolean = false;
      
      public function BabyIcon()
      {
         super();
      }
      
      public static function show() : void
      {
         var _parent:DisplayObjectContainer = null;
         var point:Point = null;
         if(GameUnitManager.hero.level < 100)
         {
            return;
         }
         if(!icon)
         {
            icon = new MainUIBtn("resource/image/baby/babyIcon.png");
            icon.addEventListener(MouseEvent.CLICK,iconEvent);
         }
         if(Boolean(EnterHomeControl.instance.exitBtn) && Boolean(EnterHomeControl.instance.exitBtn.parent))
         {
            _parent = EnterHomeControl.instance.exitBtn.parent;
            point = new Point(EnterHomeControl.instance.exitBtn.x - 65,EnterHomeControl.instance.exitBtn.y);
            if(!_parent.contains(icon))
            {
               _parent.addChild(icon);
            }
            ComponentUtil.setPropertie(icon,{
               "x":point.x,
               "y":point.y
            });
         }
         hasIcon = true;
      }
      
      public static function babyIconVisCtrl(result:int) : Function
      {
         if(result == 1)
         {
            return hide;
         }
         return show;
      }
      
      private static function iconEvent(e:MouseEvent) : void
      {
         Model_baby.show(BabyPanGuide.instance,"show");
      }
      
      public static function hide() : void
      {
         if(Boolean(icon) && Boolean(icon.parent))
         {
            icon.parent.removeChild(icon);
         }
         hasIcon = false;
      }
   }
}

