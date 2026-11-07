package com.yiTian.view.modules.newerGuide.thirdNewerGuide
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   
   public class thirdNewerContainer extends Sprite
   {
      
      private static var _instance:thirdNewerContainer;
      
      private static const GAPWIDTH:int = 70;
      
      private static const GAPHEIGHT:int = 70;
      
      private static const MIDGAP:int = 365;
      
      private static const LEFT_CONTAIN:int = 0;
      
      private static const RIGHT_CONTAIN:int = 1;
      
      private static const ROLL_NUM:int = 6;
      
      public static const OUTSIDE_MOVEIN:String = "outside_movein";
      
      public static const INSIDE_MOVE:String = "inside_move";
      
      private static var containerVec:Vector.<Sprite> = new Vector.<Sprite>();
      
      private var arr:Array = [];
      
      public function thirdNewerContainer()
      {
         var s:Sprite = null;
         super();
         GameScene.uiLayer.addChild(this);
         var i:int = 0;
         while(i < 2)
         {
            s = new Sprite();
            addChild(s);
            ComponentUtil.setPropertie(s,{"x":MIDGAP * i});
            containerVec.push(s);
            i++;
         }
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.reposition);
         this.reposition();
      }
      
      public static function get instance() : thirdNewerContainer
      {
         if(!_instance)
         {
            _instance = new thirdNewerContainer();
         }
         return _instance;
      }
      
      public function addBtn(disObj:BtnSpr, status:int) : void
      {
         if(this.arr.indexOf(disObj) != -1)
         {
            return;
         }
         this.arr.push(disObj);
         disObj.status = status;
         if(status == 1)
         {
            ComponentUtil.setPropertie(disObj,{
               "x":-100,
               "y":-100
            });
            this.moveBtn(disObj,1,1000);
         }
         else if(status == 2)
         {
            ComponentUtil.setPropertie(disObj,{
               "x":-600,
               "y":-100
            });
            this.moveBtn(disObj,2,2000);
         }
      }
      
      public function moveBtn(disObj:BtnSpr, status:int, time:int, moveType:String = "outside_movein") : void
      {
         var __X:int = 0;
         var nerversN:int = status == 1 ? 2 : 1;
         var con:Sprite = containerVec[status - 1];
         var other:Sprite = containerVec[nerversN - 1];
         disObj.status = status;
         if(moveType == INSIDE_MOVE)
         {
            __X = disObj.x + disObj.parent.x - con.x;
            ComponentUtil.setPropertie(disObj,{"x":__X});
         }
         con.addChild(disObj);
         this.resize(con,time);
         if(moveType == INSIDE_MOVE)
         {
            this.resize(other,time);
         }
      }
      
      private function resize(contain:DisplayObjectContainer, time:int = 1000) : void
      {
         var pro:Object = null;
         var childObj:DisplayObject = null;
         var num:int = contain.numChildren;
         var j:int = 0;
         while(j < num)
         {
            pro = {
               "x":int(j % ROLL_NUM) * GAPWIDTH,
               "y":int(j / ROLL_NUM) * GAPHEIGHT
            };
            childObj = contain.getChildAt(j);
            Tween.curTo(childObj,time,pro);
            j++;
         }
      }
      
      public function removeBtn(disObj:DisplayObject, status:int) : void
      {
         var con:Sprite = null;
         if(this.arr.indexOf(disObj) == -1)
         {
            return;
         }
         con = containerVec[status - 1];
         Tween.to(disObj,500,{
            "y":[disObj.y,disObj.y - 300],
            "alpha":[1,0]
         },function():void
         {
            con.removeChild(disObj);
            arr.splice(arr.indexOf(disObj),1);
            resize(con);
         });
      }
      
      private function reposition() : void
      {
         x = (Global.stage.stageWidth - 930) / 2;
         y = (Global.stage.stageHeight - 400) / 2;
      }
   }
}

