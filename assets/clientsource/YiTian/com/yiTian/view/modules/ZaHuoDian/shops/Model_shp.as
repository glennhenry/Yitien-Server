package com.yiTian.view.modules.ZaHuoDian.shops
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class Model_shp
   {
      
      public static var shpTy:Boolean = true;
      
      public static var dataDic:Dictionary = new Dictionary();
      
      public function Model_shp()
      {
         super();
      }
      
      public static function changedBtn(leftBtn:Button, rightBtn:Button, txt:MyTextField, func:Function) : void
      {
         var arr:Array = null;
         arr = txt.text.split("/");
         if(Boolean(leftBtn) && Boolean(rightBtn))
         {
            leftBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
            {
               var __num:int = int(arr[0]);
               __num--;
               if(Boolean(func.length))
               {
                  func(__num);
               }
            });
            rightBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
            {
               var _num:int = int(arr[0]);
               _num++;
               if(Boolean(func.length))
               {
                  func(_num);
               }
            });
         }
      }
      
      public static function getData(_arr:Array, _curp:int, perPageLen:int) : Array
      {
         var item:Object = null;
         if(!_arr || !_arr.length)
         {
            return [];
         }
         var dataArr:Array = [];
         var dataLen:int = int(_arr.length);
         var left_L:int = dataLen % perPageLen == 0 ? 10 : int(dataLen % perPageLen);
         var maxP:int = int(dataLen / perPageLen) + int(left_L != 0);
         var startIndex:int = perPageLen * (_curp - 1);
         var xunHuanLen:int = _curp == maxP ? left_L : perPageLen;
         var i:int = startIndex;
         while(i < startIndex + xunHuanLen)
         {
            item = _arr[i];
            dataArr.push(item);
            i++;
         }
         return dataArr;
      }
   }
}

