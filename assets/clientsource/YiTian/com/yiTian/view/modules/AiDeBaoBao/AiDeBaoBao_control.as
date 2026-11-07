package com.yiTian.view.modules.AiDeBaoBao
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_AiDeBaoBao;
   import com.yiTian.data.config.Enum_AstarGridType;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.AiDeBaoBaoCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.AStar;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.Kunlun.View_RoomTipBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class AiDeBaoBao_control
   {
      
      public static var roomId:int;
      
      private static var skillTimer1:Timer;
      
      private static var skillTimer2:Timer;
      
      private static var skillTimer3:Timer;
      
      private static var skillTimer4:Timer;
      
      public static var startPointArray:Array;
      
      public static var middlePointArray:Array;
      
      public static var middlePointArray2:Array;
      
      public static var endPointArray:Array;
      
      private static var btn1:Sprite;
      
      private static var btn2:Sprite;
      
      private static var btn3:MainUIBtn;
      
      private static var startLine:Effect;
      
      private static var middleLine:Effect;
      
      private static var middleLine2:Effect;
      
      private static var endLine:Effect;
      
      private static var flowerDown_MC:MovieClip;
      
      private static var playMC:Boolean;
      
      public static var target:Player;
      
      public static var checkTimer:Timer;
      
      private static var isFirstInit:Boolean = true;
      
      public function AiDeBaoBao_control()
      {
         super();
      }
      
      public static function creatShowAndHide(isShow:Boolean) : void
      {
         if(isShow)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ADD_PLAYER_2,onChangeShow);
            Global.control.registerCallBack(Enum_MsgType.UPDATE_AVATER_COMPLETE,onChangeShow);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ADD_PLAYER_2,onChangeShow);
            Global.control.removeCallBack(Enum_MsgType.UPDATE_AVATER_COMPLETE,onChangeShow);
         }
      }
      
      private static function onChangeShow(player:Player) : void
      {
         if(player.status == Status.AiDeBaoBao_BeiBao)
         {
            player.visible = false;
         }
         else if(player.status == Status.AiDeBaoBao_Bao)
         {
            player.visible = true;
         }
      }
      
      public static function Enter(room:int) : void
      {
         roomId = room;
         UIManager.questTraceView.visible = false;
         UIManager.newMainBtnContainer.visible = false;
         UIManager.mainUiBtnContainer.visible = false;
         UIManager.mappanel.visible = false;
         UIManager.special_btn.visible = false;
         UIManager.mainMenu.visible = false;
         UIManager.petHeadPanel.visible = false;
         UIManager.heroHead.visible = false;
         btn1 = View_AiDeBaoBao_explainIcon.instance;
         btn2 = View_RoomTipBtn.getInstance();
         if(!btn3)
         {
            btn3 = new MainUIBtn("resource/image/pata/Exit_Icon.png");
            btn3.addEventListener(MouseEvent.CLICK,clickBtnHandler);
            btn3.addEventListener(MouseEvent.ROLL_OVER,overBtnHandler);
            btn3.addEventListener(MouseEvent.ROLL_OUT,outBtnHandler);
            btn3.transform.colorTransform = Util.colorNomal;
            btn3.mouseEnabled = true;
            btn3.visible = true;
            btn3.filters = [];
         }
         GameScene.uiLayer.addChild(btn1);
         GameScene.uiLayer.addChild(btn2);
         GameScene.uiLayer.addChild(btn3);
         GameScene.uiLayer.addChild(View_AiDeBaoBao_returnIcon.instance);
         View_AiDeBaoBao_returnIcon.instance.visible = false;
         btn1.x = Global.stage.stageWidth - 235 - 75 * 3;
         btn2.x = Global.stage.stageWidth - 235 - 75 * 2;
         btn3.x = Global.stage.stageWidth - 235 - 75;
         View_AiDeBaoBao_returnIcon.instance.x = Global.stage.stageWidth - 235 - 75 * 4;
         View_AiDeBaoBao_PaiHang.instance.visible = true;
         View_AiDeBaoBao_findPartner.instance.visible = true;
         View_AiDeBaoBao_finishMenu.instance.visible = false;
         if(isFirstInit)
         {
            View_AiDeBaoBao_explainMenu.instance.visible = true;
            checkTimer = new Timer(200);
         }
         checkTimer.addEventListener(TimerEvent.TIMER,sendPosition);
         if(!GameUnitManager.isShowPlayer)
         {
            UIManager.smallMap.biClick(null);
         }
         Enum_explor.bindDic[Enum_explor.BTN_MAP].enabled = false;
         Enum_explor.bindDic[Enum_explor.BTN_Bi].enabled = false;
         Enum_explor.bindDic[Enum_explor.BTN_HUODONG].enabled = false;
         Enum_explor.bindDic[Enum_explor.BTN_JIAOYI].enabled = false;
         Enum_explor.bindDic[Enum_explor.BTN_FINDEXP].enabled = false;
         Enum_explor.bindDic[Enum_explor.BTN_LETTER].enabled = false;
         Enum_explor.bindDic[Enum_explor.BTN_BANG].enabled = false;
         Enum_explor.bindDic[Enum_explor.BTN_MART].enabled = false;
         Enum_explor.bindDic[Enum_explor.BTN_POINT].enabled = false;
         Enum_explor.bindDic[Enum_explor.BTN_FU].enabled = false;
         if(Boolean(Enum_explor.bindDic[Enum_explor.Button_Zi]))
         {
            Enum_explor.bindDic[Enum_explor.Button_Zi].enabled = false;
         }
         Global.stage.addEventListener(Event.RESIZE,onResize);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN_OK,alterMap);
         Global.control.registerCallBack(Enum_AiDeBaoBao.RESET_MAP,alterMap);
         Global.control.registerCallBack(Enum_AiDeBaoBao.RESET_MAP_MIDDLE,alterMap_middle);
         Global.control.registerCallBack(Enum_AiDeBaoBao.RESET_MAP_MIDDLE_2,alterMap_middle2);
         Global.control.registerCallBack(Enum_AiDeBaoBao.RESET_MAP_END,alterMap_end);
         isFirstInit = false;
         target = null;
         Global.control.sendNotification(Enum_AiDeBaoBao.GUIDE_ARROW_POINT_TO_FIND_PARTNER,null);
      }
      
      private static function onResize(e:Event) : void
      {
         btn1.x = Global.stage.stageWidth - 235 - 75 * 3;
         btn2.x = Global.stage.stageWidth - 235 - 75 * 2;
         btn3.x = Global.stage.stageWidth - 235 - 75;
         View_AiDeBaoBao_returnIcon.instance.x = Global.stage.stageWidth - 235 - 75 * 4;
      }
      
      public static function Exit() : void
      {
         target = null;
         Enum_explor.bindDic[Enum_explor.BTN_MAP].enabled = true;
         Enum_explor.bindDic[Enum_explor.BTN_Bi].enabled = true;
         Enum_explor.bindDic[Enum_explor.BTN_HUODONG].enabled = true;
         Enum_explor.bindDic[Enum_explor.BTN_JIAOYI].enabled = true;
         Enum_explor.bindDic[Enum_explor.BTN_FINDEXP].enabled = true;
         Enum_explor.bindDic[Enum_explor.BTN_LETTER].enabled = true;
         Enum_explor.bindDic[Enum_explor.BTN_BANG].enabled = true;
         Enum_explor.bindDic[Enum_explor.BTN_MART].enabled = true;
         Enum_explor.bindDic[Enum_explor.BTN_POINT].enabled = true;
         Enum_explor.bindDic[Enum_explor.BTN_FU].enabled = true;
         if(Boolean(Enum_explor.bindDic[Enum_explor.Button_Zi]))
         {
            Enum_explor.bindDic[Enum_explor.Button_Zi].enabled = true;
         }
         View_AiDeBaoBao_findPartner.instance.visible = false;
         View_AiDeBaoBao_changeRoom.instance.visible = false;
         View_AiDeBaoBao_explainMenu.instance.visible = false;
         View_AiDeBaoBao_partnerMenu.instance.visible = false;
         View_AiDeBaoBao_prizeMenu.instance.visible = false;
         View_AiDeBaoBao_PaiHang.instance.visible = false;
         View_AiDeBaoBao_PaiHang.instance.setRank([]);
         View_AiDeBaoBao_skillBar.instance.visible = false;
         View_AiDeBaoBao_finishMenu.instance.visible = false;
         View_AiDeBaoBao_startCountDown.instance.visible = false;
         UIManager.questTraceView.visible = true;
         UIManager.mainMenu.visible = true;
         UIManager.newMainBtnContainer.visible = true;
         UIManager.special_btn.visible = true;
         UIManager.mainUiBtnContainer.visible = true;
         UIManager.petHeadPanel.visible = true;
         UIManager.heroHead.visible = true;
         if(GameScene.uiLayer.contains(btn1))
         {
            GameScene.uiLayer.removeChild(btn1);
         }
         if(GameScene.uiLayer.contains(btn2))
         {
            GameScene.uiLayer.removeChild(btn2);
         }
         if(GameScene.uiLayer.contains(btn3))
         {
            GameScene.uiLayer.removeChild(btn3);
         }
         if(GameScene.uiLayer.contains(View_AiDeBaoBao_returnIcon.instance))
         {
            GameScene.uiLayer.removeChild(View_AiDeBaoBao_returnIcon.instance);
         }
         View_AiDeBaoBao_findPartner.instance.End();
         checkTimer.reset();
         checkTimer.removeEventListener(TimerEvent.TIMER,sendPosition);
         Global.stage.removeEventListener(Event.RESIZE,onResize);
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN_OK,alterMap);
         Global.control.removeCallBack(Enum_AiDeBaoBao.RESET_MAP,alterMap);
         Global.control.removeCallBack(Enum_AiDeBaoBao.RESET_MAP_MIDDLE,alterMap_middle);
         Global.control.removeCallBack(Enum_AiDeBaoBao.RESET_MAP_MIDDLE_2,alterMap_middle2);
         Global.control.removeCallBack(Enum_AiDeBaoBao.RESET_MAP_END,alterMap_end);
         if(Boolean(startLine))
         {
            EffectManager.removeEffect(startLine);
            startLine = null;
         }
         if(Boolean(middleLine))
         {
            EffectManager.removeEffect(middleLine);
            middleLine = null;
         }
         if(Boolean(middleLine2))
         {
            EffectManager.removeEffect(middleLine2);
            middleLine2 = null;
         }
         if(Boolean(endLine))
         {
            EffectManager.removeEffect(endLine);
            endLine = null;
         }
         if(Boolean(flowerDown_MC))
         {
            if(Boolean(flowerDown_MC.parent))
            {
               flowerDown_MC.parent.removeChild(flowerDown_MC);
            }
            flowerDown_MC = null;
         }
      }
      
      private static function sendPosition(e:TimerEvent) : void
      {
         AiDeBaoBaoCGMessage.CG_AiDeBaoBao_CHECK_POSITION(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y);
      }
      
      private static function clickBtnHandler(event:MouseEvent) : void
      {
         GameUnitManager.hero.stopGo();
         View_Alert.show(LangConfig.getWord("10308",1),2,function():void
         {
            AiDeBaoBaoCGMessage.CG_AiDeBaoBao_EXIT();
         });
      }
      
      private static function overBtnHandler(e:MouseEvent) : void
      {
         btn3.transform.colorTransform = Util.colorWhite2;
      }
      
      private static function outBtnHandler(e:MouseEvent) : void
      {
         btn3.transform.colorTransform = Util.colorNomal;
      }
      
      private static function alterMap(e:*) : void
      {
         if(SceneConfig.getSceneType() != SceneConfig.AiDeBaoBao)
         {
            return;
         }
         if(e == Enum_AiDeBaoBao.RESET_MAP)
         {
            AStar.setBlock(startPointArray,false);
            if(Boolean(startLine))
            {
               EffectManager.removeEffect(startLine);
               startLine = null;
            }
         }
         else
         {
            AStar.setBlock(startPointArray,true);
            AStar.setBlock(middlePointArray,true);
            AStar.setBlock(middlePointArray2,false);
            AStar.setBlock(endPointArray,true);
            GameUnitManager.addUnit(new View_AiDeBaoBao_staticNPC(Data_lib.AiDeBaoBao_position[5][3],Data_lib.AiDeBaoBao_position[5][0],Data_lib.AiDeBaoBao_position[5][4],Data_lib.AiDeBaoBao_position[5][2],Data_lib.AiDeBaoBao_position[5][1].split("_")));
            GameUnitManager.addUnit(new View_AiDeBaoBao_staticNPC(Data_lib.AiDeBaoBao_position[6][3],Data_lib.AiDeBaoBao_position[6][0],Data_lib.AiDeBaoBao_position[6][4],Data_lib.AiDeBaoBao_position[6][2],Data_lib.AiDeBaoBao_position[6][1].split("_")));
            GameUnitManager.addUnit(new View_AiDeBaoBao_staticNPC(Data_lib.AiDeBaoBao_position[7][3],Data_lib.AiDeBaoBao_position[7][0],Data_lib.AiDeBaoBao_position[7][4],Data_lib.AiDeBaoBao_position[7][2],Data_lib.AiDeBaoBao_position[7][1].split("_")));
            GameUnitManager.addUnit(new View_AiDeBaoBao_staticNPC(Data_lib.AiDeBaoBao_position[8][3],Data_lib.AiDeBaoBao_position[8][0],Data_lib.AiDeBaoBao_position[8][4],Data_lib.AiDeBaoBao_position[8][2],Data_lib.AiDeBaoBao_position[8][1].split("_")));
            if(!startLine)
            {
               startLine = EffectManager.addEffect("35214",GameScene.gridLayer,1000,6845,3905,true);
            }
            if(!middleLine)
            {
               middleLine = EffectManager.addEffect("35214",GameScene.gridLayer,1000,2635,1100,true);
            }
            if(Boolean(middleLine2))
            {
               EffectManager.removeEffect(middleLine2);
               middleLine2 = null;
            }
            if(!endLine)
            {
               endLine = EffectManager.addEffect("35214",GameScene.gridLayer,1000,1354,4131,true);
               endLine.scaleX = -1;
            }
         }
         if(playMC)
         {
            playMC = false;
            if(!flowerDown_MC)
            {
               flowerDown_MC = ComponentUtil.getDisplayObject("FlowerDown",null,null,Global.ADBB_Imgsdm) as MovieClip;
               flowerDown_MC.mouseEnabled = false;
               flowerDown_MC.mouseChildren = false;
            }
            GameScene.uiLayer.addChild(flowerDown_MC);
            flowerDown_MC.gotoAndPlay(2);
         }
      }
      
      private static function alterMap_middle(e:Boolean) : void
      {
         if(SceneConfig.getSceneType() != SceneConfig.AiDeBaoBao)
         {
            return;
         }
         if(e)
         {
            AStar.setBlock(middlePointArray,true);
            if(!middleLine)
            {
               middleLine = EffectManager.addEffect("35214",GameScene.gridLayer,1000,2529,1162,true);
            }
         }
         else
         {
            AStar.setBlock(middlePointArray,false);
            if(Boolean(middleLine))
            {
               EffectManager.removeEffect(middleLine);
               middleLine = null;
            }
         }
      }
      
      private static function alterMap_middle2(e:Boolean) : void
      {
         if(SceneConfig.getSceneType() != SceneConfig.AiDeBaoBao)
         {
            return;
         }
         if(e)
         {
            AStar.setBlock(middlePointArray2,true);
            if(!middleLine2)
            {
               middleLine2 = EffectManager.addEffect("35214",GameScene.gridLayer,1000,3337,1466,true);
            }
         }
         else
         {
            AStar.setBlock(middlePointArray2,false);
            if(Boolean(middleLine2))
            {
               EffectManager.removeEffect(middleLine2);
               middleLine2 = null;
            }
         }
      }
      
      private static function alterMap_end(e:Boolean) : void
      {
         if(SceneConfig.getSceneType() != SceneConfig.AiDeBaoBao)
         {
            return;
         }
         if(e)
         {
            AStar.setBlock(endPointArray,true);
            if(!endLine)
            {
               endLine = EffectManager.addEffect("35214",GameScene.gridLayer,1000,1354,4131,true);
               endLine.scaleX = -1;
            }
         }
         else
         {
            AStar.setBlock(endPointArray,false);
            if(Boolean(endLine))
            {
               EffectManager.removeEffect(endLine);
               endLine = null;
            }
         }
      }
      
      public static function AddEndPoint() : void
      {
         if(GameUnitManager.hero.status == Status.AiDeBaoBao_Bao)
         {
            GameScene.instance.addFrameCallBack(checkEndPoint);
         }
      }
      
      private static function checkEndPoint() : void
      {
         if(AStar._grid.getNode(int(GameUnitManager.hero.global_x / 25),int(GameUnitManager.hero.global_y / 25)).buffId == Enum_AstarGridType.AiDeBaoBao_endPoint)
         {
            GameScene.instance.removeFrameCallBack(checkEndPoint);
            AiDeBaoBaoCGMessage.CG_AiDeBaoBao_ARRIVE_END();
         }
      }
      
      public static function Arrive_end(costTime:int, rank:int) : void
      {
         View_AiDeBaoBao_finishMenu.instance.visible = true;
         View_AiDeBaoBao_findPartner.instance.visible = false;
         View_AiDeBaoBao_finishMenu.instance.setCostTime(costTime,rank);
         View_AiDeBaoBao_returnIcon.instance.visible = true;
         alterMap_end(true);
         playMC = true;
      }
      
      public static function SkillBuffStart(skillId:int) : void
      {
         switch(skillId)
         {
            case 1:
               if(!skillTimer1)
               {
                  skillTimer1 = new Timer(1000,8);
                  skillTimer1.addEventListener(TimerEvent.TIMER_COMPLETE,onSkillBuffEnd);
               }
               skillTimer1.reset();
               skillTimer1.start();
               break;
            case 2:
               if(!skillTimer2)
               {
                  skillTimer2 = new Timer(1000,3);
                  skillTimer2.addEventListener(TimerEvent.TIMER_COMPLETE,onSkillBuffEnd);
               }
               skillTimer2.reset();
               skillTimer2.start();
               break;
            case 3:
               if(!skillTimer3)
               {
                  skillTimer3 = new Timer(1000,3);
                  skillTimer3.addEventListener(TimerEvent.TIMER_COMPLETE,onSkillBuffEnd);
               }
               skillTimer3.reset();
               skillTimer3.start();
               UIManager.centerBroadcast.addMsg("你被<font color=\'#ff0000\'>定身</font>了!!!!赶紧使用<font color=\'#ff0000\'>免疫</font>技能吧!");
               if(GameUnitManager.hero.status == Status.AiDeBaoBao_Bao)
               {
                  Global.control.sendNotification(Enum_AiDeBaoBao.GUIDE_ARROW_POINT_TO_SKILL,2);
               }
               break;
            case 4:
               if(!skillTimer4)
               {
                  skillTimer4 = new Timer(1000,3);
                  skillTimer4.addEventListener(TimerEvent.TIMER_COMPLETE,onSkillBuffEnd);
               }
               skillTimer4.reset();
               skillTimer4.start();
               UIManager.centerBroadcast.addMsg("你被<font color=\'#ff0000\'>眩晕</font>了!!!!");
         }
      }
      
      private static function onSkillBuffEnd(e:TimerEvent) : void
      {
         switch(e.currentTarget)
         {
            case skillTimer1:
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_SKILL_BUFF(1);
               break;
            case skillTimer2:
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_SKILL_BUFF(2);
               break;
            case skillTimer3:
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_SKILL_BUFF(3);
               break;
            case skillTimer4:
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_SKILL_BUFF(4);
         }
      }
   }
}

