package com.yiTian.manager
{
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.guide.View_questGuiJian;
   import com.yiTian.view.modules.guide.View_questGuiKuang;
   import com.yiTian.view.modules.quest.View_quest_trace;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class QuestGuiManager
   {
      
      private static var _bindSpr:Sprite;
      
      private static var toX:int;
      
      private static var toY:int;
      
      public function QuestGuiManager()
      {
         super();
      }
      
      public static function addJian(bindSpr:Sprite, _x:int, _y:int, rotation:int) : void
      {
         var jian:View_questGuiJian = null;
         var point:Point = null;
         var npc:Npc = null;
         var __x:int = 0;
         var __y:int = 0;
         if(bindSpr == null)
         {
            if(Boolean(View_questGuiJian.instance) && Boolean(View_questGuiJian.instance.parent))
            {
               View_questGuiJian.instance.parent.removeChild(View_questGuiJian.instance);
               Tween.stop(View_questGuiJian.instance);
            }
            return;
         }
         View_questGuiJian.instance.bindSpr = bindSpr;
         jian = View_questGuiJian.instance;
         if(Boolean(jian.parent))
         {
            _bindSpr = bindSpr;
            toX = _x;
            toY = _y;
            Tween.stop(jian);
            if(jian.parent != GameScene.popupLayer)
            {
               point = jian.parent.localToGlobal(new Point(jian.x,jian.y));
               jian.x = point.x;
               jian.y = point.y;
               GameScene.popupLayer.addChild(jian);
            }
            if(bindSpr is Npc)
            {
               npc = bindSpr as Npc;
               Tween.to(jian,400,{
                  "x":[jian.x,npc.global_x - CameraManager.sightX + _x],
                  "y":[jian.y,npc.global_y - CameraManager.sightY + _y],
                  "rotation":[jian.rotation,rotation]
               },moveEnd,null,Tween.SIN);
            }
            else
            {
               if(bindSpr.parent is View_quest_trace)
               {
                  __x = bindSpr.parent.x;
                  __y = bindSpr.parent.y;
               }
               else
               {
                  __x = bindSpr.x;
                  __y = bindSpr.y;
               }
               Tween.to(jian,400,{
                  "x":[jian.x,__x + _x],
                  "y":[jian.y,__y + _y],
                  "rotation":[jian.rotation,rotation]
               },moveEnd,null,Tween.SIN);
            }
         }
         else
         {
            View_questGuiJian.instance.x = _x;
            View_questGuiJian.instance.y = _y;
            View_questGuiJian.instance.rotation = rotation;
            bindSpr.addChild(View_questGuiJian.instance);
         }
      }
      
      private static function moveEnd() : void
      {
         var jian:View_questGuiJian = null;
         jian = View_questGuiJian.instance;
         jian.x = toX;
         jian.y = toY;
         _bindSpr.addChild(jian);
      }
      
      public static function addKuang(bindSpr:Sprite, _x:int, _y:int, wid:int, hei:int) : void
      {
         if(bindSpr == null)
         {
            if(Boolean(View_questGuiKuang.instance) && Boolean(View_questGuiKuang.instance.parent))
            {
               View_questGuiKuang.instance.parent.removeChild(View_questGuiKuang.instance);
               Tween.stop(View_questGuiKuang.instance);
            }
            return;
         }
         View_questGuiKuang.instance.setSize(wid,hei);
         View_questGuiKuang.instance.x = _x;
         View_questGuiKuang.instance.y = _y;
         bindSpr.addChild(View_questGuiKuang.instance);
      }
   }
}

