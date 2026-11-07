package com.yiTian.view.modules.guide
{
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.utils.MassLoader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class View_questGuiJian extends Sprite
   {
      
      private static var _instance:View_questGuiJian;
      
      public var bindSpr:Sprite;
      
      private var jian:MovieClip;
      
      public function View_questGuiJian()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
         if(!this.jian)
         {
            this.loadJian();
         }
      }
      
      public static function get instance() : View_questGuiJian
      {
         if(!_instance)
         {
            _instance = new View_questGuiJian();
         }
         return _instance;
      }
      
      private function loadJian() : void
      {
         MassLoader.add("modelRes/magic/jian.swf",function(info:Object):void
         {
            var imges:Class = info.applicationDomain.getDefinition("jianMov") as Class;
            jian = new imges();
            addChild(jian);
         },null,MassLoader.LEVEL0,null,Enum_resType.MODEL_URL);
      }
   }
}

