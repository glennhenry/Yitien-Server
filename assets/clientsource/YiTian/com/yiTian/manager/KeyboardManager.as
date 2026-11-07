package com.yiTian.manager
{
   import com.yiTian.Global;
   import com.yiTian.view.modules.crossCampBattle.Model_CrossCampBattle;
   import com.yiTian.view.modules.kuafujingjichang.DRKFlistPanel;
   import flash.events.KeyboardEvent;
   import flash.system.IME;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   
   public class KeyboardManager
   {
      
      private static var cast:Array;
      
      public static const NUMBER1:int = 49;
      
      public static const NUMBER2:int = 50;
      
      public static const NUMBER3:int = 51;
      
      public static const NUMBER4:int = 52;
      
      public static const NUMBER5:int = 53;
      
      public static const NUMBER6:int = 54;
      
      public static const NUMBER7:int = 55;
      
      public static const NUMBER8:int = 56;
      
      public static const NUMBER9:int = 57;
      
      public static const NUMBER0:int = 48;
      
      public static const F1:int = 112;
      
      public static const F2:int = 113;
      
      public static const F3:int = 114;
      
      public static const F4:int = 115;
      
      public static const F5:int = 116;
      
      public static const F6:int = 117;
      
      public static const F7:int = 118;
      
      public static const F8:int = 119;
      
      public static const F9:int = 120;
      
      public static const F10:int = 121;
      
      public static const F11:int = 122;
      
      public static const F12:int = 123;
      
      public static const A:int = 65;
      
      public static const B:int = 66;
      
      public static const C:int = 67;
      
      public static const D:int = 68;
      
      public static const E:int = 69;
      
      public static const F:int = 70;
      
      public static const G:int = 71;
      
      public static const H:int = 72;
      
      public static const I:int = 73;
      
      public static const J:int = 74;
      
      public static const K:int = 75;
      
      public static const L:int = 76;
      
      public static const M:int = 77;
      
      public static const N:int = 78;
      
      public static const O:int = 79;
      
      public static const P:int = 80;
      
      public static const Q:int = 81;
      
      public static const R:int = 82;
      
      public static const S:int = 83;
      
      public static const T:int = 84;
      
      public static const U:int = 85;
      
      public static const V:int = 86;
      
      public static const W:int = 87;
      
      public static const X:int = 88;
      
      public static const Y:int = 89;
      
      public static const Z:int = 90;
      
      public static const SPACE:int = 32;
      
      public static const ESCAPE:int = 27;
      
      public static const TILDE:int = 192;
      
      public static const ENTER:int = 13;
      
      public static const TAB:int = 9;
      
      private static var isUp:Boolean = true;
      
      private static var _isEnabled:Boolean = true;
      
      private static var _restrains:Object = {};
      
      public function KeyboardManager()
      {
         super();
      }
      
      public static function setRestrain(key:String, v:Boolean) : void
      {
         _restrains[key] = v;
      }
      
      public static function set isEnabled(v:Boolean) : void
      {
         _isEnabled = v;
      }
      
      public static function get isEnabled() : Boolean
      {
         return _isEnabled;
      }
      
      public static function init() : void
      {
         Global.stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
         Global.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
         if(!cast)
         {
            cast = [];
            new KeyBorderHandler(cast);
         }
      }
      
      public static function onKeyUp(e:KeyboardEvent) : void
      {
         isUp = true;
      }
      
      public static function onKeyDown(e:KeyboardEvent) : void
      {
         var b:Boolean = false;
         if(Global.focus is TextField && (Global.focus as TextField).type == TextFieldType.INPUT)
         {
            IME.enabled = true;
            return;
         }
         for each(b in _restrains)
         {
            if(b)
            {
               IME.enabled = true;
               return;
            }
         }
         IME.enabled = false;
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE || Global.sceneMap == 14401)
         {
            if(!isUp || e.keyCode != M)
            {
               return;
            }
         }
         else if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            if(Model_CrossCampBattle.hasDie == true)
            {
               return;
            }
            if(!isUp || e.keyCode != M)
            {
               return;
            }
         }
         else
         {
            if(Boolean(DRKFlistPanel.instance) && DRKFlistPanel.instance.visible)
            {
               DRKFlistPanel.instance.closeClick();
            }
            if(!isUp || !isEnabled)
            {
               return;
            }
         }
         if(Boolean(cast[e.keyCode]))
         {
            cast[e.keyCode](e);
         }
         isUp = false;
      }
      
      public static function dispose() : void
      {
         Global.stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyUp);
         Global.stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
      }
   }
}

