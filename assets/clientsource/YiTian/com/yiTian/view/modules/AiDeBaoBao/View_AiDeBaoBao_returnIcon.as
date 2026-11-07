package com.yiTian.view.modules.AiDeBaoBao
{
   import com.yiTian.net.message.cg.AiDeBaoBaoCGMessage;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_AiDeBaoBao_returnIcon extends Sprite
   {
      
      private static var _instance:View_AiDeBaoBao_returnIcon;
      
      private var bg:Bitmap;
      
      public function View_AiDeBaoBao_returnIcon()
      {
         super();
      }
      
      public static function get instance() : View_AiDeBaoBao_returnIcon
      {
         if(!_instance)
         {
            _instance = new View_AiDeBaoBao_returnIcon();
            _instance.Init();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         this.bg = Utils.getLoadBitmap("resource/image/AiDeBaoBao/return.png");
         this.buttonMode = true;
         this.addChild(this.bg);
         this.addEventListener(MouseEvent.CLICK,this.onClickHandle);
      }
      
      public function onClickHandle(e:MouseEvent = null) : void
      {
         AiDeBaoBaoCGMessage.CG_AiDeBaoBao_RETURN_TO_BEGIN();
         this.visible = false;
      }
   }
}

