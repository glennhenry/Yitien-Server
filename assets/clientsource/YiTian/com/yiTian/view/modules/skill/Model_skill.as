package com.yiTian.view.modules.skill
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_bar_swap;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.SkillCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.skill.masterSk.GuideTip;
   import com.yiTian.view.modules.skill.masterSk.View_masterSkill;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Model_skill
   {
      
      private static var _container:DisplayObjectContainer;
      
      public static var msterSkillPan:View_masterSkill;
      
      public static var dragObj:DragObj;
      
      public static var guideObj:Sprite;
      
      private static var startX:Number = 0;
      
      private static var startY:Number = 0;
      
      public static var isGuideSkill:Boolean = false;
      
      public function Model_skill()
      {
         super();
      }
      
      public static function addMasterUnit(_parent:DisplayObjectContainer) : void
      {
         _container = _parent;
      }
      
      public static function hideMasterSkillPan() : void
      {
         _container.visible = false;
      }
      
      public static function showMasterSkillPan() : void
      {
         _container.visible = true;
         if(!msterSkillPan)
         {
            msterSkillPan = new View_masterSkill();
            _container.addChild(msterSkillPan);
         }
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(msterSkillPan,msterSkillPan.show);
      }
      
      public static function dragTarget(target:Bitmap, index:int) : void
      {
         startX = target.x;
         startY = target.y;
         if(!dragObj)
         {
            dragObj = new DragObj();
         }
         dragObj.bm.bitmapData = target.bitmapData;
         dragObj.data = index;
         if(Global.stage.hasEventListener(MouseEvent.MOUSE_MOVE) == false)
         {
            Global.stage.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
         }
      }
      
      public static function runToSkillBar() : void
      {
         var point:Point = null;
         isGuideSkill = true;
         var icon:Bitmap = ComponentUtil.getBitmap("JiNeng",Global.stage,{
            "x":Global.stage.stageWidth / 2,
            "y":Global.stage.stageHeight / 2
         },Global.Img_Cdm);
         point = UIManager.mainMenu.getItemGlobalPosC("skillBtn");
         Tween.to(icon,1000,{
            "x":[icon.x,point.x],
            "y":[icon.y,point.y]
         },function(bm:Bitmap):void
         {
            var nn:int = 0;
            if(!guideObj)
            {
               getGuideSkill();
            }
            if(Boolean(bm) && Boolean(bm.parent))
            {
               bm.parent.removeChild(bm);
            }
            UIManager.mainMenu.skillBtn.transform.colorTransform = Util.yellow;
            nn = int(setTimeout(function():void
            {
               clearTimeout(nn);
               UIManager.mainMenu.skillBtn.transform.colorTransform = Util.colorNomal;
            },130));
            runto(point.x + 24,point.y - 36,90);
         });
      }
      
      public static function uptoLvlHd() : void
      {
         var point:Point = null;
         if(UIManager.skillPanel.visible)
         {
            isGuideSkill = true;
            if(!guideObj)
            {
               getGuideSkill();
            }
            point = UIManager.skillPanel.localToGlobal(new Point(110,43));
            runto(point.x + 35,point.y - 40,90);
         }
         else
         {
            runToSkillBar();
         }
      }
      
      public static function removeGuideObj() : void
      {
         if(Boolean(guideObj) && Boolean(guideObj.parent))
         {
            guideObj.parent.removeChild(guideObj);
         }
         guideObj = null;
      }
      
      public static function addGuideMask(_parent:DisplayObjectContainer) : void
      {
         var shap:Shape = null;
         var guidTip:GuideTip = null;
         shap = ComponentUtil.getShape(455,428,0,0.4);
         _parent.addChild(shap);
         ComponentUtil.setPropertie(shap,{
            "x":34,
            "y":50
         });
         guidTip = new GuideTip();
         guidTip.Init();
         guidTip.Show(LangConfig.getWord("10669",1));
         ComponentUtil.setPropertie(guidTip,{
            "x":134,
            "y":125
         });
         _parent.addChild(guidTip);
         _parent.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            _parent.removeEventListener(MouseEvent.CLICK,arguments.callee);
            if(Boolean(shap) && Boolean(shap.parent))
            {
               shap.parent.removeChild(shap);
            }
            Tween.to(guidTip,500,{
               "x":[guidTip.x,455],
               "y":[guidTip.y,-10],
               "scaleX":[1,0],
               "scaleY":[1,0]
            },function(dObj:DisplayObject):void
            {
               var nn:int = 0;
               if(Boolean(dObj) && Boolean(dObj.parent))
               {
                  dObj.parent.removeChild(dObj);
               }
               UIManager.skillPanel.helpBtn.transform.colorTransform = Util.yellow;
               nn = int(setTimeout(function():void
               {
                  clearTimeout(nn);
                  UIManager.skillPanel.helpBtn.transform.colorTransform = Util.colorNomal;
               },100));
            });
            Model_skill.isGuideSkill = false;
         });
      }
      
      public static function runto(toX:Number, toY:Number, rotation:Number) : void
      {
         Tween.to(guideObj,400,{
            "x":[guideObj.x,toX],
            "y":[guideObj.y,toY],
            "rotation":[guideObj.rotation,rotation]
         },null,null,Tween.SIN);
      }
      
      private static function getGuideSkill() : void
      {
         guideObj = ComponentUtil.getDisplayObject("farm_arrow",Global.stage,{
            "x":Global.stage.stageWidth / 2,
            "y":Global.stage.stageHeight / 2
         },Global.Img_Cdm) as Sprite;
      }
      
      private static function onMove(e:MouseEvent) : void
      {
         if(Utils.dist(startX,startY,e.stageX,e.stageY) < 5)
         {
            return;
         }
         if(!Global.stage.contains(dragObj.bm))
         {
            Global.stage.addChild(dragObj.bm);
         }
         dragObj.bm.x = e.stageX - dragObj.bm.width / 2;
         dragObj.bm.y = e.stageY - dragObj.bm.height / 2;
      }
      
      public static function stopDraw() : void
      {
         if(!dragObj)
         {
            return;
         }
         if(Boolean(!Util.isOnUI && dragObj) && Boolean(int(dragObj.data) > 0) && int(dragObj.data) < 11)
         {
            SkillCGMessage.CG_SET_BAR(Enum_bar_swap.BAR_DEL,int(dragObj.data),0);
         }
         if(Boolean(dragObj.bm) && Global.stage.contains(dragObj.bm))
         {
            Global.stage.removeChild(dragObj.bm);
            dragObj.bm.bitmapData = null;
            dragObj.data = null;
         }
         Global.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
      }
   }
}

import flash.display.Bitmap;

class DragObj
{
   
   public var bm:Bitmap = new Bitmap();
   
   public var data:Object;
   
   public function DragObj()
   {
      super();
   }
}
