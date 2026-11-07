package com.yiTian.data.model
{
   import com.yiTian.view.modules.keJu.RankVO;
   import flash.display.BitmapData;
   
   public class Model_KeJu
   {
      
      public static var poemsID:int;
      
      public static var isLucky:int;
      
      public static var isCaishen:int;
      
      public static var answernum:int;
      
      public static var questID:int;
      
      public static var version:int;
      
      public static var lqNum:int;
      
      public static var poemsIndexArr:Array = [];
      
      public static var poemsAnswerArr:Array = [];
      
      public static var answerArr:Array = [];
      
      public static var rankArr:Vector.<RankVO> = new Vector.<RankVO>();
      
      public static var poemsRankArr:Vector.<RankVO> = new Vector.<RankVO>();
      
      public static var poemsBMD:Vector.<BitmapData> = new Vector.<BitmapData>();
      
      public function Model_KeJu()
      {
         super();
      }
   }
}

