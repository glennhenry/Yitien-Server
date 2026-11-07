package com.yiTian.view.modules.tianTi
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Data_lib;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class Child_tianTiNode extends Sprite
   {
      
      private static var pool:Array = [];
      
      private var _lord:Child_tianTiUnit;
      
      private var _lv:int = 0;
      
      private var bg:Bitmap;
      
      private var tf:MyTextField;
      
      private var _isShowNpc:Boolean = false;
      
      public function Child_tianTiNode()
      {
         super();
      }
      
      public static function pop() : Child_tianTiNode
      {
         return Boolean(pool.length) ? pool.pop() : new Child_tianTiNode();
      }
      
      public function set lv(value:int) : void
      {
         this._lv = value;
      }
      
      public function get lv() : int
      {
         return this._lv;
      }
      
      public function init() : void
      {
         this.bg = new Bitmap();
         this.bg.x = -187;
         this.bg.y = -90;
         this.bg = Utils.getSwfBitmap("resource/pic_swf/Challenge_Floor.swf",this.bg);
         addChild(this.bg);
         this.tf = ComponentUtil.getTextField("",this);
      }
      
      private function loadC(info:Object) : void
      {
         TianTiManager.floodDomain = info.applicationDomain;
         var cla:Class = TianTiManager.floodDomain.getDefinition("s") as Class;
         this.bg.bitmapData = new cla();
      }
      
      public function isShowNpc(b:Boolean) : void
      {
         if(b)
         {
            if(!this._lord)
            {
               this._lord = Child_tianTiUnit.pop();
               addChild(this._lord);
            }
         }
         else if(Boolean(this._lord))
         {
            removeChild(this._lord);
            this._lord.dispose();
            this._lord = null;
         }
         this._isShowNpc = b;
      }
      
      public function resetNpcModel() : void
      {
         var i:int = 0;
         if(!this._lord)
         {
            return;
         }
         var tDic:Dictionary = Data_lib.tianTi;
         var nDic:Dictionary = Data_lib.npc;
         if(this.lv > 0 && this.lv <= TianTiManager.maxLv)
         {
            if(Boolean(this.lord))
            {
               i = int(nDic[tDic[this.lv][0]][4]);
               this.lord.type = Child_tianTiUnit.MONSTER;
               this.lord.way = 5;
               this.lord.modelId = i;
            }
         }
      }
      
      public function get lord() : Child_tianTiUnit
      {
         return this._lord;
      }
      
      public function dispose() : void
      {
         pool.push(this);
      }
   }
}

