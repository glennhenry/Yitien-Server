package com.yiTian.view.modules.yellowDiamond_NationalDay
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.YellowDiamondCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_YellowDiamond_ND_Tip extends Sprite
   {
      
      private static var _instance:View_YellowDiamond_ND_Tip;
      
      private var _bg:Bitmap;
      
      private var eff:Effect;
      
      public var tipBtn:MainUIBtn;
      
      public function View_YellowDiamond_ND_Tip()
      {
         super();
      }
      
      public static function get instance() : View_YellowDiamond_ND_Tip
      {
         if(!_instance)
         {
            _instance = new View_YellowDiamond_ND_Tip();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         this._bg = Utils.getLoadBitmap("resource/image/myPath/yellow.png",this._bg);
         buttonMode = true;
         addChild(this._bg);
         if(!this.eff)
         {
            this.eff = EffectManager.addEffect("35343",this,1000,32,29,true);
         }
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      public function show() : void
      {
         if(!this.tipBtn)
         {
            this.tipBtn = new MainUIBtn("resource/image/myPath/yellow.png");
            UIManager.mainUiBtnContainer.addBTN(this.tipBtn);
            this.tipBtn.addEventListener(MouseEvent.CLICK,this.clickHandle);
         }
      }
      
      public function remove() : void
      {
         if(UIManager.mainUiBtnContainer.hasBTN(this.tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.tipBtn);
         }
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         UIManager.yellowDiamondND.visible = !UIManager.yellowDiamondND.visible;
         if(UIManager.yellowDiamondND.visible)
         {
            YellowDiamondCGMessage.CG_YELLOW_REQUEST_INITDATA();
         }
      }
   }
}

