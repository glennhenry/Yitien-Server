package com.yiTian.view.modules.newRolePan
{
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.view.modules.shenBing.ShenBingUtil;
   import com.yiTian.view.modules.shenBing.Vo_ShenBingAtb;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ShenBingAtbIconSp extends Sprite
   {
      
      private var _bm:Bitmap2;
      
      private var _enabled:Boolean = false;
      
      private var _vo:Vo_ShenBingAtb;
      
      public function ShenBingAtbIconSp()
      {
         super();
         this._bm = new Bitmap2();
         addChild(this._bm);
      }
      
      public function set vo(vo:Vo_ShenBingAtb) : void
      {
         this._vo = vo;
         visible = Boolean(vo) && vo.type > 0;
      }
      
      public function get vo() : Vo_ShenBingAtb
      {
         return this._vo;
      }
      
      public function init() : void
      {
         if(this._enabled == true)
         {
            return;
         }
         this._enabled = true;
         this._bm.load(ShenBingUtil.ATB_ICON);
         addEventListener(MouseEvent.MOUSE_MOVE,this.showTipHd);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOutHd);
      }
      
      protected function rollOutHd(event:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      protected function showTipHd(event:MouseEvent) : void
      {
         if(!this._vo || this.vo.type <= 0)
         {
            return;
         }
         TipManager.update(this._vo);
      }
   }
}

