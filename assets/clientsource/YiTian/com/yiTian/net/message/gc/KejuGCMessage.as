package com.yiTian.net.message.gc
{
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_KeJu;
   import com.yiTian.data.model.Model_KeJu;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.Magic;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.CollectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.net.message.cg.KejuCGMessage;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.keJu.Keju_DSBtn;
   import com.yiTian.view.modules.keJu.Keju_XSBtn;
   import com.yiTian.view.modules.keJu.MyInfoVO;
   import com.yiTian.view.modules.keJu.RankVO;
   import com.yiTian.view.modules.keJu.View_DS_Introduce;
   import com.yiTian.view.modules.keJu.View_KeJuReward;
   import com.yiTian.view.modules.keJu.View_Keju;
   import com.yiTian.view.modules.keJu.View_KejuBroadcast;
   import com.yiTian.view.modules.keJu.View_Poems;
   import com.yiTian.view.modules.keJu.View_PoemsRank;
   import com.yiTian.view.modules.keJu.View_XS_Introduce;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class KejuGCMessage
   {
      
      public function KejuGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_JOINKEJU] = this.GC_JOINKEJU;
         index[MessageType.GC_ASKQUESTION] = this.GC_ASKQUESTION;
         index[MessageType.GC_RANKLIST] = this.GC_RANKLIST;
         index[MessageType.GC_MYKEJUINFO] = this.GC_MYKEJUINFO;
         index[MessageType.GC_ENTER_KEJU] = this.GC_ENTER_KEJU;
         index[MessageType.GC_CATCHEND] = this.GC_CATCHEND;
         index[MessageType.GC_SHOWKEJU_ICON] = this.GC_SHOWKEJU_ICON;
         index[MessageType.GC_CATCHICE] = this.GC_CATCHICE;
         index[MessageType.GC_KEJUROLL] = GC_KEJUROLL;
         index[MessageType.GC_GETKEJU_REWARD] = GC_GETKEJU_REWARD;
         index[MessageType.GC_SHOWKEJU_BTN] = GC_SHOWKEJU_BTN;
         index[MessageType.GC_ANSWERTIMEOUT] = GC_ANSWERTIMEOUT;
         index[MessageType.GC_USE_CAISHEN] = GC_USE_CAISHEN;
         index[MessageType.GC_TOOLSNUM] = GC_TOOLSNUM;
         index[MessageType.GC_SHOW_REWARD] = GC_SHOW_REWARD;
         index[MessageType.GC_POEMSRANK] = GC_POEMSRANK;
         index[MessageType.GC_QUIT_KEJU] = GC_QUIT_KEJU;
         index[MessageType.GC_CHANGKEJU] = GC_CHANGKEJU;
         index[MessageType.GC_POEMS_ANSWER] = GC_POEMS_ANSWER;
         index[MessageType.GC_UPDATA_POEMS_MAP] = GC_UPDATA_POEMS_MAP;
      }
      
      private static function GC_UPDATA_POEMS_MAP(patch:IDataInput) : void
      {
         View_Poems.instance.showBox();
         if(Boolean(CollectManager.npc) && CollectManager.isCollecting)
         {
            CollectManager.end();
         }
      }
      
      private static function GC_POEMS_ANSWER(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80001",8));
            View_Alert.show(LangConfig.getWord("80002",8),View_Alert.OK,function():void
            {
               KejuCGMessage.CG_QUIT_KEJU(1);
            });
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80003",8));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80042",8));
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80043",8));
         }
      }
      
      private static function GC_CHANGKEJU(patch:IDataInput) : void
      {
         var npcId:int = 0;
         View_Keju.instance.stopChangQuestion();
         npcId = patch.readInt();
         View_Keju.instance.hideFun = function():void
         {
            View_Keju.instance.visible = false;
            GameUnitManager.hero.autoMove(npcId);
         };
      }
      
      private static function GC_QUIT_KEJU(patch:IDataInput) : void
      {
         View_Poems.instance.visible = false;
         View_PoemsRank.instance.visible = false;
         View_DS_Introduce.instance.visible = false;
         UIManager.questTraceView.visible = true;
         if(Boolean(CollectManager.npc) && CollectManager.isCollecting)
         {
            CollectManager.end();
         }
      }
      
      private static function GC_POEMSRANK(patch:IDataInput) : void
      {
         var vo:RankVO = null;
         var myTime:Number = patch.readInt();
         var leng:int = patch.readInt();
         Model_KeJu.poemsRankArr.length = 0;
         var i:int = 0;
         while(i < leng)
         {
            vo = new RankVO();
            vo.name = patch.readUTF();
            vo.scores = patch.readInt();
            vo.time = patch.readInt();
            Model_KeJu.poemsRankArr.push(vo);
            i++;
         }
         View_PoemsRank.instance.updata();
         View_PoemsRank.instance.changInfo(myTime);
      }
      
      private static function GC_SHOW_REWARD(patch:IDataInput) : void
      {
         var num:int = 0;
         var vo:MyInfoVO = null;
         var result:int = patch.readByte();
         if(result == 1)
         {
            Model_KeJu.version = 1;
            num = patch.readInt();
            vo = new MyInfoVO();
            vo.count = patch.readInt();
            vo.num = patch.readInt();
            vo.time = patch.readInt();
            View_Keju.instance.hideFun = function():void
            {
               View_Keju.instance.visible = false;
               View_KeJuReward.instance.show(num,vo);
            };
         }
      }
      
      private static function GC_TOOLSNUM(patch:IDataInput) : void
      {
         var luckyNum:int = patch.readInt();
         var caishenNum:int = patch.readInt();
         View_Keju.instance.changTools(caishenNum,luckyNum);
      }
      
      private static function GC_USE_CAISHEN(patch:IDataInput) : void
      {
         var answerNum:int = 0;
         var result:int = patch.readByte();
         if(result == 1)
         {
            answerNum = patch.readInt();
            View_Keju.instance.getAnswer(answerNum);
            View_KejuBroadcast.instance.addMsg(LangConfig.getWord("80055",8));
            View_Keju.instance.luckyStar.dispose(false);
            View_Keju.instance.caishenStar.dispose(false);
         }
         else if(result == 2)
         {
            View_KejuBroadcast.instance.addMsg(LangConfig.getWord("80005",8));
         }
         else if(result == 3)
         {
            View_KejuBroadcast.instance.addMsg(LangConfig.getWord("80006",8));
         }
      }
      
      private static function GC_ANSWERTIMEOUT(patch:IDataInput) : void
      {
         var exp:int = 0;
         var scorse:int = 0;
         var result:int = patch.readByte();
         if(result == 1)
         {
            exp = patch.readInt();
            scorse = patch.readInt();
            View_KejuBroadcast.instance.addMsg(LangConfig.getWord("80008",8,exp));
            View_KejuBroadcast.instance.addMsg(LangConfig.getWord("80009",8,scorse));
            View_Keju.instance.addScoresFly();
            View_Keju.instance.playEff(1);
         }
         else
         {
            View_Keju.instance.playEff(2);
         }
      }
      
      private static function GC_SHOWKEJU_BTN(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         if(type == 1)
         {
            Keju_XSBtn.instance.show();
         }
         else if(type == 3)
         {
            Model_actDaily.getInstance().updateAct(10,true);
            UIManager.smallMap.addTip(0);
            Keju_XSBtn.instance.canJoin(true);
         }
         else
         {
            Keju_XSBtn.instance.hide();
            View_Keju.instance.visible = false;
            Model_actDaily.getInstance().updateAct(10,false);
            UIManager.smallMap.removeTip(0);
         }
      }
      
      private static function GC_GETKEJU_REWARD(patch:IDataInput) : void
      {
      }
      
      private static function GC_KEJUROLL(patch:IDataInput) : void
      {
         var version:int = patch.readByte();
         var num:int = patch.readInt();
         Model_KeJu.version = version;
         var tmp:String = num.toString();
         var arr:Array = [];
         while(Boolean(tmp.length))
         {
            arr.push(int(tmp.substr(0,1)));
            tmp = tmp.substr(1);
         }
         Model_KeJu.lqNum = num;
         View_KeJuReward.instance.roll(arr);
      }
      
      private function GC_SHOWKEJU_ICON(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         if(type == 1)
         {
            Keju_DSBtn.instance.show();
         }
         else if(type == 2)
         {
            Keju_DSBtn.instance.hide();
            if(Global.sceneID == 12305)
            {
               View_Alert.show(LangConfig.getWord("80011",8),View_Alert.OK,function():void
               {
                  KejuCGMessage.CG_QUIT_KEJU(2);
                  View_Poems.instance.dispose();
               });
               return;
            }
            View_Poems.instance.dispose();
         }
      }
      
      private function GC_CATCHICE(patch:IDataInput) : void
      {
         var iceId:int = 0;
         var npc:Npc = null;
         var result:int = patch.readByte();
         if(result == 1)
         {
            iceId = patch.readInt();
            npc = Npc.getNpcBySysid(iceId);
            if(!npc)
            {
               return;
            }
            CollectManager.begin(npc);
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80012",8));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80043",8));
         }
      }
      
      private function GC_CATCHEND(patch:IDataInput) : void
      {
         var iceId:int = 0;
         var ice:Npc = null;
         var point:Point = null;
         var gameUnit:Magic = null;
         var result:int = patch.readByte();
         if(result == 1)
         {
            iceId = patch.readInt();
            if(Model_KeJu.poemsIndexArr.indexOf(iceId) != -1)
            {
               return;
            }
            ice = Npc.getNpcBySysid(iceId + 56957 - 1);
            if(!ice)
            {
               return;
            }
            point = new Point(ice.global_x,ice.global_y);
            View_Poems.instance.go(iceId,point);
            gameUnit = GameUnitManager.getUnit(UnitType.MAGIC) as Magic;
            gameUnit.init(iceId,ice.global_x - 15,ice.global_y,30,false,35102,3000);
            GameUnitManager.addUnit(gameUnit);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80013",8));
         }
      }
      
      private function GC_ENTER_KEJU(patch:IDataInput) : void
      {
         var num:int = 0;
         View_DS_Introduce.instance.visible = true;
         View_PoemsRank.instance.visible = true;
         UIManager.questTraceView.visible = false;
         var poemsID:int = patch.readInt();
         var leng:int = patch.readInt();
         Model_KeJu.poemsIndexArr.length = 0;
         var i:int = 0;
         while(i < leng)
         {
            num = patch.readInt();
            Model_KeJu.poemsIndexArr.push(num);
            i++;
         }
         View_Poems.instance.init(poemsID);
      }
      
      private function GC_MYKEJUINFO(patch:IDataInput) : void
      {
         var vo:MyInfoVO = new MyInfoVO();
         vo.count = patch.readInt();
         vo.num = patch.readInt();
         vo.time = patch.readInt();
         View_Keju.instance.updatMyInfo(vo);
      }
      
      private function GC_RANKLIST(patch:IDataInput) : void
      {
         var vo:RankVO = null;
         var leng:int = patch.readInt();
         Model_KeJu.rankArr.length = 0;
         var i:int = 0;
         while(i < leng)
         {
            vo = new RankVO();
            vo.name = patch.readUTF();
            vo.scores = patch.readInt();
            vo.time = patch.readInt();
            Model_KeJu.rankArr.push(vo);
            i++;
         }
         View_Keju.instance.updataRank();
      }
      
      private function GC_ASKQUESTION(patch:IDataInput) : void
      {
         var leftTime:int = 0;
         var questID:int = patch.readInt();
         var questNum:int = patch.readInt();
         var status:int = patch.readByte();
         var answer:int = patch.readInt();
         if(status != 1)
         {
            leftTime = patch.readInt();
         }
         View_Keju.instance.changQuestion(questID,questNum,status,answer,leftTime);
      }
      
      private function GC_JOINKEJU(patch:IDataInput) : void
      {
         var npcId:int = 0;
         var npc:Npc = null;
         var npcID:int = 0;
         var npcNum:int = 0;
         var type:int = patch.readByte();
         var result:int = patch.readByte();
         if(type == 1)
         {
            if(result == 1)
            {
               npcId = patch.readInt();
               npc = Npc.getNpcBySysid(npcId);
               View_Keju.instance.show(npc);
               View_Keju.instance.visible = true;
            }
            else if(result == 2)
            {
               npcID = patch.readInt();
               npcNum = npcID - (Enum_KeJu.FIRSTNPC - 1);
               View_Alert.show(LangConfig.getWord("80014",8,npcNum),View_Alert.OK_CANCAL,function():void
               {
                  GameUnitManager.hero.autoMove(npcID);
               },null,null,null,310,LangConfig.getWord("80015",8));
            }
            else if(result == 3)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80016",8));
            }
            else if(result == 4)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80017",8));
            }
            else if(result == 5)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80018",8));
            }
         }
         else if(type == 2)
         {
            if(result == 2)
            {
               npcID = patch.readInt();
               View_XS_Introduce.instance.show(function():void
               {
                  GameUnitManager.hero.autoMove(npcID);
               });
            }
            else if(result == 3)
            {
               View_Keju.instance.visible = true;
               View_Keju.instance.endKeju();
            }
         }
      }
   }
}

