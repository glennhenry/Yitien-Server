package com.yiTian.view.modules.kuafujingjichang.extralDill
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import flash.display.DisplayObjectContainer;
   import flash.utils.setTimeout;
   
   public class Model_DRKF
   {
      
      private static var lianZhanCount:int;
      
      public function Model_DRKF()
      {
         super();
      }
      
      public static function set lianShaNun(value:int) : void
      {
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,battleEndHd);
         lianZhanCount = value;
      }
      
      private static function battleEndHd() : void
      {
         var n:int;
         if(lianZhanCount == 0)
         {
            return;
         }
         LianZhanUnit.instance.visible = true;
         n = int(setTimeout(function():void
         {
            LianZhanUnit.instance.addLianZhan(lianZhanCount);
         },500));
      }
      
      public static function beginHd() : void
      {
         LianZhanUnit.instance.visible = false;
      }
      
      public static function addLianZhanUnit(_parent:DisplayObjectContainer, obj:Object) : void
      {
         _parent.addChild(LianZhanUnit.instance);
         LianZhanUnit.instance.visible = false;
         LianZhanUnit.instance.property = obj;
      }
      
      public static function hide() : void
      {
         LianZhanUnit.instance.visible = false;
      }
   }
}

