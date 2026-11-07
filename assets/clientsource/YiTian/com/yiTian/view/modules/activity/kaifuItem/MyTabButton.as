package com.yiTian.view.modules.activity.kaifuItem
{
   import com.ui.controls.TabButton;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.view.modules.activity.Enum_KF;
   import com.yiTian.view.modules.chat.EffecObj;
   import flash.events.MouseEvent;
   
   public class MyTabButton extends TabButton
   {
      
      private var _effect:Effect;
      
      private var _actId:int;
      
      private var _state:int = 0;
      
      private var bm:Bitmap2;
      
      public function MyTabButton()
      {
         super("","ClassButton",Global.Img_Cdm);
         addEventListener(MouseEvent.CLICK,this.clickCB);
      }
      
      private function clickCB(evt:MouseEvent) : void
      {
         var id:int = this.actId;
         UIManager.actKaiFu.setInfoId(id);
         UIManager.actKaiFu.CG_GETDATA(id);
      }
      
      public function get actId() : int
      {
         return this._actId;
      }
      
      public function set actId(value:int) : void
      {
         this._actId = value;
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function set state(value:int) : void
      {
         if(this._state == value)
         {
            return;
         }
         if(value == 1)
         {
            textColor = chooseColor = 16776960;
            EffecObj.getEffec(this);
         }
         else
         {
            textColor = chooseColor = 16773818;
            EffecObj.removeEffect(this);
         }
         this._state = value;
      }
      
      public function set dateImg(index:*) : void
      {
         if(index == 0)
         {
            if(Boolean(this.bm))
            {
               this.bm.load(null);
            }
            return;
         }
         this.bm = this.bm || new Bitmap2();
         if(Boolean(Enum_KF.URL_IMG[index]))
         {
            this.bm.load("resource/image/kfhd/" + Enum_KF.URL_IMG[index] + ".png");
         }
         else
         {
            this.bm.load("resource/image/kfhd/" + index + ".png");
         }
         this.bm.x = 62;
         this.bm.y = -3;
         this.addChild(this.bm);
      }
   }
}

