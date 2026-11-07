package com.yiTian.view.modules.xiaoxiaole
{
   import com.yiTian.data.model.Model_xiaoxiaole;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class XXLUtil
   {
      
      public function XXLUtil()
      {
         super();
      }
      
      public static function getNewBlock(s:String) : Array
      {
         var b:String = null;
         if(!s)
         {
            return [];
         }
         var temp:Array = s.split(",");
         var temp1:Array = [];
         while(Boolean(temp.length))
         {
            b = temp.shift();
            temp1.push(b.split("_"));
         }
         return temp1;
      }
      
      public static function getStrByNode(node:XXLNode) : String
      {
         return node.col + "_" + node.row;
      }
      
      public static function getStrByList(arr:Array) : String
      {
         var checkIndex:Function;
         var checkIndexs:Function;
         var model:Model_xiaoxiaole = null;
         var compare:Function = null;
         var d:* = undefined;
         var compare1:Function = null;
         var c:* = undefined;
         var parentN:Array = null;
         var index:int = 0;
         var indexArr:Array = null;
         var i:int = 0;
         var arrs:Array = null;
         var bb:int = 0;
         var t:Array = null;
         var b:int = 0;
         compare = function(a:Array, b:Array):Number
         {
            if(a[1] < b[1])
            {
               return -1;
            }
            return 1;
         };
         var toStr:Function = function(A:Array):String
         {
            return A[0] + "_" + A[1];
         };
         compare1 = function(a:Array, b:Array):Number
         {
            if(a[0] < b[0])
            {
               return -1;
            }
            return 1;
         };
         var tempArr:Function = function():Array
         {
            var node:XXLNode = null;
            var node1:XXLNode = null;
            var temp:Array = model.mapData.concat();
            if(model.selectedNode.length == 2)
            {
               node = model.selectedNode[0];
               node1 = model.selectedNode[1];
               temp[node.col][node.row] = node1.value;
               temp[node1.col][node1.row] = node.value;
            }
            return temp;
         };
         var colArr:Object = new Object();
         var rowArr:Dictionary = new Dictionary();
         var temp:Array = [];
         var result:String = "";
         var tempA:Array = arr.concat();
         model = Model_xiaoxiaole.getInstance();
         while(Boolean(tempA.length))
         {
            parentN = tempA.shift();
            index = int(parentN[0]);
            indexArr = [];
            i = 0;
            while(i < tempA.length)
            {
               if(index == tempA[i][0])
               {
                  if(!(colArr[index] is Array))
                  {
                     colArr[index] = [];
                  }
                  if((colArr[index] as Array).indexOf(tempA[i][0]) == -1)
                  {
                     (colArr[index] as Array).push(tempA[i]);
                     indexArr.push(tempA[i]);
                  }
               }
               i++;
            }
            i = 0;
            while(i < indexArr.length)
            {
               tempA.splice(tempA.indexOf(indexArr[i]),1);
               i++;
            }
            if(Boolean(colArr[index] as Array) && Boolean((colArr[index] as Array).length))
            {
               (colArr[index] as Array).push(parentN);
            }
         }
         tempA = arr.concat();
         while(Boolean(tempA.length))
         {
            parentN = tempA.shift();
            index = int(parentN[1]);
            indexArr = [];
            i = 0;
            while(i < tempA.length)
            {
               if(index == tempA[i][1])
               {
                  if(!(rowArr[index] is Array))
                  {
                     rowArr[index] = [];
                  }
                  if((rowArr[index] as Array).indexOf(tempA[i][1]) == -1)
                  {
                     (rowArr[index] as Array).push(tempA[i]);
                     indexArr.push(tempA[i]);
                  }
               }
               i++;
            }
            i = 0;
            while(i < indexArr.length)
            {
               tempA.splice(tempA.indexOf(indexArr[i]),1);
               i++;
            }
            if(Boolean(rowArr[index] as Array) && Boolean((rowArr[index] as Array).length))
            {
               (rowArr[index] as Array).push(parentN);
            }
         }
         for(d in colArr)
         {
            arrs = colArr[d];
            if(arrs.length >= 3)
            {
               arrs.sort(compare);
               while(Boolean(arrs.length))
               {
                  checkIndex = function():int
                  {
                     if(bb >= arrs.length - 1)
                     {
                        return bb;
                     }
                     if(tempArr()[arrs[bb][0]][arrs[bb][1]] == tempArr()[arrs[bb + 1][0]][arrs[bb + 1][1]])
                     {
                        if(arrs[bb][1] + 1 == arrs[bb + 1][1])
                        {
                           ++bb;
                           return checkIndex();
                        }
                     }
                     return bb;
                  };
                  indexArr = [];
                  bb = 0;
                  t = arrs.splice(0,checkIndex() + 1);
                  if(t.length >= 3)
                  {
                     i = 0;
                     while(i < t.length)
                     {
                        result += toStr(t[i]);
                        if(i != t.length - 1)
                        {
                           result += ",";
                        }
                        i++;
                     }
                     bb = 0;
                     result += ";";
                  }
               }
            }
         }
         for(c in rowArr)
         {
            arrs = rowArr[c];
            arrs.sort(compare1);
            if(arrs.length >= 3)
            {
               while(Boolean(arrs.length))
               {
                  checkIndexs = function():int
                  {
                     if(b >= arrs.length - 1)
                     {
                        return b;
                     }
                     if(tempArr()[arrs[b][0]][arrs[b][1]] == tempArr()[arrs[b + 1][0]][arrs[b + 1][1]])
                     {
                        if(arrs[b][0] + 1 == arrs[b + 1][0])
                        {
                           ++b;
                           return checkIndexs();
                        }
                     }
                     return b;
                  };
                  indexArr = [];
                  b = 0;
                  t = arrs.splice(0,checkIndexs() + 1);
                  if(t.length >= 3)
                  {
                     i = 0;
                     while(i < t.length)
                     {
                        result += toStr(t[i]);
                        if(i != t.length - 1)
                        {
                           result += ",";
                        }
                        i++;
                     }
                     b = 0;
                     result += ";";
                  }
               }
            }
         }
         return result;
      }
      
      public static function getStrToSever() : String
      {
         var Max:int;
         var k:int;
         var model:Model_xiaoxiaole = null;
         var start:int = 0;
         var j:int = 0;
         var a:int = 0;
         var str:String = null;
         var b:int = 0;
         var tempArr:Function = function():Array
         {
            var node:XXLNode = null;
            var node1:XXLNode = null;
            var temp:Array = clone(model.mapData.concat()) as Array;
            if(model.selectedNode.length == 2)
            {
               node = model.selectedNode[0];
               node1 = model.selectedNode[1];
               temp[node.col][node.row] = node1.value;
               temp[node1.col][node1.row] = node.value;
            }
            return temp;
         };
         var clone:Function = function(value:Object):Object
         {
            var bytes:ByteArray = new ByteArray();
            bytes.writeObject(value);
            bytes.position = 0;
            return bytes.readObject();
         };
         model = Model_xiaoxiaole.getInstance();
         var arr:Array = tempArr();
         var result:String = "";
         var i:int = 0;
         while(i < arr.length)
         {
            j = 0;
            while(j < arr[i].length)
            {
               start = j;
               if(!(start + 1 >= arr[i].length - 1 || arr[i][start] != arr[i][start + 1]))
               {
                  while(arr[i][start] == arr[i][start + 1])
                  {
                     start++;
                     if(start >= arr[i].length - 1)
                     {
                        break;
                     }
                  }
                  if(start > j + 1)
                  {
                     a = j;
                     while(a <= start)
                     {
                        str = "";
                        if(a < start)
                        {
                           str += i + "_" + a + ",";
                        }
                        else
                        {
                           str += i + "_" + a + ";";
                        }
                        result += str;
                        a++;
                     }
                  }
                  j = start;
                  start = 0;
               }
               j++;
            }
            i++;
         }
         start = 0;
         Max = 6;
         k = 0;
         while(k < 12)
         {
            b = 0;
            while(b < 7)
            {
               start = b;
               if(!(start >= Max || arr[start][k] != arr[start + 1][k]))
               {
                  while(arr[start][k] == arr[start + 1][k])
                  {
                     start++;
                     if(start >= Max)
                     {
                        break;
                     }
                  }
                  if(start > b + 1)
                  {
                     a = b;
                     while(a <= start)
                     {
                        str = "";
                        if(a < start)
                        {
                           str += a + "_" + k + ",";
                        }
                        else
                        {
                           str += a + "_" + k + ";";
                        }
                        result += str;
                        a++;
                     }
                  }
                  b = start;
                  start = 0;
               }
               b++;
            }
            k++;
         }
         return result;
      }
      
      public static function getColor(i:int) : String
      {
         var arr:Array = ["无","黄","红","蓝","绿","朱","紫"];
         return arr[i];
      }
   }
}

