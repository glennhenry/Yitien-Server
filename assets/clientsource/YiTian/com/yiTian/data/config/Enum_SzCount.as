package com.yiTian.data.config
{
   import com.yiTian.data.vo.Vo_equip;
   import flash.utils.Dictionary;
   
   public class Enum_SzCount
   {
      
      public static var _dic:Dictionary = new Dictionary();
      
      public static var pool:Array = [];
      
      public function Enum_SzCount()
      {
         super();
      }
      
      public static function szCountHandle(voE:Vo_equip, time:int) : void
      {
         if(Boolean(_dic[voE.id_server]))
         {
            _dic[voE.id_server].rewmoveFrame();
            _dic[voE.id_server] = null;
         }
         var tar:voI = new voI();
         tar.time = time;
         tar.vo = voE;
         tar.addFrame();
         _dic[voE.id_server] = tar;
      }
   }
}

import com.yiTian.data.vo.Vo_equip;
import com.yiTian.manager.TipManager;
import com.yiTian.net.message.cg.BagCGMessage;
import com.yiTian.scene.GameScene;
import flash.display.Sprite;
import flash.utils.getTimer;

class voI extends Sprite
{
   
   public var time:int;
   
   public var vo:Vo_equip;
   
   private var lastTime:int;
   
   public function voI()
   {
      super();
   }
   
   public function addFrame() : void
   {
      GameScene.instance.addFrameCallBack(this.frameHandle);
   }
   
   public function frameHandle() : void
   {
      var now:int = getTimer();
      if(now - this.lastTime >= 1000)
      {
         --this.vo.daoTime;
         this.lastTime = now;
         if(TipManager.getEqView().visible)
         {
            if(this.vo.daoTime <= 0)
            {
               TipManager.getEqView().getSzT(true);
            }
            else
            {
               TipManager.getEqView().getSzT(false);
            }
         }
      }
      if(this.vo.daoTime < 0)
      {
         this.rewmoveFrame();
         BagCGMessage.CG_CZ_END(this.vo.id_server);
         return;
      }
   }
   
   public function rewmoveFrame() : void
   {
      GameScene.instance.removeFrameCallBack(this.frameHandle);
   }
}
