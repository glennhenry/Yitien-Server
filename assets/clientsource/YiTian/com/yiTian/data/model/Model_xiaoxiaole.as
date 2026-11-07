package com.yiTian.data.model
{
   import com.yiTian.data.config.Enum_xiaoxiaole;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.xiaoxiaole.View_xiaoxiaole;
   import com.yiTian.view.modules.xiaoxiaole.XXLNode;
   import com.yiTian.view.modules.xiaoxiaole.XXLUtil;
   import flash.utils.ByteArray;
   
   public class Model_xiaoxiaole
   {
      
      public static var gameStep:int;
      
      public static var isSelected:Boolean;
      
      private static var instance:Model_xiaoxiaole;
      
      private var _mapData:Array;
      
      public var remaindStep:int = 1;
      
      public var jp:int;
      
      public var selectedNode:Vector.<XXLNode> = new Vector.<XXLNode>();
      
      public var isEffect:Boolean;
      
      public var canOpen:Boolean;
      
      public var delList:Array = [];
      
      public var toolCounts:Array = [];
      
      public var newBlockMap:Array = [];
      
      public var ppPoint:String;
      
      public var gravity:String;
      
      private var delLists:Array;
      
      public function Model_xiaoxiaole()
      {
         super();
      }
      
      public static function getInstance() : Model_xiaoxiaole
      {
         if(!instance)
         {
            instance = new Model_xiaoxiaole();
         }
         return instance;
      }
      
      public function get mapData() : Array
      {
         return this._mapData;
      }
      
      public function set mapData(value:Array) : void
      {
         this._mapData = value;
      }
      
      public function addNode(node:XXLNode) : void
      {
         var add:Function = function():void
         {
            var node1:XXLNode = selectedNode[0];
            if(node1.col == node.col && node1.row == node.row)
            {
               return;
            }
            if(node1.col == node.col && (node1.row == node.row + 1 || node1.row == node.row - 1) || node1.row == node.row && (node1.col == node.col + 1 || node1.col == node.col - 1))
            {
               selectedNode.push(node);
               View_xiaoxiaole.getInstance().checkWithS();
            }
            else
            {
               selectedNode = new Vector.<XXLNode>();
            }
         };
         if(this.isEffect)
         {
            return;
         }
         switch(this.selectedNode.length)
         {
            case 0:
               this.selectedNode.push(node);
               break;
            case 1:
               add();
               break;
            case 2:
               this.selectedNode = new Vector.<XXLNode>();
               this.selectedNode.push(node);
         }
      }
      
      public function checkXiaoCu() : Array
      {
         var rTemp:Array;
         var temp:Array;
         var i:int;
         var node:XXLNode = null;
         var node1:XXLNode = null;
         var j:int = 0;
         var clone:Function = function(value:Object):Object
         {
            var bytes:ByteArray = new ByteArray();
            bytes.writeObject(value);
            bytes.position = 0;
            return bytes.readObject();
         };
         var tempMaps:Array = clone(this.mapData) as Array;
         var k:int = 0;
         if(this.selectedNode.length == 2)
         {
            node = this.selectedNode[0];
            node1 = this.selectedNode[1];
            this.mapData[node.col][node.row] = node1.value;
            this.mapData[node1.col][node1.row] = node.value;
         }
         rTemp = [];
         temp = [];
         i = this.mapData.length - 1;
         while(i >= 0)
         {
            temp = this.mapData[i];
            j = temp.length - 1;
            for(; j >= 0; j--)
            {
               if(temp[j] == null)
               {
                  continue;
               }
               switch(j)
               {
                  case 0:
                     if(!(temp[j] == temp[j + 1] && temp[j] == temp[j + 2]))
                     {
                        break;
                     }
                     rTemp.push([i,j]);
                     continue;
                  case temp.length - 1:
                     if(!(temp[j] == temp[j - 1] && temp[j] == temp[j - 2]))
                     {
                        break;
                     }
                     rTemp.push([i,j]);
                     continue;
                  case 1:
                     if(!(temp[j] == temp[j + 1] && temp[j] == temp[j + 2] || temp[j] == temp[j + 1] && temp[j] == temp[j - 1]))
                     {
                        break;
                     }
                     rTemp.push([i,j]);
                     continue;
                  case temp.length - 2:
                     if(!(temp[j] == temp[j - 1] && temp[j] == temp[j - 2] || temp[j] == temp[j + 1] && temp[j] == temp[j - 1]))
                     {
                        break;
                     }
                     rTemp.push([i,j]);
                     continue;
                  default:
                     if(!(temp[j] == temp[j - 1] && temp[j] == temp[j - 2] || temp[j] == temp[j + 1] && temp[j] == temp[j + 2] || temp[j] == temp[j - 1] && temp[j] == temp[j + 1]))
                     {
                        break;
                     }
                     rTemp.push([i,j]);
                     continue;
               }
               switch(i)
               {
                  case 1:
                     if(this.mapData[i][j] == this.mapData[i + 1][j] && this.mapData[i][j] == this.mapData[i + 2][j] || this.mapData[i][j] == this.mapData[i + 1][j] && this.mapData[i][j] == this.mapData[i - 1][j])
                     {
                        rTemp.push([i,j]);
                     }
                     break;
                  case this.mapData.length - 2:
                     if(this.mapData[i][j] == this.mapData[i - 1][j] && this.mapData[i][j] == this.mapData[i - 2][j] || this.mapData[i][j] == this.mapData[i + 1][j] && this.mapData[i][j] == this.mapData[i - 1][j])
                     {
                        rTemp.push([i,j]);
                     }
                     break;
                  case 0:
                     if(this.mapData[i][j] == this.mapData[i + 1][j] && this.mapData[i][j] == this.mapData[i + 2][j])
                     {
                        rTemp.push([i,j]);
                     }
                     break;
                  case this.mapData.length - 1:
                     if(this.mapData[i - 1][j] == this.mapData[i][j] && this.mapData[i][j] == this.mapData[i - 2][j])
                     {
                        rTemp.push([i,j]);
                     }
                     break;
                  default:
                     if(this.mapData[i][j] == this.mapData[i - 1][j] && this.mapData[i][j] == this.mapData[i - 2][j] || this.mapData[i][j] == this.mapData[i + 1][j] && this.mapData[i][j] == this.mapData[i + 2][j] || this.mapData[i][j] == this.mapData[i + 1][j] && this.mapData[i][j] == this.mapData[i - 1][j])
                     {
                        rTemp.push([i,j]);
                     }
               }
            }
            i--;
         }
         this.mapData = tempMaps;
         return rTemp;
      }
      
      public function changeMap() : void
      {
         var node:XXLNode = null;
         var node1:XXLNode = null;
         if(this.selectedNode.length == 2)
         {
            node = this.selectedNode[0];
            node1 = this.selectedNode[1];
            this.mapData[node.col][node.row] = node1.value;
            this.mapData[node1.col][node1.row] = node.value;
            View_xiaoxiaole.getInstance().alginValue();
         }
      }
      
      public function checkList(flag:int, temp:Array, col:int, row:int) : Boolean
      {
         if(col < 2)
         {
            if(row < 2)
            {
               return true;
            }
            if(temp[col][row - 1] == temp[col][row - 2] && temp[col][row - 2] == flag)
            {
               return false;
            }
         }
         else
         {
            if(temp[col][row - 1] == temp[col][row - 2] && temp[col][row - 2] == flag)
            {
               return false;
            }
            if(temp[col - 1][row] == temp[col - 2][row] && temp[col - 2][row] == flag)
            {
               return false;
            }
         }
         return true;
      }
      
      public function ramdomMap() : Array
      {
         var random:int = 0;
         var k:int = 0;
         var ramList:Array = [];
         var i:int = 0;
         while(i < Enum_xiaoxiaole.COL)
         {
            ramList.push(new Array());
            k = 0;
            while(k < Enum_xiaoxiaole.ROW)
            {
               random = Math.random() * 5;
               while(!this.checkList(random,ramList,i,k))
               {
                  random = Math.random() * 5;
               }
               (ramList[i] as Array).push(random);
               k++;
            }
            i++;
         }
         return ramList;
      }
      
      public function setGravity() : void
      {
         var temp:XXLNode = null;
         if(!this.gravity.length)
         {
            trace("没有地图重力");
            return;
         }
         var u:String = this.gravity.slice(0,this.gravity.length - 1);
         var gravityArr:Array = XXLUtil.getNewBlock(u);
         var i:int = 0;
         while(i < gravityArr.length)
         {
            temp = View_xiaoxiaole.getInstance().getGridByNode(new XXLNode(gravityArr[i][0],gravityArr[i][1],0));
            if(Boolean(temp))
            {
               temp.gravity += gravityArr[i][2];
            }
            else
            {
               trace(gravityArr[i][0],gravityArr[i][1],"已删除");
            }
            i++;
         }
         this.gravity = "";
      }
      
      public function resetMapDataByGravity(node:XXLNode) : void
      {
         var temp:int = int(this.mapData[node.col][node.row]);
         this.mapData[node.col + node.gravity][node.row] = temp;
      }
      
      public function testMap(s:String = "发协议") : void
      {
         Utils.print(s);
         var i:int = 0;
         while(i < this.mapData.length)
         {
            Utils.print(this.mapData[i]);
            i++;
         }
         Utils.print("地图开始完毕");
      }
      
      public function tool_clear(color:int) : Array
      {
         var j:int = 0;
         this.delLists = [];
         var i:int = 0;
         while(i < this.mapData.length)
         {
            j = 0;
            while(j < this.mapData[i].length)
            {
               if(this.mapData[i][j] == color)
               {
                  this.delLists.push([i,j]);
               }
               j++;
            }
            i++;
         }
         return this.delLists;
      }
      
      public function getDelListByPP(u:String) : Array
      {
         var j:int = 0;
         var col:int = int(u.split("_")[0]);
         var row:int = int(u.split("_")[1]);
         this.delLists = [];
         var i:int = col - 1;
         while(i < col + 2)
         {
            j = row - 1;
            while(j < row + 2)
            {
               this.delLists.push([i,j]);
               j++;
            }
            i++;
         }
         return this.delLists;
      }
      
      public function getColorChangeList(color:int, newcolor:int) : Array
      {
         var j:int = 0;
         this.delLists = [];
         var temp:Array = [];
         var i:int = 0;
         while(i < this.mapData.length)
         {
            temp = this.mapData[i];
            j = 0;
            while(j < temp.length)
            {
               if(temp[j] == color)
               {
                  temp[j] = newcolor;
                  this.delLists.push([i,j]);
               }
               j++;
            }
            i++;
         }
         return this.delLists;
      }
      
      public function isCanXiaochu() : Boolean
      {
         var col:int = 0;
         var row:int = 0;
         var j:int = 0;
         var tempMap:Array = this.mapData.concat();
         var colTemp:Array = [];
         var rowTemp:Array = [];
         var temp:Array = [];
         var i:int = this.mapData.length - 1;
         while(i >= 0)
         {
            temp = this.mapData[i];
            j = temp.length - 1;
            while(j >= 0)
            {
               if(temp[j] != null)
               {
                  if(j != temp.length - 1)
                  {
                     if(temp[j] == temp[j + 1])
                     {
                        colTemp.push([i,j]);
                     }
                  }
                  if(i != this.mapData.length - 1)
                  {
                     if(this.mapData[i][j] == this.mapData[i + 1][j])
                     {
                        rowTemp.push([i,j]);
                     }
                  }
               }
               j--;
            }
            i--;
         }
         if(!colTemp.length && !rowTemp.length)
         {
            return false;
         }
         i = colTemp.length - 1;
         while(i >= 0)
         {
            col = int(colTemp[i][0]);
            row = int(colTemp[i][1]);
            switch(row)
            {
               case Enum_xiaoxiaole.ROW - 2:
                  if(this.mapData[col][row - 2] == this.mapData[col][row])
                  {
                     return true;
                  }
                  if(col > 0 && this.mapData[col][row] == this.mapData[col - 1][row - 1])
                  {
                     return true;
                  }
                  if(col < Enum_xiaoxiaole.COL - 1 && this.mapData[col][row] == this.mapData[col + 1][row - 1])
                  {
                     return true;
                  }
                  break;
               case 1:
                  if(col > 0 && this.mapData[col][row] == this.mapData[col - 1][row - 1])
                  {
                     return true;
                  }
                  if(col < Enum_xiaoxiaole.COL - 1 && this.mapData[col][row] == this.mapData[col + 1][row - 1])
                  {
                     return true;
                  }
               case 0:
                  if(this.mapData[col][row + 3] == this.mapData[col][row])
                  {
                     return true;
                  }
                  if(col > 0 && this.mapData[col][row] == this.mapData[col - 1][row + 2])
                  {
                     return true;
                  }
                  if(col < Enum_xiaoxiaole.COL - 1 && this.mapData[col][row] == this.mapData[col + 1][row + 2])
                  {
                     return true;
                  }
                  break;
               default:
                  if(this.mapData[col][row + 3] == this.mapData[col][row] || this.mapData[col][row - 2] == this.mapData[col][row])
                  {
                     return true;
                  }
                  if(col > 0 && (this.mapData[col][row] == this.mapData[col - 1][row - 1] || this.mapData[col][row] == this.mapData[col - 1][row + 2]))
                  {
                     return true;
                  }
                  if(col < Enum_xiaoxiaole.COL - 1 && (this.mapData[col][row] == this.mapData[col + 1][row - 1] || this.mapData[col][row] == this.mapData[col + 1][row + 2]))
                  {
                     return true;
                  }
            }
            i--;
         }
         i = rowTemp.length - 1;
         while(i >= 0)
         {
            col = int(rowTemp[i][0]);
            row = int(rowTemp[i][1]);
            switch(col)
            {
               case Enum_xiaoxiaole.COL - 2:
                  if(this.mapData[col - 2][row] == this.mapData[col][row])
                  {
                     return true;
                  }
                  if(row > 0 && this.mapData[col - 1][row - 1] == this.mapData[col][row])
                  {
                     return true;
                  }
                  if(row < Enum_xiaoxiaole.ROW - 2 && this.mapData[col - 1][row + 1] == this.mapData[col][row])
                  {
                     return true;
                  }
                  break;
               case 1:
                  if(row > 0 && this.mapData[col - 1][row - 1] == this.mapData[col][row])
                  {
                     return true;
                  }
                  if(row < Enum_xiaoxiaole.ROW - 2 && this.mapData[col - 1][row + 1] == this.mapData[col][row])
                  {
                     return true;
                  }
               case 0:
                  if(this.mapData[col + 3][row] == this.mapData[col][row])
                  {
                     return true;
                  }
                  if(row > 0 && this.mapData[col + 2][row - 1] == this.mapData[col][row])
                  {
                     return true;
                  }
                  if(row < Enum_xiaoxiaole.ROW - 2 && this.mapData[col + 2][row + 1] == this.mapData[col][row])
                  {
                     return true;
                  }
                  break;
               default:
                  if(col + 3 < this.mapData.length && this.mapData[col + 3][row] == this.mapData[col][row])
                  {
                     return true;
                  }
                  if(col - 2 >= 0 && this.mapData[col - 2][row] == this.mapData[col][row])
                  {
                     return true;
                  }
                  if(row > 0 && (this.mapData[col + 2][row - 1] == this.mapData[col][row] || this.mapData[col - 1][row - 1] == this.mapData[col][row]))
                  {
                     return true;
                  }
                  if(row < Enum_xiaoxiaole.ROW - 2 && (this.mapData[col + 2][row + 1] == this.mapData[col][row] || this.mapData[col - 1][row + 1] == this.mapData[col][row]))
                  {
                     return true;
                  }
            }
            i--;
         }
         return false;
      }
   }
}

