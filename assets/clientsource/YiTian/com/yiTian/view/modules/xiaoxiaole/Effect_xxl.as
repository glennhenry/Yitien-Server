package com.yiTian.view.modules.xiaoxiaole
{
   import com.utils.ComponentUtil;
   import com.yiTian.data.config.Enum_xiaoxiaole;
   import com.yiTian.data.model.Model_xiaoxiaole;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Effect_xxl
   {
      
      private static var instance:Effect_xxl;
      
      private static var urlList:Array = ["SZ_Ling","SZ_Yi","SZ_Er","SZ_San","SZ_Si","SZ_Wu","SZ_Liu","SZ_Qi","SZ_Ba","SZ_Jiu"];
      
      private var model:Model_xiaoxiaole = Model_xiaoxiaole.getInstance();
      
      private var effList:Array;
      
      private var dic:Array = new Array();
      
      public function Effect_xxl()
      {
         super();
      }
      
      public static function getInstance() : Effect_xxl
      {
         return instance || (instance = new Effect_xxl());
      }
      
      public function addEff(type:int, _x:int, _y:int, calls:Function) : void
      {
         var callBack:Function;
         if(calls != null)
         {
            callBack = function():void
            {
               removeEff();
               calls();
            };
         }
      }
      
      public function removeEff() : void
      {
         var eff:Effect = null;
         if(!this.effList)
         {
            return;
         }
         while(Boolean(this.effList.length))
         {
            eff = this.effList.shift();
            eff.parent.removeChild(eff);
         }
      }
      
      public function moveTwoBoy(callBack:Function = null) : void
      {
         var grid:GeZi;
         var grid1:GeZi;
         var count:int = 0;
         var call:Function = null;
         call = function():void
         {
            ++count;
            if(count == 2)
            {
               model.isEffect = false;
               if(callBack != null)
               {
                  callBack();
               }
            }
         };
         this.model.isEffect = true;
         count = 0;
         grid = this.model.selectedNode[0].gird;
         grid1 = this.model.selectedNode[1].gird;
         if(grid.y != grid1.y)
         {
            Tween.to(grid,300,{"y":[grid.y,grid1.y]},call);
            Tween.to(grid1,300,{"y":[grid1.y,grid.y]},call);
         }
         else
         {
            Tween.to(grid,300,{"x":[grid.x,grid1.x]},call);
            Tween.to(grid1,300,{"x":[grid1.x,grid.x]},call);
         }
      }
      
      public function playEff(del:Array = null) : void
      {
         var index:int;
         var arr:Array = null;
         var eff:Effect = null;
         var effPool:Array = null;
         var flags:int = 0;
         var flag:int = 0;
         var node:XXLNode = null;
         var p:Point = null;
         var p1:Point = null;
         var delEnd:Function = function():void
         {
            var ef:Effect = null;
            while(Boolean(effPool.length))
            {
               ef = effPool.shift();
               EffectManager.removeEffect(ef);
            }
         };
         this.model.isEffect = true;
         index = 0;
         if(Boolean(del))
         {
            this.model.delList = del;
         }
         else
         {
            this.model.delList = this.model.checkXiaoCu();
         }
         effPool = [];
         flags = int(this.model.delList.length);
         while(index < this.model.delList.length)
         {
            arr = this.model.delList[index];
            node = View_xiaoxiaole.getInstance().getGridByNode(new XXLNode(arr[0],arr[1],0));
            eff = EffectManager.addEffect("35040",GameScene.upUILayer,800,11,11);
            p = View_xiaoxiaole.getInstance().localToGlobal(new Point(node.gird.x,node.gird.y));
            p1 = View_xiaoxiaole.getInstance().getJPTxtPoint();
            effPool.push(eff);
            Tween.to(eff,300,{
               "y":[p.y,p.y - Math.random() * 70],
               "x":[p.x,p.x - Math.random() * 70]
            },function(eff:Effect):void
            {
               Tween.to(eff,500,{
                  "y":[eff.y,p1.y - 4],
                  "x":[eff.x,p1.x - 20]
               },function():void
               {
                  --flags;
                  if(flags == 0)
                  {
                     delEnd();
                  }
               });
            },null);
            node.gird.playEffect("35288",node.gird.dispose);
            this.model.mapData[arr[0]][arr[1]] = null;
            View_xiaoxiaole.getInstance().delGird(node);
            index++;
         }
         flag = int(setTimeout(function():void
         {
            moveGrid();
            clearTimeout(flag);
         },400));
      }
      
      private function addGrid() : void
      {
         var j:int = 0;
         var node:XXLNode = null;
         var temp:Array = [];
         var i:int = this.model.mapData.length - 1;
         while(i >= 0)
         {
            temp = this.model.mapData[i];
            j = temp.length - 1;
            while(j >= 0)
            {
               node = View_xiaoxiaole.getInstance().getGridByNode(new XXLNode(i,j,0));
               if(Boolean(node) && node.gravity > 0)
               {
                  this.model.resetMapDataByGravity(node);
                  node.col += node.gravity;
                  node.gravity = 0;
               }
               j--;
            }
            i--;
         }
         temp = [];
         if(Boolean(this.model.newBlockMap) && Boolean(this.model.newBlockMap.length))
         {
            while(Boolean(this.model.newBlockMap.length))
            {
               temp = this.model.newBlockMap.shift();
               this.model.mapData[temp[0]][temp[1]] = temp[2];
               View_xiaoxiaole.getInstance().createNewGrid(temp[0],temp[1],temp[2]);
            }
         }
         this.model.selectedNode = new Vector.<XXLNode>();
         View_xiaoxiaole.getInstance().checkMap();
         this.model.isEffect = false;
      }
      
      private function moveGrid() : void
      {
         var flag:int;
         var time:int;
         var dic:Vector.<XXLNode>;
         var i:* = undefined;
         var f:int = 0;
         var grid:GeZi = null;
         this.model.setGravity();
         flag = 0;
         time = 100;
         dic = View_xiaoxiaole.getInstance().gridDic;
         for(i in dic)
         {
            if(dic[i].gravity > 0)
            {
               grid = dic[i].gird;
               Tween.to(grid,time,{"y":[grid.y,grid.y + grid.node.gravity * Enum_xiaoxiaole.GRID_H]},function call(grid:GeZi):void
               {
               });
            }
         }
         f = int(setTimeout(function():void
         {
            addGrid();
            clearTimeout(f);
         },200));
      }
      
      public function getNumBmByMaths(value:uint, con:Sprite, index:int) : void
      {
         var add:int = 0;
         var flag:int = 0;
         var play:Function = null;
         var resultFun:Function = function(values:int):void
         {
            var b:Bitmap = null;
            var ss:String = null;
            var s:String = null;
            reset();
            var valueStr:String = values.toString();
            var len:uint = uint(valueStr.length);
            var i:uint = 0;
            while(i < len)
            {
               b = Pool.getObject(Bitmap);
               dic[index][1].push(b);
               con.addChild(b);
               ss = valueStr.charAt(i);
               s = "resource/image/equipTips/" + urlList[int(ss)] + ".png";
               Utils.getLoadBitmap(s,b);
               i++;
            }
            resize();
         };
         var resize:Function = function():void
         {
            var bbb:Bitmap = null;
            var j:uint = 0;
            while(j < dic[index][1].length)
            {
               bbb = dic[index][1][j];
               ComponentUtil.setPropertie(bbb,{"x":11 * j});
               j++;
            }
         };
         var reset:Function = function():void
         {
            var bb:Bitmap = null;
            for each(bb in dic[index][1])
            {
               if(Boolean(bb) && Boolean(bb.parent))
               {
                  bb.parent.removeChild(bb);
                  bb.bitmapData = null;
                  Pool.saveObject(bb);
               }
            }
            dic[index][1] = [];
         };
         if(!this.dic[index])
         {
            this.dic[index] = [0,[],0,1,1];
         }
         this.dic[index][2] = 0;
         if(this.dic[index][4] == 1)
         {
            resultFun(value);
            this.dic[index][0] = value;
            this.dic[index][4] = 0;
            return;
         }
         if(this.dic[index][0] < value)
         {
            play = function():void
            {
               if(flag != 0)
               {
                  clearTimeout(flag);
                  flag = 0;
               }
               if(dic[index][2] == 0)
               {
                  return;
               }
               if(dic[index][0] >= value)
               {
                  resultFun(value);
                  dic[index][0] = value;
               }
               else
               {
                  dic[index][0] += add;
                  if(dic[index][0] >= value)
                  {
                     resultFun(value);
                     dic[index][0] = value;
                     return;
                  }
                  resultFun(dic[index][0]);
                  flag = setTimeout(play,100);
               }
            };
            add = (value - this.dic[index][0]) / 5;
            this.dic[index][2] = 1;
            if(add <= 0)
            {
               resultFun(value);
               this.dic[index][0] = value;
               return;
            }
            flag = int(setTimeout(play,100));
         }
         else
         {
            setTimeout(function():void
            {
               resultFun(value);
               dic[index][0] = value;
            },200);
         }
      }
   }
}

