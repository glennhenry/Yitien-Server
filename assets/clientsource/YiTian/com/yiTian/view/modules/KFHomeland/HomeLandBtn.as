package com.yiTian.view.modules.KFHomeland
{
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_CrossType;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.KFHomeland.KFHomeTuoZhan.TipPan;
   import com.yiTian.view.modules.KFHomeland.KFHomeTuoZhan.Vo_TipPan;
   import com.yiTian.view.modules.guangMingDing.View_guangMingDingTeamPanel;
   import com.yiTian.view.modules.mainUIBtnContainer.IMainUiBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.qiJu.View_JoinQiJu;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   
   public class HomeLandBtn
   {
      
      public static const LowHomeBtnLevel:int = 60;
      
      public static var instance:HomeLandBtn = new HomeLandBtn();
      
      public var _btn:MainUIBtn;
      
      private var _btnUrl:String = "resource/image/exBtn/JiaYuan.png";
      
      private var _sampleHome:SampleHome;
      
      private var eff:Effect;
      
      private var tp:TipPan;
      
      public function HomeLandBtn()
      {
         super();
         if(!this._btn)
         {
            this.initBtn();
         }
      }
      
      public function initBtn() : void
      {
         var ind:int;
         this._btn = new MainUIBtn(this._btnUrl);
         ind = Vo_TipPan.tiLi;
         this._btn.addEventListener(MouseEvent.CLICK,this.btnClkHandle);
         this._btn.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this._btn.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         if(!Global.KFJYdm)
         {
            SingleLoader.add("lang/ch/KFJY.swf",function(info:Object):void
            {
               Global.KFJYdm = info.applicationDomain;
            });
         }
      }
      
      private function onMouseOver(e:MouseEvent) : void
      {
         var p:Point = null;
         if(Vo_TipPan.isCanGet == false)
         {
            return;
         }
         if(Boolean(this._btn) && Boolean(this._btn.visible) && Boolean(this._btn.parent))
         {
            this.tp = TipPan.instance;
            p = this._btn.parent.localToGlobal(new Point(this._btn.x,this._btn.y));
            this.tp.x = p.x - this.tp.width / 2 + this._btn.width / 2;
            this.tp.y = p.y + this._btn.height;
            this.tp.show();
            this.tp.visible = true;
            GameScene.uiLayer.addChild(this.tp);
         }
      }
      
      private function onMouseOut(e:MouseEvent) : void
      {
         if(!this.tp)
         {
            return;
         }
         if(e.target == this.tp)
         {
            return;
         }
         setTimeout(function():void
         {
            tp.visible = false;
         },2000);
      }
      
      public function enterHome() : void
      {
         if(Model_team.hasTeam())
         {
            HomeLandCGMessage.CG_LOCAL_TEAM_VISITHOME();
         }
         else
         {
            Global.crossType = Enum_CrossType.CROSS_HOME;
            HomeLandGCMessage.roleId = GameUnitManager.hero.id;
            HomeLandGCMessage.type = 0;
            HomeLandGCMessage.zone = VoHome.heroS;
            HomeLandCGMessage.CG_ENTER_HOME_SCENE(2,Global.crossType,GameUnitManager.hero.id + "_0" + "_" + GameUnitManager.hero.id);
         }
      }
      
      private function btnClkHandle(evt:MouseEvent) : void
      {
         var i:int;
         var j:int = 0;
         var spr:Sprite = null;
         var pnl:View_guangMingDingTeamPanel = View_guangMingDingTeamPanel.getInstance();
         if(pnl.visible)
         {
            UIManager.centerBroadcast.addMsg("亲，你已在光眀顶创建队伍，不能进入家园。");
            return;
         }
         if(View_JoinQiJu.instance.visible)
         {
            UIManager.centerBroadcast.addMsg("亲，请先关闭珍龙棋局再进入家园。");
            return;
         }
         i = UIManager.visiblePanels.length - 1;
         while(i >= 0)
         {
            j = UIManager.visiblePanels[i].length - 1;
            while(j >= 0)
            {
               spr = UIManager.visiblePanels[i][j] as Sprite;
               spr.visible = false;
               j--;
            }
            i--;
         }
         if(Boolean(VoHome.isCreatHome))
         {
            View_Alert.show(LangConfig.getWord("30150",3),View_Alert.OK_CANCAL,function(evt:MouseEvent):void
            {
               enterHome();
            });
         }
         else
         {
            if(!this._sampleHome)
            {
               this._sampleHome = new SampleHome();
               this._sampleHome.init();
            }
            this._sampleHome.visible = true;
         }
      }
      
      public function get homeBtn() : IMainUiBtn
      {
         return this._btn;
      }
      
      public function hideSmpleHome() : void
      {
         if(Boolean(this._sampleHome) && this._sampleHome.visible)
         {
            this._sampleHome.visible = false;
         }
      }
      
      public function addBtn(value:Boolean) : void
      {
         if(value)
         {
            if(!UIManager.mainUiBtnContainer.hasBTN(this._btn))
            {
               UIManager.mainUiBtnContainer.addBTN(this._btn);
            }
         }
         else
         {
            UIManager.mainUiBtnContainer.removeBTN(this._btn);
         }
      }
   }
}

