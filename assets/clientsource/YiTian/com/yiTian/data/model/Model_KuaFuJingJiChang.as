package com.yiTian.data.model
{
   import com.yiTian.view.modules.kuafujingjichang.MyTeamVo;
   import com.yiTian.view.modules.kuafujingjichang.PingLunVO;
   
   public class Model_KuaFuJingJiChang
   {
      
      public static var team_id:int;
      
      public static var isCaptain:Boolean;
      
      public static var myTeamMembers:Object;
      
      public static var zfId:int;
      
      public static var myTeamVo:Vector.<MyTeamVo> = new Vector.<MyTeamVo>();
      
      public static var team_Type:int = -1;
      
      public static var team_captain_id:Number = 0;
      
      public static var listVo:Array = [];
      
      public static var teamlist:Array = [];
      
      public static var PJVo:Vector.<PingLunVO> = new Vector.<PingLunVO>();
      
      public function Model_KuaFuJingJiChang()
      {
         super();
      }
   }
}

