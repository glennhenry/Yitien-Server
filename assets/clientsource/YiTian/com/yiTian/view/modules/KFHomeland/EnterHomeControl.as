package com.yiTian.view.modules.KFHomeland
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_npc_type;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.modules.baby.babyManager.Model_baby;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class EnterHomeControl
   {
      
      public static var dismantId:int;
      
      public static var xDismantGrid:int;
      
      public static var yDismantGrid:int;
      
      private static var _instance:EnterHomeControl;
      
      public static var homeName_ofPlayer:String = "";
      
      public static var maskSP:Sprite = new Sprite();
      
      public var visiteFriHome:VisiteFriendHome;
      
      public var sortBuild:SortBuildings;
      
      public var introduceH:IntroduceHome;
      
      private var friendBtn:Button;
      
      private var buildBtn:Button;
      
      private var dismantleBtn:Button;
      
      public var exitBtn:MainUIBtn;
      
      private var goHomeBtn:Button;
      
      private var intrBtn:Button;
      
      private var _dismantNum:int;
      
      private var _dismantSymbol:int;
      
      private var _dismantNumBit:Bitmap;
      
      private var _dismantNumTxt:MyTextField;
      
      public var attBar:ownerAttBar;
      
      private var homeId:int;
      
      private var dismanleBVec:Vector.<CreatedBuildings>;
      
      private var tipsTxt:MyTextField;
      
      private var lastTi:int;
      
      private var starTi:int;
      
      public function EnterHomeControl()
      {
         super();
         if(!Global.KFJYdm)
         {
            SingleLoader.add("lang/ch/KFJY.swf",function(info:Object):void
            {
               Global.KFJYdm = info.applicationDomain;
               init();
            });
         }
         else
         {
            this.init();
         }
      }
      
      public static function get instance() : EnterHomeControl
      {
         if(!_instance)
         {
            _instance = new EnterHomeControl();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this.visiteFriHome = new VisiteFriendHome();
         this.sortBuild = new SortBuildings();
         this.attBar = new ownerAttBar();
         this.introduceH = new IntroduceHome();
         this.goHomeBtn = ComponentUtil.getButton("","Button_HuiFu",null,null,Global.KFJYdm);
         this.exitBtn = new MainUIBtn("resource/image/pata/Exit_Icon.png");
         this.friendBtn = ComponentUtil.getButton("","Button_HaoYou",null,null,Global.KFJYdm);
         this.buildBtn = ComponentUtil.getButton("","Button_JianZao",null,null,Global.KFJYdm);
         this.dismantleBtn = ComponentUtil.getButton("","Button_ChanChu",null,null,Global.KFJYdm);
         this.intrBtn = ComponentUtil.getButton("","Button_ShuoMing",null,null,Global.KFJYdm);
         this.goHomeBtn.addEventListener(MouseEvent.CLICK,this.getHomeHandle);
         this.exitBtn.addEventListener(MouseEvent.CLICK,this.exitHandle);
         this.friendBtn.addEventListener(MouseEvent.CLICK,this.friClkHandle);
         this.buildBtn.addEventListener(MouseEvent.CLICK,this.buildClkHandle);
         this.dismantleBtn.addEventListener(MouseEvent.CLICK,this.dismanleClkHandle);
         this.intrBtn.addEventListener(MouseEvent.CLICK,this.intrClkHandle);
      }
      
      private function setBtnCoord() : void
      {
         ComponentUtil.setPropertie(this.exitBtn,{
            "x":UIManager.smallMap.x - 90,
            "y":UIManager.smallMap.y + 10
         });
         var btnX:Number = Global.stage.stageWidth - 25 - 50;
         var btnY:Number = Global.stage.stageHeight - 73 - 20;
         ComponentUtil.setPropertie(this.attBar,{
            "x":Global.stage.stageWidth - this.attBar.width - 10,
            "y":UIManager.smallMap.y + 220
         });
         ComponentUtil.setPropertie(this.dismantleBtn,{
            "x":btnX,
            "y":btnY - this.dismantleBtn.height
         });
         ComponentUtil.setPropertie(this.buildBtn,{
            "x":btnX,
            "y":this.dismantleBtn.y - this.dismantleBtn.height + 0
         });
         ComponentUtil.setPropertie(this.goHomeBtn,{
            "x":btnX,
            "y":this.buildBtn.y
         });
         ComponentUtil.setPropertie(this.friendBtn,{
            "x":btnX,
            "y":this.buildBtn.y - this.buildBtn.height + 0
         });
         if(this.intrBtn.visible)
         {
            ComponentUtil.setPropertie(this.intrBtn,{
               "x":btnX + 40,
               "y":this.friendBtn.y - 30
            });
         }
      }
      
      public function get buildBtnCoord() : Point
      {
         return new Point(this.buildBtn.x,this.buildBtn.y);
      }
      
      public function getIntrBtnCoord() : Point
      {
         return new Point(this.friendBtn.x,this.friendBtn.y - this.friendBtn.height);
      }
      
      private function getHomeHandle(evt:MouseEvent) : void
      {
         HomeLandCGMessage.CG_ENTER_HOMELAND(GameUnitManager.hero.id,0,VoHome.heroS);
      }
      
      private function exitHandle(evt:MouseEvent) : void
      {
         this.exitDismanle();
         this.exitHomeLand();
         HomeLandCGMessage.CG_EXIT_HOMELAND();
      }
      
      private function friClkHandle(evt:MouseEvent) : void
      {
         this.exitDismanle();
         this.visiteFriHome.visible = !this.visiteFriHome.visible;
      }
      
      private function buildClkHandle(evt:MouseEvent) : void
      {
         this.exitDismanle();
         this.sortBuild.visible = !this.sortBuild.visible;
      }
      
      private function intrClkHandle(evt:MouseEvent) : void
      {
         this.introduceH.visible = !this.introduceH.visible;
      }
      
      private function setdismanleNum() : void
      {
         if(!this.dismantleBtn)
         {
            return;
         }
         this._dismantSymbol = VoHome.dismantSymbol;
         if(!this._dismantNumBit)
         {
            this._dismantNumBit = ComponentUtil.getBitmap("cishu_tis",this.dismantleBtn,{
               "x":2,
               "y":2
            },Global.New_Imgsdm);
            this._dismantNumTxt = ComponentUtil.getTextField("",this.dismantleBtn,{
               "size":11,
               "color":16771584,
               "x":this._dismantNumBit.x + this._dismantNumBit.width / 2 - 2.5,
               "y":5
            },"center");
         }
         this.showDismanleNum(true);
         this._dismantNumTxt.text = String(this._dismantSymbol);
      }
      
      public function showDismanleNum(boo:Boolean) : void
      {
         if(Boolean(this._dismantNumBit))
         {
            this._dismantNumBit.visible = boo;
            this._dismantNumTxt.visible = boo;
         }
      }
      
      private function dismanleClkHandle(evt:MouseEvent) : void
      {
         VoHome.isDismant = true;
         if(VoHome.isOut == 1 && VoHome.isMyHome == 1)
         {
            this.dismanleBVec = VoHome.outBuildVec;
         }
         else if(VoHome.isOut == 2 && VoHome.isMyHome == 1)
         {
            this.dismanleBVec = VoHome.innerBuildVec;
         }
         if(!this.dismanleBVec || this.dismanleBVec.length <= 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30149",3));
            return;
         }
         this._dismantNum = this.dismanleBVec.length;
         this.setdismanleNum();
         var i:int = 0;
         while(i < this._dismantNum)
         {
            this.dismanleBVec[i].dismantleStatus(true);
            i++;
         }
         if(!Global.stage.hasEventListener(MouseEvent.MOUSE_UP))
         {
            Global.stage.addEventListener(MouseEvent.MOUSE_UP,this.upHandle);
         }
         this.addEscTips("按‘Esc’键可取消拆除状态");
      }
      
      public function addEscTips(str:String = "按‘Esc’键可取消建造状态") : void
      {
         if(!this.tipsTxt)
         {
            this.tipsTxt = ComponentUtil.getTextField(str,GameScene.uiLayer,{
               "x":UIManager.mainMenu.x + 100,
               "y":UIManager.mainMenu.y - 30,
               "color":16383744,
               "size":20,
               "leading":0
            });
         }
         else
         {
            this.tipsTxt.visible = true;
            this.tipsTxt.text = str;
            ComponentUtil.setPropertie(this.tipsTxt,{
               "x":UIManager.mainMenu.x + 100,
               "y":UIManager.mainMenu.y - 30
            });
         }
      }
      
      public function hideEscTips() : void
      {
         if(Boolean(this.tipsTxt))
         {
            this.tipsTxt.visible = false;
         }
      }
      
      private function upHandle(evt:MouseEvent) : void
      {
         var display:DisplayObject = evt.target as DisplayObject;
         if(VoHome.isDismant && display is CreatedBuildings)
         {
            CreatedBuildings(display).dismantleHandle(evt);
            Global.stage.removeEventListener(MouseEvent.MOUSE_UP,this.upHandle);
         }
      }
      
      public function exitDismanle() : void
      {
         var i:int = 0;
         VoHome.isDismant = false;
         this.hideEscTips();
         if(Global.stage.hasEventListener(MouseEvent.MOUSE_UP))
         {
            Global.stage.removeEventListener(MouseEvent.MOUSE_UP,this.upHandle);
         }
         if(Boolean(this._dismantNum > 0) && Boolean(this.dismanleBVec) && this.dismanleBVec.length > 0)
         {
            i = 0;
            while(i < this._dismantNum)
            {
               this.dismanleBVec[i].dismantleStatus(false);
               i++;
            }
            this.showDismanleNum(false);
         }
      }
      
      public function sureDismanle() : void
      {
         var i:int = 0;
         var serverInfoArr:Array = null;
         var build:CreatedBuildings = null;
         if(Global.stage.hasEventListener(MouseEvent.MOUSE_UP))
         {
            Global.stage.removeEventListener(MouseEvent.MOUSE_UP,this.upHandle);
         }
         i = 0;
         while(i < this._dismantNum)
         {
            build = this.dismanleBVec[i];
            if(this.dismanleBVec[i].id == dismantId && this.dismanleBVec[i].xGrid == xDismantGrid && this.dismanleBVec[i].yGrid == yDismantGrid)
            {
               GameUnitManager.removeUnit(build);
               this.dismanleBVec.splice(i,1);
               this._dismantNum = this.dismanleBVec.length;
               i -= 1;
               if(i < 0)
               {
                  i = 0;
               }
            }
            i++;
         }
         if(VoHome.isOut == 1)
         {
            serverInfoArr = VoHome.outHomeBuildInfoArr;
         }
         else if(VoHome.isOut == 2)
         {
            serverInfoArr = VoHome.innerHomeBuildInfoArr;
         }
         if(serverInfoArr.length > 0)
         {
            i = 0;
            while(i < serverInfoArr.length)
            {
               if(serverInfoArr[i][0] == dismantId && serverInfoArr[i][1] == xDismantGrid && serverInfoArr[i][2] == yDismantGrid)
               {
                  serverInfoArr.splice(i,1);
                  i -= 1;
                  if(i < 0)
                  {
                     i = 0;
                  }
               }
               i++;
            }
         }
         dismantId = -1;
      }
      
      public function enterHomeMap() : void
      {
         Global.isInHome = true;
         ModalUIManager.HIDE();
         this.showModules(false);
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,function():void
         {
            setBtnCoord();
         });
      }
      
      public function updateHomeBuild(name:String) : void
      {
         this.addHomeLandBtn(true);
         if(VoHome.isOut == 1)
         {
            VoHome.outBuildVec = null;
         }
         else if(VoHome.isOut == 2)
         {
            VoHome.innerBuildVec = null;
         }
         BuildAction.instance.reset();
         BuildAction.instance.layoutBudilings();
         if(!this.isMyHome())
         {
            this.addEscTips("欢迎参观" + Model_heFu.repName(name) + "家园");
         }
         else
         {
            this.hideEscTips();
         }
         homeName_ofPlayer = Model_heFu.repNameByHero(name);
      }
      
      private function showModules(boo:Boolean) : void
      {
         UIManager.questTraceView.visible = boo;
         UIManager.newMainBtnContainer.visible = boo;
         UIManager.mainUiBtnContainer.visible = boo;
         UIManager.special_btn.visible = boo;
         UIManager.smallMap.changeBtnEnable(boo);
         UIManager.mainMenu.updateCrossClanBtn(boo);
         UIManager.heroHead.enabledCZBtn(boo);
         if(!boo)
         {
            UIManager.friendPanel.visible = boo;
         }
         UIManager.tipBtnContainer.visible = boo;
         Model_baby.isEnableRole_beside_icon = boo;
      }
      
      public function addIntrBtn(boo:Boolean) : void
      {
         this.intrBtn.visible = boo;
         if(boo)
         {
            if(this.friendBtn.visible)
            {
               ComponentUtil.setPropertie(this.intrBtn,{
                  "x":this.friendBtn.x + 40,
                  "y":this.friendBtn.y - 30
               });
            }
            GameScene.uiLayer.addChild(this.intrBtn);
         }
         else if(GameScene.uiLayer.contains(this.intrBtn))
         {
            GameScene.uiLayer.removeChild(this.intrBtn);
         }
      }
      
      private function showExitBtn() : void
      {
         if(getTimer() - this.starTi - this.lastTi >= 5000)
         {
            GameScene.instance.removeFrameCallBack(this.showExitBtn);
            this.exitBtn.visible = true;
         }
      }
      
      private function addHomeLandBtn(boo:Boolean) : void
      {
         var homeNpc:Npc = null;
         this.friendBtn.visible = boo;
         if(boo)
         {
            this.starTi = getTimer();
            GameScene.instance.addFrameCallBack(this.showExitBtn);
         }
         else
         {
            if(GameScene.instance.hasFrameCallBack(this.showExitBtn))
            {
               GameScene.instance.removeFrameCallBack(this.showExitBtn);
            }
            this.exitBtn.visible = false;
         }
         this.buildBtn.visible = boo && this.isMyHome();
         if(this.isMyHome() && boo)
         {
            GameScene.mainLayer.mouseEnabled = boo;
            GameScene.mainLayer.mouseChildren = boo;
         }
         else
         {
            GameScene.mainLayer.mouseEnabled = false;
            GameScene.mainLayer.mouseChildren = false;
         }
         this.dismantleBtn.visible = this.buildBtn.visible;
         this.attBar.visible = this.buildBtn.visible;
         this.goHomeBtn.visible = !this.buildBtn.visible;
         if(boo)
         {
            GameScene.uiLayer.addChild(this.friendBtn);
            GameScene.uiLayer.addChild(this.exitBtn);
            if(this.buildBtn.visible)
            {
               GameScene.uiLayer.addChild(this.buildBtn);
               GameScene.uiLayer.addChild(this.dismantleBtn);
               GameScene.uiLayer.addChild(this.attBar);
               this.attBar.visible = true;
               this.attBar.update();
            }
            else
            {
               GameScene.uiLayer.addChild(this.goHomeBtn);
            }
            this.setBtnCoord();
         }
         else
         {
            if(GameScene.uiLayer.contains(this.friendBtn))
            {
               GameScene.uiLayer.removeChild(this.friendBtn);
            }
            if(GameScene.uiLayer.contains(this.buildBtn))
            {
               GameScene.uiLayer.removeChild(this.buildBtn);
            }
            if(GameScene.uiLayer.contains(this.dismantleBtn))
            {
               GameScene.uiLayer.removeChild(this.dismantleBtn);
            }
            if(GameScene.uiLayer.contains(this.exitBtn))
            {
               GameScene.uiLayer.removeChild(this.exitBtn);
            }
            if(GameScene.uiLayer.contains(this.goHomeBtn))
            {
               GameScene.uiLayer.removeChild(this.goHomeBtn);
            }
            if(GameScene.uiLayer.contains(this.attBar))
            {
               GameScene.uiLayer.removeChild(this.attBar);
            }
         }
         if(!this.isMyHome() && VoHome.isOut == 1)
         {
            homeNpc = Npc.getNpcBySysid(Enum_npc_type.HOMENPCSYSID);
            if(Boolean(homeNpc))
            {
               GameUnitManager.removeUnit(homeNpc);
            }
         }
      }
      
      public function isMyHome() : Boolean
      {
         if(VoHome.isMyHome == 1)
         {
            return true;
         }
         return false;
      }
      
      public function exitHomeLand() : void
      {
         Global.isInHome = false;
         this.showModules(true);
         this.addHomeLandBtn(false);
         this.addIntrBtn(false);
         VoHome.outBuildVec = null;
         VoHome.innerBuildVec = null;
         if(this.sortBuild.visible)
         {
            this.sortBuild.visible = false;
         }
         if(HomeSpecialMall.instance.visible)
         {
            HomeSpecialMall.instance.visible = false;
         }
         if(this.visiteFriHome.visible)
         {
            this.visiteFriHome.visible = false;
         }
         if(this.intrBtn.visible)
         {
            this.intrBtn.visible = false;
         }
         this.hideEscTips();
      }
      
      private function delCacheBuild(vec:Vector.<CreatedBuildings>) : void
      {
         var i:int = 0;
         var delB:CreatedBuildings = null;
         if(Boolean(vec) && vec.length > 0)
         {
            i = 0;
            while(i < vec.length)
            {
               delB = vec[i];
               GameUnitManager.removeUnit(delB);
               i++;
            }
         }
      }
      
      public function buildHome() : void
      {
         this.hideSmallAction(false);
      }
      
      private function hideSmallAction(boo:Boolean) : void
      {
         UIManager.heroHead.visible = boo;
         if(!boo)
         {
            UIManager.mappanel.visible = boo;
         }
         if(Model_team.hasTeam() && boo)
         {
            UIManager.teamSignTogether.visible = true;
         }
         else
         {
            UIManager.teamSignTogether.visible = false;
         }
         UIManager.mainMenu.visible = boo;
         UIManager.chatPanel.visible = boo;
         UIManager.petHeadPanel.visible = boo;
         UIManager.smallMap.visible = boo;
         this.friendBtn.visible = boo;
         this.buildBtn.visible = boo;
         this.exitBtn.visible = boo;
         this.dismantleBtn.visible = boo;
         this.attBar.visible = boo;
         this.intrBtn.visible = boo;
      }
      
      public function exitBuildHome() : void
      {
         this.hideSmallAction(true);
      }
   }
}

