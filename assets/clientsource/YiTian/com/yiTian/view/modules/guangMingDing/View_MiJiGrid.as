package com.yiTian.view.modules.guangMingDing
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.Pool;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   
   public class View_MiJiGrid extends Sprite
   {
      
      private var _bmBG:Bitmap2;
      
      private var _bmIcon:Bitmap2;
      
      public var _tfCount:MyTextField;
      
      public var _vo:Vo_MiJi;
      
      public function View_MiJiGrid()
      {
         super();
         this._bmBG = new Bitmap2();
         addChild(this._bmBG);
         this._bmIcon = new Bitmap2();
         this._bmIcon.x = 3;
         this._bmIcon.y = 3;
         addChild(this._bmIcon);
         this._tfCount = ComponentUtil.getTextField("",this,{
            "x":34,
            "y":21
         });
         this._tfCount.autoSize = TextFieldAutoSize.RIGHT;
      }
      
      public static function getObj() : View_MiJiGrid
      {
         return Pool.getObject(View_MiJiGrid);
      }
      
      public function setBG(iconUrl:String = null) : void
      {
         this._bmBG.load(iconUrl);
      }
      
      public function set vo(vo:Object) : void
      {
         this._vo = vo as Vo_MiJi;
         this._bmIcon.load(vo.getIconUrl());
         this._tfCount.text = vo.freeCount.toString();
      }
      
      public function get vo() : Object
      {
         return this._vo;
      }
      
      public function dispose() : void
      {
         Pool.saveObject(this);
      }
   }
}

