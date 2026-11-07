package com.yiTian.view.modules.quest
{
   import com.ui.controls.Button;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.ScrollBar;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_quest_type;
   import com.yiTian.data.config.Enum_thing_type;
   import com.yiTian.data.model.Model_bqzy;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.quest.Vo_quest;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.QuestGuiManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.MainUIBase;
   import com.yiTian.view.modules.bianqiangzhiyin.View_bqzy;
   import com.yiTian.view.modules.boatChall.BoatManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.newerGuide.Model_newer;
   import com.yiTian.view.modules.newerGuide.QuestNewer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class View_quest_trace extends MainUIBase
   {
      
      public static var isTextLinking:Boolean;
      
      public static var _sign:Boolean;
      
      private static var suoXiaoEd:Boolean = false;
      
      private static var isSuoXiaoRunning:Boolean = false;
      
      private var Button_MissionOpen01:Button;
      
      public var Button_All:Button;
      
      public var Button_MissionTrace:TabButton;
      
      public var Button_KeJieMission:TabButton;
      
      private var Button_Minim:Button;
      
      private var Button_Move1:Button;
      
      private var Button_MissionOpen02:Button;
      
      public var acceptedList:QuestTraceContainer;
      
      public var canAcceptList:QuestTraceContainer;
      
      private var instance6:ScaleBitmap;
      
      private var instance1:Button;
      
      private var instance2:Button;
      
      private var instance3:Button;
      
      private var instance4:Button;
      
      private var instance5:Button;
      
      private var instance7:ScaleBitmap;
      
      private var container:Sprite;
      
      private var miniCon:Sprite;
      
      private var now:TabButton;
      
      public var newerGuideUnit:QuestNewer;
      
      public var beginPoint:Point;
      
      public function View_quest_trace()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.container = new Sprite();
         addChild(this.container);
         this.miniCon = new Sprite();
         addChild(this.miniCon);
         var back:ScaleBitmap = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.container,{
            "x":0,
            "y":0,
            "width":239,
            "height":24
         },Global.Img_Cdm);
         var back2:ScaleBitmap = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.container,{
            "x":0,
            "y":24,
            "width":239,
            "height":140
         },Global.Img_Cdm);
         this.Button_Move1 = ComponentUtil.getButton("","Button_MissionM",this.container,{
            "x":2,
            "y":2,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_MissionTrace = ComponentUtil.getTabButton(LangConfig.getWord("10481",1),"Mission_Four",this.container,{
            "x":75,
            "y":2,
            "textColor":16184781,
            "chooseColor":11904647
         },Global.Img_Cdm);
         this.Button_All = ComponentUtil.getButton(LangConfig.getWord("10262",1),"Button_TiliteFour",this.container,{
            "x":22,
            "y":2,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_KeJieMission = ComponentUtil.getTabButton(LangConfig.getWord("10480",1),"Mission_Four",this.container,{
            "x":146,
            "y":2,
            "textColor":16184781,
            "chooseColor":11904647
         },Global.Img_Cdm);
         ComponentUtil.setPropertie(this.miniCon,{
            "x":217 + 10,
            "y":2 + 10
         });
         this.Button_Minim = ComponentUtil.getButton("","Button_MissionR",this.miniCon,{
            "x":-10,
            "y":-10,
            "textColor":16184781
         },Global.Img_Cdm);
         this.acceptedList = new QuestTraceContainer(236,136);
         this.acceptedList.x = 1;
         this.acceptedList.y = 25;
         this.container.addChild(this.acceptedList);
         this.canAcceptList = new QuestTraceContainer(236,136);
         this.canAcceptList.x = 1;
         this.canAcceptList.y = 25;
         this.container.addChild(this.canAcceptList);
         this.acceptedList.visible = false;
         this.canAcceptList.visible = false;
         this.Button_Move1.addEventListener(MouseEvent.MOUSE_DOWN,this.downEvent);
         this.Button_Move1.addEventListener(MouseEvent.MOUSE_UP,this.upEvent);
         this.miniCon.addEventListener(MouseEvent.CLICK,this.cliHd);
         this.Button_All.addEventListener(MouseEvent.CLICK,this.setQuestPVis);
         this.Button_MissionTrace.binding = this.acceptedList;
         this.Button_KeJieMission.binding = this.canAcceptList;
         this.Button_MissionTrace.addEventListener(MouseEvent.CLICK,this.clickEvent);
         this.Button_KeJieMission.addEventListener(MouseEvent.CLICK,this.clickEvent);
         this.Button_MissionTrace.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         addEventListener(MouseEvent.CLICK,this.moveFun);
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resetPosition);
      }
      
      private function cliHd(e:MouseEvent = null) : void
      {
         var obj:Object = null;
         if(isSuoXiaoRunning)
         {
            return;
         }
         isSuoXiaoRunning = true;
         if(suoXiaoEd)
         {
            obj = {"rotation":[180,0]};
            Tween.to(this.container,200,{
               "scaleX":[0,1],
               "scaleY":[0,1],
               "x":[this.container.x,this.container.x - 237]
            });
         }
         else
         {
            obj = {"rotation":[0,180]};
            Tween.to(this.container,200,{
               "scaleX":[1,0],
               "scaleY":[1,0],
               "x":[this.container.x,this.container.x + 237]
            });
         }
         Tween.to(this.miniCon,200,obj,function():void
         {
            isSuoXiaoRunning = false;
         });
         suoXiaoEd = !suoXiaoEd;
      }
      
      private function moveFun(event:MouseEvent) : void
      {
         if(event.target is MainUIBtn || event.target is Button || event.target is TabButton || event.target is ScrollBar)
         {
            return;
         }
         if(isTextLinking)
         {
            return;
         }
         if(GameUnitManager.hero.level < 30)
         {
            this.touchFun();
            return;
         }
         GameScene.instance.uiOnGo(event);
      }
      
      private function touchFun() : void
      {
         var list:QuestTraceContainer = this.now == this.Button_KeJieMission ? this.canAcceptList : this.acceptedList;
         list.clickFirstQuest();
      }
      
      private function setQuestPVis(e:MouseEvent) : void
      {
         UIManager.questPanel.visible = !UIManager.questPanel.visible;
      }
      
      private function upEvent(e:MouseEvent) : void
      {
         stopDrag();
      }
      
      private function downEvent(e:MouseEvent) : void
      {
         startDrag();
      }
      
      private function clickEvent(e:MouseEvent) : void
      {
         var btn:TabButton = e.target as TabButton;
         this.setBtnChoose(btn);
      }
      
      private function setBtnChoose(btn:TabButton) : void
      {
         if(this.now == btn)
         {
            return;
         }
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         btn.choose = true;
         this.now = btn;
      }
      
      private function boolGuide(questid:int) : Boolean
      {
         if(Data_lib.quest[questid][Model_newer.finiser] == "0")
         {
            return false;
         }
         var ss:String = Data_lib.quest[questid][Model_newer.finiser];
         var arr:Array = ss.split("_");
         if(Boolean(this.newerGuideUnit))
         {
            this.newerGuideUnit.update(172 * Number(int(arr[0]) / int(arr[1])),arr[0] + "/" + arr[1]);
         }
         return true;
      }
      
      public function showIconSp(questId:int) : void
      {
         if(!this.newerGuideUnit)
         {
            this.newerGuideUnit = new QuestNewer();
            this.container.addChild(this.newerGuideUnit);
            this.newerGuideUnit.y = -Model_newer.questPanSpecialLen;
         }
         _sign = this.boolGuide(questId);
         if(_sign)
         {
            y = 210 + Model_newer.questPanSpecialLen;
         }
         else
         {
            y = 210;
         }
         if(Boolean(this.newerGuideUnit))
         {
            this.newerGuideUnit.visible = _sign;
         }
         if(_sign)
         {
            UIManager.newMainBtnContainer.y = 380 + 45 + View_bqzy.thisH;
            Global.control.sendNotification("resetPosition",null);
         }
         else
         {
            UIManager.newMainBtnContainer.y = 380 + View_bqzy.thisH;
         }
      }
      
      public function update() : void
      {
         var quest:Vo_quest = null;
         var _dicEd:Dictionary = Model_quest.accepted;
         var _dicCan:Dictionary = Model_quest.canAccept;
         this.acceptedList.init(Model_quest.accepted);
         this.canAcceptList.init(Model_quest.canAccept);
         for each(quest in Model_quest.accepted)
         {
            if(Boolean(quest) && (quest.type == Enum_quest_type.MAIN || quest.type == Enum_quest_type.DAILY || quest.type == Enum_quest_type.PAOBIAO || quest.type == Enum_quest_type.BANG_HUI || quest.type == Enum_quest_type.ZHUOGUI || quest.type == Enum_quest_type.HUANGBANG))
            {
               this.setBtnChoose(this.Button_MissionTrace);
               return;
            }
         }
         this.setBtnChoose(this.Button_KeJieMission);
      }
      
      public function showEff(thing:Array) : void
      {
         var type:int = 0;
         var item:Vo_equip = null;
         var vo:Vo_item = null;
         var len:int = int(thing.length);
         var i:int = 0;
         while(i < len)
         {
            type = int(thing[i][0]);
            if(type == Enum_thing_type.EQUIP)
            {
               item = new Vo_equip();
               item.id = thing[i][1];
               item.Init_lib();
               if(!this.beginPoint)
               {
                  return;
               }
               Tween.gridToBagBezierFuncDef(item,-1,this.beginPoint.x,this.beginPoint.y);
            }
            else if(type == Enum_thing_type.ITEM)
            {
               vo = new Vo_item();
               vo.id = thing[i][1];
               vo.Init_lib();
               Tween.gridToBagBezierFuncDef(vo,-1,this.beginPoint.x,this.beginPoint.y);
            }
            i++;
         }
      }
      
      public function showMainQGuide() : void
      {
         QuestGuiManager.addKuang(null,25,45,145,23);
         QuestGuiManager.addJian(this.container,35,65,-45);
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth + BoatManager.questCX;
         if(Boolean(this.newerGuideUnit) && this.newerGuideUnit.visible)
         {
            y = 210 + Model_newer.questPanSpecialLen;
         }
         else
         {
            y = 210;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(Model_bqzy.Init)
         {
            View_bqzy.instance.visible = value;
         }
      }
   }
}

