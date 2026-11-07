package com.yiTian.view.modules.cast
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class CastEffect extends Sprite
   {
      
      private static var playObj:DisplayObject;
      
      private static var upStyle:Bitmap;
      
      private static var _upStyle:BitmapData;
      
      private static var _bmp:Bitmap;
      
      public function CastEffect()
      {
         super();
      }
      
      public static function getEffect(source:String, obj:Object, _parent:Sprite) : void
      {
         var point:Point = null;
         if(Boolean(_bmp))
         {
            _bmp.bitmapData = null;
         }
         _upStyle = ComponentUtil.getBitmapData(source,Global.wordEffect);
         _bmp = ComponentUtil.getBitmap("",_parent,null,Global.wordEffect);
         _bmp.bitmapData = _upStyle;
         if(obj is Sprite)
         {
            _bmp.x = obj.x + obj.width / 2 - 30;
            _bmp.y = obj.y + obj.height - 86;
         }
         else if(obj is Point)
         {
            point = obj as Point;
            _bmp.x = point.x;
            _bmp.y = point.y;
         }
         var eff:Effect = EffectManager.addEffect("35068",_parent,500,_bmp.x + 70,_bmp.y + 23,false,2,endHanlde);
         eff.blendMode = BlendMode.ADD;
         eff.alpha = 0.5;
      }
      
      public static function getSkillEffect(source:String, _parent:Sprite) : void
      {
         var _point:Point = null;
         if(Boolean(_bmp))
         {
            _bmp.bitmapData = null;
         }
         _upStyle = ComponentUtil.getBitmapData(source,Global.Img_Cdm);
         _bmp = ComponentUtil.getBitmap("",_parent,null,Global.Img_Cdm);
         _bmp.bitmapData = _upStyle;
         _point = new Point(Global.stage.stageWidth / 2,Global.stage.stageHeight / 2);
         _bmp.x = _point.x;
         _bmp.y = _point.y;
         var eff:Effect = EffectManager.addEffect("35068",_parent,500,_point.x,_point.y,false,2,endHanlde);
         eff.blendMode = BlendMode.ADD;
         eff.alpha = 0.5;
      }
      
      public static function getFailEffect(source:String, obj:Object, _parent:Sprite) : void
      {
         var point:Point = null;
         if(Boolean(_bmp))
         {
            _bmp.bitmapData = null;
         }
         _upStyle = ComponentUtil.getBitmapData(source,Global.wordEffect);
         _bmp = ComponentUtil.getBitmap("",_parent,null,Global.wordEffect);
         _bmp.bitmapData = _upStyle;
         if(obj is Sprite)
         {
            _bmp.x = obj.x + obj.width / 2 - 30;
            _bmp.y = obj.y + obj.height - 86;
         }
         else if(obj is Point)
         {
            point = obj as Point;
            _bmp.x = point.x;
            _bmp.y = point.y;
         }
      }
      
      public static function endHanlde() : void
      {
         _bmp.bitmapData = null;
      }
      
      public static function effectHandle(grid:View_Grid, sourceStr:String) : void
      {
      }
      
      public static function tweenHanlde(startGrid:View_Grid, endGrid:View_Grid, sourceStr:String, compleHandle:Function) : void
      {
      }
   }
}

