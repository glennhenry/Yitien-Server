package com.yiTian.view.modules.roleHead
{
   import com.utils.ComponentUtil;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class VIP_item extends Sprite
   {
      
      private var vipBMP:Bitmap;
      
      private var _sourType:String;
      
      public function VIP_item()
      {
         super();
         this.vipBMP = new Bitmap();
         addChild(this.vipBMP);
         buttonMode = true;
         this.vipBMP.bitmapData = ComponentUtil.getBitmapData(View_HeroHead.VIP_DISABLED);
         addEventListener(MouseEvent.CLICK,this.cliHandle);
      }
      
      public function update(_index:int) : void
      {
         var temType:Boolean = false;
         if(_index == 1)
         {
            this.vipBMP.bitmapData = ComponentUtil.getBitmapData(View_HeroHead.VIP1);
            this._sourType = View_HeroHead.VIP1;
            temType = true;
         }
         else if(_index == 2)
         {
            this.vipBMP.bitmapData = ComponentUtil.getBitmapData(View_HeroHead.VIP2);
            this._sourType = View_HeroHead.VIP2;
            temType = true;
         }
         else if(_index == 3)
         {
            this.vipBMP.bitmapData = ComponentUtil.getBitmapData(View_HeroHead.VIP3);
            this._sourType = View_HeroHead.VIP3;
            temType = true;
         }
         else
         {
            this.vipBMP.bitmapData = ComponentUtil.getBitmapData(View_HeroHead.VIP_DISABLED);
            this._sourType = View_HeroHead.VIP_DISABLED;
            temType = false;
         }
      }
      
      public function get sourStype() : String
      {
         return this._sourType;
      }
      
      private function cliHandle(e:MouseEvent) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE || SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            return;
         }
         UIManager.vipPanel.visible = !UIManager.vipPanel.visible;
      }
   }
}

