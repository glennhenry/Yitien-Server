package com.yiTian.manager
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.config.guide.Enum_guide_enterFuben;
   import com.yiTian.data.config.guide.Enum_guide_tonggun;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.Magic;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.net.message.cg.GuideCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.chat.TweenRichTF;
   import com.yiTian.view.modules.guide.View_guide_dialog;
   import com.yiTian.view.modules.guide.View_guide_tip;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class GuideManager
   {
      
      private static var steps:Array;
      
      private static var _reward:String;
      
      private static var _curStep:String;
      
      public static var isPlaying:Boolean;
      
      private static var shape:Shape;
      
      private static var npcs:Array;
      
      public static var watchX:int;
      
      public static var watchY:int;
      
      public static var rewardInfo:String;
      
      private static var lockRole:Role;
      
      private static var magicDic:Dictionary = new Dictionary();
      
      private static var timeinters:Array = [];
      
      private static const FRAME:Object = {
         1:88,
         2:71,
         3:86,
         4:112
      };
      
      public function GuideManager()
      {
         super();
      }
      
      public static function checkEnterFuben(fubenId:int) : Boolean
      {
         var data:Array = Data_lib.guideEnterGuan[fubenId];
         if(Boolean(data))
         {
            return Model_quest.hasAcceptQuest(data[Enum_guide_enterFuben.QUESTID]);
         }
         return false;
      }
      
      public static function checkTongGun(fubenId:int) : Boolean
      {
         var data:Array = Data_lib.guideTongGuan[fubenId];
         if(Boolean(data))
         {
            return Model_quest.hasAcceptQuest(data[Enum_guide_tonggun.QUESTID]);
         }
         return false;
      }
      
      public static function checkQuest(questId:int) : Boolean
      {
         var data:Array = Data_lib.guideQuest[questId];
         if(Boolean(data))
         {
            return true;
         }
         return false;
      }
      
      public static function showGuide(info:String, reward:String, beizu:String = null) : void
      {
         if(!UIManager.guideDialog)
         {
            UIManager.guideDialog = new View_guide_dialog();
            UIManager.guideDialog.init();
            UIManager.guideDialog.resetPosition();
         }
         UIManager.guideDialog.visible = true;
         GameScene.downUILayer.visible = false;
         GameScene.uiLayer.visible = false;
         GameScene.popupLayer.visible = false;
         GameScene.modalLayer.visible = false;
         GameUnitManager.setAllVisible(false);
         if(!shape)
         {
            shape = ComponentUtil.getShape(2500,2000,0,0.6);
         }
         GameScene.newGridLayer.addChild(shape);
         var pos:Array = explainSteps(info);
         if(Boolean(pos))
         {
            watchX = pos[0];
            watchY = pos[1];
            CameraManager.wacth(watchX,watchY);
         }
         if(Boolean(beizu))
         {
            setBeizu(beizu);
         }
         _reward = reward;
         isPlaying = true;
         play();
         Global.control.sendNotification(Enum_MsgType.MOVIE_PLAY,null);
      }
      
      public static function showDialog(info:String, reward:String, beizu:String = null) : void
      {
         GameScene.downUILayer.visible = false;
         GameScene.uiLayer.visible = false;
         GameScene.popupLayer.visible = false;
         GameScene.modalLayer.visible = false;
         var pos:Array = explainSteps(info);
         if(Boolean(pos))
         {
            CameraManager.wacth(pos[0],int(pos[1]));
         }
         if(Boolean(beizu))
         {
            setBeizu(beizu);
         }
         isPlaying = true;
         GameScene.instance.addFrameCallBack(frame);
         play();
      }
      
      private static function setBeizu(beizu:String) : void
      {
         var infoArr:Array = null;
         var type:int = 0;
         var npc:Npc = null;
         if(beizu == "0")
         {
            return;
         }
         npcs = [];
         var data:Array = beizu.split(",");
         var i:int = 0;
         while(i < data.length)
         {
            if(data[i])
            {
               infoArr = data[i].split("_");
               type = int(infoArr[0]);
               if(type != 1)
               {
                  if(type == 2)
                  {
                     GameUnitManager.hero.visible = true;
                  }
                  else if(type.toString().charAt(0) == "5")
                  {
                     npc = GameUnitManager.findUnit(infoArr[0],UnitType.NPC) as Npc;
                     if(Boolean(npc))
                     {
                        return;
                     }
                     npc = GameUnitManager.getUnit(UnitType.NPC) as Npc;
                     npc.init(infoArr[0],infoArr[0],infoArr[2],infoArr[4],1,1,1,1,4,null,null);
                     if(int(infoArr[0]) == 51048)
                     {
                        npc.setShadow(Status.NOMAL,12);
                        npc.way = 1;
                        npc.status = Status.NOMAL;
                     }
                     GameUnitManager.addUnit(npc);
                     npc.visible = true;
                     npcs.push(npc);
                  }
               }
            }
            i++;
         }
      }
      
      private static function explainSteps(info:String) : Array
      {
         var tempArr:Array = null;
         var step:Array = null;
         steps = [];
         var stepData:Array = info.split(";");
         var i:int = 0;
         while(i < stepData.length)
         {
            if(Boolean(stepData[i]))
            {
               step = stepData[i].split("_");
               if(step[0] == 2)
               {
                  tempArr = [step[3],step[5]];
               }
               steps.push(step);
            }
            i++;
         }
         return tempArr;
      }
      
      private static function clearNpc() : void
      {
         var i:int = 0;
         if(Boolean(npcs))
         {
            i = npcs.length - 1;
            while(i >= 0)
            {
               GameUnitManager.removeUnit(npcs[i]);
               npcs.splice(i,1);
               i--;
            }
         }
         npcs = null;
      }
      
      private static function clearMagics() : void
      {
         var url:String = null;
         var magic:Magic = null;
         for(url in magicDic)
         {
            magic = magicDic[url];
            if(Boolean(magic.parent) && magic.url.indexOf(url) != -1)
            {
               GameUnitManager.removeUnit(magic);
            }
            delete magicDic[url];
         }
      }
      
      private static function claerTimeinter() : void
      {
         var i:int = int(timeinters.length);
         while(i >= 0)
         {
            clearTimeout(timeinters[i]);
            timeinters.splice(i,1);
            i--;
         }
      }
      
      private static function end() : void
      {
         GameScene.instance.removeFrameCallBack(frame);
         GameScene.downUILayer.visible = true;
         GameScene.uiLayer.visible = true;
         GameScene.popupLayer.visible = true;
         GameScene.modalLayer.visible = true;
         GameUnitManager.setAllVisible(true);
         clearNpc();
         clearMagics();
         claerTimeinter();
         lockRole = null;
         watchX = 0;
         watchY = 0;
         if(Boolean(UIManager.guideDialog))
         {
            UIManager.guideDialog.visible = false;
         }
         if(Boolean(shape) && GameScene.newGridLayer.contains(shape))
         {
            GameScene.newGridLayer.removeChild(shape);
         }
         isPlaying = false;
         if(rewardInfo != null && rewardInfo != "")
         {
            View_guide_tip.instance.play(rewardInfo);
            rewardInfo = "";
         }
         if(!Global.isPlayingMarriageEffect)
         {
            CameraManager.wacth(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y);
         }
         Global.control.sendNotification(Enum_MsgType.MOVIE_END,null);
      }
      
      public static function jumpFlash() : void
      {
         steps = [];
         _curStep = null;
         end();
      }
      
      private static function play() : void
      {
         if(steps.length > 0)
         {
            doStep(steps.shift());
         }
         else
         {
            end();
         }
      }
      
      private static function dealReward() : void
      {
         var rewardData:Array = _reward.split("_");
         switch(int(rewardData[0]))
         {
            case 3:
               GuideCGMessage.CG_GUIDE_SKILL(int(rewardData[1].split(",")[Enum_job.getBaseJob(GameUnitManager.hero.job) - 1]));
               break;
            case 4:
               GuideCGMessage.CG_GUIDE_PET();
               break;
            case 5:
               GuideCGMessage.CG_GUIDE_HORSE(int(rewardData[1]));
         }
      }
      
      private static function doStep(stepData:Array) : void
      {
         var id:int = int(stepData[0]);
         if(id == 2)
         {
            UIManager.guideDialog.hide();
            playFlash(stepData.splice(1));
         }
         else if(id == 3)
         {
            showHeadDialog(stepData.splice(1));
         }
         else if(id == 4)
         {
            doRun(stepData.splice(1));
         }
         else if(id == 5)
         {
            doBattle(stepData.splice(1));
         }
         else
         {
            UIManager.guideDialog.update(id,stepData[1]);
            UIManager.guideDialog.addEventListener("GUIDE_DIALOD_END",GUIDE_DIALOD_END);
         }
      }
      
      private static function showHeadDialog(param:Array) : void
      {
         var contentStr:String = null;
         var costTime:int = 0;
         var stanTime:int = 0;
         var unit:Role = null;
         var tf:TweenRichTF = null;
         var tfPercentComplete:Function = null;
         tfPercentComplete = function():void
         {
            Tween.to(tf,stanTime,{},function():void
            {
               Tween.to(tf,200,{"alpha":[1,0]},function():void
               {
                  unit.removeChild(tf);
                  tf.dispose();
                  Pool.saveObject(tf);
                  play();
               });
            });
         };
         var uId:int = int(param[0]);
         contentStr = param[1];
         costTime = 1500 + contentStr.length / 5 * 500;
         stanTime = 100;
         if(uId == 1)
         {
            unit = GameUnitManager.hero;
         }
         else
         {
            unit = Npc.getNpcBySysid(uId);
         }
         CameraManager.wacth(unit.global_x,unit.global_y);
         tf = Pool.getObject(TweenRichTF) as TweenRichTF;
         tf.x = -80;
         tf.y = -220;
         tf.content = contentStr;
         tf.alpha = 1;
         unit.addChild(tf);
         Tween.to(tf,costTime,{"percent":[0,1]},tfPercentComplete);
      }
      
      private static function doRun(param:Array) : void
      {
         var unit:Role = null;
         var uId:int = int(param[0]);
         if(uId == 1)
         {
            unit = GameUnitManager.hero;
         }
         else
         {
            unit = Npc.getNpcBySysid(uId);
            lockRole = unit;
            unit.speed = 80;
         }
         var arr:Array = [];
         var i:int = 1;
         while(i < param.length)
         {
            arr.push([param[i],param[i + 1]]);
            i += 2;
         }
         unit.route = arr;
         play();
      }
      
      private static function doBattle(param:Array) : void
      {
         var unit:Role = Npc.getNpcBySysid(param[0]);
         unit.interaction();
         play();
      }
      
      private static function frame() : void
      {
         if(Boolean(lockRole) && lockRole.action == Action.RUN)
         {
            CameraManager.wacth(lockRole.global_x,lockRole.global_y);
         }
      }
      
      private static function playFlash(swfInfo:Array) : void
      {
         var arr:Array = null;
         if(int(swfInfo[0]) == 50003)
         {
            if(!ResourceManager.hasLoaded("modelRes/magic/" + swfInfo[0] + ".swf") || !ResourceManager.hasLoaded("modelRes/magic/" + "3" + Enum_job.getBaseJob(GameUnitManager.hero.job) + "901" + ".swf"))
            {
               arr = [];
               arr.push(["modelRes/magic/" + swfInfo[0] + ".swf",ResourceManager.setSource,LangConfig.getWord("10550",1),Enum_loaderType.MASS,Enum_resType.MODEL_URL]);
               arr.push(["modelRes/magic/" + "3" + Enum_job.getBaseJob(GameUnitManager.hero.job) + "901" + ".swf",ResourceManager.setSource,LangConfig.getWord("10550",1),Enum_loaderType.MASS,Enum_resType.MODEL_URL]);
               View_loading.instance.load(arr,_playFlashBegin,swfInfo);
            }
            else
            {
               _playFlashBegin(swfInfo);
            }
         }
         else if(!ResourceManager.hasLoaded("modelRes/magic/" + swfInfo[0] + ".swf"))
         {
            arr = [];
            arr.push(["modelRes/magic/" + swfInfo[0] + ".swf",ResourceManager.setSource,LangConfig.getWord("10550",1),Enum_loaderType.MASS,Enum_resType.MODEL_URL]);
            View_loading.instance.load(arr,_playFlashBegin,swfInfo);
         }
         else
         {
            _playFlashBegin(swfInfo);
         }
      }
      
      private static function _playFlashBegin(swfInfo:Array) : void
      {
         switch(int(swfInfo[0]))
         {
            case 50001:
               playYuFu(swfInfo);
               break;
            case 50003:
               playShenGong(swfInfo);
               break;
            case 35901:
               playDianXue(swfInfo);
         }
      }
      
      private static function playYuFu(swfInfo:Array) : void
      {
         timeinters.push(setTimeout(play,40 * 180));
         var magic:Magic = GameUnitManager.getUnit(UnitType.MAGIC) as Magic;
         magic.init(swfInfo[0],swfInfo[2],int(swfInfo[4]) - 100,0,false,swfInfo[0],40 * 180);
         GameUnitManager.addUnit(magic);
         magic.visible = true;
         magicDic[magic.url] = magic;
      }
      
      private static function playShenGong(swfInfo:Array) : void
      {
         var magic:Magic = null;
         magic = GameUnitManager.getUnit(UnitType.MAGIC) as Magic;
         magic.init(swfInfo[0],int(swfInfo[2]) + 40,int(swfInfo[4]) - 30,0,false,swfInfo[0],40 * 46);
         GameUnitManager.addUnit(magic);
         magic.visible = true;
         magicDic[magic.url] = magic;
         timeinters.push(setTimeout(playJobSG,40 * 30,swfInfo));
      }
      
      private static function playJobSG(swfInfo:Array) : void
      {
         var magic:Magic = null;
         var frame:int = int(FRAME[Enum_job.getBaseJob(GameUnitManager.hero.job)]);
         var time:int = 40 * frame;
         timeinters.push(setTimeout(play,time));
         magic = GameUnitManager.getUnit(UnitType.MAGIC) as Magic;
         var id:int = int("3" + Enum_job.getBaseJob(GameUnitManager.hero.job) + "901");
         magic.init(id,int(swfInfo[2]) + 40,int(swfInfo[4]) - 30,0,false,id,time);
         GameUnitManager.addUnit(magic);
         magic.visible = true;
         magicDic[magic.url] = magic;
         GuideManager.rewardInfo = LangConfig.getWord("10551",1);
      }
      
      private static function playDianXue(swfInfo:Array) : void
      {
         var magic:Magic = null;
         timeinters.push(setTimeout(play,40 * 158));
         magic = GameUnitManager.getUnit(UnitType.MAGIC) as Magic;
         magic.init(swfInfo[0],int(swfInfo[2]) + 380,int(swfInfo[4]) - 20,0,false,swfInfo[0],40 * 158);
         GameUnitManager.addUnit(magic);
         magic.visible = true;
         magicDic[magic.url] = magic;
      }
      
      private static function doClick(e:MouseEvent) : void
      {
         Global.stage.removeEventListener(MouseEvent.CLICK,doClick);
         play();
      }
      
      private static function GUIDE_DIALOD_END(e:Event) : void
      {
         UIManager.guideDialog.removeEventListener("GUIDE_DIALOD_END",GUIDE_DIALOD_END);
         play();
      }
   }
}

