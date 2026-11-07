package com.yiTian.view.modules.farm
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_farm_small_icon extends Sprite
   {
      
      public static const typeList:Array = ["",LangConfig.getWord("40",9),LangConfig.getWord("41",9),LangConfig.getWord("42",9),LangConfig.getWord("43",9),LangConfig.getWord("44",9),LangConfig.getWord("45",9),LangConfig.getWord("46",9),LangConfig.getWord("47",9),LangConfig.getWord("48",9),LangConfig.getWord("49",9),LangConfig.getWord("164",9)];
      
      public static const typeName:Array = ["","iconLook","iconCatch","iconRelease","iconReward","iconRedeem","iconSeekHelp","iconResist","iconGrab","iconShovel","iconRefresh","iconLook"];
      
      public static const type_look:uint = 1;
      
      public static const type_catch:uint = 2;
      
      public static const type_release:uint = 3;
      
      public static const type_reward:uint = 4;
      
      public static const type_redeem:uint = 5;
      
      public static const type_seek_help:uint = 6;
      
      public static const type_resist:uint = 7;
      
      public static const type_grab:uint = 8;
      
      public static const type_kill:uint = 9;
      
      public static const type_refresh:uint = 10;
      
      public static const type_grab_look:uint = 11;
      
      private var bg:Bitmap;
      
      private var pic:Bitmap;
      
      public var type:uint;
      
      public function View_farm_small_icon(type:uint)
      {
         super();
         this.type = type;
         this.init();
      }
      
      private function init() : void
      {
         this.bg = ComponentUtil.getBitmap("iconBg",this,null,Global.ShanZhuang_Imgsdm);
         this.buttonMode = true;
         TipManager.bind(this,typeList[this.type]);
         this.pic = ComponentUtil.getBitmap(typeName[this.type],this,null,Global.ShanZhuang_Imgsdm);
         this.pic.x = 2;
         this.pic.y = 2;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
      }
      
      private function onOver(evt:MouseEvent) : void
      {
         filters = Util.glowFFFF00;
      }
      
      private function onOut(evt:MouseEvent) : void
      {
         filters = null;
      }
   }
}

