package com.yiTian.view.modules.qingrenjie
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Icon_QRJ extends Sprite
   {
      
      private static var _instance:Icon_QRJ;
      
      private var _bm:Bitmap;
      
      private var effect:Effect;
      
      public function Icon_QRJ()
      {
         super();
      }
      
      public static function get instance() : Icon_QRJ
      {
         if(!_instance)
         {
            _instance = new Icon_QRJ();
         }
         return _instance;
      }
      
      public function init() : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,this.show);
         }
         else
         {
            this.show();
         }
      }
      
      private function show() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,this.show);
         this._bm = new Bitmap();
         this._bm = Utils.getLoadBitmap("resource/image/qingrenjie/Icon_YXQY.png",this._bm);
         addChild(this._bm);
         this.effect = EffectManager.addEffect("35343",this,1000,32,29,true);
         buttonMode = true;
         UIManager.mainUiBtnContainer.addBTN(this);
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      protected function clickHandle(event:MouseEvent) : void
      {
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_QingRenJie.instance,function():void
         {
            View_QingRenJie.instance.visible = !View_QingRenJie.instance.visible;
         });
         if(Boolean(this.effect))
         {
            EffectManager.removeEffect(this.effect);
            this.effect = null;
         }
      }
   }
}

