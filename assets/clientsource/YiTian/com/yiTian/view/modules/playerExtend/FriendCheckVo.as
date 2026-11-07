package com.yiTian.view.modules.playerExtend
{
   public class FriendCheckVo
   {
      
      public static var _instance:FriendCheckVo;
      
      public var _dataArr:Array = [];
      
      public function FriendCheckVo()
      {
         super();
      }
      
      public static function get instance() : FriendCheckVo
      {
         if(!_instance)
         {
            _instance = new FriendCheckVo();
         }
         return _instance;
      }
      
      public static function set dataArr(_data:Array) : void
      {
         instance._dataArr = _data;
         CGXTestPan._objData = instance;
      }
   }
}

