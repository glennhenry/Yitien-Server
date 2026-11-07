package com.yiTian.data.vo.quest
{
   import com.utils.ColorConstant;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.Enum_quest_reward_lib;
   import com.yiTian.data.config.Enum_quest_reward_type;
   import com.yiTian.data.config.Enum_quest_step_type;
   import com.yiTian.data.config.Enum_quest_type;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.utils.HtmlUtil;
   
   public class Vo_quest
   {
      
      public static const QUEST_NAME:int = 0;
      
      public static const QUEST_TYPE:int = 1;
      
      public static const DISCRIPT:int = 2;
      
      public static const MIN_LEVEL:int = 3;
      
      public static const ACCEPT_LEVEL:int = 4;
      
      public static const MAX_LEVEL:int = 5;
      
      public static const JOB:int = 6;
      
      public static const RECYCLE_COUNT:int = 7;
      
      public static const RECYCLE_TIME:int = 8;
      
      public static const PRE_QUESTID:int = 9;
      
      public static const AFTER_QUESTID:int = 10;
      
      public static const ACCEPT_STEP:int = 11;
      
      public static const CONTINUE_STEP:int = 12;
      
      public static const FINISH_STEP:int = 13;
      
      public static const REWARD:int = 14;
      
      public static const PRACTICE:int = 15;
      
      private static const linkReg:RegExp = /(\(|\（)(\d|_)*(\)|\）)/gi;
      
      private static const mapReg:RegExp = /<m>[\s\S]*<m>/gi;
      
      private static const itemReg:RegExp = /<l>[\s\S]*<l>/gi;
      
      private static const npcReg:RegExp = /<n>[\s\S]*<n>/gi;
      
      private static const specialReg:RegExp = /<s>[\s\S]*<s>/gi;
      
      private static const countReg:RegExp = /<c>[\s\S]*<c>/gi;
      
      public var id:int;
      
      public var name:String;
      
      public var type:int;
      
      public var discript:String;
      
      public var accept_level:int;
      
      public var job:int;
      
      public var acceptStep:Vo_questStep;
      
      public var finishStep:Vo_questStep;
      
      public var continueStep:Array;
      
      public var reward:Vo_questReward;
      
      private var _status:int;
      
      public var step:int;
      
      public var count:String;
      
      public var leftTime:int;
      
      public var pratice:String;
      
      public function Vo_quest(id:int)
      {
         var continueArr:Array = null;
         var conStep:Vo_questStep = null;
         var i:int = 0;
         var rewardDatas:Array = null;
         var j:int = 0;
         var rewData:Array = null;
         var rewType:int = 0;
         var equip:Vo_equip = null;
         var item:Vo_item = null;
         super();
         this.id = id;
         var data:Array = Data_lib.quest[id];
         this.name = data[QUEST_NAME];
         this.type = data[QUEST_TYPE];
         this.discript = data[DISCRIPT];
         this.accept_level = data[ACCEPT_LEVEL];
         this.job = data[JOB];
         this.pratice = data[PRACTICE];
         if(this.type != Enum_quest_type.SPECIAL && this.type != Enum_quest_type.DAILY_GUIDE)
         {
            this.acceptStep = new Vo_questStep();
            this.explainStep(data[ACCEPT_STEP],this.acceptStep);
         }
         this.continueStep = [];
         if(Boolean(data[CONTINUE_STEP]))
         {
            continueArr = (data[CONTINUE_STEP] as String).split(";");
            i = 0;
            while(i < continueArr.length)
            {
               if(continueArr[i] != "" && continueArr[i] != null)
               {
                  conStep = new Vo_questStep();
                  this.continueStep.push(conStep);
                  this.explainStep(continueArr[i],conStep);
               }
               i++;
            }
         }
         if(this.type != Enum_quest_type.SPECIAL && this.type != Enum_quest_type.DAILY_GUIDE)
         {
            if(this.type == Enum_quest_type.HUANGBANG)
            {
               if(data[FINISH_STEP] != 0)
               {
                  this.finishStep = new Vo_questStep();
                  this.explainStep(data[FINISH_STEP],this.finishStep);
               }
            }
            else
            {
               this.finishStep = new Vo_questStep();
               this.explainStep(data[FINISH_STEP],this.finishStep);
            }
         }
         this.reward = new Vo_questReward();
         var rewardStr:String = data[REWARD];
         if(rewardStr != null && rewardStr != "0")
         {
            rewardDatas = rewardStr.split(",");
            j = 0;
            while(j < rewardDatas.length)
            {
               if(Boolean(rewardDatas[j]))
               {
                  rewData = rewardDatas[j].split("_");
                  rewType = int(rewData[0]);
                  if(rewType == Enum_quest_reward_type.EQUIP)
                  {
                     equip = new Vo_equip();
                     equip.id = rewData[1];
                     equip.Init_lib();
                     equip.count = rewData[2];
                     this.reward.items.push(equip);
                  }
                  else if(rewType == Enum_quest_reward_type.ITEM)
                  {
                     item = new Vo_item();
                     item.id = rewData[1];
                     item.Init_lib();
                     item.count = rewData[2];
                     this.reward.items.push(item);
                  }
                  else
                  {
                     this.reward.baseProp.push(Enum_quest_reward_type.getTypeName(rewType) + HtmlUtil.fontNoSize(rewData[1],"#f9ff00"));
                  }
               }
               j++;
            }
         }
         var rewardData:Array = Data_lib.renwujiangli[id];
         var baseJob:int = int(Enum_job.getBaseJob(GameUnitManager.hero.job));
         if(Boolean(rewardData))
         {
            rewType = int(rewardData[Enum_quest_reward_lib.TYPE]);
            if(rewType == Enum_quest_reward_type.EQUIP)
            {
               equip = new Vo_equip();
               equip.id = rewardData[baseJob - 1];
               equip.Init_lib();
               equip.count = rewardData[Enum_quest_reward_lib.COUNT];
               this.reward.items.push(equip);
            }
            else if(rewType == Enum_quest_reward_type.ITEM)
            {
               item = new Vo_item();
               item.id = rewardData[baseJob - 1];
               item.Init_lib();
               item.count = rewardData[Enum_quest_reward_lib.COUNT];
               this.reward.items.push(item);
            }
         }
         Model_quest.list[id] = this;
      }
      
      private function explainStep(str:String, questStep:Vo_questStep) : void
      {
         var tempStr:String = null;
         var linkArr:Array = null;
         var mapStr:String = null;
         var mapTempStr:String = null;
         var itemStr:String = null;
         var itemTempStr:String = null;
         var npcStr:String = null;
         var npcTempStr:String = null;
         var specialStr:String = null;
         var specialTempStr:String = null;
         var countStr:String = null;
         var countTempStr:String = null;
         var tempArr:Array = str.match(linkReg);
         var linkstr:String = tempArr[tempArr.length - 1];
         if(linkstr != "" && linkstr != null)
         {
            tempStr = linkstr.replace(/(\(|\（|\)|\）)/gi,"");
            linkArr = tempStr.split("_");
            questStep.mapId = linkArr[0];
            if(Boolean(linkArr[1]))
            {
               questStep.npcId = linkArr[1];
               questStep.npcName = Data_lib.npc[questStep.npcId][Npc.NAME];
            }
            str = str.replace(linkstr,"");
         }
         var data:Array = str.split("_");
         questStep.stepType = data[0];
         questStep.itemId = data[1];
         switch(questStep.stepType)
         {
            case Enum_quest_step_type.DIALOG:
            case Enum_quest_step_type.ANSWER:
               questStep.dialog = data[2];
               questStep.descript = data[3];
               break;
            case Enum_quest_step_type.BEAT_MONSTER:
               questStep.count = data[1];
               questStep.descript = data[2];
               break;
            case Enum_quest_step_type.COLLECT_EQUIP:
            case Enum_quest_step_type.COLLECT_ITEM:
            case Enum_quest_step_type.CAI_JI:
            case Enum_quest_step_type.CHU_CHONG:
               questStep.count = data[2];
               questStep.descript = data[3];
               break;
            case Enum_quest_step_type.TONG_GUAN:
               questStep.descript = data[1];
               if(Boolean(data[2]))
               {
                  questStep.count = data[2];
               }
               break;
               questStep.descript = data[1];
               break;
            case Enum_quest_step_type.PETEQUIP_QIANGHUA:
               questStep.descript = data[1];
               break;
            default:
               questStep.descript = data[1];
               if(questStep.stepType == Enum_quest_step_type.SHANG_CHENG)
               {
                  questStep.itemId = data[2];
               }
               break;
            case Enum_quest_step_type.DAILY_GUIDE_ZhangMenRen:
            case Enum_quest_step_type.DAILY_GUIDE_ChuangGuan:
            case Enum_quest_step_type.DAILY_GUIDE_LingQiJuanXian:
            case Enum_quest_step_type.DAILY_GUIDE_JiangHuLiXian:
            case Enum_quest_step_type.DAILY_GUIDE_JingJi:
            case Enum_quest_step_type.DAILY_GUIDE_GuangMingDing:
            case Enum_quest_step_type.DAILY_GUIDE_WanAnSi:
            case Enum_quest_step_type.DAILY_GUIDE_ZhenLongQiJu:
            case Enum_quest_step_type.DAILY_GUIDE_ZhangMenRen:
            case Enum_quest_step_type.DAILY_GUIDE_TongTianFeng:
            case Enum_quest_step_type.DAILY_GUIDE_JINGPO:
         }
         var maparr:Array = questStep.descript.match(mapReg);
         if(Boolean(maparr.length))
         {
            mapStr = maparr[0];
            mapTempStr = mapStr.replace(/<m>/gi,"");
            questStep.descript = questStep.descript.replace(mapStr,"<u>" + HtmlUtil.link(HtmlUtil.fontNoSize(mapTempStr,ColorConstant.getColorStr(ColorConstant.MAP_NAME)),(questStep.stepType == Enum_quest_step_type.TONG_GUAN ? "map" + questStep.mapId : "npc" + questStep.npcId) + (this.type == Enum_quest_type.BANG_HUI ? "_bang" + questStep.mapId : "")) + "</u>");
         }
         var itemArr:Array = questStep.descript.match(itemReg);
         if(Boolean(itemArr.length))
         {
            itemStr = itemArr[0];
            itemTempStr = itemStr.replace(/<l>/gi,"");
            questStep.descript = questStep.descript.replace(itemStr,"<u>" + HtmlUtil.link(HtmlUtil.fontNoSize(itemTempStr,ColorConstant.getColorStr(6)),(questStep.stepType == Enum_quest_step_type.TONG_GUAN ? "map" + questStep.mapId : "npc" + questStep.npcId) + (this.type == Enum_quest_type.BANG_HUI ? "_bang" + questStep.mapId : "")) + "</u>");
         }
         var npcArr:Array = questStep.descript.match(npcReg);
         if(Boolean(npcArr.length))
         {
            npcStr = npcArr[0];
            npcTempStr = npcStr.replace(/<n>/gi,"");
            questStep.descript = questStep.descript.replace(npcStr,"<u>" + HtmlUtil.link(HtmlUtil.fontNoSize(npcTempStr,ColorConstant.getColorStr(ColorConstant.NPC_NAME)),(questStep.stepType == Enum_quest_step_type.TONG_GUAN ? "map" + questStep.mapId : "npc" + questStep.npcId) + (this.type == Enum_quest_type.BANG_HUI ? "_bang" + questStep.mapId : "")) + "</u>");
         }
         var specialArr:Array = questStep.descript.match(specialReg);
         if(Boolean(specialArr.length))
         {
            specialStr = specialArr[0];
            specialTempStr = specialStr.replace(/<s>/gi,"");
            questStep.descript = questStep.descript.replace(specialStr,"<u>" + HtmlUtil.link(HtmlUtil.fontNoSize(specialTempStr,ColorConstant.getColorStr(ColorConstant.NPC_NAME)),"open" + questStep.stepType) + "</u>");
         }
         var countArr:Array = questStep.descript.match(countReg);
         if(Boolean(countArr.length))
         {
            countStr = countArr[0];
            countTempStr = countStr.replace(/<c>/gi,"");
            if(questStep.stepType >= Enum_quest_step_type.DAILY_GUIDE_ZhangMenRen && questStep.stepType <= Enum_quest_step_type.DAILY_GUIDE_TongTianFeng)
            {
               questStep.descript = questStep.descript.replace(countStr,"");
            }
            else
            {
               questStep.descript = questStep.descript.replace(countStr,countTempStr);
            }
            questStep.count = countTempStr;
         }
      }
      
      public function set status(value:int) : void
      {
         this._status = value;
         if(value < 0)
         {
            Model_quest.canAccept[this.id] = this;
            this.step = 0;
            delete Model_quest.accepted[this.id];
         }
         else
         {
            Model_quest.accepted[this.id] = this;
            delete Model_quest.canAccept[this.id];
         }
      }
      
      public function get status() : int
      {
         return this._status;
      }
   }
}

