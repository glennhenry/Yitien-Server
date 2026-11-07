package com.yiTian.view.comp
{
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.role.BattleUnit;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.chat.RichTF;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class SceneWords extends Sprite
   {
      
      private static var pool:Array = [];
      
      private var _bg:ScaleBitmap;
      
      private var _text:RichTF;
      
      private var _stop:int;
      
      public var isTurnningAlpha:Boolean = false;
      
      public function SceneWords()
      {
         super();
         this._bg = ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,null,Global.Img_Cdm);
         this._text = RichTF.getRichTF();
         this._text.init("");
         this._text.x = 3;
         this._text.y = 8;
         this._text.width = 160;
         addChild(this._text);
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public static function getWord() : SceneWords
      {
         if(Boolean(SceneWords.pool.length))
         {
            return SceneWords.pool.pop();
         }
         return new SceneWords();
      }
      
      public function set data(value:Object) : void
      {
         if(Boolean(this._text))
         {
            this._text.data = value;
         }
      }
      
      public function set text(str:String) : void
      {
         this._text.htmlText = str;
         this._bg.width = this._text.TextWidth + 11;
         this._bg.height = this._text.height + 9;
      }
      
      override public function get height() : Number
      {
         return this._bg.height;
      }
      
      override public function get width() : Number
      {
         return this._bg.width;
      }
      
      public function show(pos:Point, parent:Sprite) : void
      {
         if(this._stop != 0)
         {
            clearTimeout(this._stop);
         }
         x = pos.x;
         y = pos.y;
         parent.addChild(this);
         this._stop = setTimeout(this.hide,3000,this);
         alpha = 0;
         Tween.to(this,200,{"alpha":[0,1]});
      }
      
      public function hide(sceneWords:SceneWords) : void
      {
         Tween.to(sceneWords,3000,{"alpha":[1,0]},this.remove);
      }
      
      public function remove() : void
      {
         var _arr:Array = null;
         if(parent is BattleUnit)
         {
            _arr = (parent as BattleUnit).listWords;
            _arr.splice(_arr.indexOf(this),1);
         }
         else if(parent is Player)
         {
            _arr = (parent as Role).listWords;
            _arr.splice(_arr.indexOf(this),1);
         }
         Tween.stop(this);
         if(this.parent != null)
         {
            this._text.clearFace();
            this.parent.removeChild(this);
            pool.push(this);
         }
         this._text.data = null;
      }
   }
}

