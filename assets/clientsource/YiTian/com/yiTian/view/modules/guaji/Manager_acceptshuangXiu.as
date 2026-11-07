package com.yiTian.view.modules.guaji
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.net.message.cg.GuaJiCGMessage;
   import com.yiTian.scene.GameScene;
   import flash.utils.getTimer;
   
   public class Manager_acceptshuangXiu
   {
      
      private static var instance:Manager_acceptshuangXiu;
      
      private var poolVec:Vector.<View_isAcceptShuangXiu>;
      
      private var enableItemVec:Vector.<View_isAcceptShuangXiu>;
      
      public function Manager_acceptshuangXiu()
      {
         super();
         if(Boolean(instance))
         {
            throw new Error("singlon error");
         }
         this.poolVec = new Vector.<View_isAcceptShuangXiu>();
         this.enableItemVec = new Vector.<View_isAcceptShuangXiu>();
         instance = this;
      }
      
      public static function getInstance() : Manager_acceptshuangXiu
      {
         if(instance)
         {
         }
         return instance;
      }
      
      private function tick(interval:int) : void
      {
         var asx:View_isAcceptShuangXiu = null;
         var subTime:int = 0;
         var remainTime:int = 0;
         var curTime:int = getTimer();
         for each(asx in this.enableItemVec)
         {
            subTime = curTime - asx.startTime;
            remainTime = 10000 - subTime;
            if(remainTime > 0)
            {
               asx.setTimeRemain(Math.ceil(remainTime / 1000));
            }
            else
            {
               GuaJiCGMessage.CG_SHUANGXIU_REQUEST_CHOOSE(3,asx.id);
               this.disposeItem(asx);
            }
         }
      }
      
      public function stopTick() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.tick);
      }
      
      public function addInfo(obj:Object) : void
      {
         var asx:View_isAcceptShuangXiu = this.getItem();
         asx.resetData(obj);
         this.enableItemVec.push(asx);
         GameScene.uiLayer.addChild(asx);
         GameScene.instance.addFrameCallBack(this.tick);
      }
      
      public function getItem() : View_isAcceptShuangXiu
      {
         return Boolean(this.poolVec.length) ? this.poolVec.pop() : new View_isAcceptShuangXiu();
      }
      
      public function disposeItem(iasx:View_isAcceptShuangXiu) : void
      {
         if(Boolean(iasx.parent))
         {
            iasx.parent.removeChild(iasx);
         }
         var idx:int = this.enableItemVec.indexOf(iasx);
         if(idx != -1)
         {
            this.enableItemVec.splice(idx,1);
         }
         if(!this.enableItemVec.length)
         {
            this.stopTick();
         }
         if(this.poolVec.indexOf(iasx) == -1)
         {
            this.poolVec.push(iasx);
         }
      }
   }
}

