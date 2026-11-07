package com.yiTian.view.modules.quest
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QuestCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.MainUIBase;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class View_quest_hero_panel extends MainUIBase
   {
      
      private const NO_USE:int = 0;
      
      private const SHOW_ACCEPT:int = 1;
      
      private const SHOW_REWARD:int = 2;
      
      private var beginEff:Effect;
      
      private var _status:int;
      
      private var _questid:int;
      
      public function View_quest_hero_panel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         addEventListener(MouseEvent.CLICK,this.checkAccept);
         GameScene.popupLayer.addChild(this);
         bindParent = GameScene.popupLayer;
         visible = false;
      }
      
      public function showQuestBegin() : void
      {
         this.clearShow();
         if(!this.beginEff)
         {
            this.beginEff = Effect.getEffect();
            this.beginEff.init("35039");
            this.beginEff.totalTime = 500;
            this.beginEff.px = 300;
            this.beginEff.py = 150;
            addChildAt(this.beginEff,0);
            GameScene.instance.addFrameCallBack(this.run);
            visible = true;
         }
         this.resetPosition();
         this._status = this.SHOW_ACCEPT;
      }
      
      public function run() : void
      {
         var now:int = getTimer();
         var past:int = now - this.beginEff.beginTime;
         if(past >= this.beginEff.totalTime)
         {
            this.beginEff.update(this.beginEff.totalTime - 1,this.beginEff.totalTime);
         }
         else
         {
            this.beginEff.update(now - this.beginEff.beginTime,this.beginEff.totalTime);
         }
      }
      
      private function checkAccept(e:MouseEvent) : void
      {
         if(this._status == this.SHOW_ACCEPT)
         {
            GameScene.instance.removeFrameCallBack(this.run);
            this.beginEff.beginTime = getTimer();
            GameScene.instance.addFrameCallBack(this.runFinish);
         }
         else
         {
            QuestCGMessage.CG_QUEST_HERO_FINISH(this._questid);
            this.clearShow();
         }
      }
      
      private function runFinish() : void
      {
         var now:int = getTimer();
         var past:int = now - this.beginEff.beginTime;
         if(past >= this.beginEff.totalTime)
         {
            GameScene.instance.removeFrameCallBack(this.runFinish);
            if(Boolean(this.beginEff))
            {
               Tween.to(this.beginEff,200,{"alpha":[1,0.2]},this.remove);
            }
            EffectManager.flyEff(localToGlobal(new Point(75,225)),new Point(UIManager.questTraceView.x + 30,UIManager.questTraceView.y + 135));
         }
         else
         {
            this.beginEff.update(this.beginEff.totalTime - past,this.beginEff.totalTime);
         }
      }
      
      private function remove() : void
      {
         this.beginEff.alpha = 1;
         this.beginEff.dispose();
         this.beginEff = null;
         visible = false;
         this._status = this.NO_USE;
      }
      
      private function clearShow() : void
      {
         if(this._status == this.SHOW_ACCEPT)
         {
            GameScene.instance.removeFrameCallBack(this.run);
            GameScene.instance.removeFrameCallBack(this.runFinish);
         }
         else if(this._status == this.SHOW_REWARD)
         {
            GameScene.instance.removeFrameCallBack(this.runReward);
         }
         if(Boolean(this.beginEff))
         {
            Tween.stop(this.beginEff);
            this.remove();
         }
      }
      
      public function showReward(questId:int) : void
      {
         this._questid = questId;
         this.clearShow();
         visible = true;
         if(!this.beginEff)
         {
            this.beginEff = Effect.getEffect();
            this.beginEff.init("35039");
            this.beginEff.totalTime = 500;
            this.beginEff.px = 300;
            this.beginEff.py = 150;
            addChildAt(this.beginEff,0);
            GameScene.instance.addFrameCallBack(this.runReward);
         }
         this.resetPosition();
         this._status = this.SHOW_REWARD;
      }
      
      private function runReward() : void
      {
         this.beginEff.update(this.beginEff.totalTime - 1,this.beginEff.totalTime);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 600) / 2;
         y = (Global.stage.stageHeight - 300) / 2;
      }
   }
}

