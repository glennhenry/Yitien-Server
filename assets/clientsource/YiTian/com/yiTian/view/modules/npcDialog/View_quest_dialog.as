package com.yiTian.view.modules.npcDialog
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_NPC_ID;
   import com.yiTian.data.config.Enum_quest_type;
   import com.yiTian.data.config.Enum_thing_type;
   import com.yiTian.data.model.Model_CrossDart;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.quest.Vo_quest;
   import com.yiTian.data.vo.quest.Vo_questStep;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.QuestDailyManager;
   import com.yiTian.manager.QuestGuiManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CrossDartCGMessage;
   import com.yiTian.net.message.cg.PaoBiaoCGMessage;
   import com.yiTian.net.message.cg.QingmingCGMessage;
   import com.yiTian.net.message.cg.QuestCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.NpcPanel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.guide.View_questGuiJian;
   import com.yiTian.view.modules.paobiao.PaoBiaoVO;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   
   public class View_quest_dialog extends NpcPanel
   {
      
      private var NPC_DIALOG:MyTextField;
      
      private var JiangLi_text:MyTextField;
      
      private var Player_DIALOG:WordItem;
      
      private var wupingTF:MyTextField;
      
      private var NPCHead:Bitmap;
      
      private var rewardGrids:Array = [];
      
      private var _gridsXY:Vector.<Point> = new Vector.<Point>();
      
      private var _curQuest:Vo_quest;
      
      public function View_quest_dialog()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var rewardGrid:View_Grid = null;
         var back:Bitmap = ComponentUtil.getBitmap("Talk",this,null,Global.npcTalk);
         var back2:Bitmap = ComponentUtil.getBitmap("NPC_Award",this,{
            "x":16,
            "y":148
         },Global.npcTalk);
         this.NPC_DIALOG = ComponentUtil.getTextField("",this,{
            "x":195,
            "y":11,
            "color":14145887,
            "realWidth":340,
            "multiline":true,
            "wordWrap":true,
            "leading":3
         });
         this.NPC_DIALOG.mouseEnabled = true;
         this.NPC_DIALOG.addEventListener(TextEvent.LINK,this.dialogLink);
         CloseButton = ComponentUtil.getButton("","NPC_Close",this,{
            "x":517,
            "y":7
         },Global.npcTalk);
         this.Player_DIALOG = new WordItem();
         this.Player_DIALOG.x = 16;
         this.Player_DIALOG.y = 112;
         addChild(this.Player_DIALOG);
         this.NPCHead = new Bitmap();
         this.NPCHead.x = 0;
         this.NPCHead.y = -15;
         addChild(this.NPCHead);
         this.JiangLi_text = ComponentUtil.getTextField("",this,{
            "x":30,
            "y":155,
            "color":14013822
         });
         this.wupingTF = ComponentUtil.getTextField(LangConfig.getWord("10615",1),this,{
            "y":155,
            "color":14013822
         });
         var i:int = 0;
         while(i < 2)
         {
            rewardGrid = new View_Grid();
            rewardGrid.type = Enum_type_grid.QUEST_TRACE_PANEL;
            rewardGrid.set_bmp_bg();
            rewardGrid.set_bmp_over();
            rewardGrid.x = 412 + i * 45;
            rewardGrid.y = 157;
            addChild(rewardGrid);
            this.rewardGrids.push(rewardGrid);
            i++;
         }
         addEventListener(MouseEvent.CLICK,this.doQuest);
      }
      
      override protected function initDynamicView() : void
      {
         if(Boolean(CloseButton))
         {
            CloseButton.callBack = this.closeClick;
         }
      }
      
      private function closeClick(e:MouseEvent) : void
      {
         if(GameUnitManager.hero.level <= Global.quest_auto_level)
         {
            this.doQuest(null);
         }
         else
         {
            this.visible = false;
         }
         e.stopPropagation();
      }
      
      public function showEff(thing:Array) : void
      {
         var type:int = 0;
         var point:Point = null;
         var item:Vo_equip = null;
         var vo:Vo_item = null;
         var len:int = int(thing.length);
         var i:uint = 0;
         while(i < this.rewardGrids.length)
         {
            this._gridsXY[i] = localToGlobal(new Point(this.rewardGrids[i].x,this.rewardGrids[i].y));
            i++;
         }
         i = 0;
         while(i < len)
         {
            type = int(thing[i][0]);
            point = new Point(Global.stage.stageWidth / 2,(Global.stage.stageHeight + 30) / 2);
            if(type == Enum_thing_type.EQUIP)
            {
               item = new Vo_equip();
               item.id = thing[i][1];
               item.Init_lib();
               Tween.gridToBagBezierFuncDef(item,-1,point.x,point.y);
            }
            else if(type == Enum_thing_type.ITEM)
            {
               vo = new Vo_item();
               vo.id = thing[i][1];
               vo.Init_lib();
               Tween.gridToBagBezierFuncDef(vo,-1,point.x,point.y);
            }
            i++;
         }
      }
      
      public function showQuest(npc:Npc, quest:Vo_quest) : void
      {
         var dialogStr:String = null;
         var step:Vo_questStep = null;
         show(npc);
         this._curQuest = quest;
         this.NPCHead.bitmapData = null;
         Utils.getSwfBitmap(Const_strImg.getNpcHeadSWF(Data_lib.npc[npc.sysId][Npc.HEAD]),this.NPCHead,null,this.npcLoadComp);
         if(quest.status == -1)
         {
            dialogStr = quest.acceptStep.dialog;
         }
         else if(quest.status == 0)
         {
            step = quest.continueStep[quest.step - 1];
            dialogStr = step.dialog;
         }
         else
         {
            dialogStr = quest.finishStep.dialog;
         }
         var dialogArr:Array = dialogStr.split("<sp>");
         var npcDialog:Array = dialogArr[0].split("<br/>");
         this.NPC_DIALOG.htmlText = HtmlUtil.fontBr(npcDialog[0],ColorConstant.getColorStr(ColorConstant.NPC_NAME),14) + "    " + npcDialog[1];
         var playerDialog:Array = dialogArr[1].split(/[:：]/gi);
         this.Player_DIALOG.htmlText = "<u>" + HtmlUtil.fontNoSize(HtmlUtil.link((playerDialog[1] as String).replace("<br/>",""),"doQuest"),ColorConstant.getColorStr(ColorConstant.GREEN)) + "</u>";
         var rewardStr:String = "";
         var i:int = 0;
         while(i < quest.reward.baseProp.length)
         {
            rewardStr += quest.reward.baseProp[i] + "    ";
            if(i % 3 == 2)
            {
               rewardStr += "\n";
            }
            i++;
         }
         this.JiangLi_text.htmlText = rewardStr;
         if(Boolean(quest.reward.items.length))
         {
            this.wupingTF.visible = true;
            this.wupingTF.x = this.JiangLi_text.x + this.JiangLi_text.textWidth + 10;
         }
         else
         {
            this.wupingTF.visible = false;
         }
         i = 0;
         while(i < this.rewardGrids.length)
         {
            if(Boolean(quest.reward.items[i]))
            {
               this.rewardGrids[i].vo = quest.reward.items[i];
               this.rewardGrids[i].visible = true;
               this.rewardGrids[i].x = this.wupingTF.x + this.wupingTF.textWidth + 5 + 45 * i;
            }
            else
            {
               this.rewardGrids[i].visible = false;
            }
            i++;
         }
         this.visible = true;
         if(Boolean(Model_quest.curMainQ))
         {
            if(Model_quest.curMainQ.status == -1 && Model_quest.curMainQ.acceptStep.npcId == bindNpc.sysId)
            {
               this.showMainQGuide();
            }
            if(Model_quest.curMainQ.status == 1 && Model_quest.curMainQ.finishStep.npcId == bindNpc.sysId)
            {
               this.showMainQGuide();
            }
         }
         if(npc.sysId == Enum_NPC_ID.YTF_LIBIAOTOU && Boolean(PaoBiaoVO.isCaiBiao))
         {
            PaoBiaoCGMessage.CG_ZHI_BIAO(1);
            this.visible = false;
            return;
         }
         if(npc.sysId == Enum_NPC_ID.YTF_LIBIAOTOU && Boolean(PaoBiaoVO.isCaiBiao))
         {
            PaoBiaoCGMessage.CG_ZHI_BIAO(1);
            this.visible = false;
            return;
         }
      }
      
      private function npcLoadComp() : void
      {
         this.NPCHead.y = 102 - this.NPCHead.height;
      }
      
      private function dialogLink(e:TextEvent) : void
      {
      }
      
      private function doQuest(e:MouseEvent) : void
      {
         if(Boolean(e) && e.target == CloseButton)
         {
            return;
         }
         if(this._curQuest.type == Enum_quest_type.ZHUOGUI && this._curQuest.status == -1)
         {
            QingmingCGMessage.CG_QINGMING_REFRESH_PANEL();
            return;
         }
         if(this._curQuest.type == Enum_quest_type.DAILY && this._curQuest.status == -1)
         {
            if(QuestDailyManager.count == 1)
            {
               UIManager.questDailyAccView.visible = true;
               UIManager.questDailyAccView.callBack = this.acceptDailyQuest;
            }
            else
            {
               QuestCGMessage.CG_QUEST_DAILY_ACCEPT(this._curQuest.id,0);
               this.visible = false;
            }
            return;
         }
         if(this._curQuest.type == Enum_quest_type.PAOBIAO && this._curQuest.status == -1)
         {
            if(Model_CrossDart.isCross())
            {
               if(Model_CrossDart.inCrossScence)
               {
                  PaoBiaoCGMessage.CG_YUNSONG_TIMES();
               }
               else
               {
                  CrossDartCGMessage.CG_CROSSDART_OPENAC(Model_CrossDart.TYPE_NPC);
               }
               return;
            }
            if(UIManager.paoBiaoPanel.hasIcon())
            {
               this.okCallBack();
            }
            else
            {
               View_Alert.show(LangConfig.getWord("10628",1),View_Alert.OK_CANCAL,this.okCallBack);
            }
            this.visible = false;
            return;
         }
         var status:int = this._curQuest.status;
         if(status == -1)
         {
            if(this._curQuest.id == 10204)
            {
               if(CommandManager.get_bag_canUse() - CommandManager.get_bag_used() == 0)
               {
                  UIManager.centerBroadcast.addMsg("背包已满");
                  return;
               }
            }
            QuestCGMessage.CG_QUEST_ACCEPT(this._curQuest.id);
         }
         else if(status == 0)
         {
            QuestCGMessage.CG_QUEST_CONTINUE(this._curQuest.id);
         }
         else if(Model_CrossDart.status == Model_CrossDart.STATUS_ING && Model_CrossDart.inCrossScence)
         {
            QuestCGMessage.CG_QUEST_FINISH(Model_CrossDart.questId,0);
         }
         else
         {
            QuestCGMessage.CG_QUEST_FINISH(this._curQuest.id,0);
         }
         this.visible = false;
      }
      
      private function okCallBack() : void
      {
         PaoBiaoCGMessage.CG_YUNSONG_TIMES();
      }
      
      public function zhiBiaoHanlder() : void
      {
         if(this._curQuest.type == Enum_quest_type.PAOBIAO)
         {
            this.doQuest(null);
         }
      }
      
      private function acceptDailyQuest(YXLid:int) : void
      {
         QuestCGMessage.CG_QUEST_DAILY_ACCEPT(this._curQuest.id,YXLid);
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            if(UIManager.questDailyAccView.visible)
            {
               UIManager.questDailyAccView.visible = false;
            }
            if(View_questGuiJian.instance.bindSpr == this)
            {
               UIManager.questTraceView.showMainQGuide();
            }
         }
      }
      
      public function showMainQGuide() : void
      {
         QuestGuiManager.addKuang(null,25,110,this.Player_DIALOG.width,23);
         QuestGuiManager.addJian(this,this.Player_DIALOG.width + 25,120,180);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 560) / 2;
         y = (Global.stage.stageHeight - 200) / 2;
      }
   }
}

