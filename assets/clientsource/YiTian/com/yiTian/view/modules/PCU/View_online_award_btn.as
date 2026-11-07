package com.yiTian.view.modules.PCU
{
   import com.yiTian.data.config.Enum_pcu_status;
   import com.yiTian.data.model.Model_PCU;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_online_award_btn extends Sprite
   {
      
      private static var _instance:View_online_award_btn;
      
      private var _bg:Bitmap;
      
      private var ef:Effect;
      
      public function View_online_award_btn()
      {
         super();
      }
      
      public static function get instance() : View_online_award_btn
      {
         if(!_instance)
         {
            _instance = new View_online_award_btn();
            _instance.init();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         this._bg = Utils.getLoadBitmap("resource/image/daTingFuLi/daTingFuLi.png",this._bg);
         buttonMode = true;
         addChild(this._bg);
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         View_online_award.instance.visible = !View_online_award.instance.visible;
         var i:int = 0;
         while(i < 5)
         {
            if(Model_PCU.onlineData[i] == Enum_pcu_status.CAN_GET || Model_PCU.banghuiData[i] == Enum_pcu_status.CAN_GET)
            {
               return;
            }
            i++;
         }
         this.effectEnd();
      }
      
      public function effectBegin() : void
      {
         if(!this.ef)
         {
            this.ef = EffectManager.addEffect("35343",this,1000,32,29,true);
         }
      }
      
      public function effectEnd() : void
      {
         if(Boolean(this.ef))
         {
            EffectManager.removeEffect(this.ef);
            this.ef = null;
         }
      }
   }
}

