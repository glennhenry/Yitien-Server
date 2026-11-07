package com.yiTian.view.modules.kupao
{
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.paoku.core.entity.Entity;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.KuPaoMgr;
   import com.yiTian.view.modules.paoku.userCom.map.KuPaoBlock;
   import com.yiTian.view.modules.paoku.userCom.state.CenterFocusCamera;
   import com.yiTian.view.modules.paoku.userCom.state.GameCamera;
   import com.yiTian.view.modules.paoku.userCom.util.Config;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class KPMap extends Sprite
   {
      
      private static var _instance:KPMap;
      
      public var camera:GameCamera;
      
      public var entitys:Array = [];
      
      public var bmBg:Bitmap2;
      
      public var tileLayer:Sprite;
      
      public var _view:Sprite;
      
      public var blockMap:Object = {};
      
      public var shapeShape:Shape;
      
      private var _globalIndex:int;
      
      private var _needClearNulls:Boolean = false;
      
      public function KPMap()
      {
         super();
         var focusCam:CenterFocusCamera = new CenterFocusCamera();
         this.camera = focusCam;
         focusCam.focusPoint(KuPaoMgr.instance.focusPoint);
         this.bmBg = new Bitmap2();
         this.bmBg.y = -10;
         addChild(this.bmBg);
         this._view = new Sprite();
         addChild(this._view);
         this.tileLayer = new Sprite();
         this._view.addChild(this.tileLayer);
         this.shapeShape = new Shape();
         addChild(this.shapeShape);
      }
      
      public static function get instance() : KPMap
      {
         return _instance = _instance || new KPMap();
      }
      
      public function shake() : void
      {
         Tween.to(this.tileLayer,400,{"y":[-2,2]},null,null,this.shakeFunc);
      }
      
      private function shakeFunc(percent:Number) : Number
      {
         var rate:Number = percent * 3.1416 * 3;
         return Math.pow(1 - Math.sin(rate) / rate,1.2);
      }
      
      public function setBGStyle(st:int) : void
      {
         Utils.getLoadBitmap("resource/image/kupao/t" + st + ".jpg",this.bmBg,null,this.complete1);
      }
      
      private function complete1() : void
      {
         Tween.to(this.bmBg,1000,{"alpha":[0.2,1]});
      }
      
      public function update(interval:int) : void
      {
         var entity:Entity = null;
         var pkEntity:KuPaoEntity = null;
         var quad:Rectangle = null;
         var xx:Number = NaN;
         var yy:Number = NaN;
         var clone:Array = null;
         if(!Model_KuPao.gameing)
         {
            return;
         }
         this.shapeShape.graphics.clear();
         var len:int = int(this.entitys.length);
         var i:int = 0;
         while(i < len)
         {
            entity = this.entitys[i];
            if(entity != null)
            {
               entity.update();
               if(Model_KuPao.isDrawRect)
               {
                  pkEntity = entity as KuPaoEntity;
                  quad = pkEntity.getQuad();
                  if(quad.width > 0)
                  {
                     xx = quad.x;
                     yy = KuPaoUtil.convertViewY(quad.y);
                     this.shapeShape.graphics.lineStyle(0);
                     this.shapeShape.graphics.beginFill(16777215,0.4);
                     this.shapeShape.graphics.drawRect(xx,yy - quad.height,quad.width,quad.height);
                     this.shapeShape.graphics.endFill();
                  }
               }
            }
            i++;
         }
         if(this._needClearNulls)
         {
            clone = [];
            i = 0;
            while(i < len)
            {
               entity = this.entitys[i];
               if(entity != null)
               {
                  clone.push(entity);
               }
               i += 1;
            }
            this.entitys.length = 0;
            this.entitys = clone;
            this._needClearNulls = false;
         }
         var p:Point = KuPaoMgr.instance.focusPoint;
         var heroX:int = Model_KuPao.heroX - 180;
         var just:int = Math.max(7 * Model_KuPao.speedMul,heroX + this._view.x);
         p.x += just;
         this.updateCamera();
      }
      
      public function updateCamera() : void
      {
         var index:int = 0;
         var bl:KuPaoBlock = null;
         var k:String = null;
         if(!Model_KuPao.gameing)
         {
            return;
         }
         var p:Point = this.camera.getViewPoint();
         this._view.x = p.x;
         this._view.y = 0;
         this.shapeShape.x = this._view.x;
         var col:int = Math.abs(this._view.x / Config.BLOCK_WID);
         var isChange:Boolean = false;
         var i:int = 0;
         while(i < 2)
         {
            index = col + i;
            if(!this.blockMap[index])
            {
               bl = KuPaoBlock.createIns();
               bl.viewIndex = index % KuPaoMgr.instance.configXMls.length;
               bl.col = index;
               bl.init();
               bl.onAdd();
               this.tileLayer.addChild(bl._view);
               this.blockMap[index] = bl;
               isChange = true;
            }
            i += 1;
         }
         if(isChange)
         {
            for(k in this.blockMap)
            {
               if(int(k) < col)
               {
                  bl = this.blockMap[k];
                  this.tileLayer.removeChild(bl._view);
                  bl.dispose();
                  delete this.blockMap[k];
               }
            }
         }
      }
      
      public function deleteScene() : void
      {
         var k:String = null;
         var bl:KuPaoBlock = null;
         for(k in this.blockMap)
         {
            bl = this.blockMap[k];
            this.tileLayer.removeChild(bl._view);
            bl.dispose();
            delete this.blockMap[k];
         }
      }
      
      public function addEntity(entity:Entity) : void
      {
         this.entitys.push(entity);
         entity.active();
      }
      
      public function removeEntity(entity:Entity) : void
      {
         var index:int = this.entitys.indexOf(entity);
         if(index != -1)
         {
            entity.unActive();
            this.entitys[index] = null;
            this._needClearNulls = true;
         }
      }
      
      public function getHitItems(rect:Rectangle) : Array
      {
         var entity:KuPaoEntity = null;
         var rest:Array = [];
         var len:int = int(this.entitys.length);
         var i:int = 0;
         while(i < len)
         {
            entity = this.entitys[i];
            if(entity != null && rect.intersects(entity.getQuad()))
            {
               rest.push(entity);
            }
            i++;
         }
         return rest;
      }
      
      public function clear() : void
      {
         var entity:Entity = null;
         var len:int = int(this.entitys.length);
         var i:int = 0;
         while(i < len)
         {
            entity = this.entitys[i];
            if(entity != null)
            {
               this.removeEntity(entity);
            }
            i += 1;
         }
         this.entitys.length = 0;
      }
   }
}

