package com.yiTian.view.modules.crossClanBattle
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_CrossType;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class View_AllCityPanel extends Panel123
   {
      
      public static var info:Object;
      
      private var bg:DisplayObject;
      
      private var container:Sprite = new Sprite();
      
      private var txtServerTime:MyTextField;
      
      private var txtDes:MyTextField;
      
      private var txtDesValue:MyTextField;
      
      private var btnChaKan:Button;
      
      private var btnJingPai:Button;
      
      private var colorIcon:Bitmap;
      
      private var modelShape:Shape;
      
      private var helBtn:Button;
      
      private var landArr:Array = [];
      
      private var textArr:Array = [];
      
      private var indexArr:Array = [];
      
      private var colorCityArr:Array = [5,18,24];
      
      private var lastTime:uint;
      
      private var count:int;
      
      private var currentMc:MovieClip;
      
      private var currentVo:CityVo;
      
      private var nowVo:CityVo;
      
      private var lastVo:CityVo;
      
      public function View_AllCityPanel()
      {
         super();
         this.createItem();
         regResource("lang/ch/KFBang_CC.swf","KFBang_CCdm");
      }
      
      public static function get instance() : View_AllCityPanel
      {
         return Singleton.getInstance(View_AllCityPanel);
      }
      
      override protected function initUI2() : void
      {
         var sp:Sprite = null;
         this.bg = ComponentUtil.getBitmap("Back_Img",this,{
            "x":0,
            "y":0
         },Global.KFBang_CCdm);
         addChild(this.container);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onDown,false,1);
         ComponentUtil.getTextField("注：攻城开始后，单击城池进入战场",this,{
            "x":685,
            "y":100,
            "color":10027008,
            "size":12,
            "leading":0,
            "filters":[]
         });
         ComponentUtil.getTextField("当前服务器时间：",this,{
            "x":690,
            "y":125,
            "color":861696,
            "size":12,
            "leading":0,
            "filters":[]
         });
         this.txtServerTime = ComponentUtil.getTextField("",this,{
            "x":787,
            "y":125,
            "color":5838336,
            "size":12,
            "leading":0,
            "filters":[]
         });
         ComponentUtil.getTextField("本帮势力颜色：",this,{
            "x":690,
            "y":180,
            "color":861696,
            "size":12,
            "leading":0,
            "filters":[]
         });
         this.txtDes = ComponentUtil.getTextField("",this,{
            "x":690,
            "y":230,
            "color":861696,
            "size":12,
            "leading":10
         });
         this.txtDes.htmlText = "占领城池名称：\n占领收益银两：\n当前归属帮派：\n出价最高帮派：\n当前出价银两：\n竞拍城池时间：\n争夺城池时间：\n第一场：\n第二场：";
         this.txtDesValue = ComponentUtil.getTextField("",this,{
            "x":779,
            "y":230,
            "color":5838336,
            "size":12,
            "leading":10
         });
         this.txtDes.filters = [];
         this.txtDesValue.filters = [];
         ComponentUtil.getBitmap("SLColor_Back",this,{
            "x":781,
            "y":175
         },Global.KFBang_CCdm);
         this.colorIcon = ComponentUtil.getBitmap("SLColor",this,{
            "x":785,
            "y":179
         },Global.KFBang_CCdm);
         sp = new Sprite();
         addChild(sp);
         sp.addChild(this.colorIcon);
         sp.buttonMode = true;
         sp.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            e.stopImmediatePropagation();
            Global.delegate.dosomething(View_ColorPanel.instance,View_ColorPanel.instance.show);
            View_ColorPanel.instance.x = Global.stage.mouseX;
            View_ColorPanel.instance.y = Global.stage.mouseY;
         });
         this.btnChaKan = ComponentUtil.getButton("","Button_ChaKan",this,{
            "x":682,
            "y":438,
            "textColor":16184781,
            "callBack":this.chaKan
         },Global.KFBang_CCdm);
         this.btnJingPai = ComponentUtil.getButton("","Button_JiaGe",this,{
            "x":682,
            "y":438,
            "textColor":16184781,
            "callBack":this.jingPai
         },Global.KFBang_CCdm);
         this.btnJingPai.visible = false;
         ComponentUtil.getButton("","Button_Close",this,{
            "x":932,
            "y":45,
            "textColor":16184781,
            "callBack":this.hide
         },Global.KFBang_CCdm);
         this.helBtn = ComponentUtil.getButton("","Button_Quest",this,{
            "x":this.bg.width - 88,
            "y":48,
            "textColor":16184781,
            "callBack":this.openHelpPanel
         },Global.KFBang_CCdm);
         Model_CrossClanBattle.setRoleBuffData();
         Global.control.registerCallBack(Enum_CrossClanBattle.CITY_UPDATE,this.updateCity);
      }
      
      private function checkBtnVisible(value:Boolean) : void
      {
         if(!this.btnChaKan)
         {
            return;
         }
         this.btnChaKan.visible = value;
         this.btnJingPai.visible = !value;
      }
      
      private function openHelpPanel(e:MouseEvent) : void
      {
         View_HelpTipPanel.instance.showOut();
      }
      
      private function onDown(e:MouseEvent) : void
      {
         e.stopImmediatePropagation();
         View_ColorPanel.instance.hide();
      }
      
      private function createItem() : void
      {
         Model_CrossClanBattle.setStaticCityData();
         Model_CrossClanBattle.setAllCityData([],0,0);
         MassLoader.add("lang/ch/KFBang_Imgs.swf",function(info:Object):void
         {
            info = info;
            container.addChild(info.content);
            dealMc(info.content);
         });
      }
      
      public function show() : void
      {
         visible = true;
         CrossClanBattleCGMessage.CG_ALLCITY_DATA();
      }
      
      public function hide(prm:* = null) : void
      {
         visible = false;
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
      }
      
      private function dealMc(mc:Object) : void
      {
         var movieStr:String = null;
         var movie:MovieClip = null;
         var child:DisplayObject = null;
         var index:int = 0;
         var i:int = 0;
         while(i < (mc as MovieClip).numChildren)
         {
            child = (mc as MovieClip).getChildAt(i);
            if(child is TextField)
            {
               (child as TextField).autoSize = TextFieldAutoSize.CENTER;
               this.textArr.push(child);
            }
            else if(child is MovieClip)
            {
               movie = child as MovieClip;
               movie.buttonMode = true;
               movie.addEventListener(MouseEvent.CLICK,this.itemClick);
               movie.addEventListener(MouseEvent.ROLL_OVER,this.onOver);
               movie.addEventListener(MouseEvent.ROLL_OUT,this.onOut);
               movieStr = movie.toString().substr(13,2);
               if(int(movieStr) >= 10)
               {
                  index = int(movieStr);
               }
               else
               {
                  index = int(movie.toString().substr(14,1));
               }
               this.indexArr[movie] = index;
               this.landArr[index - 1] = movie;
            }
            i++;
         }
         this.updateCity();
      }
      
      public function updateServerTime() : void
      {
         if(Boolean(this.txtServerTime))
         {
            this.txtServerTime.htmlText = Model_CrossClanBattle.transDate(Model_CrossClanBattle.serverTime);
         }
      }
      
      public function updateCity() : void
      {
         var vo:CityVo = null;
         var mc:MovieClip = null;
         this.updateServerTime();
         if(Model_CrossClanBattle.endConfirmTime - Model_CrossClanBattle.serverTime <= 0)
         {
            this.checkBtnVisible(true);
         }
         else
         {
            this.checkBtnVisible(true);
         }
         var len:int = int(Model_CrossClanBattle.allStaticCityDataByIndex.length);
         var i:int = 0;
         while(i < this.textArr.length)
         {
            vo = Model_CrossClanBattle.allStaticCityDataByIndex[i];
            if(Boolean(vo))
            {
               if(Boolean(this.textArr[i]))
               {
                  mc = this.landArr[i] as MovieClip;
                  mc.transform.colorTransform = vo.color;
                  if(this.colorCityArr.indexOf(vo.index) != -1)
                  {
                     this.textArr[i].htmlText = vo.name;
                     (this.textArr[i] as TextField).textColor = 14590764;
                  }
                  else
                  {
                     this.textArr[i].htmlText = vo.name;
                  }
               }
               if(vo.clan == GameUnitManager.hero.party)
               {
                  this.setIconColor(vo.color);
               }
            }
            i++;
         }
         i = 0;
         while(i < len)
         {
            this.nowVo = Model_CrossClanBattle.allStaticCityDataByIndex[i];
            if(this.nowVo.maxSpendclan == GameUnitManager.hero.party || this.nowVo.secondSpendclan == GameUnitManager.hero.party)
            {
               this.currentMc = this.landArr[i] as MovieClip;
               if(Boolean(this.currentMc))
               {
                  this.currentVo = this.nowVo;
                  Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
               }
               if(Boolean(this.lastVo))
               {
                  this.setDesValue(this.lastVo);
               }
               else
               {
                  this.setDesValue(this.nowVo);
               }
               return;
            }
            i++;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
         this.nowVo = Model_CrossClanBattle.allStaticCityDataByIndex[0];
         if(Boolean(this.lastVo))
         {
            this.setDesValue(this.lastVo);
         }
         else
         {
            this.setDesValue(this.nowVo);
         }
      }
      
      private function frameStep() : void
      {
         var now:uint = uint(getTimer());
         if(now - this.lastTime > 300)
         {
            this.lastTime = now;
            if(Boolean(this.currentMc) && Boolean(this.currentVo))
            {
               if(this.count == 0)
               {
                  this.currentMc.filters = Util.glowFFFFFF;
                  this.count = 1;
               }
               else
               {
                  this.currentMc.filters = [];
                  this.count = 0;
               }
            }
         }
      }
      
      private function onOver(e:MouseEvent) : void
      {
         var mc:MovieClip = e.currentTarget as MovieClip;
         mc.filters = Util.glowFFFFFF;
         this.setVoData(mc);
      }
      
      private function onOut(e:MouseEvent) : void
      {
         var mc:MovieClip = e.currentTarget as MovieClip;
         mc.filters = [];
      }
      
      public function setDesValue(vo:CityVo) : void
      {
         if(!this.txtDesValue)
         {
            return;
         }
         this.txtDesValue.htmlText = vo.name + "\n" + vo.silver + "\n" + Model_heFu.repNameUseSerID(vo.clanName) + "\n" + Model_heFu.repNameUseSerID(vo.maxSpendclanName) + "\n" + vo.maxSpendSilver + "\n周一12:00--周四22:00" + "\n" + Model_CrossClanBattle.weekArr[vo.battleTime - 1] + "\n21:30\n21:50";
      }
      
      private function setIconColor(colorTransform:ColorTransform) : void
      {
         this.colorIcon.bitmapData.colorTransform(this.colorIcon.bitmapData.rect,colorTransform);
      }
      
      public function itemClick(e:MouseEvent) : void
      {
         var i:int = 0;
         var mc:MovieClip = e.currentTarget as MovieClip;
         this.setVoData(mc);
         if(!Model_CrossClanBattle.allCityTimeData.length)
         {
            View_BattleConfirmPanel.instance.show(this.nowVo);
         }
         else if(GameUnitManager.hero.party != this.nowVo.maxSpendclan && this.nowVo.secondSpendclan != GameUnitManager.hero.party)
         {
            View_BattleConfirmPanel.instance.show(this.nowVo);
         }
         else
         {
            i = 0;
            while(i < Model_CrossClanBattle.allCityTimeData.length)
            {
               if(Model_CrossClanBattle.allCityTimeData[i][0] == this.nowVo.id)
               {
                  if(Model_CrossClanBattle.allCityTimeData[i][4] - Model_CrossClanBattle.serverTime < 0 && Model_CrossClanBattle.allCityTimeData[i][4] - Model_CrossClanBattle.serverTime > -3600)
                  {
                     if(Model_CrossClanBattle.notEnterScene() == true)
                     {
                        return;
                     }
                     Global.crossType = Enum_CrossType.CROSS_CLAN_BATTLE;
                     CrossClanBattleCGMessage.CG_ENTER_BATTLE_SCENE(Global.crossType,this.nowVo.id + "");
                     Model_CrossClanBattle.currentCityId = this.nowVo.id;
                     Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
                     return;
                  }
                  View_BattleConfirmPanel.instance.show(this.nowVo);
                  return;
               }
               i++;
            }
            View_BattleConfirmPanel.instance.show(this.nowVo);
         }
      }
      
      private function setVoData(mc:MovieClip) : void
      {
         this.nowVo = Model_CrossClanBattle.allStaticCityDataByIndex[this.indexArr[mc] - 1];
         this.lastVo = this.nowVo;
         this.setDesValue(this.nowVo);
      }
      
      private function chaKan(e:MouseEvent) : void
      {
         CrossClanBattleCGMessage.CG_SEGIE_TIME();
      }
      
      private function jingPai(e:MouseEvent) : void
      {
         Global.delegate.dosomething(View_allConfirmDataPanel.instance,View_allConfirmDataPanel.instance.show);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
      
      override public function get height() : Number
      {
         if(!this.bg)
         {
            return super.height;
         }
         return this.bg.height;
      }
      
      override public function get width() : Number
      {
         if(!this.bg)
         {
            return super.width;
         }
         return this.bg.width;
      }
   }
}

