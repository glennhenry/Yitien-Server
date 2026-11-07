package com.yiTian.view.modules.tianMing
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.utils.Tween;
   import flash.display.DisplayObjectContainer;
   import flash.utils.getTimer;
   
   public class TianMing_Effect
   {
      
      private static var nowBitmap:EffItem;
      
      private static var time:Number;
      
      private static const START_POINT:Number = 80;
      
      private static const STOP_POINT:Number = 0;
      
      private static const END_POINT:Number = -50;
      
      public function TianMing_Effect()
      {
         super();
      }
      
      public static function addEff(type:int, parent:DisplayObjectContainer) : void
      {
         check();
         nowBitmap = EffItem.getItem();
         nowBitmap.init(type);
         ComponentUtil.setPropertie(nowBitmap,{
            "x":-nowBitmap.width / 2,
            "y":START_POINT
         });
         parent.addChild(nowBitmap);
         Tween.to(nowBitmap,800,{"y":[START_POINT,STOP_POINT]},stop,null,Tween.EASYINOUT);
      }
      
      private static function check() : void
      {
         if(Boolean(nowBitmap))
         {
            Tween.stop(nowBitmap);
            Tween.to(nowBitmap,800,{
               "y":[nowBitmap.y,END_POINT],
               "alpha":[nowBitmap.alpha,0]
            },clear,null,Tween.EASYINOUT);
            if(Global.control.hasCallBack(Enum_MsgType.MSG_ENTERFRAME,hide))
            {
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,hide);
            }
            nowBitmap = null;
         }
      }
      
      private static function clear(effItem:EffItem) : void
      {
         effItem.dispose();
      }
      
      private static function stop() : void
      {
         time = getTimer();
         nowBitmap.play();
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,hide);
      }
      
      private static function hide() : void
      {
         if(getTimer() - time >= 500)
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,hide);
            Tween.to(nowBitmap,800,{
               "y":[nowBitmap.y,END_POINT],
               "alpha":[nowBitmap.alpha,0]
            },clear,null,Tween.EASYINOUT);
            nowBitmap = null;
         }
      }
   }
}

import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.manager.EffectManager;
import flash.display.Bitmap;
import flash.display.Sprite;

class EffItem extends Sprite
{
   
   private static var pool:Vector.<EffItem> = new Vector.<EffItem>();
   
   private var bitmap:Bitmap;
   
   private var type:int;
   
   public function EffItem()
   {
      super();
   }
   
   public static function getItem() : EffItem
   {
      if(pool.length != 0)
      {
         return pool.pop();
      }
      return new EffItem();
   }
   
   public function init(type:int) : void
   {
      alpha = 1;
      this.type = type;
      var str:String = type == 1 ? "Up_Success" : "Up_Fail";
      this.bitmap = ComponentUtil.getBitmap(str,this,null,Global.TianMing_Imgsdm);
   }
   
   public function play() : void
   {
      if(this.type == 0)
      {
         EffectManager.addEffect("35065",this,500,20,25,false);
         EffectManager.addEffect("35065",this,500,130,25,false);
         EffectManager.addEffect("35066",this,500,75,25,false);
      }
      else
      {
         EffectManager.addEffect("35068",this,500,75,25,false);
      }
   }
   
   public function dispose() : void
   {
      alpha = 0;
      if(Boolean(this.bitmap))
      {
         if(Boolean(this.bitmap.parent))
         {
            removeChild(this.bitmap);
         }
         this.bitmap.bitmapData = null;
         this.bitmap = null;
      }
      if(Boolean(parent))
      {
         parent.removeChild(this);
      }
      pool.push(this);
   }
}
