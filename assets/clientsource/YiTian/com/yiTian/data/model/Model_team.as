package com.yiTian.data.model
{
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.view.modules.qingMing.Model_QingMing;
   import com.yiTian.view.modules.qingMing.Msg_QingMing;
   import com.yiTian.view.modules.qingMing.View_zhuaGuiPanel;
   import flash.utils.Dictionary;
   
   public class Model_team
   {
      
      private static var id:int;
      
      public static var team_id:int;
      
      public static var leastLvlSave:int;
      
      public static var biggestLvlSave:int;
      
      public static var currentZhenFa:int;
      
      public static var isRegest:int;
      
      public static var HMPArr:Array;
      
      public static var petInfoArr:Array;
      
      public static var pataTime:int;
      
      public static var createTeamSuccessed:int = 0;
      
      public static var team_data_save:Array = [];
      
      public static var teamInfo_data_save:Array = [];
      
      public static var teamMumbers_data_save:Array = [];
      
      public static var isFollow:Dictionary = new Dictionary();
      
      public static var save_inviTip:Dictionary = new Dictionary();
      
      public static var teamMumberInfo_data_save:Array = [];
      
      public static var kickRoleId:Dictionary = new Dictionary();
      
      public static var isTeam:Dictionary = new Dictionary();
      
      public static var isCaptain:Dictionary = new Dictionary();
      
      public static var learnZhenFa:String = "";
      
      public static var memberIcon:Array = [];
      
      isFollow[GameUnitManager.hero.id] = 1;
      isTeam[GameUnitManager.hero.id] = false;
      isCaptain[GameUnitManager.hero.id] = false;
      
      public function Model_team()
      {
         super();
      }
      
      public static function getMemberInfo(memberId:Number) : Array
      {
         var a:Array = null;
         for each(a in teamMumberInfo_data_save)
         {
            if(a[13] == memberId)
            {
               return a;
            }
         }
         return null;
      }
      
      public static function positionSort() : void
      {
         var j:uint = 0;
         var temp:Array = null;
         var i:uint = 0;
         while(i < Model_team.teamMumberInfo_data_save.length)
         {
            j = i + 1;
            while(j < Model_team.teamMumberInfo_data_save.length)
            {
               if(Model_team.teamMumberInfo_data_save[i][0] > Model_team.teamMumberInfo_data_save[j][0])
               {
                  temp = Model_team.teamMumberInfo_data_save[i];
                  Model_team.teamMumberInfo_data_save[i] = Model_team.teamMumberInfo_data_save[j];
                  Model_team.teamMumberInfo_data_save[j] = temp;
               }
               j++;
            }
            i++;
         }
         Model_team.memberIcon.sort(function(a:Array, b:Array):Number
         {
            if(a[0] > b[0])
            {
               return 1;
            }
            if(a[0] < b[0])
            {
               return -1;
            }
            return 0;
         });
         if(View_zhuaGuiPanel.instance.visible == true)
         {
            Global.control.sendNotification(Msg_QingMing.QUALITY_UPDATE,Model_QingMing._curLv);
         }
      }
      
      public static function getIsTeamMember(playerId:Number) : Boolean
      {
         var member:Array = null;
         var i:int = 0;
         while(i < teamMumberInfo_data_save.length)
         {
            member = teamMumberInfo_data_save[i];
            if(member[member.length - 1] == playerId)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public static function isCanGo() : Boolean
      {
         if(!isTeam[GameUnitManager.hero.id])
         {
            return true;
         }
         var i:uint = 0;
         while(i < Model_team.teamMumberInfo_data_save.length)
         {
            if(Model_team.teamMumberInfo_data_save[i][13] == GameUnitManager.hero.id)
            {
               if(Model_team.teamMumberInfo_data_save[i][0] == 0)
               {
                  return true;
               }
               if(Model_team.isFollow[GameUnitManager.hero.id] == 1)
               {
                  return false;
               }
               return true;
            }
            i++;
         }
         return true;
      }
      
      public static function isCap() : Boolean
      {
         var i:uint = 0;
         while(i < Model_team.teamMumberInfo_data_save.length)
         {
            if(Model_team.teamMumberInfo_data_save[i][13] == GameUnitManager.hero.id && Model_team.teamMumberInfo_data_save[i][0] == 0)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public static function hasTeam() : Boolean
      {
         return Model_team.teamMumberInfo_data_save.length > 0;
      }
      
      public static function capIsOffline() : Boolean
      {
         var i:uint = 0;
         while(i < Model_team.teamMumberInfo_data_save.length)
         {
            if(Model_team.teamMumberInfo_data_save[i][0] == 0 && Model_team.isFollow[Model_team.teamMumberInfo_data_save[i][13]] == -1)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public static function isAway() : Boolean
      {
         var tempB:Boolean = false;
         var j:uint = 0;
         while(j < Model_team.teamMumberInfo_data_save.length)
         {
            if(Model_team.isFollow[Model_team.teamMumberInfo_data_save[j][13]] == 0 && Model_team.teamMumberInfo_data_save[j][13] != GameUnitManager.hero.id)
            {
               tempB = true;
               break;
            }
            j++;
         }
         return tempB;
      }
      
      public static function isOffLine() : Boolean
      {
         var tempB:Boolean = false;
         var j:uint = 0;
         while(j < Model_team.teamMumberInfo_data_save.length)
         {
            if(Model_team.isFollow[Model_team.teamMumberInfo_data_save[j][13]] == -1)
            {
               tempB = true;
               break;
            }
            j++;
         }
         return tempB;
      }
   }
}

