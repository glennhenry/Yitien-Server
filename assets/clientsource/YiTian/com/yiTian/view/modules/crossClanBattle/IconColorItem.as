package com.yiTian.view.modules.crossClanBattle
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   
   public class IconColorItem extends Sprite
   {
      
      private var colorIcon:Bitmap;
      
      private var nowVo:CityVo;
      
      private var color:int;
      
      public function IconColorItem(index:int)
      {
         var sp:Sprite = null;
         super();
         ComponentUtil.getBitmap("SLColor_Back",this,{
            "x":5,
            "y":5
         },Global.KFBang_CCdm);
         this.colorIcon = ComponentUtil.getBitmap("SLColor" + index,this,{
            "x":9,
            "y":9
         },Global.KFBang_CCdm);
         sp = new Sprite();
         addChild(sp);
         sp.addChild(this.colorIcon);
         sp.buttonMode = true;
         sp.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            CrossClanBattleCGMessage.CG_REFRESH_CITY_COLOR(color + "");
         });
      }
      
      public function updateColor(color:int, colorTransform:ColorTransform) : void
      {
         this.color = color + 1;
         this.colorIcon.bitmapData.colorTransform(this.colorIcon.bitmapData.rect,colorTransform);
      }
   }
}

