package manager
{
   import flash.events.Event;
   
   public class FrameManager
   {
      
      public function FrameManager()
      {
         super();
      }
      
      public static function beginRun() : void
      {
         Global.stage.addEventListener(Event.ENTER_FRAME,run);
      }
      
      private static function run(e:Event) : void
      {
         EffectManager.run();
      }
      
      public static function endRun() : void
      {
         Global.stage.removeEventListener(Event.ENTER_FRAME,run);
      }
   }
}

