package com.yiTian.manager
{
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_npc_fun;
   import com.yiTian.data.model.Model_KeJu;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.net.message.cg.AiDeBaoBaoCGMessage;
   import com.yiTian.net.message.cg.BabyCGMessage;
   import com.yiTian.net.message.cg.BangBattleCGMessage;
   import com.yiTian.net.message.cg.CrossCampBattleCGMessage;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.net.message.cg.FishingCGMessage;
   import com.yiTian.net.message.cg.HuangbangCGMessage;
   import com.yiTian.net.message.cg.KLMountianCGMessage;
   import com.yiTian.net.message.cg.KejuCGMessage;
   import com.yiTian.net.message.cg.MarriageCGMessage;
   import com.yiTian.net.message.cg.PataCGMessage;
   import com.yiTian.net.message.cg.QuestCGMessage;
   import com.yiTian.net.message.cg.ShiZhuangSuiPianCGMessage;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.net.message.cg.YelloDiaCGMessage;
   import com.yiTian.net.message.cg.ZaHuoDianCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.KFHomeland.HomeLandCGMessage;
   import com.yiTian.view.modules.KFHomeland.HomeSpecialMall;
   import com.yiTian.view.modules.ShiZhuangSuiPian.View_ShiZhuangSuiPian_menu;
   import com.yiTian.view.modules.baby.babyManager.Model_baby;
   import com.yiTian.view.modules.baby.babyPan.BabyChooseLY;
   import com.yiTian.view.modules.christmas.ViewChristMas;
   import com.yiTian.view.modules.crossCampBattle.Enum_CrossCampBattle;
   import com.yiTian.view.modules.keJu.View_PoemsNpc;
   import com.yiTian.view.modules.keJu.View_XS_Introduce;
   import com.yiTian.view.modules.marriage.MarriageConfig;
   import com.yiTian.view.modules.marriage.Model_Marriage;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.getTimer;
   
   public class NpcFunManager
   {
      
      private static var funs:Array = [];
      
      public function NpcFunManager()
      {
         super();
      }
      
      public static function register() : void
      {
         funs[Enum_npc_fun.YAO_DIAN] = YAO_DIAN;
         funs[Enum_npc_fun.ZA_HUO_DIAN] = ZA_HUO_DIAN;
         funs[Enum_npc_fun.EQUIP_DIAN] = EQUIP_DIAN;
         funs[Enum_npc_fun.DEPOT] = DEPOT;
         funs[Enum_npc_fun.ENTER_KUNLUN] = ENTER_KUNLUN;
         funs[Enum_npc_fun.PLAY_INTRODUCE] = KL_JIESHAO;
         funs[Enum_npc_fun.PA_TA] = PA_TA;
         funs[Enum_npc_fun.PA_TA2] = PA_TA2;
         funs[Enum_npc_fun.QUEST_DAILY] = QUEST_DAILY;
         funs[Enum_npc_fun.FISH] = FISH;
         funs[Enum_npc_fun.ADVENTURE_PAIHANG] = ADVENTURE_PAIHANG;
         funs[Enum_npc_fun.BANG_PAI] = BATTLE_BANG;
         funs[Enum_npc_fun.REQUEST_BANG_BOSS] = REQUEST_BANG_BOSS;
         funs[Enum_npc_fun.PA_TA_TEAM] = PA_TA_TEAM;
         funs[Enum_npc_fun.YUN_SONG_BIAO_CHE] = YUN_SONG_BIAO_CHE;
         funs[Enum_npc_fun.XIJIE_LIANGYUAN] = XIJIE_LIANGYUAN;
         funs[Enum_npc_fun.TOU_FANGHONGBAO] = TOU_FANGHONGBAO;
         funs[Enum_npc_fun.WO_YAOLIHUN] = WO_YAOLIHUN;
         funs[Enum_npc_fun.GETQIXIREWARD] = GETQIXIREWARD;
         funs[Enum_npc_fun.JOINKEJU] = JOINKEJU;
         funs[Enum_npc_fun.ABOUTKEJU] = ABOUTKEJU;
         funs[Enum_npc_fun.JOIN_XINYUE] = JOIN_XINYUE;
         funs[Enum_npc_fun.JOIN_IN_XINYUE] = JOIN_IN_XINYUE;
         funs[Enum_npc_fun.GET_XINYUE_GIFT] = GET_XINYUE_GIFT;
         funs[Enum_npc_fun.christmas_big_snowman] = christmas_big_snowman;
         funs[Enum_npc_fun.ShiZhuangSuiPian] = ShiZhuangSuiPian;
         funs[Enum_npc_fun.COMMIT_MINE] = commitMine;
         funs[Enum_npc_fun.AiDeBaoBao_middle] = AiDeBaoBao_middle;
         funs[Enum_npc_fun.jinHuangbang] = EnterHuangbang;
         funs[Enum_npc_fun.GET_QIXI_GIFT] = GET_QIXI_GIFT;
         funs[Enum_npc_fun.ENTER_INNER_HOME] = ENTER_INNER_HOME;
         funs[Enum_npc_fun.OPEN_HOME_MALL] = OPEN_HOME_MALL;
         funs[Enum_npc_fun.COMMIT_CRYSTAL] = COMMIT_CRYSTAL;
         funs[Enum_npc_fun.COMMIT_JADE_ESSENCE] = COMMIT_JADE_ESSENCE;
         funs[Enum_npc_fun.LINGYANG_CHILD] = LINGYANG_CHILD;
         funs[Enum_npc_fun.TUOGUAN_CHILD] = TUOGUAN_CHILD;
      }
      
      public static function LINGYANG_CHILD(bindNpc:Npc) : void
      {
         if(GameUnitManager.hero.marriageID == 0)
         {
            UIManager.centerBroadcast.addMsg("单身人士不允许领养崽崽哦亲",1);
            return;
         }
         Model_baby.show(BabyChooseLY.instance,"show");
      }
      
      private static function TUOGUAN_CHILD(bindNpc:Npc) : void
      {
         BabyCGMessage.CG_CLICK_TO_TUOGUAN();
      }
      
      public static function oper(ability:int, bindNpc:Npc) : void
      {
         if(Boolean(funs[ability]))
         {
            funs[ability](bindNpc);
         }
      }
      
      public static function JOIN_XINYUE(bindNpc:Npc) : void
      {
         navigateToURL(new URLRequest("http://xinyue.qq.com/gamezone/yi/index.shtml"));
      }
      
      public static function JOIN_IN_XINYUE(bindNpc:Npc) : void
      {
         navigateToURL(new URLRequest("http://xinyue.qq.com/gamezone/yi/index.shtml"));
      }
      
      public static function GET_XINYUE_GIFT(bindNpc:Npc) : void
      {
         if(GameUnitManager.hero.xinYueLvl == 0)
         {
            UIManager.centerBroadcast.addMsg("亲，你还不是心悦会员哦");
            return;
         }
         YelloDiaCGMessage.CG_GET_XINYUE_GIFT();
      }
      
      public static function ABOUTKEJU(bindNpc:Npc) : void
      {
         View_XS_Introduce.instance.show();
      }
      
      public static function christmas_big_snowman(bindNpc:Npc) : void
      {
         if(!UIManager.christmasView)
         {
            UIManager.christmasView = new ViewChristMas();
            UIManager.christmasView.init();
         }
         UIManager.christmasView.visible = true;
      }
      
      public static function JOINKEJU(bindNpc:Npc) : void
      {
         if(bindNpc.sysId == 51102)
         {
            if(Model_KeJu.poemsIndexArr.length >= 20)
            {
               View_PoemsNpc.instance.show(bindNpc);
            }
            else
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80042",8));
            }
         }
         else
         {
            KejuCGMessage.CG_JOINKEJU(bindNpc.sysId);
         }
      }
      
      public static function ENTER_KUNLUN(bindNpc:Npc) : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10507",1));
            return;
         }
         if(Model_team.hasTeam())
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10552",1));
            return;
         }
         KLMountianCGMessage.CG_ENTER_KL_MOUNTIAN();
      }
      
      private static function KL_JIESHAO(bindNpc:Npc) : void
      {
         UIManager.kunlun_jieShao.visible = true;
      }
      
      private static function DEPOT(bindNpc:Npc) : void
      {
         UIManager.depotPanel.visible = true;
      }
      
      private static function ZA_HUO_DIAN(bindNpc:Npc) : void
      {
         UIManager.zaHuoDian.show(bindNpc);
         UIManager.zaHuoDian.set_title("ZAHUODIAN");
         Model_shop.get_shop_id = bindNpc.sysId;
         if(!Model_shop.ZHD_data_arr[bindNpc.sysId])
         {
            Model_shop.ZHD_data_arr[bindNpc.sysId] = [];
         }
         if(!Model_shop.ZHD_data_arr[bindNpc.sysId].length)
         {
            ZaHuoDianCGMessage.CG_ZAHUODIAN_QUERY(Model_shop.get_shop_id);
         }
         else
         {
            UIManager.zaHuoDian.visible = true;
            UIManager.zaHuoDian.update(1,1);
         }
      }
      
      private static function EQUIP_DIAN(bindNpc:Npc) : void
      {
         UIManager.zaHuoDian.show(bindNpc);
         UIManager.zaHuoDian.set_title("ZBDIAN");
         Model_shop.get_shop_id = bindNpc.sysId;
         if(!Model_shop.ZB_data_arr[bindNpc.sysId])
         {
            Model_shop.ZB_data_arr[bindNpc.sysId] = [];
         }
         if(!Model_shop.ZB_data_arr[bindNpc.sysId].length)
         {
            ZaHuoDianCGMessage.CG_ZAHUODIAN_QUERY(Model_shop.get_shop_id);
         }
         else
         {
            UIManager.zaHuoDian.visible = true;
            UIManager.zaHuoDian.update(1,2);
         }
      }
      
      private static function YAO_DIAN(bindNpc:Npc) : void
      {
         UIManager.zaHuoDian.show(bindNpc);
         UIManager.zaHuoDian.set_title("YPDIAN");
         Model_shop.longShopType = false;
         Model_shop.get_shop_id = bindNpc.sysId;
         UIManager.bagPanel.x = Global.stage.stageWidth / 2 + 100;
         if(!Model_shop.YP_data_arr[bindNpc.sysId])
         {
            Model_shop.YP_data_arr[bindNpc.sysId] = [];
         }
         if(!Model_shop.YP_data_arr[bindNpc.sysId].length)
         {
            ZaHuoDianCGMessage.CG_ZAHUODIAN_QUERY(Model_shop.get_shop_id);
         }
         else
         {
            UIManager.zaHuoDian.visible = true;
            UIManager.zaHuoDian.update(1,1);
         }
      }
      
      private static function PA_TA(bindNpc:Npc) : void
      {
         if(Model_team.teamMumberInfo_data_save.length > 0)
         {
            if(isCap())
            {
               if(Model_team.isAway() || Model_team.isOffLine())
               {
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10553",1) + "</font>");
               }
               else
               {
                  PataCGMessage.CG_ENTER_TTF_TIMES();
               }
            }
            else
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10310",1) + "</font>");
            }
         }
         else
         {
            PataCGMessage.CG_ENTER_TTF_TIMES();
         }
      }
      
      private static function PA_TA2(bindNpc:Npc) : void
      {
         if(GameUnitManager.hero.level < 80)
         {
            UIManager.centerBroadcast.addMsg("等级未达80，请加油练级哦");
            return;
         }
         if(Model_team.teamMumberInfo_data_save.length > 0)
         {
            if(isCap())
            {
               if(Model_team.isAway() || Model_team.isOffLine())
               {
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10553",1) + "</font>");
               }
               else
               {
                  PataCGMessage.CG_ENTER_TTF_TIMES(1000);
               }
            }
            else
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10310",1) + "</font>");
            }
         }
         else
         {
            PataCGMessage.CG_ENTER_TTF_TIMES(1000);
         }
      }
      
      public static function isCap() : Boolean
      {
         return Model_team.teamMumberInfo_data_save.some(modelTeamArrSome);
      }
      
      private static function modelTeamArrSome(element:Array, index:int, arr:Array) : Boolean
      {
         return element[13] == GameUnitManager.hero.id && element[0] == 0;
      }
      
      public static function QUEST_DAILY(bindNpc:Npc) : void
      {
         QuestCGMessage.CG_QUEST_DAILY_REFRESH();
      }
      
      public static function FISH(bindNpc:Npc) : Boolean
      {
         if(Model_team.teamMumberInfo_data_save.length > 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10554",1));
            return false;
         }
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10555",1));
            return false;
         }
         FishingCGMessage.CG_ENTER_RIVER(-1);
         return true;
      }
      
      public static function ADVENTURE_PAIHANG(bindNpc:Npc) : Boolean
      {
         UIManager.kunlun_substantive.visible = true;
         return true;
      }
      
      public static function BATTLE_BANG(bindNpc:Npc) : Boolean
      {
         if(Model_bang.partyType == 1)
         {
            UIManager.centerBroadcast.addMsg("公共帮会不能参与帮会战");
            return true;
         }
         if(GameUnitManager.hero.partyId == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10556",1));
            return true;
         }
         if(GameUnitManager.hero.level < 35)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10557",1));
            return true;
         }
         if(Model_team.teamMumberInfo_data_save.length > 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10558",1));
            return true;
         }
         BangBattleCGMessage.CG_ENTER_BANG_BATTLE();
         return true;
      }
      
      public static function REQUEST_BANG_BOSS(bindNpc:Npc) : Boolean
      {
         BangBattleCGMessage.CG_QUEST_BANG_BATTLE(2,bindNpc.id,bindNpc.sysId);
         return true;
      }
      
      public static function PA_TA_TEAM(bindNpc:Npc) : void
      {
         var curTime:int = 0;
         if(Model_team.isCap())
         {
            if(Model_team.teamMumberInfo_data_save.length < 3)
            {
               curTime = getTimer();
               if(Boolean(Model_team.pataTime) && curTime - Model_team.pataTime < 60000)
               {
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10559",1) + "</font>");
               }
               else
               {
                  Model_team.pataTime = curTime;
                  TeamCGMessage.CG_TEAM_PATA();
               }
            }
            else
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10560",1) + "</font>");
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10561",1) + "</font>");
         }
      }
      
      public static function YUN_SONG_BIAO_CHE(bindNpc:Npc) : void
      {
      }
      
      public static function XIJIE_LIANGYUAN(bindNpc:Npc) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(UIManager.marriagePlane,function():void
         {
            UIManager.marriagePlane.visible = true;
         });
      }
      
      public static function TOU_FANGHONGBAO(bindNpc:Npc) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         UIManager.hongbao.visible = true;
      }
      
      public static function WO_YAOLIHUN(bindNpc:Npc) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         Model_Marriage.breakMarriage();
      }
      
      public static function GETQIXIREWARD(bindNpc:Npc) : void
      {
         MarriageCGMessage.CG_GETQIXIREWARD();
      }
      
      public static function ShiZhuangSuiPian(bindNpc:Npc) : void
      {
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_ShiZhuangSuiPian_menu.instance,function():void
         {
            View_ShiZhuangSuiPian_menu.instance.visible = true;
            ShiZhuangSuiPianCGMessage.OpenMenu();
         });
      }
      
      public static function commitMine(bindNpc:Npc) : void
      {
         CrossClanBattleCGMessage.CG_COMMIT_RESOURCE_MINE();
      }
      
      public static function AiDeBaoBao_middle(bindNpc:Npc) : void
      {
         AiDeBaoBaoCGMessage.CG_AiDeBaoBao_JOIN_SECOND_HALF();
      }
      
      public static function EnterHuangbang(bindNpc:Npc) : void
      {
         HuangbangCGMessage.CG_ENTER_HUANGBANG();
      }
      
      public static function GET_QIXI_GIFT(bindNpc:Npc) : void
      {
         MarriageCGMessage.CG_GET_QIXI_GIFT();
      }
      
      public static function ENTER_INNER_HOME(bindNpc:Npc) : void
      {
         if(Model_team.hasTeam())
         {
            HomeLandCGMessage.CG_GLOBAL_TEAM_VISITHOME();
         }
         else
         {
            HomeLandCGMessage.CG_INNER_HOMELAND();
         }
      }
      
      public static function OPEN_HOME_MALL(bindNpc:Npc) : void
      {
         HomeSpecialMall.instance.visible = !HomeSpecialMall.instance.visible;
      }
      
      public static function COMMIT_CRYSTAL(bindNpc:Npc) : void
      {
         CrossCampBattleCGMessage.CG_CAMP_COMMIT_ITEM(Enum_CrossCampBattle.COMMIT_CRYSTAL,bindNpc.id);
      }
      
      public static function COMMIT_JADE_ESSENCE(bindNpc:Npc) : void
      {
         CrossCampBattleCGMessage.CG_CAMP_COMMIT_ITEM(Enum_CrossCampBattle.COMMIT_CRYSTAL,bindNpc.id);
      }
   }
}

