package com.yiTian.view.modules.huangbang
{
   import com.ui.controls.MyTextField;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.getTimer;
   
   public class Child_ShakerItem extends Sprite
   {
      
      private static const timeCount:int = 20;
      
      private var txt:MyTextField;
      
      private var icon:Bitmap;
      
      private var iconGuide:Bitmap;
      
      private var eff:Effect;
      
      private var isShowShake:Boolean;
      
      private var lastShakeTime:uint;
      
      private var lastTime:uint;
      
      private var up:Boolean;
      
      private var count:int;
      
      public function Child_ShakerItem()
      {
         super();
         this.icon = new Bitmap();
         this.icon.x = 10;
         this.icon.y = 5;
         addChild(this.icon);
         this.iconGuide = new Bitmap();
         this.iconGuide.x = -10;
         this.iconGuide.y = -45;
         addChild(this.iconGuide);
         this.eff = EffectManager.addEffect("35219",this,250,25,15,true);
         this.buttonMode = true;
      }
      
      public function update(url:String, str:String) : void
      {
         Utils.getLoadBitmap("resource/image/huangbang/" + url + ".png",this.icon);
         Utils.getLoadBitmap("resource/image/huangbang/guide/" + url + ".png",this.iconGuide);
         TipManager.bind(this,str);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.shake);
         this.iconGuide.visible = true;
      }
      
      public function showShake() : void
      {
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.shake);
         this.iconGuide.visible = true;
         this.isShowShake = true;
      }
      
      private function shake() : void
      {
         if(getTimer() - this.lastShakeTime > 500)
         {
            if(this.up == true)
            {
               this.iconGuide.y = -45;
               this.up = false;
            }
            else
            {
               this.iconGuide.y = -40;
               this.up = true;
            }
            this.lastShakeTime = getTimer();
         }
         if(getTimer() - this.lastTime > 1000 && this.isShowShake == false)
         {
            ++this.count;
            this.lastTime = getTimer();
            if(this.count >= timeCount)
            {
               this.hideGuide();
            }
         }
      }
      
      public function hideGuideByClick() : void
      {
         if(this.isShowShake == true)
         {
            this.hideGuide();
            this.isShowShake = false;
         }
      }
      
      private function hideGuide() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.shake);
         this.count = 0;
         this.iconGuide.visible = false;
      }
   }
}

