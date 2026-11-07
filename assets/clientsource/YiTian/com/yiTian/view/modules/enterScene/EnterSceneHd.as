package com.yiTian.view.modules.enterScene
{
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.UIManager;
   
   public class EnterSceneHd
   {
      
      public static var isUsingNew:Boolean = true;
      
      public function EnterSceneHd()
      {
         super();
      }
      
      public static function isShowHd() : void
      {
         var arr:Array;
         var hasUsedEx:Boolean;
         var _id:int;
         var _gridId:int = 0;
         if(!isUsingNew)
         {
            return;
         }
         arr = [43061,43062,43063,43064];
         hasUsedEx = UIManager.heroHead.getBuffUse(arr);
         if(hasUsedEx)
         {
            return;
         }
         _id = getId(arr);
         if(Boolean(_id))
         {
            _gridId = CommandManager.getGridIdById(_id);
         }
         else
         {
            _gridId = 0;
         }
         UIManager.jjdProm.show(function(__type:int, __vo:Vo_item):void
         {
            trace("sss");
         },_gridId,_id);
      }
      
      private static function getId(_arr:Array) : int
      {
         var _id:int = 0;
         var _num:int = 0;
         var i:int = 0;
         while(i < _arr.length)
         {
            _id = int(_arr[i]);
            _num = CommandManager.get_bag_count(_id);
            if(_num != 0)
            {
               return _id;
            }
            i++;
         }
         return 0;
      }
   }
}

