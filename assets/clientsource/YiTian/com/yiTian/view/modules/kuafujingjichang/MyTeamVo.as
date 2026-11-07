package com.yiTian.view.modules.kuafujingjichang
{
   import com.yiTian.data.vo.Vo_grid;
   
   public class MyTeamVo extends Vo_grid
   {
      
      public var isCaptain:int;
      
      public var Id:int;
      
      public var name:String;
      
      public var sex:int;
      
      public var job:int;
      
      public var level:int;
      
      public var num:int;
      
      public var zhanLi:int;
      
      public var Fashion:int;
      
      public var wuQi:int;
      
      public var zhenFa:String;
      
      public var zhenFaArr:Array;
      
      public var notZhenFa:String;
      
      public var notZhenFaArr:Array;
      
      public var nowZhenFa:int;
      
      public var position:String;
      
      public var petValue:Number = 0;
      
      public var petId:int;
      
      public var petName:String;
      
      public var petLevel:int;
      
      public var petHp:String;
      
      public var petHpArr:Array;
      
      public var heroHp:String;
      
      public var heroHpArr:Array;
      
      public var heroMp:String;
      
      public var heroMpArr:Array;
      
      public var type:int;
      
      public var petVo:MyTeamVo;
      
      public var wing:int;
      
      public function MyTeamVo()
      {
         super();
      }
   }
}

