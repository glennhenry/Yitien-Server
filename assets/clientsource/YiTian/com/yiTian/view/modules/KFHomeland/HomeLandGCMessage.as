package com.yiTian.view.modules.KFHomeland
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.KFHomeland.KFHomeTuoZhan.TipPan;
   import com.yiTian.view.modules.KFHomeland.KFHomeTuoZhan.View_GetDanQiPan;
   import com.yiTian.view.modules.KFHomeland.KFHomeTuoZhan.Vo_TipPan;
   import com.yiTian.view.modules.crossClanBattle.Enum_CrossClanBattle;
   import com.yiTian.view.modules.crossClanBattle.Model_CrossClanBattle;
   import com.yiTian.view.modules.pet.PetVO;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class HomeLandGCMessage
   {
      
      public static var roleId:Number;
      
      public static var type:int;
      
      public static var zone:int;
      
      private static var eff:Effect;
      
      private var isHighLight:Boolean = false;
      
      public function HomeLandGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_HOME_ACTIVITY] = this.GC_HOME_ACTIVITY;
         index[MessageType.GC_HOME_SOCKET] = this.GC_HOME_SOCKET;
         index[MessageType.GC_OWNER_HOMELAND] = this.GC_OWNER_HOMELAND;
         index[MessageType.GC_BUY_HOMELAND] = this.GC_BUY_HOMELAND;
         index[MessageType.GC_ENTER_HOMELAND] = this.GC_ENTER_HOMELAND;
         index[MessageType.GC_OUT_HOMELAND] = this.GC_OUT_HOMELAND;
         index[MessageType.GC_INNER_HOMELAND] = this.GC_INNER_HOMELAND;
         index[MessageType.GC_BUILD_HOMELAND] = this.GC_BUILD_HOMELAND;
         index[MessageType.GC_VISIT_OUT_HOMELAND] = this.GC_VISIT_OUT_HOMELAND;
         index[MessageType.GC_SURE_BUILDING] = this.GC_SURE_BUILDING;
         index[MessageType.GC_DISMANTLE] = this.GC_DISMANTLE;
         index[MessageType.GC_BUY_SKIN] = this.GC_BUY_SKIN;
         index[MessageType.GC_USE_SKIN] = this.GC_USE_SKIN;
         index[MessageType.GC_ENTER_MALL] = this.GC_ENTER_MALL;
         index[MessageType.GC_REFRESH_MALL] = this.GC_REFRESH_MALL;
         index[MessageType.GC_BUY_MALL] = this.GC_BUY_MALL;
         index[MessageType.GC_ATTRIBUTE_HOMELAND] = this.GC_ATTRIBUTE_HOMELAND;
         index[MessageType.GC_CLEAN_HOMELAND] = this.GC_CLEAN_HOMELAND;
         index[MessageType.GC_FIRENDLIST_HOMELAND] = this.GC_FIRENDLIST_HOMELAND;
         index[MessageType.GC_EXIT_HOMELAND] = this.GC_EXIT_HOMELAND;
         index[MessageType.GC_GLOBAL_TEAM_VISITHOME] = this.GC_GLOBAL_TEAM_VISITHOME;
         index[MessageType.GC_LOCAL_TEAM_VISITHOME] = this.GC_LOCAL_TEAM_VISITHOME;
         index[MessageType.GC_REFRESH_HOMECURR] = this.GC_REFRESH_HOMECURR;
         index[MessageType.GC_INTRODUCE_HOME] = this.GC_INTRODUCE_HOME;
         index[MessageType.GC_START_BUILD] = this.GC_START_BUILD;
         index[MessageType.GC_CONTROL_ICON] = this.GC_CONTROL_ICON;
         index[MessageType.GC_ASK_GETGOODS] = this.GC_ASK_GETGOODS;
         index[MessageType.GC_ASK_SURE_GET] = this.GC_ASK_SURE_GET;
         index[MessageType.GC_UPDE_DANQI_COUNTS] = this.GC_UPDE_DANQI_COUNTS;
         index[MessageType.GC_CANNOT_USE_DANQI] = this.GC_CANNOT_USE_DANQI;
      }
      
      private function GC_HOME_ACTIVITY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         VoHome.heroS = patch.readInt();
         if(result == 1)
         {
            VoHome.isActivity = true;
         }
         else
         {
            VoHome.isActivity = false;
         }
         if(GameUnitManager.hero.level >= HomeLandBtn.LowHomeBtnLevel && VoHome.isActivity)
         {
            HomeLandBtn.instance.addBtn(true);
         }
      }
      
      private function GC_HOME_SOCKET(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            if(!Model_team.hasTeam())
            {
               if(GameUnitManager.hero.captainId == 0)
               {
                  Utils.print("参观好友家园的 好友 区号           " + zone);
                  HomeLandCGMessage.CG_ENTER_HOMELAND(roleId,type,zone);
               }
            }
         }
      }
      
      public function GC_OWNER_HOMELAND(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         VoHome.isCreatHome = result;
      }
      
      public function GC_BUY_HOMELAND(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30151",3));
               HomeLandBtn.instance.hideSmpleHome();
               HomeLandBtn.instance.enterHome();
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30152",3));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30153",3));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30154",3));
               break;
            case 5:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30155",3));
         }
      }
      
      public function GC_ENTER_HOMELAND(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30156",3));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30157",3));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30158",3));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30159",3));
               break;
            case 5:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30160",3));
               break;
            case 6:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30161",3));
               break;
            case 7:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30162",3));
               break;
            case 8:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30163",3),1);
               break;
            case 9:
               UIManager.centerBroadcast.addMsg("好友还没有家园");
               break;
            case 13:
               UIManager.centerBroadcast.addMsg("当前家园进入人数已满，请稍后在进",1);
         }
         if(result != 9)
         {
            Model_CrossClanBattle.port = 0;
            SocketManager.setChangeSocketFun(false);
            SocketManager.setKuafuSocketFun(false);
         }
      }
      
      public function GC_OUT_HOMELAND(patch:IDataInput) : void
      {
         var buildingId:int = 0;
         var xGrid:int = 0;
         var yGrid:int = 0;
         var orien:int = 0;
         var name:String = patch.readUTF();
         if(Boolean(VoHome.outHomeBuildInfoArr) && VoHome.outHomeBuildInfoArr.length > 0)
         {
            VoHome.outHomeBuildInfoArr.length = 0;
         }
         VoHome.isMyHome = patch.readByte();
         var skinId:int = patch.readInt();
         VoHome.visitHomeRoleId = LongUtil.readLong(patch);
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            buildingId = patch.readInt();
            xGrid = patch.readInt();
            yGrid = patch.readInt();
            orien = patch.readByte();
            arr.push([buildingId,xGrid,yGrid,orien]);
            i++;
         }
         VoHome.outHomeBuildInfoArr = arr;
         EnterHomeControl.instance.updateHomeBuild(name);
      }
      
      public function GC_INNER_HOMELAND(patch:IDataInput) : void
      {
         var buildingId:int = 0;
         var xGrid:Number = NaN;
         var yGrid:Number = NaN;
         var orien:int = 0;
         var name:String = patch.readUTF();
         if(Boolean(VoHome.innerHomeBuildInfoArr) && VoHome.innerHomeBuildInfoArr.length > 0)
         {
            VoHome.innerHomeBuildInfoArr.length = 0;
         }
         VoHome.isMyHome = patch.readByte();
         var skinId:int = patch.readInt();
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            buildingId = patch.readInt();
            xGrid = patch.readInt();
            yGrid = patch.readInt();
            orien = patch.readByte();
            arr.push([buildingId,xGrid,yGrid,orien]);
            i++;
         }
         VoHome.innerHomeBuildInfoArr = arr;
         EnterHomeControl.instance.updateHomeBuild(name);
      }
      
      public function GC_BUILD_HOMELAND(patch:IDataInput) : void
      {
         var info:InfoItemBuildings = null;
         VoHome.isOut = patch.readByte();
         var type:int = patch.readByte();
         var len:int = patch.readByte();
         var arr:Vector.<InfoItemBuildings> = new Vector.<InfoItemBuildings>();
         var i:int = 0;
         while(i < len)
         {
            info = new InfoItemBuildings();
            info.id = patch.readInt();
            if(type != 0)
            {
               info.num = patch.readInt();
            }
            else
            {
               info.leftTime = patch.readInt();
            }
            arr.push(info);
            i++;
         }
         EnterHomeControl.instance.sortBuild.updateServer(type,arr);
      }
      
      public function GC_VISIT_OUT_HOMELAND(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30164",3));
               SortBuildings.startBuildHome();
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30165",3),1);
               EnterHomeControl.instance.exitHomeLand();
               Model_CrossClanBattle.port = 0;
               SocketManager.setChangeSocketFun(false);
               SocketManager.setKuafuSocketFun(false);
         }
      }
      
      public function GC_SURE_BUILDING(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30166",3));
               BuildAction.instance.sureLayToHome();
               break;
            case 2:
               BuildAction.instance.canelBuilding();
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30167",3));
               break;
            case 3:
               BuildAction.instance.canelBuilding();
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30168",3));
               break;
            case 4:
               BuildAction.instance.canelBuilding();
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30169",3));
               break;
            case 5:
               BuildAction.instance.canelBuilding();
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30170",3));
         }
      }
      
      public function GC_DISMANTLE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 0:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30171",3));
               EnterHomeControl.instance.sureDismanle();
               break;
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30172",3));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30173",3));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30174",3));
         }
      }
      
      public function GC_BUY_SKIN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var _sId:int = patch.readInt();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30175",3));
               HomeLandCGMessage.CG_USE_SKIN(_sId);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30176",3));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30177",3));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30178",3));
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("该皮肤已经在使用当中");
         }
      }
      
      public function GC_USE_SKIN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var _sId:int = patch.readInt();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30179",3));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30180",3));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30181",3));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("亲，外院的皮肤只能在外院使用。");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("亲,内屋的皮肤只能在内屋使用。");
         }
      }
      
      public function GC_ENTER_MALL(patch:IDataInput) : void
      {
         var id:int = 0;
         var buy:int = 0;
         var status:int = 0;
         var _mallData:Object = new Object();
         _mallData.leftRefresh = patch.readInt();
         _mallData.yunbao = LongUtil.readLong(patch);
         _mallData.homeMoney = LongUtil.readLong(patch);
         _mallData.silver = LongUtil.readLong(patch);
         _mallData.bindSilver = LongUtil.readLong(patch);
         var len:int = patch.readByte();
         var goodsInfoArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            id = patch.readInt();
            buy = patch.readByte();
            status = patch.readByte();
            goodsInfoArr.push([id,buy,status]);
            i++;
         }
         _mallData.goodsInfoArr = goodsInfoArr;
         HomeSpecialMall.instance.update(_mallData);
      }
      
      public function GC_REFRESH_MALL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30182",3));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30183",3));
         }
      }
      
      public function GC_BUY_MALL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30184",3));
               HomeSpecialMall.instance.flyToSortBag();
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30185",3));
               break;
            case 16:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30186",3));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30187",3));
               break;
            case 45:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30231",3));
               break;
            case 18:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30232",3));
               break;
            case 29:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30232",3));
         }
      }
      
      public function GC_ATTRIBUTE_HOMELAND(patch:IDataInput) : void
      {
         VoHome.boom = patch.readInt();
         VoHome.clean = patch.readInt();
         VoHome.homeMoney = LongUtil.readLong(patch);
         VoHome.dismantSymbol = patch.readInt();
         EnterHomeControl.instance.attBar.update();
      }
      
      public function GC_CLEAN_HOMELAND(patch:IDataInput) : void
      {
         var needCleanFee:Number = NaN;
         var result:int = 0;
         var type:int = patch.readByte();
         if(type == 1)
         {
            needCleanFee = LongUtil.readLong(patch);
            View_Alert.show(LangConfig.getWord("30213",3,needCleanFee),View_Alert.OK_CANCAL,function(evt:MouseEvent):void
            {
               HomeLandCGMessage.CG_CLEAN_HOMELAND(2);
            });
         }
         else if(type == 2)
         {
            result = patch.readByte();
            switch(result)
            {
               case 1:
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("30188",3));
                  break;
               case 2:
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("30189",3));
                  break;
               case 3:
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("30190",3));
                  break;
               case 4:
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("30191",3));
            }
         }
      }
      
      public function GC_FIRENDLIST_HOMELAND(patch:IDataInput) : void
      {
         var friInfobj:Object = null;
         var type:int = patch.readByte();
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            friInfobj = new Object();
            friInfobj.nameFri = patch.readUTF();
            friInfobj.jobFri = patch.readByte();
            friInfobj.sexFri = patch.readByte();
            friInfobj.roleId = LongUtil.readLong(patch);
            friInfobj.roleZone = patch.readInt();
            friInfobj.hasHome = patch.readByte();
            arr.push(friInfobj);
            i++;
         }
         EnterHomeControl.instance.visiteFriHome.update(type,arr);
      }
      
      public function GC_EXIT_HOMELAND(patch:IDataInput) : void
      {
         EnterHomeControl.instance.exitHomeLand();
         TipPan.instance.removeIcon();
         if(View_GetDanQiPan.instance.visible)
         {
            View_GetDanQiPan.instance.visible = false;
         }
         Model_CrossClanBattle.port = 0;
         SocketManager.setChangeSocketFun(false);
         SocketManager.setKuafuSocketFun(false);
         CrossClanBattleCGMessage.CG_KUAFUCLAN_BATTLE_CHANGE_SOCKET(Enum_CrossClanBattle.NEED_LOAD);
      }
      
      public function GC_GLOBAL_TEAM_VISITHOME(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var roleName:String = patch.readUTF();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30192",3));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30193",3));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30194",3));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30195",3,roleName));
               break;
            case 5:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30196",3,roleName));
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("组队状态下不能参观好友家园");
         }
      }
      
      public function GC_LOCAL_TEAM_VISITHOME(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30197",3));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30198",3));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30199",3));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30200",3));
               break;
            case 5:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30201",3));
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("亲，有队员没有家园，队伍不能参观家园");
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("亲，有队员等级不够。");
         }
      }
      
      public function GC_REFRESH_HOMECURR(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var owNum:int = LongUtil.readLong(patch);
         HomeSpecialMall.instance.refreshCurrery(type,owNum);
      }
      
      public function GC_INTRODUCE_HOME(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            IntroduceHome.isFly = true;
            EnterHomeControl.instance.introduceH.visible = true;
         }
         else if(result == 2)
         {
            EnterHomeControl.instance.addIntrBtn(true);
         }
      }
      
      public function GC_START_BUILD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            View_Alert.show(LangConfig.getWord("30224",3),View_Alert.OK_CANCAL,function(evt:MouseEvent):void
            {
               HomeLandCGMessage.CG_VISIT_OUT_HOMELAND();
            });
         }
         else if(result == 2)
         {
            SortBuildings.startBuildHome();
         }
      }
      
      public function GC_CONTROL_ICON(patch:IDataInput) : void
      {
         var str:String = patch.readUTF();
         var arr:Array = str.split("_");
         var i:int = 0;
         while(i < arr.length)
         {
            if(arr[i] == 1 || arr[i] == 2)
            {
               Vo_TipPan.isCanGet = true;
               break;
            }
            i += 1;
         }
         Vo_TipPan.tiLi = arr[0];
         Vo_TipPan.danQi = arr[1];
         if(Vo_TipPan.tiLi == 1 || Vo_TipPan.danQi == 1)
         {
            if(Boolean(HomeLandBtn.instance._btn))
            {
               if(!eff)
               {
                  eff = EffectManager.addEffect("35343",HomeLandBtn.instance._btn,1000,32,29,true);
               }
            }
         }
         TipPan.instance.showIcon();
      }
      
      private function removeEff() : void
      {
         if(Boolean(eff))
         {
            EffectManager.removeEffect(eff);
            eff = null;
         }
      }
      
      public function GC_ASK_GETGOODS(patch:IDataInput) : void
      {
         var type:int = 0;
         var str:String = null;
         type = patch.readByte();
         var count:int = patch.readInt();
         Vo_TipPan.count = count;
         str = "";
         if(type == 1)
         {
            str = "<font color=\'#ffffff\'>" + "是否领取" + "</font>" + "<font color=\'#f9ff00\'>" + count.toString() + "体力" + "</font>" + "<font color=\'#ffffff\'>" + "（最多领1000体力）\n" + "</font>" + "<font color=\'#f4cd31\'>" + "体力=50+繁荣度/500（向下取整）*25" + "</font>\n" + "";
         }
         UIManager.storeTip.visible = true;
         UIManager.storeTip.update(987654,type,-100,1,1,1,1,str);
      }
      
      public function GC_ASK_SURE_GET(patch:IDataInput) : void
      {
         var tp:TipPan = TipPan.instance;
         var type:int = patch.readByte();
         var result:int = patch.readByte();
         if(type == 1)
         {
            switch(result)
            {
               case 1:
                  UIManager.centerBroadcast.addMsg("亲，领取体力后将溢出，请先用些体力");
                  break;
               case 2:
                  UIManager.centerBroadcast.addMsg("亲，你今天已领取过家园体力奖励");
                  break;
               case 3:
                  UIManager.centerBroadcast.addMsg("亲，你还没有家园，赶快买一个");
                  break;
               case 4:
                  UIManager.centerBroadcast.addMsg("恭喜您在家园领取了" + Vo_TipPan.count.toString() + "点体力",1);
                  tp.dispose();
                  Vo_TipPan.isCanGet = false;
                  Vo_TipPan.tiLi = 0;
                  tp.show();
                  tp.removeIcon();
                  tp.showIcon();
            }
         }
         else if(type == 2)
         {
            switch(result)
            {
               case 1:
                  UIManager.centerBroadcast.addMsg("宠物内丹还没进阶到尊丹,不能领取",1);
                  break;
               case 2:
                  UIManager.centerBroadcast.addMsg("今天已领取过家园丹气奖励");
                  break;
               case 3:
                  UIManager.centerBroadcast.addMsg("家园繁荣度未达到要求");
                  break;
               case 4:
                  UIManager.centerBroadcast.addMsg("家园币不足，无法领取");
                  break;
               case 5:
                  tp.dispose();
                  Vo_TipPan.isCanGet = false;
                  Vo_TipPan.danQi = 0;
                  tp.show();
                  tp.removeIcon();
                  tp.showIcon();
                  View_GetDanQiPan.instance.visible = false;
                  UIManager.centerBroadcast.addMsg("恭喜您在家园领取了" + Vo_TipPan.count.toString() + "点丹气",1);
                  break;
               case 6:
                  UIManager.centerBroadcast.addMsg("元宝不足，无法领取");
            }
         }
         trace(Vo_TipPan.tiLi,Vo_TipPan.danQi,"vo_tipPan");
         if(Vo_TipPan.tiLi == 0 && Vo_TipPan.danQi != 1)
         {
            this.removeEff();
         }
      }
      
      public function GC_CANNOT_USE_DANQI(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var count:int = patch.readInt();
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("亲，你的宠物内丹还没进阶到尊丹,不可使用",1);
         }
         else if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("恭喜您获得了" + count.toString() + "点丹气值",1);
         }
      }
      
      public function GC_UPDE_DANQI_COUNTS(patch:IDataInput) : void
      {
         var counts:int = patch.readInt();
         PetVO.danQiCount = counts;
         UIManager.petPanel.update();
      }
   }
}

