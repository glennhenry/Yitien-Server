package com.yiTian.view.modules.ChongChuJiangHu
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.net.message.cg.ChongChuJinagHuCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_ChongChuJiangHu_Icon extends Sprite
   {
      
      private static var _instance:View_ChongChuJiangHu_Icon;
      
      private var _bg:Bitmap;
      
      private var ef:Effect;
      
      public function View_ChongChuJiangHu_Icon()
      {
         super();
      }
      
      public static function get instance() : View_ChongChuJiangHu_Icon
      {
         if(!_instance)
         {
            _instance = new View_ChongChuJiangHu_Icon();
            _instance.Init();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         this._bg = new Bitmap();
         this._bg = Utils.getLoadBitmap("resource/image/ChongChuJiangHu/ChongChuJiangHu.png",this._bg);
         this.buttonMode = true;
         this.addChild(this._bg);
         this.addEventListener(MouseEvent.CLICK,this.onClickHandle);
      }
      
      private function onClickHandle(e:MouseEvent) : void
      {
         e.stopPropagation();
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_ChongChuJiangHu_menu.instance,function():void
         {
            View_ChongChuJiangHu_menu.instance.visible = !View_ChongChuJiangHu_menu.instance.visible;
            if(View_ChongChuJiangHu_menu.instance.visible)
            {
               ChongChuJinagHuCGMessage.OpenMenu();
            }
         });
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

