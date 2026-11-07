package com.debug.battle
{
   import flash.utils.ByteArray;
   
   public class BattleDebug
   {
      
      public static var roleBody:Array;
      
      public static var skillIds:Array;
      
      public function BattleDebug()
      {
         super();
      }
      
      public static function CG_BATTLE(body:ByteArray) : void
      {
         var roles:Array = [[10001,1,11,1,"张无忌",40,50,30,40,11,BattleDebug.roleBody[0 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20],[10002,1,12,1,"张无忌",40,50,30,40,12,BattleDebug.roleBody[0 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20],[10003,1,13,1,"张无忌",40,50,30,40,13,BattleDebug.roleBody[0 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20],[10004,1,21,1,"张无忌",40,50,30,40,21,BattleDebug.roleBody[0 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20],[10005,1,22,1,"张无忌",40,50,30,40,22,BattleDebug.roleBody[0 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20],[10006,1,23,1,"张无忌",40,50,30,40,23,BattleDebug.roleBody[0 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20],[10007,1,31,1,"张无忌",40,50,30,40,31,BattleDebug.roleBody[0 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20],[10008,1,32,1,"张无忌",40,50,30,40
         ,32,BattleDebug.roleBody[0 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20],[10009,1,33,1,"张无忌",40,50,30,40,33,BattleDebug.roleBody[0 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20],[20001,1,11,2,"赵敏",40,50,30,40,11,BattleDebug.roleBody[1 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20],[20002,1,12,2,"赵敏",40,50,30,40,12,BattleDebug.roleBody[1 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20],[20003,1,13,2,"赵敏",40,50,30,40,13,BattleDebug.roleBody[1 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20],[20004,1,21,2,"赵敏",40,50,30,40,21,BattleDebug.roleBody[1 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20],[20005,1,22,2,"赵敏",40,50,30,40,22,BattleDebug.roleBody[1 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20],[20006,1,23,2,"赵敏",40,50,30,40,23,BattleDebug.roleBody[1 * 4],1,BattleDebug.roleBody[0 * 4 + 1]
         ,BattleDebug.roleBody[0 * 4 + 2],30,20],[20007,1,31,2,"赵敏",40,50,30,40,31,BattleDebug.roleBody[1 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20],[20008,1,32,2,"赵敏",40,50,30,40,32,BattleDebug.roleBody[1 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20],[20009,1,33,2,"赵敏",40,50,30,40,33,BattleDebug.roleBody[1 * 4],1,BattleDebug.roleBody[0 * 4 + 1],BattleDebug.roleBody[0 * 4 + 2],30,20]];
         var steps:Array = [[1,10001,200,300,20,30,BattleDebug.skillIds[0],[],[[10002,20,30,40,50,[]]]],[1,10002,200,300,20,30,BattleDebug.skillIds[0],[],[[10001,20,30,40,50,[]]]]];
      }
   }
}

