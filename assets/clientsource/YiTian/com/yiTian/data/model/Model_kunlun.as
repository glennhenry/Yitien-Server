package com.yiTian.data.model
{
   import com.yiTian.command.BindObj;
   
   public class Model_kunlun
   {
      
      public static var voArr:Array = [new Array(),new Array()];
      
      public static var voCountArr:Array = [0,0];
      
      public static var scoreArr:Array = [0,0];
      
      public static var myKLInfo:BindObj = new BindObj();
      
      public static var klRoomInfo:BindObj = new BindObj();
      
      public function Model_kunlun()
      {
         super();
      }
      
      public static function initKLRanksData() : void
      {
         voArr = [new Array(),new Array()];
         voCountArr = [0,0];
         scoreArr = [0,0];
      }
   }
}

