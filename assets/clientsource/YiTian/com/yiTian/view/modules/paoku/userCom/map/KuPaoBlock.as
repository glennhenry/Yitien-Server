package com.yiTian.view.modules.paoku.userCom.map
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.modules.kupao.KPMap;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.KuPaoMgr;
   import com.yiTian.view.modules.paoku.userCom.role.EntityFactory;
   import com.yiTian.view.modules.paoku.userCom.util.Config;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class KuPaoBlock
   {
      
      public var row:int;
      
      public var col:int;
      
      public var viewIndex:int;
      
      public var isFillEmpty:Boolean = false;
      
      public var _view:Bitmap;
      
      private var _bmd:BitmapData;
      
      public function KuPaoBlock()
      {
         super();
         this._view = new Bitmap();
      }
      
      public static function createIns() : KuPaoBlock
      {
         return new KuPaoBlock();
      }
      
      public function init() : void
      {
         if(this._bmd == null)
         {
            this._bmd = new BitmapData(Config.BLOCK_WID,Config.BLOCK_HEI,true,5614335);
         }
      }
      
      public function onAdd() : void
      {
         var xml:XML = null;
         var tileInfoList:XMLList = null;
         var len:int = 0;
         var rect:Rectangle = null;
         var p:Point = null;
         var tiles:Array = null;
         var viewInfoList:XMLList = null;
         var i:int = 0;
         var emptyRow:int = 0;
         var objectGroups:XMLList = null;
         var cols:Array = null;
         var j:int = 0;
         var index:int = 0;
         var blockInfo:XML = null;
         var blockType:int = 0;
         var viewInfo:XML = null;
         var viewType:String = null;
         var viewTypeInt:int = 0;
         var blockBmd:BitmapData = null;
         var group:XML = null;
         var obj:XML = null;
         var entity:KuPaoEntity = null;
         this._view.x = this.col * Config.BLOCK_WID;
         this._bmd.lock();
         xml = KuPaoMgr.instance.configXMls[this.viewIndex];
         tileInfoList = xml.layer.(@name == "block")[0].data[0].tile;
         len = tileInfoList.length();
         rect = new Rectangle(0,0,40,40);
         p = new Point();
         tiles = [];
         viewInfoList = xml.layer.(@name == "view")[0].data[0].tile;
         i = 0;
         while(i < 12)
         {
            cols = [];
            j = 0;
            while(j < 25)
            {
               index = i * 25 + j;
               blockInfo = tileInfoList[index];
               blockType = int(blockInfo.@gid);
               viewInfo = viewInfoList[index];
               viewType = viewInfo.@gid;
               viewTypeInt = int(viewType);
               if(viewTypeInt > 1)
               {
                  try
                  {
                     blockBmd = ComponentUtil.getBitmapData(viewType,Global.KuPaoStyle1dm);
                     p.x = j * 40;
                     p.y = i * 40;
                     this._bmd.copyPixels(blockBmd,rect,p);
                  }
                  catch(e:Error)
                  {
                     viewTypeInt = 0;
                  }
               }
               cols.push(blockType == 1 ? 1 : 0);
               j += 1;
            }
            tiles.unshift(cols);
            i += 1;
         }
         emptyRow = 1;
         if(this.isFillEmpty)
         {
            i = 0;
            while(i < 25)
            {
               if(tiles[emptyRow][i] != "1")
               {
                  tiles[emptyRow][i] = 1;
                  try
                  {
                     p.x = i * 40;
                     p.y = KuPaoUtil.convertViewY(emptyRow * 40) - 40;
                     blockBmd = ComponentUtil.getBitmapData("21",Global.MMKPdm);
                     this._bmd.copyPixels(blockBmd,rect,p,null,null,true);
                  }
                  catch(e:Error)
                  {
                     trace(e.getStackTrace());
                  }
               }
               i++;
            }
         }
         KuPaoMgr.instance.blockInfoDict[this.col] = tiles;
         this._bmd.unlock();
         this._view.bitmapData = this._bmd;
         objectGroups = xml.objectgroup;
         if(Boolean(objectGroups.length()))
         {
            for each(group in objectGroups)
            {
               for each(obj in group.object)
               {
                  entity = EntityFactory.buildInstance(obj,this);
                  if(entity != null)
                  {
                     KPMap.instance.addEntity(entity);
                  }
               }
            }
         }
      }
      
      public function dispose() : void
      {
         KuPaoMgr.instance.blockInfoDict[this.col] = null;
         var _temp_1:* = this;
         this.col = 0;
         _temp_1.row = 0;
         this._view.bitmapData = null;
         if(Boolean(this._bmd))
         {
            this._bmd.dispose();
         }
         this._bmd = null;
      }
   }
}

