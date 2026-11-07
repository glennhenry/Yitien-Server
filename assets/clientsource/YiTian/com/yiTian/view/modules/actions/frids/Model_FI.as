package com.yiTian.view.modules.actions.frids
{
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Model_FI
   {
      
      public static var getStatus:Array = new Array();
      
      public static var nowGetItemArr:Array = [];
      
      public function Model_FI()
      {
         super();
      }
      
      public static function flayToBag(g:View_Grid, count:int, _index:int) : void
      {
         var num:int = 0;
         if(_index > count)
         {
            return;
         }
         num = int(setTimeout(function():void
         {
            ComboTweenStep.toBag(g);
            ++_index;
            flayToBag(g,count,_index);
            clearTimeout(num);
         },200));
      }
      
      public static function getAward() : void
      {
         var item:FItems = null;
         var i:int = nowGetItemArr.length - 1;
         while(i >= 0)
         {
            item = nowGetItemArr[i];
            if(Boolean(item))
            {
               item.getAward();
               nowGetItemArr.splice(i,1);
            }
            i--;
         }
      }
   }
}

