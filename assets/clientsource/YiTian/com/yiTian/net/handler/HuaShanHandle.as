package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HuaShanCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import com.yiTian.view.modules.huaShanLunJian.model.Model_HuaShan;
   import com.yiTian.view.modules.huaShanLunJian.util.Enum_HuaShan;
   import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
   import com.yiTian.view.modules.huaShanLunJian.viewer.View_HuaShanBaoMing;
   import com.yiTian.view.modules.huaShanLunJian.viewer.View_HuaShanBubblePanel;
   import com.yiTian.view.modules.huaShanLunJian.viewer.View_HuaShanTaoTai;
   import com.yiTian.view.modules.huaShanLunJian.viewer.View_HuaShanWoDeXiaZhu;
   import com.yiTian.view.modules.huaShanLunJian.viewer.View_HuaShanZhenXing;
   import com.yiTian.view.modules.huaShanLunJian.viewer.View_HuaShanZhuFuPanel;
   import com.yiTian.view.modules.huaShanLunJian.viewer.View_HuaShanZhuFuRank;
   import com.yiTian.view.modules.huaShanLunJian.viewer.View_ShenJiaBangPanel;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class HuaShanHandle
   {
      
      private static var _lastClickTime:int;
      
      public function HuaShanHandle()
      {
         super();
      }
      
      public static function GC_HS_TIPBTNSHOW(type:int) : void
      {
         var model:Model_HuaShan = null;
         var infoStr:String = null;
         switch(type)
         {
            case 1:
               showHSIcon();
               break;
            case 2:
               if(Singleton.hasInstance(Model_HuaShan))
               {
                  model = Singleton.getInstance(Model_HuaShan);
                  if(Boolean(model.tipBtn))
                  {
                     UIManager.mainUiBtnContainer.removeBTN(model.tipBtn);
                     model.tipBtn.dispose();
                     model.tipBtn = null;
                  }
               }
               break;
            case 3:
               infoStr = LangConfig.getWord("29375",2);
               break;
            case 4:
               infoStr = LangConfig.getWord("29376",2);
               break;
            case 5:
               infoStr = LangConfig.getWord("29377",2);
               break;
            case 6:
               infoStr = LangConfig.getWord("29378",2);
               break;
            case 7:
               infoStr = LangConfig.getWord("29379",2);
         }
         if(Boolean(infoStr))
         {
            UIManager.centerBroadcast.addMsg(infoStr);
         }
      }
      
      public static function showHSIcon() : BitmapBtn
      {
         var model:Model_HuaShan = null;
         model = Singleton.getInstance(Model_HuaShan);
         if(!model.tipBtn)
         {
            model.tipBtn = new BitmapBtn();
            model.tipBtn.init(0,0,50,50);
            model.tipBtn.buttonMode = true;
            model.tipBtn.setBgDir(HuaShanUtil.BMTIPBTNDIR);
            model.tipBtn.clickCallBack = tipBtnClickHd;
            UIManager.mainUiBtnContainer.addBTN(model.tipBtn);
         }
         return model.tipBtn;
      }
      
      private static function tipBtnClickHd(event:MouseEvent) : void
      {
         var now:int = getTimer();
         if(now - _lastClickTime >= 3000)
         {
            _lastClickTime = now;
            HuaShanCGMessage.CG_HS_INFO();
         }
      }
      
      public static function GC_HS_INFO(myState:int) : void
      {
         var pnl:View_HuaShanBaoMing = null;
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
         model.matchState = myState;
         pnl = Singleton.getInstance(View_HuaShanBaoMing);
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
         {
            pnl.update();
            pnl.visible = true;
         });
      }
      
      public static function GC_HS_TEAM(teamInfo:Array) : void
      {
         var teamPnl:View_HuaShanZhenXing = null;
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
         model.teamInfo = teamInfo;
         teamPnl = Singleton.getInstance(View_HuaShanZhenXing) as View_HuaShanZhenXing;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(teamPnl,function():void
         {
            teamPnl.update();
            ModalUIManager.POPUP(teamPnl);
         });
      }
      
      public static function GC_HS_RANKS(bangType:int, curPageIndex:int, numMaxPage:int, info:Array) : void
      {
         var pnl:View_HuaShanTaoTai = null;
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         model.phbPageIndex = curPageIndex;
         model.phbMaxPage = numMaxPage;
         pnl = Singleton.getInstance(View_HuaShanTaoTai);
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
         {
            pnl.updateRanks(info);
         });
      }
      
      public static function GC_HS_MATCH_INFO(areaType:int, bangType:int, isOverMatch:int, myBangType:int, myScore:int, remainLife:int, myRank:int, otherInfo:Array, myInfo:Array) : void
      {
         var bClear:Boolean = false;
         var bPlay:Boolean = false;
         var viewer:View_HuaShanTaoTai = null;
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
         bClear = model.bangType != bangType;
         model.type = areaType;
         model.bangType = bangType;
         model.isOverMatch = isOverMatch;
         model.myBangType = myBangType;
         model.curScore = myScore;
         model.remainLife = remainLife;
         model.myCurRank = myRank;
         if(isOverMatch == 1)
         {
            bPlay = true;
         }
         else
         {
            bPlay = false;
            bClear = true;
         }
         viewer = Singleton.getInstance(View_HuaShanTaoTai);
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(viewer,function():void
         {
            viewer.updateType();
            viewer.updateMainLabel();
            viewer.updateMyInfo();
            viewer.updateOtherList(otherInfo,bPlay,bClear);
            viewer.updateGRList(myInfo);
            if(!viewer.visible)
            {
               viewer.visible = true;
            }
         });
      }
      
      public static function GC_HS_UPDATE_TIP(sai:int, bangType:int) : void
      {
         if(!Singleton.hasInstance(Model_HuaShan))
         {
            return;
         }
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
         if(sai == 1 || sai == 2)
         {
            if(!Singleton.hasInstance(View_HuaShanTaoTai))
            {
               return;
            }
            if(!(Singleton.getInstance(View_HuaShanTaoTai) as View_HuaShanTaoTai).visible)
            {
               return;
            }
            if(model.type == sai && model.bangType == bangType)
            {
               HuaShanCGMessage.CG_HS_GET_RANKS_INFO(model.bangType,model.phbPageIndex);
            }
         }
         else if(sai == 3)
         {
            if(!Singleton.hasInstance(View_HuaShanBubblePanel))
            {
               return;
            }
            if(!(Singleton.getInstance(View_HuaShanBubblePanel) as View_HuaShanBubblePanel).visible)
            {
               return;
            }
            HuaShanCGMessage.CG_XUANBAMATCHINFO(model.jie,model.bangType2);
         }
      }
      
      public static function GC_XUANBAMATCHINFO(jie:int, bangType:int, playerInfoArr:Array, matchInfoArr:Array) : void
      {
         var model:Model_HuaShan = null;
         var oldType:int = 0;
         var infos:Array = null;
         var viewer:View_HuaShanBubblePanel = null;
         var info:Array = null;
         var winWay:int = 0;
         model = Singleton.getInstance(Model_HuaShan);
         oldType = model.bangType2;
         model.curPlayerInfoArr = playerInfoArr;
         model.curMatchInfoArr = matchInfoArr;
         model.jie = jie;
         model.bangType2 = bangType;
         for each(infos in matchInfoArr)
         {
            for each(info in infos)
            {
               winWay = HuaShanUtil.getWhoWin(info[Enum_HuaShan.NODE_MATCHRESULTS]);
               info.push(winWay);
            }
         }
         viewer = Singleton.getInstance(View_HuaShanBubblePanel);
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(viewer,function():void
         {
            viewer.updateMatchPlayer();
            if(!viewer.visible)
            {
               viewer.visible = true;
               viewer.playLineShp(0);
            }
            else
            {
               viewer.playLineShp(model.bangType2 - oldType,true);
            }
            viewer.updateBubbleMathViewer();
            viewer.updateNxtInfo();
            viewer.updateBangType();
            viewer.updateJie();
            viewer.uiVisible = true;
         });
      }
      
      public static function GC_MYXUANBABET(jie:int, bangType:int, infos:Array) : void
      {
         var viewer:View_HuaShanWoDeXiaZhu = null;
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
         if(model.jie != jie || model.bangType2 != bangType)
         {
            return;
         }
         viewer = Singleton.getInstance(View_HuaShanWoDeXiaZhu);
         View_HuaShanWoDeXiaZhu.curPlayerInfoArr = model.curPlayerInfoArr;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(viewer,function():void
         {
            viewer.update(bangType,infos);
         });
      }
      
      public static function GC_SHENJIABANG(jie:int, bangType:int, infos:Array) : void
      {
         var i:int;
         var viewer:View_ShenJiaBangPanel = null;
         var needInfos:Array = null;
         var rank:int = 0;
         var roleID:Number = NaN;
         var roleInfo:Array = null;
         var roleName:String = null;
         var value:int = 0;
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
         if(model.jie != jie || model.bangType2 != bangType)
         {
            return;
         }
         viewer = Singleton.getInstance(View_ShenJiaBangPanel);
         needInfos = [];
         i = 0;
         while(i < infos.length)
         {
            rank = i + 1;
            roleID = Number(infos[i][0]);
            roleInfo = HuaShanUtil.finPlayerInfoByID(roleID,model.curPlayerInfoArr);
            roleName = roleInfo[Enum_HuaShan.CONT_ROLENAME];
            value = int(infos[i][1]);
            needInfos.push([rank,roleID,roleName,value]);
            i += 1;
         }
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(viewer,function():void
         {
            viewer.visible = true;
            viewer.update(needInfos);
         });
      }
      
      public static function GC_XUANBABET(result:int) : void
      {
      }
      
      public static function GC_CENTERSERVADDRESS(url:String) : void
      {
         Global.kuafuzhanCenterServAddress = url;
      }
      
      public static function GC_NXTMATCHINFO(nxtTime:int, nxtLun:int, nxtChang:int) : void
      {
         var viewer:View_HuaShanBubblePanel = null;
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
         model.Match32ExtraInfo = [nxtTime,nxtLun,nxtChang];
         viewer = Singleton.getInstance(View_HuaShanBubblePanel);
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(viewer,function():void
         {
            viewer.updateNxtInfo();
         });
      }
      
      public static function GC_BLESS_ROLE(result:int, roleID:Number, blessLV:int, blessStar:int, blessExp:int) : void
      {
         var errorStr:String = null;
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29380",2));
            var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
            var zhufuPnl:View_HuaShanZhuFuPanel = Singleton.getInstance(View_HuaShanZhuFuPanel);
            zhufuPnl.update2(roleID,blessLV,blessStar,blessExp);
            return;
         }
         switch(result)
         {
            case 5:
               errorStr = LangConfig.getWord("29381",2);
               break;
            case 4:
               errorStr = LangConfig.getWord("29446",2);
         }
         if(Boolean(errorStr))
         {
            UIManager.centerBroadcast.addMsg(errorStr);
         }
      }
      
      public static function GC_HS_OPEN_BLESSUI(info:Array) : void
      {
      }
      
      public static function GC_HS_BLESS_RANK(jie:int, bangType:int, infos:Array) : void
      {
         var i:int;
         var viewer:View_HuaShanZhuFuRank = null;
         var needInfos:Array = null;
         var rank:int = 0;
         var roleID:Number = NaN;
         var roleInfo:Array = null;
         var roleName:String = null;
         var areaID:int = 0;
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
         if(model.jie != jie || model.bangType2 != bangType)
         {
            return;
         }
         viewer = Singleton.getInstance(View_HuaShanZhuFuRank);
         needInfos = [];
         i = 0;
         while(i < infos.length)
         {
            rank = i + 1;
            roleID = Number(infos[i][0]);
            roleInfo = HuaShanUtil.finPlayerInfoByID(roleID,model.curPlayerInfoArr);
            roleName = roleInfo[Enum_HuaShan.CONT_ROLENAME];
            areaID = int(roleInfo[Enum_HuaShan.CONT_SERVNAME]);
            needInfos.push([rank,roleID,roleName,areaID,infos[i]]);
            i += 1;
         }
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(viewer,function():void
         {
            viewer.visible = true;
            viewer.update(jie,bangType,needInfos);
         });
      }
      
      public static function GC_HS_MY_BLESSING(jie:int, infos:Array) : void
      {
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
         if(model.jie != jie)
         {
            return;
         }
         model.myZhuFuInfo = infos;
      }
      
      public static function GC_HS_BROADCAST(type:int) : void
      {
         UIManager.actBroadcast.addMsg(HuaShanUtil.tipStrArr[type]);
      }
      
      private static function sorrt(a:Array, b:Array) : int
      {
         if(a[0] < b[0])
         {
            return -1;
         }
         if(a[0] > b[0])
         {
            return 1;
         }
         return 0;
      }
      
      public static function GC_HS_CHAMPION(infos:Array) : void
      {
         infos.sort(sorrt);
         var i:int = 0;
         while(i < infos.length)
         {
            UIManager.actBroadcast.addMsg(LangConfig.getWord("29395",2,infos[i][2],infos[i][3],HuaShanUtil.labelsArr[infos[i][0] - 1]),0,infos[i][0] * 1000 + 4000);
            i += 1;
         }
      }
   }
}

