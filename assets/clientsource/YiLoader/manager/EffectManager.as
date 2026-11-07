package manager
{
   import flash.display.Sprite;
   import flash.utils.getTimer;
   import view.Effect;
   
   public class EffectManager
   {
      
      private static var effects:Array = [];
      
      public function EffectManager()
      {
         super();
      }
      
      public static function run() : void
      {
         var effect:Effect = null;
         var past:int = 0;
         var now:int = getTimer();
         var i:int = effects.length - 1;
         while(i >= 0)
         {
            effect = effects[i] as Effect;
            past = now - effect.beginTime;
            if(past >= effect.totalTime)
            {
               if(!effect.isLoop)
               {
                  effects.splice(i,1);
                  effect.dispose();
               }
               else
               {
                  effect.beginTime = now;
               }
            }
            else
            {
               effect.update(now - effect.beginTime,effect.totalTime);
            }
            i--;
         }
      }
      
      public static function addEffect(sourceId:String, parent:Sprite, totalTime:int, px:int, py:int, isLoop:Boolean = false) : Effect
      {
         var eff:Effect = Effect.getEffect();
         eff.init(sourceId);
         eff.totalTime = totalTime;
         eff.px = px;
         eff.py = py;
         eff.isLoop = isLoop;
         if(Boolean(parent))
         {
            parent.addChild(eff);
         }
         effects.push(eff);
         return eff;
      }
      
      public static function removeEffect(eff:Effect) : void
      {
         var index:int = effects.indexOf(eff);
         if(index != -1)
         {
            effects.splice(index,1);
         }
         eff.dispose();
      }
   }
}

