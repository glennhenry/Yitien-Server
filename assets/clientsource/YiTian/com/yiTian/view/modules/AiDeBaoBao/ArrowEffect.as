package com.yiTian.view.modules.AiDeBaoBao
{
   import com.yiTian.data.config.Enum_AiDeBaoBao;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class ArrowEffect extends Sprite
   {
      
      private var arrow:Effect;
      
      private var setId:int;
      
      public function ArrowEffect()
      {
         super();
         this.arrow = EffectManager.addEffect("35247",this,2000,0,0,true);
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
      }
      
      private function onAddToStage(e:Event) : void
      {
         this.setId = setTimeout(this.hide,Enum_AiDeBaoBao.GUIDE_SHOW_TIMES);
      }
      
      public function hide() : void
      {
         clearTimeout(this.setId);
         EffectManager.removeEffect(this.arrow);
      }
   }
}

