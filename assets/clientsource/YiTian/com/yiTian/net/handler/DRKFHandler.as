package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_KuaFuJingJiChang;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KuaFuJingJiChangCGMessage;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.kuafujingjichang.TeamVo;
   
   public class DRKFHandler extends Panel123
   {
      
      public function DRKFHandler()
      {
         super();
      }
      
      public static function getHeatUrl(sex:int, job:int) : String
      {
         var icon_num:int = 23000 + Enum_job.getBaseJob(job) * 100 + 30 + sex;
         return "resource/image/icon/" + icon_num.toString() + ".jpg";
      }
      
      public static function joinDRKFTeam(teamId:int, teamType:int, password:String) : void
      {
         if(Model_team.hasTeam())
         {
            UIManager.centerBroadcast.addMsg("组队状态不支持加入队伍");
         }
         else if(UIManager.mainUiBtnContainer.curFuBenType != 0 || Global.sceneID == 12304)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80175",8));
         }
         else if(GameUnitManager.hero.paoBiao != 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80176",8));
         }
         else
         {
            KuaFuJingJiChangCGMessage.CG_KUAFUTEAM_JOIN(teamId,password);
         }
      }
      
      public static function getListSource(type:int) : Array
      {
         var vo:TeamVo = null;
         var arr:Array = [];
         for each(vo in Model_KuaFuJingJiChang.listVo)
         {
            if(vo.team_type == type)
            {
               arr.push(vo);
            }
         }
         return arr.sort(sortFun);
      }
      
      public static function upDataList() : void
      {
      }
      
      private static function sortFun(vo1:TeamVo, vo2:TeamVo) : int
      {
         if(vo1.status == 1)
         {
            return -1;
         }
         if(vo2.status == 1)
         {
            return 1;
         }
         return vo1.status - vo2.status;
      }
   }
}

