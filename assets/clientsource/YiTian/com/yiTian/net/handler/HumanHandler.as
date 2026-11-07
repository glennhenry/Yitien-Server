package com.yiTian.net.handler
{
   import com.ui.controls.MyTextField;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_Jianghulixian;
   import com.yiTian.data.config.Enum_thing_sysType;
   import com.yiTian.data.config.Enum_thing_type;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_layInPill;
   import com.yiTian.data.model.Model_shuXingDan;
   import com.yiTian.data.vo.Vo_shuXingDan;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.gameUnit.role.Pet;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.manager.BattleStatusManager;
   import com.yiTian.manager.CollectManager;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.MapManager;
   import com.yiTian.manager.NewPushManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.DAU.Model_DAU;
   import com.yiTian.view.modules.KFHomeland.HomeLandBtn;
   import com.yiTian.view.modules.KFHomeland.VoHome;
   import com.yiTian.view.modules.SmallActivityLink.SmallActManager;
   import com.yiTian.view.modules.SmallActivityLink.VoSmallAct;
   import com.yiTian.view.modules.broadcast.StrengthTip;
   import com.yiTian.view.modules.crossClanBattle.Model_CrossClanBattle;
   import com.yiTian.view.modules.farm.ViewFarmIcon;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.mainUIBtnContainer.View_TipBtnContainer;
   import com.yiTian.view.modules.shenBing.Model_ShenBing;
   import com.yiTian.view.modules.shenBing.Vo_ShenBingAtb;
   import com.yiTian.view.modules.skill.Model_skill;
   import com.yiTian.view.modules.yellowDiamond.TwoEggsTip;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class HumanHandler
   {
      
      private static var tf:MyTextField;
      
      private static var _levUpInt:int;
      
      public function HumanHandler()
      {
         super();
      }
      
      public static function GC_HERO_INFO(result:int, job:int, sex:int, level:int, mSpeed:int, hp:int, hpMax:int, mp:int, mpMax:int, id:Number, name:String, direct:int, signed:String, hasPlay:int, fubenInfo:String, YLDiaLvl:int, isYearDia:int, huangZuanLvl:int, isHuangZuanYear:int, huiyuanLv:int, huiyuanYear:int, superLan:int, superLanYear:int, xinYueType:int, xinLvl:int, isShow:int, isSuperHuang:int) : void
      {
         if(result == 1)
         {
            GameUnitManager.hero.type = UnitType.PLAYER;
            GameUnitManager.hero.job = job;
            GameUnitManager.hero.sex = sex;
            GameUnitManager.hero.level = level;
            GameUnitManager.hero.speed = mSpeed;
            GameUnitManager.hero.hp = hp;
            GameUnitManager.hero.hpMax = hpMax;
            GameUnitManager.hero.mp = mp;
            GameUnitManager.hero.mpMax = mpMax;
            GameUnitManager.hero.id = id;
            GameUnitManager.hero.way = direct;
            GameUnitManager.hero.signed = signed;
            GameUnitManager.hero.isShow = isShow;
            GameUnitManager.hero.status = Status.NOMAL;
            GameUnitManager.hero.setShadow(Status.NOMAL,11);
            GameUnitManager.hero.ylDiaLvl = YLDiaLvl;
            GameUnitManager.hero.isYearDia = isYearDia;
            GameUnitManager.hero.huangZuanLvl = huangZuanLvl;
            GameUnitManager.hero.isHuangZuanYear = isHuangZuanYear;
            GameUnitManager.hero.isSuperHuang = isSuperHuang;
            GameUnitManager.hero.isHuiyuan = huiyuanLv;
            GameUnitManager.hero.isHuiyuanYear = huiyuanYear;
            GameUnitManager.hero.superLan = superLan;
            GameUnitManager.hero.superLanYear = superLanYear;
            GameUnitManager.hero.xinYueType = xinYueType;
            GameUnitManager.hero.xinYueLvl = xinLvl;
            if(Model_CrossClanBattle.port == 0)
            {
               GameUnitManager.hero.name = name;
               Global.isFirstPlay = !hasPlay;
            }
            MapManager.initFubenInfo(fubenInfo);
            showButton(GameUnitManager.hero.level);
         }
      }
      
      private static function showButton(level:int) : void
      {
         var farmView:ViewFarmIcon = null;
         var container:View_TipBtnContainer = UIManager.tipBtnContainer;
         if(level > Global.farmOpenLevel)
         {
            farmView = ViewFarmIcon.instance;
            FarmHandler.viewFarmIcon = farmView;
            if(!UIManager.mainUiBtnContainer.hasBTN(farmView))
            {
               UIManager.mainUiBtnContainer.addBTN(farmView);
            }
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.WuLinShanZhuang,1]);
         }
         if(level >= Model_layInPill.instance.pillLvevl)
         {
            if(Boolean(UIManager.mainMenu.layInImg))
            {
               UIManager.mainMenu.layInImg.visible = true;
               TipManager.bind(UIManager.mainMenu.sprite,"当前经验储存/本级最高储存" + "<br>" + Model_layInPill.instance.currentExp + "/" + Model_layInPill.instance.highestExp + "<br>" + "使用武林山庄内兑换的【经验储存丹】可储存");
            }
         }
         if(level >= VoSmallAct.loveActLowLevel && Global.LoveAct)
         {
            SmallActManager.instance.getLoveActBtn();
         }
         if(level >= HomeLandBtn.LowHomeBtnLevel && VoHome.isActivity)
         {
            HomeLandBtn.instance.addBtn(true);
         }
      }
      
      public static function GC_UPDATE_AVATER(id:Number, status:int, weapon:int, body:int, horse:int, speed:int, lqColor:int, qhtz:int, paoBiao:int, chengHao:int, wulinChengHao:String, sex:int, name:String, isShow:int, job:int, xunZhangLvl:int = 0, partner:Number = 0, skillStr:String = "", shenBing:int = 0, zoneId:int = 0, wing:int = 0) : void
      {
         var player:Player = null;
         var pet:Pet = null;
         var sss:String = null;
         var pattern:RegExp = null;
         var ar:Array = null;
         var s:String = null;
         Utils.print("GC_UPDATE_AVATER",id,status,weapon,body,horse,wing,speed,lqColor);
         if(id == GameUnitManager.hero.id)
         {
            GameUnitManager.hero.xunZhangLv = xunZhangLvl;
            GameUnitManager.hero.setBody(status,body);
            GameUnitManager.hero.weapon = weapon;
            GameUnitManager.hero.body = body;
            GameUnitManager.hero.horse = horse;
            GameUnitManager.hero.wing = wing;
            GameUnitManager.hero._status = status;
            GameUnitManager.hero.setWeapon(status,weapon);
            GameUnitManager.hero.setHorse(status,horse);
            GameUnitManager.hero.setWing(status,wing);
            GameUnitManager.hero.speed = speed;
            GameUnitManager.hero.lqColor = lqColor;
            GameUnitManager.hero.qhtz = qhtz;
            GameUnitManager.hero.wulinChengHao = wulinChengHao;
            GameUnitManager.hero.paoBiao = paoBiao;
            GameUnitManager.hero.isShow = isShow;
            GameUnitManager.hero.chengHao = chengHao;
            GameUnitManager.hero.sex = sex;
            GameUnitManager.hero.job = job;
            GameUnitManager.hero.shenBingLv = shenBing;
            UIManager.skillPanel.jobAtbIcon.setJob(job);
            Global.control.sendNotification(Enum_MsgType.ROLE_PAN_UPDATE,null);
            Global.control.sendNotification(Enum_MsgType.ROLE_MODEL_CHANGE,null);
            if(SceneConfig.getSceneType() != SceneConfig.KFBZ_BATTLE && SceneConfig.getSceneType() != SceneConfig.CROSS_CAMP_BATTLE)
            {
               GameUnitManager.hero.status = status;
               GameUnitManager.hero.name = name;
               sss = name;
               pattern = /\.[A-Z][0-9]*/;
               ar = sss.match(pattern);
               if(ar != null && ar.length != 0)
               {
                  s = (ar[0] as String).slice(2,ar[0].length);
                  GameUnitManager.hero.nickName = s;
                  GameUnitManager.hero.name = sss.replace(pattern,"");
               }
            }
            pet = Pet.heroIdList[GameUnitManager.hero.id];
            if(Boolean(pet))
            {
               pet.speed = speed;
            }
            GameUnitManager.hero.zoneId = zoneId;
            GameUnitManager.hero.AiDeBaoBao_partner = partner;
            GameUnitManager.hero.AiDeBaoBao_buff = skillStr.split("_");
            Global.control.sendNotification(Enum_MsgType.UPDATE_AVATER_COMPLETE,GameUnitManager.hero);
            return;
         }
         player = GameUnitManager.findUnit(id,UnitType.PLAYER) as Player;
         if(!player)
         {
            return;
         }
         player.wulinChengHao = wulinChengHao;
         player.xunZhangLv = xunZhangLvl;
         player.setBody(status,body);
         player.setWeapon(status,weapon);
         player.setHorse(status,horse);
         player.setWing(status,wing);
         player.speed = speed;
         player.isShow = isShow;
         player.lqColor = lqColor;
         player.qhtz = qhtz;
         if(SceneConfig.getSceneType() != SceneConfig.KFBZ_BATTLE && SceneConfig.getSceneType() != SceneConfig.CROSS_CAMP_BATTLE)
         {
            player.status = status;
            player.name = name;
         }
         player.paoBiao = paoBiao;
         player.chengHao = chengHao;
         player.sex = sex;
         player.job = job;
         pet = Pet.heroIdList[player.id];
         if(Boolean(pet))
         {
            pet.speed = speed;
         }
         player.zoneId = zoneId;
         player.AiDeBaoBao_partner = partner;
         player.AiDeBaoBao_buff = skillStr.split("_");
         Global.control.sendNotification(Enum_MsgType.UPDATE_AVATER_COMPLETE,player);
      }
      
      public static function GC_DETAIL_INFO(result:int, level:int, hp:int, hpMax:int, mp:int, mpMax:int, vigor:int, maxvigor:int, exp:String, nextExp:String, bingSilver:int, money:int, silver:int, liquan:int, prestige:int, title:Array, minAtt:int, def:int, attRate:int, dod:int, crit:int, repelv:int, attSpeed:int, strength:int, damgr:int, partyId:Number, party:String, vip:int, critv:int, battleTime:int, yeLi:int, christmasScore:int, huangZuan:int, blueZ:int, sanLiuL:int, hasShenBing:int, shenBingAtbs:Array, shenBingSkills:Array, shuXingDanCounts:Array, shuXingDanAtbs:Array) : void
      {
         var add:int = 0;
         var shenBingVo:Vo_ShenBingAtb = null;
         var shuXingDanVo:Vo_shuXingDan = null;
         var hero:Hero = GameUnitManager.hero;
         if(result == 1 && hero.strength != 0)
         {
            add = strength - hero.strength;
            if(add > 0)
            {
               StrengthTip.showADD(hero.strength,add,LangConfig.getWord("346",0) + " ");
            }
            else if(add < 0)
            {
               StrengthTip.showSub(add,LangConfig.getWord("346",0));
            }
         }
         if(result == 1 || result == 2)
         {
            hero.sanLiu = sanLiuL;
            hero.level = level;
            hero.hp = hp;
            hero.hpMax = hpMax;
            hero.mp = mp;
            hero.mpMax = mpMax;
            hero.vigor = vigor;
            hero.huangZuan = huangZuan;
            hero.exp = Number(exp);
            hero.nextexp = Number(nextExp);
            hero.bingSilver = bingSilver;
            hero.money = money;
            hero.silver = silver;
            hero.liquan = liquan;
            hero.prestige = prestige;
            hero.title = title;
            hero.minAtt = minAtt;
            hero.def = def;
            hero.attRate = attRate;
            hero.dod = dod;
            hero.crit = crit;
            hero.critv = critv;
            hero.repelv = repelv;
            hero.attSpeed = attSpeed;
            hero.strength = strength;
            hero.damgr = damgr;
            hero.partyId = partyId;
            hero.party = Model_heFu.repNameByHero(party);
            hero.vip = vip;
            hero.yeLi = yeLi;
            hero.christmasScore = christmasScore;
            UIManager.heroHead.update();
            UIManager.mainMenu.update();
            UIManager.bagPanel.update_attribute(bingSilver,money,liquan,silver);
            if(Boolean(UIManager.treasureChest))
            {
               UIManager.treasureChest.updateMoney(bingSilver + silver);
            }
            shenBingVo = new Vo_ShenBingAtb();
            shenBingVo.type = hasShenBing;
            shenBingVo.atbs = shenBingAtbs;
            shenBingVo.skills = shenBingSkills;
            Model_ShenBing.heroShenBingVO = shenBingVo;
            shuXingDanVo = new Vo_shuXingDan();
            shuXingDanVo.count = shuXingDanCounts;
            shuXingDanVo.atbs = shuXingDanAtbs;
            Model_shuXingDan.heroShuXingDanVo = shuXingDanVo;
            Global.control.sendNotification(Enum_MsgType.ROLE_PAN_UPDATE,null);
            if(result == 2)
            {
               BattleStatusManager.setSelfBattleRun(battleTime);
            }
            Global.control.sendNotification(Enum_Jianghulixian.Jianghulixian_UPDATE_Yueli,null);
            if(UIManager.shenBingPanel.visible)
            {
               UIManager.shenBingPanel.updateShenbingTip();
            }
         }
      }
      
      public static function GC_GET_THING(module:int, thing:Array) : void
      {
         var thingInfo:String = null;
         var discript:String = null;
         var type:int = 0;
         switch(module)
         {
            case Enum_thing_sysType.QUEST:
               UIManager.questDialog.showEff(thing);
               break;
            case Enum_thing_sysType.HERO_QUEST:
               UIManager.questTraceView.showEff(thing);
               break;
            case Enum_thing_sysType.GET_GOODS:
               JiaoYiHandle.GET_GOODS_HANDLE(thing);
               break;
            case Enum_thing_sysType.COLLECT:
               CollectManager.showEff(thing);
         }
         var len:int = int(thing.length);
         var i:int = 0;
         while(i < len)
         {
            type = int(thing[i][0]);
            if(type != Enum_thing_type.EQUIP)
            {
               if(type != Enum_thing_type.ITEM)
               {
                  thingInfo = thing[i][2];
                  if(module != Enum_thing_sysType.BATTLE)
                  {
                     discript = Enum_thing_type.getDiscript(type).replace("&va",thingInfo);
                     UIManager.selfBroadcast.addMsg(discript);
                  }
               }
            }
            i++;
         }
      }
      
      public static function GC_LEVEL_UP(id:Number, level:int) : void
      {
         var player:Player = GameUnitManager.findUnit(id,UnitType.PLAYER) as Player;
         if(Boolean(player))
         {
            player.level = level;
            player.addEffect("35003",false,0,0,1500);
         }
      }
      
      public static function GC_LEVEL_UP_ABB(id:Number, lv:int, power:int, att:int, def:int, maxHp:int, maxMp:int) : void
      {
         var arr:Array = null;
         if(id == GameUnitManager.hero.id)
         {
            GameUnitManager.hero.level = lv;
            _levUpInt = setTimeout(playLevUp,1000);
            arr = [power,att,def,maxHp,maxMp];
            BroadCastHandle.HEROABB(arr);
            Global.control.sendNotification(Enum_MsgType.MSG_LV_UP,lv);
            Global.control.sendNotification(Enum_MsgType.MSG_LV_UP_2,lv);
            Model_DAU.handleLevelUp();
            if(GameUnitManager.hero.level == 110)
            {
               Model_skill.uptoLvlHd();
            }
         }
         if(id == GameUnitManager.hero.id)
         {
            if(UIManager.skillPanel.visible)
            {
               UIManager.skillPanel.update_data();
            }
            CommandManager.inform_hero_lvUp(lv);
            NewPushManager.showNew(lv);
            if(lv >= 30)
            {
               UIManager.mainUiBtnContainer.showTTFBtn();
               if(Global.twoEggs)
               {
                  TwoEggsTip.instance.show();
               }
            }
            showButton(lv);
         }
      }
      
      private static function playLevUp() : void
      {
         clearTimeout(_levUpInt);
         GameUnitManager.hero.addEffect("35003",false,0,0,1500);
      }
      
      public static function GC_CHENGHAO_UPGRADE(result:int) : void
      {
         if(Boolean(result))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10533",1));
            Global.control.sendNotification(Enum_MsgType.ROLE_PAN_UPDATE,null);
         }
      }
      
      public static function GC_SOUND(type:int) : void
      {
         UIManager.heroHead.setSound(type);
      }
   }
}

