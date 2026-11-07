package com.yiTian.view.modules.mainMenu
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_bar_swap;
   import com.yiTian.data.config.Enum_quest_id;
   import com.yiTian.data.model.Model_jingJiChang;
   import com.yiTian.data.model.Model_layInPill;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.BagHandler;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.net.message.cg.SkillCGMessage;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.net.message.cg.VIPCGMessage;
   import com.yiTian.net.message.cg.XianGouCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bezier;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.MainUIBase;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.Shopping.View_shoppingMall;
   import com.yiTian.view.modules.Shopping.shoppingMall.ShoppingMallPan;
   import com.yiTian.view.modules.banhui.View_bangList;
   import com.yiTian.view.modules.banhui.View_banghuiBack;
   import com.yiTian.view.modules.boatChall.BoatManager;
   import com.yiTian.view.modules.chat.EffecObj;
   import com.yiTian.view.modules.friends.Model_Friends;
   import com.yiTian.view.modules.friends.View_FriendsPanel;
   import com.yiTian.view.modules.friends.View_friQuestList;
   import com.yiTian.view.modules.huaShanLunJian.model.Model_HuaShan;
   import com.yiTian.view.modules.huaShanLunJian.viewer.View_HuaShanZhenXing;
   import com.yiTian.view.modules.newRolePan.View_rolePan;
   import com.yiTian.view.modules.panel.View_bagPanel;
   import com.yiTian.view.modules.panel.View_castPanel;
   import com.yiTian.view.modules.panel.View_rolePanel;
   import com.yiTian.view.modules.skill.View_SkillPanel;
   import com.yiTian.view.modules.team.TeamListPanel;
   import com.yiTian.view.modules.team.TeamSearchPanel;
   import com.yiTian.view.modules.tianTi.View_xinFaPanel;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_MainMenu extends MainUIBase
   {
      
      public static var isLightResult:int;
      
      public static var isLight:Boolean = false;
      
      private static var teamInfo:Array = [];
      
      private var jy_Back:DisplayObject;
      
      private var jy_Load:Bitmap;
      
      private var jy_mask:Shape;
      
      private var guajiBtn:Button;
      
      public var roleBtn:MicroButton;
      
      public var bagBtn:MicroButton;
      
      public var skillBtn:MicroButton;
      
      private var neigongBtn:MicroButton;
      
      private var banghuiBtn:MicroButton;
      
      private var teamBtn:MicroButton;
      
      private var friendBtn:MicroButton;
      
      private var zhenfaBtn:MicroButton;
      
      private var Button_Mall:Button;
      
      public var layInImg:Bitmap;
      
      private var btnCheckAll:Button;
      
      private var maskBar:Sprite = new Sprite();
      
      private var back:DisplayObject;
      
      private var obj_vec:Vector.<MicroButton>;
      
      public var sprite:Sprite;
      
      private var grids:Array = [];
      
      private var aimPoint:Point;
      
      public function View_MainMenu()
      {
         super();
      }
      
      public static function zhenfaHandler(e:MouseEvent = null) : void
      {
         var model:Model_HuaShan;
         var teamPnl:View_HuaShanZhenXing = null;
         if(GameUnitManager.hero.level < 5)
         {
            UIManager.centerBroadcast.addMsg("5级以后开启阵型");
            return;
         }
         teamInfo = [[Model_jingJiChang.heropos,1,GameUnitManager.hero.id,GameUnitManager.hero.name,GameUnitManager.hero.body],[Model_jingJiChang.petpos,2,GameUnitManager.pet.id,GameUnitManager.pet.name,GameUnitManager.pet.body]];
         model = Singleton.getInstance(Model_HuaShan);
         model.teamInfo = teamInfo;
         teamPnl = Singleton.getInstance(View_HuaShanZhenXing) as View_HuaShanZhenXing;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(teamPnl,function():void
         {
            teamPnl.update(2);
            ModalUIManager.POPUP(teamPnl);
         });
      }
      
      override protected function initStaticView() : void
      {
         this.obj_vec = new Vector.<MicroButton>();
         this.jy_Back = ComponentUtil.getBitmap("Back_EXP",this,{
            "x":101,
            "y":61
         },Global.Scenedm);
         this.jy_Load = ComponentUtil.getBitmap("EXP",this,{
            "x":101,
            "y":61
         },Global.Scenedm);
         this.jy_mask = ComponentUtil.getShape(this.jy_Load.width,this.jy_Load.height,16711680,0);
         this.jy_mask.x = 101;
         this.jy_mask.y = 61;
         addChild(this.jy_mask);
         this.jy_Load.mask = this.jy_mask;
         this.back = ComponentUtil.getBitmap("Back_GNL",this,{
            "x":27,
            "y":0
         },Global.Scenedm);
         this.maskBar.graphics.beginFill(0,0);
         this.maskBar.graphics.drawRect(0,0,614,8);
         this.maskBar.x = 101;
         this.maskBar.y = 61;
         addChild(this.maskBar);
         this.maskBar.addEventListener(MouseEvent.MOUSE_OVER,this.overHandle);
         this.guajiBtn = ComponentUtil.getButton("","Button_GuaJi",this,{
            "x":0,
            "y":5,
            "textColor":16184781
         },Global.Scenedm);
         TipManager.bind(this.guajiBtn,LangConfig.getWord("10571",1) + "(Z)");
         this.roleBtn = this.getMicroButton("JueSe",{
            "x":330,
            "y":5
         },LangConfig.getWord("10572",1) + "(C)");
         this.roleBtn.setVisValue(MicroButton.FROM_LEVEL,1);
         this.bagBtn = this.getMicroButton("BeiBao",{
            "x":378,
            "y":5
         },LangConfig.getWord("10573",1) + "(B)");
         this.bagBtn.setVisValue(MicroButton.FROM_LEVEL,1);
         this.skillBtn = this.getMicroButton("JiNeng",{
            "x":426,
            "y":5
         },LangConfig.getWord("10574",1) + "(V)");
         this.skillBtn.setVisValue(MicroButton.FROM_QUEST,Enum_quest_id.SKILL);
         this.neigongBtn = this.getMicroButton("NeiGong",{
            "x":474,
            "y":5
         },LangConfig.getWord("10575",1) + "(O)");
         this.neigongBtn.setVisValue(MicroButton.FROM_QUEST,Enum_quest_id.NEI_GONG);
         this.zhenfaBtn = this.getMicroButton("icom_BZ_J",{
            "x":570,
            "y":5
         },"阵法");
         this.zhenfaBtn.setVisValue(MicroButton.FROM_LEVEL,1);
         this.banghuiBtn = this.getMicroButton("BangHui",{
            "x":522,
            "y":5
         },LangConfig.getWord("10577",1) + "(G)");
         this.banghuiBtn.setVisValue(MicroButton.FROM_QUEST,Enum_quest_id.BANG_HUI);
         this.teamBtn = this.getMicroButton("DuiWu",{
            "x":618,
            "y":5
         },LangConfig.getWord("10578",1) + "(T)");
         this.teamBtn.setVisValue(MicroButton.FROM_LEVEL,1);
         this.friendBtn = this.getMicroButton("HaoYou",{
            "x":666,
            "y":5
         },LangConfig.getWord("10579",1) + "(F)");
         this.friendBtn.setVisValue(MicroButton.FROM_LEVEL,1);
         this.Button_Mall = ComponentUtil.getButton("","Button_ShangCheng",this,{
            "x":728,
            "y":13,
            "textColor":16184781
         },Global.Img_Cdm);
         TipManager.bind(this.Button_Mall,LangConfig.getWord("10580",1) + "(S)");
         this.sprite = new Sprite();
         addChild(this.sprite);
         this.layInImg = ComponentUtil.getBitmap("GuJi_Tips",this.sprite,{
            "x":718,
            "y":58
         },Global.Scenedm);
         if(GameUnitManager.hero.level >= Model_layInPill.instance.pillLvevl)
         {
            this.layInImg.visible = true;
         }
         else
         {
            this.layInImg.visible = false;
         }
         this.teamBtn.addEventListener(MouseEvent.CLICK,this.teamCliHandle);
         this.friendBtn.addEventListener(MouseEvent.CLICK,this.frieHandle);
         this.Button_Mall.addEventListener(MouseEvent.CLICK,this.shoppingMallHandle);
         this.banghuiBtn.addEventListener(MouseEvent.CLICK,this.bangHandle);
         this.zhenfaBtn.addEventListener(MouseEvent.CLICK,zhenfaHandler);
         this.btnCheckAll = ComponentUtil.getButton("","Button_Jia",this,null,Global.Img_Cdm);
         this.btnCheckAll.x = 755;
         this.btnCheckAll.y = -5;
         this.btnCheckAll.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            UIManager.selfBroadcast.onClick();
         });
         TipManager.bind(this.btnCheckAll,LangConfig.getWord("10581",1));
         this.obj_vec.push(this.roleBtn,this.bagBtn,this.skillBtn,this.neigongBtn,this.banghuiBtn,this.zhenfaBtn,this.teamBtn,this.friendBtn);
         this.bindBtnInit();
      }
      
      public function initMicroBtns(questId:int) : void
      {
         var nowIndex:int = 0;
         var item:MicroButton = null;
         var i:int = this.obj_vec.length - 1;
         while(i >= 0)
         {
            item = this.obj_vec[i];
            if(item.visType == MicroButton.FROM_QUEST && item.visValue < questId || item.visType == MicroButton.FROM_LEVEL && item.visValue <= GameUnitManager.hero.level)
            {
               item.visible = true;
               item.x = 666 - nowIndex * 48;
               nowIndex++;
            }
            else
            {
               item.visible = false;
            }
            i--;
         }
      }
      
      public function getItemGlobalPosC(btnStr:String) : Point
      {
         var item:Sprite = this[btnStr];
         return localToGlobal(new Point(item.x,item.y));
      }
      
      public function enabledBtn(boo:Boolean) : void
      {
         var item:MicroButton = null;
         this.guajiBtn.enabled = boo;
         this.Button_Mall.enabled = boo;
         var i:int = this.obj_vec.length - 1;
         while(i >= 0)
         {
            item = this.obj_vec[i];
            if(item != this.teamBtn)
            {
               item.enabled = boo;
            }
            i--;
         }
      }
      
      public function bindBtnInit() : void
      {
         Enum_explor.bindDic[Enum_explor.BTN_ROLE] = this.roleBtn;
         Enum_explor.bindDic[Enum_explor.BTN_BAG] = this.bagBtn;
         Enum_explor.bindDic[Enum_explor.BTN_SKILL] = this.skillBtn;
         Enum_explor.bindDic[Enum_explor.BTN_NEIGONG] = this.neigongBtn;
         Enum_explor.bindDic[Enum_explor.BTN_PARTY] = this.banghuiBtn;
         Enum_explor.bindDic[Enum_explor.BTN_TEAM] = this.teamBtn;
         Enum_explor.bindDic[Enum_explor.BTN_FRIEND] = this.friendBtn;
         Enum_explor.bindDic[Enum_explor.BTN_ZHENFA] = this.zhenfaBtn;
      }
      
      public function setBtnEnabled(value:Boolean) : void
      {
         var i:* = undefined;
         for(i in this.obj_vec)
         {
            this.obj_vec[i].enabled = value;
         }
         this.guajiBtn.enabled = value;
         this.Button_Mall.enabled = value;
      }
      
      public function setEffBang(value:int) : void
      {
         isLightResult = value;
         if(value == 1)
         {
            EffecObj.getEffec(this.banghuiBtn);
            isLight = true;
         }
         else if(value == 2)
         {
            EffecObj.removeEffect(this.banghuiBtn);
            isLight = false;
         }
      }
      
      public function getBtnPoint(_target:Object) : Point
      {
         var item:MicroButton = null;
         for each(item in this.obj_vec)
         {
            if(_target == item)
            {
               return localToGlobal(new Point(item.x,item.y));
            }
         }
         return new Point(0,0);
      }
      
      private function setBgVisible(value:Boolean) : void
      {
         if(value == true)
         {
            this.sprite.filters = [];
            this.guajiBtn.filters = [];
            this.Button_Mall.filters = [];
         }
         else
         {
            this.sprite.filters = Util.disabled;
            this.guajiBtn.filters = Util.disabled;
            this.Button_Mall.filters = Util.disabled;
         }
         this.sprite.mouseChildren = value;
         this.sprite.mouseEnabled = value;
         this.guajiBtn.mouseChildren = value;
         this.guajiBtn.mouseEnabled = value;
         this.Button_Mall.mouseChildren = value;
         this.Button_Mall.mouseEnabled = value;
         var i:int = 0;
         while(i < this.grids.length)
         {
            (this.grids[i] as View_Grid).mouseChildren = value;
            (this.grids[i] as View_Grid).mouseEnabled = value;
            if(value == true)
            {
               (this.grids[i] as View_Grid).filters = [];
            }
            else
            {
               (this.grids[i] as View_Grid).filters = Util.disabled;
            }
            i++;
         }
      }
      
      public function updateCrossClanBtn(value:Boolean) : void
      {
         var i:int = 0;
         for(; i < this.obj_vec.length; i++)
         {
            if(value == false)
            {
               if(this.obj_vec[i] == this.teamBtn)
               {
                  continue;
               }
            }
            this.obj_vec[i].mouseChildren = value;
            this.obj_vec[i].mouseEnabled = value;
            if(value == true)
            {
               this.obj_vec[i].filters = [];
            }
            else
            {
               this.obj_vec[i].filters = Util.disabled;
            }
         }
         this.setBgVisible(value);
      }
      
      public function getbagPoint() : Point
      {
         return localToGlobal(new Point(this.bagBtn.x,this.bagBtn.y));
      }
      
      private function overHandle(e:MouseEvent) : void
      {
         TipManager.bind(this.maskBar,LangConfig.getWord("10083",1) + GameUnitManager.hero.exp + " / " + GameUnitManager.hero.nextexp);
      }
      
      override protected function initDynamicView() : void
      {
         var grid:View_Grid = null;
         var len:int = 6;
         var i:int = 0;
         while(i < len)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.BAR;
            grid.set_bmp_bg(View_Grid.GRID_MAINMENU);
            grid.set_bmp_over(true,null);
            grid.set_tf_info((i + 1).toString());
            grid.index = i;
            grid.x = 93 + i * 38;
            grid.y = 19;
            grid.addEventListener(MouseEvent.MOUSE_DOWN,UIManager.startDrag);
            grid.addEventListener(MouseEvent.MOUSE_UP,this.onUp);
            addChild(grid);
            this.grids.push(grid);
            i++;
         }
         this.roleBtn.addEventListener(MouseEvent.CLICK,function():void
         {
            WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
            {
               pan.visible = !pan.visible;
               if(pan.visible)
               {
                  pan.showView(0);
               }
            });
         });
         this.bagBtn.addEventListener(MouseEvent.CLICK,this.openBagHandle);
         this.skillBtn.addEventListener(MouseEvent.CLICK,this.skillHandle);
         this.neigongBtn.bind = UIManager.xinFaPanel;
         if(GameUnitManager.hero.level < 30)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.lvUpCallBack);
            this.guajiBtn.enabled = false;
            TipManager.bind(this.guajiBtn,LangConfig.getWord("10582",1));
         }
         else
         {
            this.guajiBtn.enabled = true;
         }
         this.guajiBtn.callBack = function(evt:MouseEvent):void
         {
            Global.control.sendNotification(Enum_MsgType.MSG_GUAJIA,null);
         };
      }
      
      public function openBagHandle(e:MouseEvent = null) : void
      {
         XianGouCGMessage.CG_GET_XIANGOU_INFO();
         UIManager.bagPanel.visible = !UIManager.bagPanel.visible;
      }
      
      public function removeEffect() : void
      {
         if(BagHandler.isValue)
         {
            EffecObj.removeEffect(BagHandler._bmp);
            GameScene.popupLayer.removeChild(BagHandler._bmp);
            BagHandler._bmp.visible = false;
            BagHandler._bmp = null;
            BagHandler.isValue = false;
         }
      }
      
      private function skillHandle(e:MouseEvent) : void
      {
         UIManager.skillPanel.visible = !UIManager.skillPanel.visible;
         if(UIManager.skillPanel.visible)
         {
            UIManager.skillPanel.get_first_grid_select(0);
         }
      }
      
      override public function get width() : Number
      {
         return this.back.width;
      }
      
      private function lvUpCallBack(lv:int) : void
      {
         if(lv >= 30)
         {
            this.guajiBtn.enabled = true;
            TipManager.unBind(this.guajiBtn);
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.lvUpCallBack);
         }
      }
      
      public function updateMicro(questId:int) : void
      {
         var delay:int = 0;
         if(questId == Enum_quest_id.SKILL)
         {
            this.openNewMicro(this.skillBtn);
            delay = this.loadBesi(this.skillBtn);
            this.showOpenMicroEff(this.skillBtn,delay);
         }
         else if(questId != Enum_quest_id.JIN_MAI)
         {
            if(questId == Enum_quest_id.NEI_GONG)
            {
               this.openNewMicro(this.neigongBtn);
               delay = this.loadBesi(this.neigongBtn);
               this.showOpenMicroEff(this.neigongBtn,delay);
            }
            else if(questId == Enum_quest_id.BANG_HUI)
            {
               this.openNewMicro(this.banghuiBtn);
               delay = this.loadBesi(this.banghuiBtn);
               this.showOpenMicroEff(this.banghuiBtn,delay);
            }
         }
      }
      
      private function loadBesi(icon:MicroButton) : int
      {
         var bm:Bitmap = null;
         this.aimPoint = localToGlobal(new Point(icon.x,icon.y));
         bm = new Bitmap();
         bm.bitmapData = icon.getIconBMD();
         bm.x = Global.stage.stageWidth / 2;
         bm.y = Global.stage.stageHeight / 2;
         var totalTime:int = Math.pow(Math.pow(this.aimPoint.y - bm.y,2) + Math.pow(this.aimPoint.x - bm.x,2),0.5) * 7;
         var point2:Point = new Point(bm.x + Util.rnd(-100,400),bm.y + Utils.rnd(100,200));
         var point3:Point = new Point(bm.x + Util.rnd(-300,100),bm.y - Utils.rnd(200,300));
         Bezier.getInstance().addTarget(bm,this.aimPoint,totalTime,GameScene.upUILayer,-1,[point3,point2],this.CFUN);
         return totalTime;
      }
      
      private function CFUN(o:DisplayObject) : void
      {
         GameScene.upUILayer.removeChild(o);
         (o as Bitmap).bitmapData = null;
      }
      
      public function showExBtn() : void
      {
         var arr:Array = null;
         var showB:Function = function(index:int):void
         {
            var btn:MicroButton;
            var n:int = 0;
            if(index >= arr.length)
            {
               return;
            }
            btn = arr[index];
            openNewMicro(btn);
            showOpenMicroEff(btn,300);
            n = int(setTimeout(function():void
            {
               clearTimeout(n);
               showB(++index);
            },1800));
         };
         arr = [this.skillBtn,this.neigongBtn,this.banghuiBtn];
         showB(0);
      }
      
      private function openNewMicro(icon:MicroButton) : void
      {
         var nowIndex:int = 0;
         var item:MicroButton = null;
         var isNeedMove:Boolean = false;
         var i:int = this.obj_vec.length - 1;
         while(i >= 0)
         {
            item = this.obj_vec[i];
            if(item == icon)
            {
               item.visible = true;
               item.alpha = 0;
               item.x = 666 - nowIndex * 48;
               nowIndex++;
               isNeedMove = true;
            }
            else if(item.visible)
            {
               if(isNeedMove)
               {
                  Tween.to(item,1000,{"x":[item.x,666 - nowIndex * 48]});
               }
               nowIndex++;
            }
            i--;
         }
      }
      
      private function showOpenMicroEff(icon:MicroButton, delay:int) : void
      {
         var inter:int = 0;
         inter = int(setTimeout(function():void
         {
            EffectManager.addEffect("35196",UIManager.mainMenu,1000,icon.x + 23,icon.y + 35,false,1);
            Tween.to(icon,1200,{"alpha":[0,1]});
            clearTimeout(inter);
         },delay));
      }
      
      private function vipHandle(e:MouseEvent = null) : void
      {
         VIPCGMessage.CG_VIP_OPEN();
      }
      
      public function bangHandle(e:MouseEvent = null) : void
      {
         if(UIManager.bangList.visible)
         {
            UIManager.bangList.visible = false;
            return;
         }
         if(UIManager.banghuiBack.visible)
         {
            UIManager.banghuiBack.visible = false;
            return;
         }
         if(isLight)
         {
            EffecObj.removeEffect(this.banghuiBtn);
            isLight = false;
         }
         BangCGMessage.CG_BANG_PAGE_SEARCH(1,"","",1);
      }
      
      private function onUp(e:MouseEvent) : void
      {
         if(!UIManager.isDrag)
         {
            return;
         }
         var upGrid:View_Grid = e.target as View_Grid;
         var dragData:Vo_grid = UIManager.dragObj.grid.vo;
         var dragGrid:View_Grid = UIManager.dragObj.grid;
         if(dragGrid.type == Enum_type_grid.BAR)
         {
            SkillCGMessage.CG_SET_BAR(Enum_bar_swap.BAR_TO_BAR,dragGrid.index + 1,upGrid.index + 1);
         }
         else if(dragGrid.type == Enum_type_grid.SKILL)
         {
            SkillCGMessage.CG_SET_BAR(Enum_bar_swap.SKILL_TO_BAR,dragGrid.index + 1,upGrid.index + 1);
         }
      }
      
      public function shoppingMallHandle(e:MouseEvent = null) : void
      {
         var pan:ShoppingMallPan = Singleton.getInstance(ShoppingMallPan) as ShoppingMallPan;
         pan.visible = !pan.visible;
      }
      
      public function frieHandle(e:MouseEvent = null) : void
      {
         var questIns:View_friQuestList = UIManager.friQuestPanel;
         if(Model_Friends.hasNewQuest)
         {
            if(questIns.visible)
            {
               questIns.visible = false;
            }
            else
            {
               questIns.show();
            }
            return;
         }
         if(questIns.visible == true)
         {
            questIns.visible = false;
         }
         UIManager.friendPanel.visible = !UIManager.friendPanel.visible;
      }
      
      public function setQuick(index:int, item:Vo_grid) : void
      {
         (this.grids[index] as View_Grid).vo = item;
      }
      
      public function teamCliHandle(e:MouseEvent = null) : void
      {
         var teamL:TeamListPanel = null;
         if(SceneConfig.getSceneType() == SceneConfig.GMD || SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao)
         {
            UIManager.centerBroadcast.addMsg("该场景不能打开组队面板");
            return;
         }
         if(!Model_team.isTeam[GameUnitManager.hero.id])
         {
            UIManager.teamSearchPanel.visible = !UIManager.teamSearchPanel.visible;
            TeamCGMessage.CG_TEAM(1);
         }
         else if(Boolean(TeamListPanel.data[Model_team.team_id]))
         {
            TeamListPanel.data[Model_team.team_id].visible = !TeamListPanel.data[Model_team.team_id].visible;
            TeamListPanel.data[Model_team.team_id].updata(Model_team.teamMumberInfo_data_save);
         }
         else
         {
            teamL = new TeamListPanel();
            TeamListPanel.data[Model_team.team_id] = teamL;
            teamL.init();
            teamL._leastLevel = Model_team.leastLvlSave;
            teamL._biggestLevel = Model_team.biggestLvlSave;
            TeamListPanel.data[Model_team.team_id].visible = !TeamListPanel.data[Model_team.team_id].visible;
            teamL.updata(Model_team.teamMumberInfo_data_save);
         }
      }
      
      private function petBtnHandler(e:MouseEvent) : void
      {
         if(Boolean(UIManager.petPanel.petVO))
         {
            UIManager.petPanel.visible = !UIManager.petPanel.visible;
         }
         else
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10172",1) + "</font>");
         }
      }
      
      private function getMicroButton(url:String, property:Object, tip:String = "") : MicroButton
      {
         var btn:MicroButton = new MicroButton(url,tip);
         if(Boolean(property))
         {
            ComponentUtil.setPropertie(btn,property);
         }
         addChild(btn);
         return btn;
      }
      
      public function update() : void
      {
         this.jy_mask.width = this.jy_Load.width * GameUnitManager.hero.exp / GameUnitManager.hero.nextexp;
         TipManager.bind(this.maskBar,LangConfig.getWord("10083",1) + GameUnitManager.hero.exp + " / " + GameUnitManager.hero.nextexp);
      }
      
      public function getExpBarXY() : Point
      {
         return localToGlobal(new Point(this.jy_mask.x + this.jy_mask.width,this.jy_mask.y));
      }
      
      public function getXY(value:DisplayObject) : Point
      {
         if(value is View_SkillPanel)
         {
            return localToGlobal(new Point(this.skillBtn.x,this.skillBtn.y));
         }
         if(value is View_xinFaPanel)
         {
            return localToGlobal(new Point(this.neigongBtn.x,this.neigongBtn.y));
         }
         if(value is View_bangList || value is View_banghuiBack)
         {
            return localToGlobal(new Point(this.banghuiBtn.x,this.banghuiBtn.y));
         }
         if(value is TeamListPanel || value is TeamSearchPanel)
         {
            return localToGlobal(new Point(this.teamBtn.x,this.teamBtn.y));
         }
         if(value is View_FriendsPanel || value is View_friQuestList)
         {
            return localToGlobal(new Point(this.friendBtn.x,this.friendBtn.y));
         }
         if(value is View_shoppingMall)
         {
            return localToGlobal(new Point(this.Button_Mall.x,this.Button_Mall.y));
         }
         if(value is View_rolePanel)
         {
            return localToGlobal(new Point(this.roleBtn.x,this.roleBtn.y));
         }
         if(value is View_bagPanel)
         {
            return localToGlobal(new Point(this.bagBtn.x,this.bagBtn.y));
         }
         if(value is View_castPanel)
         {
            return localToGlobal(new Point(Global.stage.stageWidth / 2,Global.stage.stageHeight / 2));
         }
         throw new Error("该面板没有动画");
      }
      
      public function getbtnCAP() : Point
      {
         return new Point(this.btnCheckAll.x,this.btnCheckAll.y);
      }
      
      override public function resetPosition() : void
      {
         if(Global.stage.stageWidth < 1440)
         {
            x = (Global.stage.stageWidth + UIManager.chatPanel.width - UIManager.mainMenu.width) / 2;
         }
         else
         {
            x = (Global.stage.stageWidth + UIManager.chatPanel.width - UIManager.mainMenu.width) / 2;
         }
         y = Global.stage.stageHeight + BoatManager.mainMenuCY;
         var p:Point = new Point(Global.stage.stageWidth - 25,0);
         this.btnCheckAll.x = globalToLocal(p).x;
      }
   }
}

