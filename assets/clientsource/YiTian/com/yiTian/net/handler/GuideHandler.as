package com.yiTian.net.handler
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.GuideManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.guide.View_Arrow;
   import flash.utils.IDataInput;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class GuideHandler
   {
      
      private static var skillArrow:View_Arrow;
      
      private static var _sitInter:int;
      
      private static var sitArrow:View_Arrow;
      
      public function GuideHandler()
      {
         super();
      }
      
      public static function GC_GUIDE_SKILL(result:int) : void
      {
         var skillName:String = null;
         switch(result)
         {
            case 1:
               skillName = Data_lib.item["461" + Enum_job.getBaseJob(GameUnitManager.hero.job) + "1"][Enum_lib_item.STR_NAME];
               GuideManager.rewardInfo = LangConfig.getWord("628",0) + HtmlUtil.fontNoSize(skillName,"#00ff00");
         }
      }
      
      public static function GC_GUIDE_PET(result:int) : void
      {
         switch(result)
         {
            case 1:
               GuideManager.rewardInfo = LangConfig.getWord("629",0) + HtmlUtil.fontNoSize(LangConfig.getWord("630",0),"#00ff00");
         }
      }
      
      public static function GC_GUIDE_HORSE(result:int) : void
      {
         switch(result)
         {
            case 1:
               GuideManager.rewardInfo = LangConfig.getWord("631",0) + HtmlUtil.fontNoSize(LangConfig.getWord("632",0),"#00ff00");
         }
      }
      
      public static function GC_GET_NEWPAWARD(result:int, patch:IDataInput) : void
      {
         var time:int = 0;
         var hors:int = 0;
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1073",0));
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1074",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1075",0));
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1076",0));
         }
         else if(result == 6)
         {
            time = patch.readByte();
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1171",0,time));
         }
         else if(result == 10)
         {
            hors = patch.readByte();
            UIManager.centerBroadcast.addMsg(hors + "小时后可再次领取");
         }
         UIManager.actKaiFu.enabledBtn();
      }
      
      public static function setCanSit() : void
      {
         if(!sitArrow)
         {
            sitArrow = new View_Arrow(View_Arrow.LEFT);
         }
         sitArrow.show(LangConfig.getWord("637",0),UIManager.mainMenu,20,0);
         _sitInter = setTimeout(removeSitArrow,5000);
      }
      
      private static function removeSitArrow() : void
      {
         clearTimeout(_sitInter);
         sitArrow.dispose();
         sitArrow = null;
      }
   }
}

