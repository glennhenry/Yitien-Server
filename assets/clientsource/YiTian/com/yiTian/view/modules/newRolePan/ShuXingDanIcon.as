package com.yiTian.view.modules.newRolePan
{
   import com.yiTian.data.vo.Vo_shuXingDan;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Bitmap2;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ShuXingDanIcon extends Sprite
   {
      
      private var _bm:Bitmap2;
      
      private var _vo:Vo_shuXingDan;
      
      public function ShuXingDanIcon()
      {
         super();
         this._bm = new Bitmap2();
         addChild(this._bm);
         this.init();
      }
      
      public function get vo() : Vo_shuXingDan
      {
         return this._vo;
      }
      
      public function set vo(value:Vo_shuXingDan) : void
      {
         this._vo = value;
      }
      
      public function init() : void
      {
         this._bm.load("resource/image/shuxingdan/shuxingdan.png");
         addEventListener(MouseEvent.MOUSE_MOVE,this.showTipHd);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOutHd);
      }
      
      private function showTipHd(e:MouseEvent) : void
      {
         if(!this._vo)
         {
            return;
         }
         TipManager.update(this._vo);
      }
      
      private function rollOutHd(e:MouseEvent) : void
      {
         TipManager.hide();
      }
   }
}

