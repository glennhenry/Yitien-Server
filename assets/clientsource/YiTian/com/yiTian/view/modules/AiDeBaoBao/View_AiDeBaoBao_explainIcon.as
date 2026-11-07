package com.yiTian.view.modules.AiDeBaoBao
{
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_AiDeBaoBao_explainIcon extends Sprite
   {
      
      private static var _instance:View_AiDeBaoBao_explainIcon;
      
      private var bg:Bitmap;
      
      private var ef:Effect;
      
      public function View_AiDeBaoBao_explainIcon()
      {
         super();
      }
      
      public static function get instance() : View_AiDeBaoBao_explainIcon
      {
         if(!_instance)
         {
            _instance = new View_AiDeBaoBao_explainIcon();
            _instance.Init();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         this.bg = Utils.getLoadBitmap("resource/image/AiDeBaoBao/explain.png");
         this.buttonMode = true;
         this.addChild(this.bg);
         this.addEventListener(MouseEvent.CLICK,this.onClickHandle);
      }
      
      public function onClickHandle(e:MouseEvent = null) : void
      {
         View_AiDeBaoBao_explainMenu.instance.visible = !View_AiDeBaoBao_explainMenu.instance.visible;
      }
   }
}

