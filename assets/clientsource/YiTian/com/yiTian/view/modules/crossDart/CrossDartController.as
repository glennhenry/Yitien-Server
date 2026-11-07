package com.yiTian.view.modules.crossDart
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_NPC_ID;
   import com.yiTian.data.config.Enum_quest_id;
   import com.yiTian.data.model.Model_CrossDart;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.QuestHandler;
   import com.yiTian.net.message.cg.CrossDartCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.bianqiangzhiyin.View_bqzy;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.npcDialog.View_npcDialog_panel;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   
   public class CrossDartController
   {
      
      private static var btn3:MainUIBtn;
      
      private static var paobiao:MainUIBtn;
      
      private static var expBar:Sprite;
      
      private static var maskBar:Shape;
      
      private static var isCreat:Boolean;
      
      private static var isInit:Boolean;
      
      private static var canTxt:MyTextField;
      
      private static var aceptTxt:MyTextField;
      
      public function CrossDartController()
      {
         super();
      }
      
      public static function enterCrossWorld() : void
      {
         if(!expBar)
         {
            expBar = new Sprite();
            maskBar = ComponentUtil.getShape(617,12,16711680,0);
            if(Global.stage.stageWidth < 1440)
            {
               maskBar.x = (Global.stage.stageWidth + UIManager.chatPanel.width - UIManager.mainMenu.width) / 2 + 101;
               maskBar.y = Global.stage.stageHeight - 12;
            }
            else
            {
               maskBar.x = (Global.stage.stageWidth + UIManager.chatPanel.width - UIManager.mainMenu.width) / 2 + 101;
               maskBar.y = Global.stage.stageHeight - 12;
            }
            expBar.addChild(maskBar);
            GameScene.uiLayer.addChild(expBar);
         }
         ModalUIManager.HIDE();
         UIManager.selfBroadcast.clear();
         TipManager.bind(expBar,LangConfig.getWord("10083",1) + GameUnitManager.hero.exp + " / " + GameUnitManager.hero.nextexp);
         expBar.visible = true;
         Global.isInHome = true;
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,resetPos);
         setEnable(UIManager.special_btn,false);
         setEnable(UIManager.mainMenu,false);
         setEnable(UIManager.petHeadPanel,false);
         setEnable(UIManager.heroHead,false);
         setEnable(UIManager.targetHead,false);
         UIManager.tipBtnContainer.visible = false;
         View_bqzy.instance.visible = false;
         UIManager.newMainBtnContainer.visible = false;
         UIManager.mainUiBtnContainer.visible = false;
         UIManager.questTraceView.visible = false;
         UIManager.questTraceView1.visible = true;
         UIManager.questTraceView1.Button_All.enabled = false;
         UIManager.questTraceView1.x = Global.stage.stageWidth - 240;
         UIManager.questTraceView1.y = 210;
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
         if(!paobiao)
         {
            paobiao = new MainUIBtn("resource/image/paobiao/icon.png");
            paobiao.addEventListener(MouseEvent.CLICK,UIManager.paoBiaoPanel.paoBiaoHandler);
            paobiao.mouseEnabled = true;
            paobiao.visible = true;
            paobiao.filters = [];
         }
         GameScene.uiLayer.addChild(paobiao);
         GameScene.uiLayer.addChild(btn3);
         paobiao.x = Global.stage.stageWidth - 235 - 75 * 2;
         btn3.x = Global.stage.stageWidth - 235 - 75;
         paobiao.showTime(Model_CrossDart.times);
      }
      
      protected static function clickHandler(event:MouseEvent) : void
      {
         if(GameUnitManager.hero.status == Status.SIT)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60038",6));
            return;
         }
         GameUnitManager.hero.autoMove(Enum_NPC_ID.YTF_LIBIAOTOU);
      }
      
      private static function clickBtnHandler(event:MouseEvent) : void
      {
         GameUnitManager.hero.stopGo();
         View_Alert.show("    是否要离开跨服运镖?\n<font color=\'#fe0000\'>(运镖中退出会当做失败处理)</font>",2,function():void
         {
            CrossDartCGMessage.CG_CROSSDART_EXIT();
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
      
      private static function resetPos() : void
      {
         if(Boolean(paobiao))
         {
            UIManager.questTraceView1.x = Global.stage.stageWidth - 240;
            UIManager.questTraceView1.y = 210;
            paobiao.x = Global.stage.stageWidth - 235 - 75 * 2;
         }
         if(Boolean(btn3))
         {
            btn3.x = Global.stage.stageWidth - 235 - 75;
         }
         if(Boolean(maskBar))
         {
            if(Global.stage.stageWidth < 1440)
            {
               maskBar.x = (Global.stage.stageWidth + UIManager.chatPanel.width - UIManager.mainMenu.width) / 2 + 101;
               maskBar.y = Global.stage.stageHeight - 12;
            }
            else
            {
               maskBar.x = (Global.stage.stageWidth + UIManager.chatPanel.width - UIManager.mainMenu.width) / 2 + 101;
               maskBar.y = Global.stage.stageHeight - 12;
            }
         }
      }
      
      public static function get isAuthorMove() : Boolean
      {
         return false;
      }
      
      public static function exitCrossWorld() : void
      {
         View_npcDialog_panel.lastNpc = null;
         Model_quest.delQuest(13002);
         Model_quest.delQuest(Enum_quest_id.KF_PAOBIAO);
         UIManager.mainMenu.setBtnEnabled(true);
         QuestHandler.GC_QUEST_LIST(2,[],[]);
         UIManager.selfBroadcast.clear();
         expBar.visible = false;
         Global.isInHome = false;
         TipManager.unBind(expBar);
         Global.control.removeCallBack(Enum_MsgType.STAGE_RESIZE,resetPos);
         setEnable(UIManager.targetHead,true);
         setEnable(UIManager.mainMenu,true);
         setEnable(UIManager.special_btn,true);
         setEnable(UIManager.petHeadPanel,true);
         setEnable(UIManager.heroHead,true);
         setEnable(UIManager.tipBtnContainer,true);
         UIManager.tipBtnContainer.visible = true;
         UIManager.newMainBtnContainer.visible = true;
         UIManager.mainUiBtnContainer.visible = true;
         UIManager.questTraceView.visible = true;
         UIManager.questTraceView1.visible = false;
         View_bqzy.instance.visible = true;
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
         if(Boolean(btn3) && GameScene.uiLayer.contains(btn3))
         {
            GameScene.uiLayer.removeChild(btn3);
         }
         if(Boolean(paobiao) && GameScene.uiLayer.contains(paobiao))
         {
            GameScene.uiLayer.removeChild(paobiao);
         }
      }
      
      public static function setQuestStatus(r:int, t:int) : void
      {
         var onLink:Function = null;
         var onLink1:Function = null;
         var str:String = null;
         var ss:String = null;
         onLink = function(evt:TextEvent):void
         {
            if(evt.text == "paobiao")
            {
               GameUnitManager.hero.autoMove(Enum_NPC_ID.KF_PAOBIAO);
            }
         };
         onLink1 = function(evt:TextEvent):void
         {
            if(evt.text == "paobiao")
            {
               GameUnitManager.hero.autoMove(Enum_NPC_ID.YTF_LIBIAOTOU);
            }
         };
         Model_CrossDart.status = r;
         if(Boolean(Npc.getNpcBySysid(Enum_NPC_ID.YTF_LIBIAOTOU)))
         {
            UIManager.yunSongBiaoChePanel.visible = false;
         }
         if(!canTxt || !UIManager.questTraceView1.canAcceptList.contains(canTxt))
         {
            str = "<font color=\'#ffffff\'><font color=\'#f9ff00\'>[镖]</font> ·运送镖车\n去<a href=\'event:paobiao\'><font color=\'#ffac00\'><u>应天府</u></font></a>寻找<a href=\'event:paobiao\'><font color=\'#99ff00\'><u>李镖头</u></font></a></font>";
            canTxt = ComponentUtil.getTextField("",UIManager.questTraceView1.canAcceptList,{
               "x":3,
               "y":3
            });
            canTxt.htmlText = str;
            canTxt.mouseEnabled = true;
            canTxt.addEventListener(TextEvent.LINK,onLink1);
         }
         if(!aceptTxt || !UIManager.questTraceView1.acceptedList.contains(aceptTxt))
         {
            ss = "<font color=\'#ffffff\'><font color=\'#f9ff00\'>[镖]</font> ·运送镖车<font color=\'#04ff00\'>(进行中)</font>\n将镖银护送到<a href=\'event:paobiao\'><font color=\'#ffac00\'><u>绿柳庄</u></font></a><a href=\'event:paobiao\'><font color=\'#99ff00\'><u>楚风</u></font></a>";
            aceptTxt = ComponentUtil.getTextField("",UIManager.questTraceView1.acceptedList,{
               "x":3,
               "y":3
            });
            aceptTxt.htmlText = ss;
            aceptTxt.mouseEnabled = true;
            aceptTxt.addEventListener(TextEvent.LINK,onLink);
         }
         if(t == 0 && r != 0)
         {
            canTxt.text = "";
            canTxt.htmlText = "";
            aceptTxt.text = "";
            aceptTxt.htmlText = "";
            QuestHandler.GC_QUEST_LIST(2,[],[]);
            return;
         }
         switch(r)
         {
            case -1:
               isCreat = true;
               QuestHandler.GC_QUEST_LIST(2,[],[[Enum_quest_id.KF_PAOBIAO,-1,0,"",-1]]);
               UIManager.questTraceView1.Button_KeJieMission.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               GameUnitManager.hero.stopGo();
               break;
            case 0:
            case 1:
               isCreat = true;
               QuestHandler.GC_QUEST_ADD(1,Enum_quest_id.KF_PAOBIAO,1,0,"",-1);
               UIManager.questTraceView1.Button_MissionTrace.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               break;
            case 2:
               Model_quest.delQuest(Enum_quest_id.KF_PAOBIAO);
               UIManager.questTraceView1.Button_KeJieMission.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               GameUnitManager.hero.stopGo();
         }
      }
      
      private static function setEnable(spr:Sprite, b:Boolean) : void
      {
         if(b)
         {
            spr.mouseEnabled = true;
            spr.mouseChildren = true;
            spr.filters = [];
         }
         else
         {
            spr.mouseChildren = false;
            spr.mouseEnabled = false;
            spr.filters = Util.disabled;
         }
      }
      
      public static function setTimes() : void
      {
         if(Boolean(paobiao) && GameScene.uiLayer.contains(paobiao))
         {
            paobiao.showTime(Model_CrossDart.times);
         }
         if(Boolean(Npc.getNpcBySysid(Enum_NPC_ID.YTF_LIBIAOTOU)) && Boolean(Model_CrossDart.times == 0) && Model_CrossDart.status != Model_CrossDart.STATUS_ING)
         {
         }
      }
   }
}

