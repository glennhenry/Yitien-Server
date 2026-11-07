package com.yiTian.view.modules.KFHomeland
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.AStar;
   import com.yiTian.utils.Utils;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class BuildAction
   {
      
      public static var moveBuild:CreatedBuildings;
      
      private static var _instance:BuildAction;
      
      public static var offsetX:Number;
      
      public static var offsetY:Number;
      
      private static var isBuilding:Boolean = false;
      
      private static const WINDOWBUFFID:int = 4;
      
      private var startX:Number;
      
      private var startY:Number;
      
      private var buffId:int;
      
      private var _layInfoArr:Array;
      
      private var _layBuildsVec:Vector.<CreatedBuildings>;
      
      private var checkBuffBuildArr:Array;
      
      private var checkMapBuildinsArr:Array;
      
      private var layCol:int;
      
      private var layRow:int;
      
      private var isMyBuffArea:Boolean = false;
      
      private var checkGridResult:Boolean = true;
      
      private var nearBuildingsArr:Array;
      
      private var halfGridDis:Number;
      
      public function BuildAction()
      {
         super();
      }
      
      public static function get instance() : BuildAction
      {
         if(!_instance)
         {
            _instance = new BuildAction();
         }
         return _instance;
      }
      
      public function layoutBudilings() : void
      {
         var i:int = 0;
         var oneInfoArr:Array = null;
         var layBuilding:CreatedBuildings = null;
         if(VoHome.isOut == 1)
         {
            if(VoHome.isMyHome == 1)
            {
               VoHome.outBuildVec = new Vector.<CreatedBuildings>();
            }
            this._layInfoArr = VoHome.outHomeBuildInfoArr;
         }
         else if(VoHome.isOut == 2)
         {
            if(VoHome.isMyHome == 1)
            {
               VoHome.innerBuildVec = new Vector.<CreatedBuildings>();
            }
            this._layInfoArr = VoHome.innerHomeBuildInfoArr;
         }
         if(!this._layInfoArr || this._layInfoArr.length <= 0)
         {
            return;
         }
         i = 0;
         while(i < this._layInfoArr.length)
         {
            oneInfoArr = this._layInfoArr[i];
            layBuilding = GameUnitManager.getUnit(UnitType.HOMEBUILDS) as CreatedBuildings;
            layBuilding.reset();
            layBuilding.id = Number(oneInfoArr[0]);
            layBuilding.xGrid = oneInfoArr[1];
            layBuilding.yGrid = oneInfoArr[2];
            layBuilding.orient = oneInfoArr[3];
            layBuilding.updateBInfo();
            layBuilding.global_x = oneInfoArr[1] * AStar.size + AStar.size / 2;
            layBuilding.global_y = oneInfoArr[2] * AStar.size + AStar.size / 2;
            GameUnitManager.addUnit(layBuilding);
            if(VoHome.isOut == 1 && VoHome.isMyHome == 1)
            {
               VoHome.outBuildVec.push(layBuilding);
            }
            else if(VoHome.isOut == 2 && VoHome.isMyHome == 1)
            {
               VoHome.innerBuildVec.push(layBuilding);
            }
            i++;
         }
      }
      
      private function sortBuildY(xB:CreatedBuildings, yB:CreatedBuildings) : Number
      {
         var lastYSort:Number = this.sortYCoord(xB.y,yB.y);
         if(lastYSort != 0)
         {
            return lastYSort;
         }
         return this.sortYCoord(xB.y,yB.y);
      }
      
      private function sortYCoord(xC:Number, yC:Number) : Number
      {
         if(xC < yC)
         {
            return -1;
         }
         if(xC > yC)
         {
            return 1;
         }
         return 0;
      }
      
      private function delIlledBuild() : void
      {
         var i:int = 0;
         var j:int = 0;
         var oneInfoArr:Array = null;
         if(!this._layBuildsVec || this._layBuildsVec.length <= 0)
         {
            return;
         }
         if(!this._layInfoArr || this._layInfoArr.length <= 0)
         {
            i = 0;
            while(i < this._layBuildsVec.length)
            {
               GameUnitManager.removeUnit(this._layBuildsVec[i]);
               i++;
            }
            return;
         }
         var noDelBuildVec:Vector.<int> = new Vector.<int>();
         i = 0;
         while(i < this._layInfoArr.length)
         {
            oneInfoArr = this._layInfoArr[i];
            j = 0;
            while(j < this._layBuildsVec.length)
            {
               if(oneInfoArr[0] == this._layBuildsVec[j].id && oneInfoArr[1] == this._layBuildsVec[j].xGrid && oneInfoArr[2] == this._layBuildsVec[j].yGrid && oneInfoArr[3] == this._layBuildsVec[j].orient)
               {
                  noDelBuildVec.push(j);
                  this._layInfoArr.splice(i,1);
                  i--;
               }
               j++;
            }
            i++;
         }
         i = 0;
         while(i < this._layBuildsVec.length)
         {
            if(Boolean(noDelBuildVec) && noDelBuildVec.indexOf(i) == -1)
            {
               GameUnitManager.removeUnit(this._layBuildsVec[i]);
            }
            i++;
         }
      }
      
      public function setUnwalkBuff(sX:int, sY:int, wB:int, hB:int, walk:Boolean = true) : void
      {
         var n:int = 0;
         this.checkBuffBuildArr = [];
         var m:int = (sX - wB / 2) / AStar.size - 1;
         while(m <= (sX + wB / 2) / AStar.size + 1)
         {
            n = (sY - hB / 2) / AStar.size - 1;
            while(n >= (sY - hB / 2) / AStar.size + 1)
            {
               this.checkBuffBuildArr.push([m,n]);
               n--;
            }
            m++;
         }
         AStar.setBlock(this.checkBuffBuildArr,walk);
      }
      
      public function building(stageX:Number, stageY:Number) : void
      {
         if(isBuilding)
         {
            return;
         }
         this.startX = stageX;
         this.startY = stageY;
         if(!Global.stage.hasEventListener(MouseEvent.MOUSE_MOVE))
         {
            Global.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMove);
         }
         Global.stage.addEventListener(MouseEvent.MOUSE_UP,this.upHandle);
         EnterHomeControl.instance.buildHome();
      }
      
      public function upHandle(evt:MouseEvent = null) : void
      {
         this.endBuilding();
         if(Global.stage.hasEventListener(MouseEvent.MOUSE_UP))
         {
            Global.stage.removeEventListener(MouseEvent.MOUSE_UP,this.upHandle);
         }
      }
      
      private function onMove(evt:MouseEvent) : void
      {
         if(Utils.dist(this.startX,this.startY,evt.stageX,evt.stageY) < 5)
         {
            return;
         }
         var curX:Number = this.startX;
         var curY:Number = this.startY;
         isBuilding = true;
         if(!Global.stage.contains(moveBuild))
         {
            Global.stage.addChild(moveBuild);
         }
         moveBuild.x = evt.stageX;
         moveBuild.y = evt.stageY;
         this.checkLayBuildingsArea();
      }
      
      private function checkLayAreaBuff() : void
      {
         var sPoint:Point = new Point(moveBuild.x,moveBuild.y);
         var mPoint:Point = GameScene.mainLayer.globalToLocal(sPoint);
         this.buffId = AStar.getBuff(mPoint.x,mPoint.y);
         if(this.buffId == -1)
         {
            moveBuild.noSit();
         }
         else
         {
            moveBuild.canSit();
         }
      }
      
      private function checkLayBuildingsArea() : void
      {
         var i:int = 0;
         var layBuInfo:Array = null;
         var compareLayedBuildsGrid:Array = null;
         this.checkGridResult = true;
         this.contMyStartGrid();
         var myLayGrid:Array = this.needMyLayGrid();
         this.verifyMyBuff(myLayGrid);
         if(!this.isMyBuffArea)
         {
            moveBuild.noSit();
            return;
         }
         if(VoHome.isOut == 1)
         {
            this.checkMapBuildinsArr = VoHome.outHomeBuildInfoArr;
         }
         else if(VoHome.isOut == 2)
         {
            this.checkMapBuildinsArr = VoHome.innerHomeBuildInfoArr;
         }
         if(Boolean(this.checkMapBuildinsArr) && this.checkMapBuildinsArr.length > 0)
         {
            if(this.layCol > AStar._grid.numCols - 1 || this.layRow > AStar._grid.numRows - 1)
            {
               moveBuild.noSit();
            }
            else
            {
               i = 0;
               while(i < this.checkMapBuildinsArr.length)
               {
                  layBuInfo = this.checkMapBuildinsArr[i] as Array;
                  compareLayedBuildsGrid = this.getMapBuildSNeedGrid(layBuInfo[0],layBuInfo[1],layBuInfo[2]);
                  this.checkGridResult = this.compareGrid(myLayGrid,compareLayedBuildsGrid);
                  if(!this.checkGridResult)
                  {
                     moveBuild.noSit();
                     break;
                  }
                  moveBuild.canSit();
                  i++;
               }
            }
         }
         else
         {
            moveBuild.canSit();
         }
      }
      
      private function contMyStartGrid() : void
      {
         var sP:Point = new Point(moveBuild.x,moveBuild.y);
         var mP:Point = GameScene.mainLayer.globalToLocal(sP);
         this.layCol = mP.x / AStar.size;
         this.layRow = mP.y / AStar.size;
      }
      
      private function verifyMyBuff(myNeedGrid:Array) : void
      {
         var myOneGrid:Array = null;
         var tempBuffId:int = 0;
         if(!myNeedGrid || myNeedGrid.length <= 0)
         {
            return;
         }
         this.isMyBuffArea = true;
         var i:int = 0;
         while(i < myNeedGrid.length)
         {
            myOneGrid = myNeedGrid[i];
            tempBuffId = AStar.getBuffIdforGrid(myOneGrid[0],myOneGrid[1]);
            if(tempBuffId == -1 || tempBuffId == 0)
            {
               this.isMyBuffArea = false;
               break;
            }
            if(tempBuffId != moveBuild.buffId)
            {
               this.isMyBuffArea = false;
               break;
            }
            i++;
         }
      }
      
      private function needMyLayGrid() : Array
      {
         var needGrid:int = moveBuild.needOccupyGridNum;
         return this.calNeedGrid(this.layCol,this.layRow,needGrid);
      }
      
      private function getMapBuildSNeedGrid(bId:int, xGrid:int, yGrid:int) : Array
      {
         var arr:Array = null;
         var needGrid:int = int(Data_lib.kfjyjzflb[bId][Enum_SortBuildins.GRID_NEED]);
         return this.calNeedGrid(xGrid,yGrid,needGrid);
      }
      
      private function calNeedGrid(xGrid:int, yGrid:int, needGrid:int) : Array
      {
         var i:int = 0;
         var j:int = 0;
         var coordTemp:int = 0;
         if(needGrid == 0)
         {
            return null;
         }
         var arr:Array = [];
         var limit:int = int(needGrid / 2);
         i = xGrid - limit;
         while(i <= xGrid + limit)
         {
            coordTemp = Math.abs(limit - Math.abs(xGrid - i));
            j = yGrid - coordTemp;
            while(j <= yGrid + coordTemp)
            {
               if(j <= yGrid + 5)
               {
                  arr.push([i,j]);
               }
               j++;
            }
            i++;
         }
         return arr;
      }
      
      private function compareGrid(myNeedGrid:Array, otherNeedGrid:Array) : Boolean
      {
         var myOneGrid:Array = null;
         var j:int = 0;
         var otherOneGrid:Array = null;
         var result:Boolean = true;
         if(!myNeedGrid)
         {
            return result;
         }
         var i:int = 0;
         while(i < myNeedGrid.length)
         {
            myOneGrid = myNeedGrid[i];
            j = 0;
            while(j < otherNeedGrid.length)
            {
               otherOneGrid = otherNeedGrid[j];
               if(myOneGrid[0] == otherOneGrid[0] && myOneGrid[1] == otherOneGrid[1])
               {
                  result = false;
                  break;
               }
               j++;
            }
            i++;
         }
         return result;
      }
      
      public function calculateDeep(myB:CreatedBuildings, otherLayServerInfoArr:Array, boo:Boolean = true) : Boolean
      {
         var resultBoo:Boolean = false;
         var resultB:CreatedBuildings = this.getMapBuilding(otherLayServerInfoArr);
         if(!resultB)
         {
            return resultBoo;
         }
         this.halfGridDis = myB.needOccupyGridNum * AStar.size + AStar.size / 2;
         if(myB.hitTestObject(resultB))
         {
            if(myB.y > resultB.y - this.halfGridDis && resultB.y - this.halfGridDis > myB.y - myB.bWidth)
            {
               if(GameScene.mainLayer.getChildIndex(myB) > GameScene.mainLayer.getChildIndex(resultB) && boo)
               {
                  GameScene.mainLayer.swapChildren(myB,resultB);
                  resultBoo = true;
               }
               if(GameScene.mainLayer.getChildIndex(myB) < GameScene.mainLayer.getChildIndex(resultB) && !boo)
               {
                  GameScene.mainLayer.swapChildren(myB,resultB);
                  resultBoo = true;
               }
            }
            else if(resultB.y > myB.y - this.halfGridDis && myB.y - this.halfGridDis > resultB.y - resultB.bHeight)
            {
               if(GameScene.mainLayer.getChildIndex(myB) < GameScene.mainLayer.getChildIndex(resultB) && boo)
               {
                  GameScene.mainLayer.swapChildren(myB,resultB);
                  resultBoo = true;
               }
               if(GameScene.mainLayer.getChildIndex(myB) > GameScene.mainLayer.getChildIndex(resultB) && !boo)
               {
                  GameScene.mainLayer.swapChildren(myB,resultB);
                  resultBoo = true;
               }
            }
         }
         return resultBoo;
      }
      
      public function calculateDeep2(myB:CreatedBuildings, otherLayServerInfoArr:Array) : Boolean
      {
         var resultBoo:Boolean = false;
         var resultB:CreatedBuildings = this.getMapBuilding(otherLayServerInfoArr);
         if(!resultB)
         {
            return resultBoo;
         }
         this.halfGridDis = myB.needOccupyGridNum * AStar.size + AStar.size / 2;
         if(Math.abs(resultB.x - myB.x) < this.halfGridDis)
         {
            if(myB.y < resultB.y - this.halfGridDis && resultB.y - this.halfGridDis < myB.y - myB.bWidth)
            {
               GameScene.mainLayer.swapChildren(myB,resultB);
               resultBoo = true;
            }
         }
         return resultBoo;
      }
      
      public function getMapBuilding(arr:Array) : CreatedBuildings
      {
         var sourceVec:Vector.<CreatedBuildings> = null;
         var tempBuildings:CreatedBuildings = null;
         if(VoHome.isOut == 1)
         {
            sourceVec = VoHome.outBuildVec;
         }
         else if(VoHome.isOut == 2)
         {
            sourceVec = VoHome.innerBuildVec;
         }
         if(!sourceVec || sourceVec.length <= 0)
         {
            return null;
         }
         var i:int = 0;
         while(i < sourceVec.length)
         {
            tempBuildings = sourceVec[i];
            if(tempBuildings.id == arr[0] && tempBuildings.xGrid == arr[1] && tempBuildings.yGrid == arr[2])
            {
               return tempBuildings;
            }
            i++;
         }
         return null;
      }
      
      public function reSetDeep(b:CreatedBuildings, boo:Boolean = true) : void
      {
         var i:int = 0;
         var itemBInfoArr:Array = null;
         if(VoHome.isOut == 1)
         {
            this.checkMapBuildinsArr = VoHome.outHomeBuildInfoArr;
         }
         else if(VoHome.isOut == 2)
         {
            this.checkMapBuildinsArr = VoHome.innerHomeBuildInfoArr;
         }
         if(Boolean(this.checkMapBuildinsArr) && this.checkMapBuildinsArr.length > 0)
         {
            i = 0;
            while(i < this.checkMapBuildinsArr.length)
            {
               itemBInfoArr = this.checkMapBuildinsArr[i];
               this.calculateDeep(b,itemBInfoArr,boo);
               i++;
            }
         }
      }
      
      public function sureLayToHome() : void
      {
         var sureBuild:CreatedBuildings = null;
         if(Global.stage.contains(moveBuild))
         {
            Global.stage.removeChild(moveBuild);
         }
         Global.isBuildHome = false;
         EnterHomeControl.instance.hideEscTips();
         sureBuild = GameUnitManager.getUnit(UnitType.HOMEBUILDS) as CreatedBuildings;
         sureBuild.id = Number(moveBuild.id);
         sureBuild.xGrid = this.layCol;
         sureBuild.yGrid = this.layRow;
         sureBuild.orient = moveBuild.orient;
         sureBuild.updateBInfo();
         sureBuild.global_x = this.layCol * AStar.size + AStar.size / 2;
         sureBuild.global_y = this.layRow * AStar.size + AStar.size / 2;
         GameUnitManager.addUnit(sureBuild);
         this.reSetDeep(sureBuild);
         if(VoHome.isOut == 1)
         {
            if(!VoHome.outHomeBuildInfoArr)
            {
               VoHome.outHomeBuildInfoArr = [];
            }
            VoHome.outHomeBuildInfoArr.push([sureBuild.id,this.layCol,this.layRow,sureBuild.orient]);
            if(!VoHome.outBuildVec)
            {
               VoHome.outBuildVec = new Vector.<CreatedBuildings>();
            }
            VoHome.outBuildVec.push(sureBuild);
         }
         else if(VoHome.isOut == 2)
         {
            if(!VoHome.innerHomeBuildInfoArr)
            {
               VoHome.innerHomeBuildInfoArr = [];
            }
            VoHome.innerHomeBuildInfoArr.push([sureBuild.id,this.layCol,this.layRow,sureBuild.orient]);
            if(!VoHome.innerBuildVec)
            {
               VoHome.innerBuildVec = new Vector.<CreatedBuildings>();
            }
            VoHome.innerBuildVec.push(sureBuild);
         }
         if(Boolean(moveBuild.parent))
         {
            moveBuild.parent.removeChild(moveBuild);
         }
         moveBuild.realDispose();
      }
      
      public function endBuilding() : void
      {
         moveBuild.showBuildBtn(true);
         this.stopBuilding();
      }
      
      public function sureBuilding() : void
      {
         var canSit:int = 1;
         GameScene.instance.endSilding();
         if(!this.isMyBuffArea)
         {
            canSit = 0;
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30147",3));
         }
         if(!this.checkGridResult)
         {
            canSit = 0;
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30148",3));
         }
         HomeLandCGMessage.CG_SURE_BUILDING(moveBuild.id,this.layCol,this.layRow,moveBuild.orient,canSit);
         if(canSit == 0)
         {
            this.canelBuilding();
         }
      }
      
      public function canelBuilding() : void
      {
         moveBuild.visible = false;
         Global.isBuildHome = false;
         this.stopBuilding();
         EnterHomeControl.instance.hideEscTips();
         if(Global.stage.contains(moveBuild))
         {
            Global.stage.removeChild(moveBuild);
         }
         if(Boolean(moveBuild.parent))
         {
            moveBuild.parent.removeChild(moveBuild);
         }
         moveBuild.realDispose();
         EnterHomeControl.instance.exitBuildHome();
      }
      
      public function stopBuilding() : void
      {
         isBuilding = false;
         if(Global.stage.hasEventListener(MouseEvent.MOUSE_MOVE))
         {
            Global.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMove);
         }
      }
      
      public function reset() : void
      {
         if(Boolean(this._layBuildsVec))
         {
            this._layBuildsVec.length = 0;
         }
      }
   }
}

