package com.yiTian.view
{
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class ControlPan
   {
      
      public static var BAG:String = "bag";
      
      public static var CAST:String = "cast";
      
      public static var ROLE:String = "role";
      
      public static var dic_panel:Dictionary = new Dictionary();
      
      public function ControlPan()
      {
         super();
      }
      
      public static function panelControl(spri:Sprite) : void
      {
         if((Boolean(dic_panel[BAG]) || Boolean(dic_panel[ROLE])) && Boolean(dic_panel[CAST]))
         {
            if(spri == dic_panel[BAG] || spri == dic_panel[ROLE])
            {
               dic_panel[CAST].visible = false;
            }
            else if(spri == dic_panel[CAST])
            {
               if(Boolean(dic_panel[BAG]))
               {
                  dic_panel[BAG].visible = false;
               }
               if(Boolean(dic_panel[ROLE]))
               {
                  dic_panel[ROLE].visible = false;
               }
            }
         }
      }
   }
}

