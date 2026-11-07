package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.vo.Vo_shuXingDan;
   import com.yiTian.data.vo.vo_otherRoleInfo;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModelManager;
   import com.yiTian.manager.OtherRoleManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.newRolePan.ComparePan;
   import com.yiTian.view.modules.newRolePan.RoleMter;
   import com.yiTian.view.modules.newRolePan.View_rolePan;
   import com.yiTian.view.modules.pet.PetEffect;
   import com.yiTian.view.modules.shenBing.Vo_ShenBingAtb;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   
   public class RoleHandler
   {
      
      public function RoleHandler()
      {
         super();
      }
      
      public static function GC_ROLE_PANEL_UPDATE(result:int, equips:Array) : void
      {
         if(result == 1)
         {
            ModelManager.rolePanel.init_vec_equip(equips);
            Utils.print("角色装备数据初始化");
            WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
            {
               pan.update_equip();
            });
         }
         else if(result == 2)
         {
            ModelManager.rolePanel.update_vec_equip(equips);
            WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
            {
               pan.update_equip();
            });
            if(UIManager.castPanel.visible)
            {
               UIManager.castPanel.changeEquipSelf(equips);
            }
            Utils.print("角色装备数据更新");
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("662",0));
         }
         Global.control.sendNotification(Enum_MsgType.ROLE_UPDATE,null);
         Global.control.sendNotification(Enum_MsgType.ROLE_PAN_UPDATE,null);
      }
      
      public static function GC_ROLE_PANEL_EMPTY(result:int, gridId:int) : void
      {
         if(result == 1)
         {
            ModelManager.rolePanel.empty_grid(gridId);
            if(UIManager.castPanel.visible)
            {
               UIManager.castPanel.update_role_emp(gridId);
            }
            WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
            {
               pan.update_equip();
            });
            Global.control.sendNotification(Enum_MsgType.ROLE_UPDATE,null);
            Utils.print("清空角色装备格子  ",gridId);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("663",0));
         }
      }
      
      public static function GC_MERIDIAN_UP(result:int, meridianID:int) : void
      {
         var pan:View_rolePan = null;
         if(result == 1)
         {
            ModelManager.rolePanel.update_vec_meridian(meridianID);
            PetEffect.getInstance().play(PetEffect.DTJM);
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("664",0));
            Global.control.sendNotification(Enum_MsgType.BAG_UPDATE,null);
            if(GameUnitManager.hero.level < 30)
            {
               pan = Singleton.getInstance(View_rolePan);
               if(pan.visible)
               {
                  pan.visible = false;
               }
            }
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("665",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("666",0));
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("667",0));
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("668",0));
         }
         else if(result == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("669",0));
         }
         else if(result == 7)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("8",0));
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("670",0));
         }
      }
      
      public static function GC_MERIDIAN_PILL(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("671",0));
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("672",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("444",0));
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("673",0));
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("8",0));
         }
         else if(result == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("670",0));
         }
      }
      
      public static function GC_MERIDIAN_INIT(result:int, vec:Vector.<int>) : void
      {
         if(result == 1)
         {
            ModelManager.rolePanel.init_vec_meridian(vec);
            Global.control.sendNotification(Enum_MsgType.BAG_UPDATE,null);
            Utils.print("经脉初始化完毕");
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("723",0));
         }
      }
      
      public static function GC_CHECK_OTHERROLE(roleId:Number, roleName:String, roleLevel:int, roleJob:int, roleSex:int, rolePartyName:String, roleShengWang:int, strength:int, physAtt:int, physDef:int, shot:int, escape:int, critical:int, critHeat:int, repel:int, attSpeed:int, vipLevel:int, hp:int, maxHp:int, mp:int, maxMp:int, tili:int, appellation:String, equips:Array, ringId:int, qinmiDu:int, stoneLvl:int, isOnLine:int, voVec:Vector.<Array>, levelTen:int, levelSix:int, levelSixNums:int, level:int, nums:int, vec:Vector.<int>, body:int, weapon:int, horse:int, dataArr:Array, chengHao:int, shenBingLevel:int, shenBingAtbs:Array, shenBingSkills:Array, shuXingDanCounts:Array, shuXingDanAtbs:Array, cpl_otherName:String, wing:int) : void
      {
         var shenBingVo:Vo_ShenBingAtb;
         var shuXingDanVo:Vo_shuXingDan;
         var otherRoleVo:vo_otherRoleInfo = null;
         otherRoleVo = new vo_otherRoleInfo();
         otherRoleVo.roleId = roleId;
         otherRoleVo.roleName = roleName;
         otherRoleVo.roleLevel = roleLevel;
         otherRoleVo.roleJob = roleJob;
         otherRoleVo.roleSex = roleSex;
         otherRoleVo.rolePartyName = rolePartyName;
         otherRoleVo.roleShengWang = roleShengWang;
         otherRoleVo.strength = strength;
         otherRoleVo.physAtt = physAtt;
         otherRoleVo.physDef = physDef;
         otherRoleVo.shot = shot;
         otherRoleVo.escape = escape;
         otherRoleVo.critical = critical;
         otherRoleVo.critHeat = critHeat;
         otherRoleVo.repel = repel;
         otherRoleVo.attSpeed = attSpeed;
         otherRoleVo.vipLevel = vipLevel;
         otherRoleVo.hp = hp;
         otherRoleVo.maxHp = maxHp;
         otherRoleVo.mp = mp;
         otherRoleVo.maxMp = maxMp;
         otherRoleVo.tili = tili;
         otherRoleVo.appellation = appellation;
         otherRoleVo.equipArr = equips;
         otherRoleVo.ringId = ringId;
         otherRoleVo.stoneLvl = stoneLvl;
         otherRoleVo.qinmiDu = qinmiDu;
         otherRoleVo.isOnLine = isOnLine;
         otherRoleVo.voVec = voVec;
         otherRoleVo.levelTen = levelTen;
         otherRoleVo.level = level;
         otherRoleVo.levelSix = levelSix;
         otherRoleVo.levelSixNums = levelSixNums;
         otherRoleVo.nums = nums;
         otherRoleVo.vec = vec;
         otherRoleVo.body = body;
         otherRoleVo.weapon = weapon;
         otherRoleVo.horse = horse;
         otherRoleVo.wing = wing;
         otherRoleVo.dataArr = dataArr;
         otherRoleVo.chengHao = chengHao;
         otherRoleVo.couple_other_name = cpl_otherName;
         OtherRoleManager.ins.addInfo(otherRoleVo);
         shenBingVo = new Vo_ShenBingAtb();
         shenBingVo.type = shenBingLevel;
         shenBingVo.atbs = shenBingAtbs;
         shenBingVo.skills = shenBingSkills;
         otherRoleVo.shenBingVo = shenBingVo;
         shuXingDanVo = new Vo_shuXingDan();
         shuXingDanVo.count = shuXingDanCounts;
         shuXingDanVo.atbs = shuXingDanAtbs;
         otherRoleVo.shuXingDan = shuXingDanVo;
         WuXingMter.getPan(ComparePan,function(pan:ComparePan):void
         {
            pan.update(otherRoleVo);
         });
      }
      
      public static function GC_STRENGTHEN_SET(levelTen:int, levelSix:int, levelSixNums:int, level:int, nums:int) : void
      {
         RoleMter.strengthenSet(levelTen,levelSix,levelSixNums,level,nums);
      }
      
      public static function GC_ROLE_FASHION(a:Array, atbs:Array) : void
      {
         var map:Object = null;
         var i:int = 0;
         map = {};
         for each(i in a)
         {
            map[i] = true;
         }
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            pan.updateFaShionShow(map,atbs);
         });
      }
      
      public static function GC_LIGHT_FASHION(result:int, type:int) : void
      {
         var map:Object = null;
         if(result == 1)
         {
            WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
            {
               map = pan.getFaShionLightMap();
               map[type] = true;
               pan.updateLigth(map);
            });
            return;
         }
         if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29453",2));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29454",2));
         }
      }
   }
}

