package com.yiTian.view.modules.tiliStore
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.model.Model_tiliStore;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class View_tiliTip extends Sprite
   {
      
      private static var point:Point;
      
      private static var movePos1:Point;
      
      private static var movePos2:Point;
      
      private static var beginTime:int;
      
      private static var startX:int;
      
      private static var startY:int;
      
      private static var endX:int;
      
      private static var endY:int;
      
      public static var pool:Array = [];
      
      private static var _leftTime:int = 10;
      
      public static var gap:int = 0;
      
      public function View_tiliTip()
      {
         super();
         var back:DisplayObject = ComponentUtil.getDisplayObject("XSTiShi_TLBuy",this);
         var tf:MyTextField = ComponentUtil.getTextField(LangConfig.getWord("60309",6),this,{
            "x":17,
            "y":5,
            "wordWrap":true,
            "multiline":true,
            "realWidth":148,
            "leading":3,
            "color":6736947
         });
         back.width = tf.width + 18;
         back.height = tf.height + 8;
         GameScene.popupLayer.addChild(this);
      }
      
      public static function getInstance() : View_tiliTip
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new View_tiliTip();
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            point = UIManager.heroHead.getTiliBtnPos();
            x = point.x + 16;
            y = point.y - 4;
            movePos1 = new Point(x - gap,y);
            movePos2 = new Point(x + gap,y);
            startX = x;
            startY = y;
            endX = movePos1.x;
            endY = movePos1.y;
            beginTime = getTimer();
            GameScene.instance.addFrameCallBack(this.frameHandle);
         }
         else
         {
            Model_tiliStore.isTiliFull = false;
            this.removeItem();
         }
      }
      
      private function frameHandle(interenal:int) : void
      {
         var now:int = getTimer();
         if(now - beginTime >= 1000)
         {
            --_leftTime;
            Tween.to(this,1000,{
               "x":[startX,endX],
               "y":[startY,endY]
            },this.comp);
            beginTime = now;
         }
         if(_leftTime < 1)
         {
            this.visible = false;
         }
         if(Model_tiliStore.isTiliFull == false)
         {
            this.visible = false;
         }
      }
      
      public function removeItem() : void
      {
         GameScene.instance.removeFrameCallBack(this.frameHandle);
         pool.push(this);
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         delete global[this];
      }
      
      private function comp() : void
      {
         startX = endX;
         startY = endY;
         if(endX == movePos2.x)
         {
            endX = movePos1.x;
         }
         else if(endX == movePos1.x)
         {
            endX = movePos2.x;
         }
      }
   }
}

