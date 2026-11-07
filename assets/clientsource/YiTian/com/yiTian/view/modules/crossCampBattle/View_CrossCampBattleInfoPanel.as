package com.yiTian.view.modules.crossCampBattle
{
   import com.ui.controls.MaskProgressBar;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.baby.babyManager.Model_baby;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextFormatAlign;
   import flash.utils.getTimer;
   
   public class View_CrossCampBattleInfoPanel extends Panel123
   {
      
      private var bg:ScaleBitmap;
      
      private var txtSelfBlood:MyTextField;
      
      private var txtenemyBlood:MyTextField;
      
      private var txtCrystalTime:MyTextField;
      
      private var txtBuffTime:MyTextField;
      
      private var txtPoints:MyTextField;
      
      private var grid:View_Grid;
      
      private var itemVo:Vo_item;
      
      private var crystalTime:int;
      
      private var buffTime:int;
      
      private var lastTime:uint;
      
      private var selfBloodBar:Bitmap;
      
      private var selfBloodBg:Bitmap;
      
      private var enemyBloodBar:Bitmap;
      
      private var enemyBloodBg:Bitmap;
      
      private var selfBloodTimeBar:MaskProgressBar;
      
      private var enemyBloodTimeBar:MaskProgressBar;
      
      private var maxSelfBloodTime:Number;
      
      private var maxEnemyBloodTime:Number;
      
      private var crystalBar:Bitmap;
      
      private var crystalBg:Bitmap;
      
      private var buffBar:Bitmap;
      
      private var buffBg:Bitmap;
      
      private var crystalTimeBar:MaskProgressBar;
      
      private var buffTimeBar:MaskProgressBar;
      
      private var maxCrystalTime:Number;
      
      private var maxBuffTime:Number;
      
      private var pointsBg:Bitmap;
      
      private var pointsBar:Bitmap;
      
      private var pointsTimeBar:MaskProgressBar;
      
      private var maxPointsTime:Number;
      
      private var selfBlood:Number;
      
      private var enemyBlood:Number;
      
      private var isUIComplete:Boolean = false;
      
      public function View_CrossCampBattleInfoPanel()
      {
         super();
         init();
      }
      
      public static function get instance() : View_CrossCampBattleInfoPanel
      {
         return Singleton.getInstance(View_CrossCampBattleInfoPanel);
      }
      
      override protected function initStaticView() : void
      {
         this.bg = ComponentUtil.getScaleBitmap("Back_HuoDong",[60,36,3,5],this,{
            "x":0,
            "y":0,
            "width":324,
            "height":215
         },Global.Img_Cdm);
         ComponentUtil.getTextField("校场信息板",this,{
            "x":128,
            "y":5,
            "color":16776304,
            "size":12,
            "leading":0
         });
         this.crystalBar = new Bitmap();
         this.crystalBar.x = 2;
         this.crystalBar.y = 2;
         this.crystalBg = new Bitmap();
         this.crystalTimeBar = new MaskProgressBar();
         this.crystalTimeBar.x = 110;
         this.crystalTimeBar.y = 117;
         this.crystalTimeBar.realWidth = 135;
         this.crystalTimeBar.bg = this.crystalBg;
         this.crystalTimeBar.bar = this.crystalBar;
         this.crystalTimeBar.init();
         this.crystalTimeBar.persent = 0;
         addChild(this.crystalTimeBar);
         this.buffBar = new Bitmap();
         this.buffBar.x = 2;
         this.buffBar.y = 2;
         this.buffBg = new Bitmap();
         this.buffTimeBar = new MaskProgressBar();
         this.buffTimeBar.x = 110;
         this.buffTimeBar.y = 139;
         this.buffTimeBar.realWidth = 135;
         this.buffTimeBar.bg = this.buffBg;
         this.buffTimeBar.bar = this.buffBar;
         this.buffTimeBar.init();
         this.buffTimeBar.persent = 0;
         addChild(this.buffTimeBar);
         this.pointsBar = new Bitmap();
         this.pointsBar.x = 2;
         this.pointsBar.y = 2;
         this.pointsBg = new Bitmap();
         this.pointsTimeBar = new MaskProgressBar();
         this.pointsTimeBar.x = 110;
         this.pointsTimeBar.y = 169;
         this.pointsTimeBar.realWidth = 135;
         this.pointsTimeBar.bg = this.pointsBg;
         this.pointsTimeBar.bar = this.pointsBar;
         this.pointsTimeBar.init();
         this.pointsTimeBar.persent = 0;
         addChild(this.pointsTimeBar);
         ComponentUtil.getTextField("矿石刷新：",this,{
            "x":41,
            "y":115,
            "color":16772287,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("Buff刷新：",this,{
            "x":43,
            "y":137,
            "color":16772287,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("积分奖励：",this,{
            "x":41,
            "y":167,
            "color":16772287,
            "size":12,
            "leading":0
         });
         this.txtCrystalTime = ComponentUtil.getTextField("00：00",this,{
            "x":150,
            "y":115,
            "color":16772287,
            "size":12,
            "leading":0
         });
         this.txtBuffTime = ComponentUtil.getTextField("00：00",this,{
            "x":150,
            "y":137,
            "color":16772287,
            "size":12,
            "leading":0
         });
         this.txtPoints = ComponentUtil.getTextField("70/90",this,{
            "x":151,
            "y":167,
            "color":16772287,
            "size":12,
            "leading":0
         });
         this.selfBloodBar = new Bitmap();
         this.selfBloodBar.x = 2;
         this.selfBloodBar.y = 2;
         this.selfBloodBg = new Bitmap();
         this.selfBloodTimeBar = new MaskProgressBar();
         this.selfBloodTimeBar.x = 110;
         this.selfBloodTimeBar.y = 54;
         this.selfBloodTimeBar.realWidth = 135;
         this.selfBloodTimeBar.bg = this.selfBloodBg;
         this.selfBloodTimeBar.bar = this.selfBloodBar;
         this.selfBloodTimeBar.init();
         this.selfBloodTimeBar.persent = 0;
         addChild(this.selfBloodTimeBar);
         this.enemyBloodBar = new Bitmap();
         this.enemyBloodBar.x = 2;
         this.enemyBloodBar.y = 2;
         this.enemyBloodBg = new Bitmap();
         this.enemyBloodTimeBar = new MaskProgressBar();
         this.enemyBloodTimeBar.x = 110;
         this.enemyBloodTimeBar.y = 90;
         this.enemyBloodTimeBar.realWidth = 135;
         this.enemyBloodTimeBar.bg = this.enemyBloodBg;
         this.enemyBloodTimeBar.bar = this.enemyBloodBar;
         this.enemyBloodTimeBar.init();
         this.enemyBloodTimeBar.persent = 0;
         addChild(this.enemyBloodTimeBar);
         this.txtSelfBlood = ComponentUtil.getTextField("00000",this,{
            "x":110,
            "y":52,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.txtenemyBlood = ComponentUtil.getTextField("00000",this,{
            "x":110,
            "y":87,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.grid = new View_Grid();
         this.txtSelfBlood.realWidth = 130;
         this.txtSelfBlood.autoSize = TextFormatAlign.CENTER;
         this.txtenemyBlood.realWidth = 130;
         this.txtenemyBlood.autoSize = TextFormatAlign.CENTER;
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over(true,null);
         this.grid.set_tf_count(true,false,true);
         addChild(this.grid);
         this.grid.x = 249;
         this.grid.y = 161;
         Config_CrossCampBattle.setPointsData();
      }
      
      public function getBtnPoint(_target:Object) : Point
      {
         return localToGlobal(new Point(_target.x,_target.y));
      }
      
      private function set selfBloodBarTime(value:Number) : void
      {
         this.selfBloodTimeBar.persent = value / this.maxSelfBloodTime;
      }
      
      private function set enemyBloodBarTime(value:Number) : void
      {
         this.enemyBloodTimeBar.persent = value / this.maxEnemyBloodTime;
      }
      
      private function set crystalBarTime(value:Number) : void
      {
         this.crystalTimeBar.persent = value / this.maxCrystalTime;
      }
      
      private function set buffBarTime(value:Number) : void
      {
         this.buffTimeBar.persent = value / this.maxBuffTime;
      }
      
      private function set pointsBarTime(value:Number) : void
      {
         this.pointsTimeBar.persent = value / this.maxPointsTime;
      }
      
      public function update(selfBlood:String, selfMaxBlood:String, enemyBlood:String, enemyMaxBlood:String, redQiZiId:int, blueQiZiId:int) : void
      {
         var npc:Npc = null;
         this.maxSelfBloodTime = Number(selfMaxBlood);
         this.maxEnemyBloodTime = Number(enemyMaxBlood);
         this.selfBlood = Number(selfBlood);
         this.enemyBlood = Number(enemyBlood);
         this.selfBloodBarTime = Number(selfBlood);
         this.enemyBloodBarTime = Number(enemyBlood);
         var slefBloodStr:String = (Number(selfBlood) / Number(selfMaxBlood) * 100).toString();
         var enemyBloodStr:String = (Number(enemyBlood) / Number(enemyMaxBlood) * 100).toString();
         this.txtSelfBlood.htmlText = slefBloodStr.substr(0,slefBloodStr.length > 5 ? 5 : slefBloodStr.length) + "%";
         this.txtenemyBlood.htmlText = enemyBloodStr.substr(0,enemyBloodStr.length > 5 ? 5 : enemyBloodStr.length) + "%";
         npc = GameUnitManager.findUnit(redQiZiId,UnitType.NPC) as Npc;
         if(Boolean(npc))
         {
            this.updateNpcHp(npc);
         }
         npc = GameUnitManager.findUnit(blueQiZiId,UnitType.NPC) as Npc;
         if(Boolean(npc))
         {
            this.updateNpcHp(npc);
         }
      }
      
      public function updateNpcHp(npc:Npc) : void
      {
         if(npc.sysId == 53536)
         {
            npc.upDataQiJuHP(this.selfBlood,this.maxSelfBloodTime);
         }
         else
         {
            npc.upDataQiJuHP(this.enemyBlood,this.maxSelfBloodTime);
         }
      }
      
      public function updateBuffTime(crystalTime:int, buffTime:int) : void
      {
         if(this.crystalTime <= 0 && crystalTime > 0)
         {
            this.maxCrystalTime = crystalTime;
         }
         if(this.buffTime <= 0 && buffTime > 0)
         {
            this.maxBuffTime = buffTime;
         }
         this.crystalTime = crystalTime;
         this.buffTime = buffTime;
         this.crystalBarTime = crystalTime;
         this.buffBarTime = buffTime;
         this.setCountDownTxt();
         if(Global.control.hasCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep) == false)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
         }
      }
      
      private function frameStep() : void
      {
         var now:uint = uint(getTimer());
         if(now - this.lastTime > 1000)
         {
            --this.crystalTime;
            --this.buffTime;
            this.crystalBarTime = this.crystalTime;
            this.buffBarTime = this.buffTime;
            this.setCountDownTxt();
            this.lastTime = now;
         }
      }
      
      public function setCountDownTxt() : void
      {
         this.txtCrystalTime.htmlText = "" + DateUtil.getMSBySecond3(this.crystalTime <= 0 ? 0 : this.crystalTime);
         this.txtBuffTime.htmlText = "" + DateUtil.getMSBySecond3(this.buffTime <= 0 ? 0 : this.buffTime);
      }
      
      public function updatePoints(points:int) : void
      {
         var maxPoints:int = 0;
         var itemId:int = 0;
         var len:int = int(Config_CrossCampBattle.pointsData.length);
         var i:int = 0;
         while(i < len)
         {
            if(points >= Config_CrossCampBattle.pointsData[i][0] && points <= Config_CrossCampBattle.pointsData[i][1])
            {
               if(GameUnitManager.hero.level >= Config_CrossCampBattle.pointsData[i][2] && GameUnitManager.hero.level <= Config_CrossCampBattle.pointsData[i][3])
               {
                  maxPoints = int(Config_CrossCampBattle.pointsData[i][1]);
                  itemId = int(Config_CrossCampBattle.pointsData[i][4]);
                  break;
               }
            }
            if(GameUnitManager.hero.level >= Config_CrossCampBattle.pointsData[i][2] && GameUnitManager.hero.level <= Config_CrossCampBattle.pointsData[i][3])
            {
               if(points >= Config_CrossCampBattle.pointsData[i][0] && points <= Config_CrossCampBattle.pointsData[i][1])
               {
                  maxPoints = int(Config_CrossCampBattle.pointsData[i][1]);
                  itemId = int(Config_CrossCampBattle.pointsData[i][4]);
                  break;
               }
            }
            i++;
         }
         if(maxPoints == 0)
         {
            i = 0;
            while(i < len)
            {
               if(points >= Config_CrossCampBattle.pointsData[i][1])
               {
                  if(GameUnitManager.hero.level >= Config_CrossCampBattle.pointsData[i][2] && GameUnitManager.hero.level <= Config_CrossCampBattle.pointsData[i][3])
                  {
                     maxPoints = int(Config_CrossCampBattle.pointsData[i][1]);
                     itemId = int(Config_CrossCampBattle.pointsData[i][4]);
                     break;
                  }
               }
               if(GameUnitManager.hero.level >= Config_CrossCampBattle.pointsData[i][2] && GameUnitManager.hero.level <= Config_CrossCampBattle.pointsData[i][3])
               {
                  if(points >= Config_CrossCampBattle.pointsData[i][1])
                  {
                     maxPoints = int(Config_CrossCampBattle.pointsData[i][1]);
                     itemId = int(Config_CrossCampBattle.pointsData[i][4]);
                     break;
                  }
               }
               i++;
            }
         }
         this.maxPointsTime = maxPoints;
         this.pointsBarTime = points;
         this.txtPoints.htmlText = points + "/" + maxPoints;
         this.itemVo = new Vo_item();
         this.itemVo.id = itemId;
         this.itemVo.Init_lib();
         this.grid.vo = this.itemVo;
      }
      
      public function show() : void
      {
         var j:int = 0;
         var spr:Sprite = null;
         var i:int = UIManager.visiblePanels.length - 1;
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
         if(Model_CrossCampBattle.preTime > 0)
         {
            Global.delegate.dosomething(View_CampBattlePrePanel.instance,View_CampBattlePrePanel.instance.showPreTime);
         }
         this.visible = true;
         UIManager.questTraceView.visible = false;
         UIManager.newMainBtnContainer.visible = false;
         UIManager.mainUiBtnContainer.visible = false;
         UIManager.tipBtnContainer.visible = false;
         UIManager.special_btn.visible = false;
         View_ExitPanel.instance.visible = true;
         UIManager.smallMap.changeBtnEnable(false);
         UIManager.mainMenu.updateCrossClanBtn(false);
         View_CrossCampBattleRulePanel.instance.visible = true;
         UIManager.chatPanel.setCrossCampChannal("演兵");
         if(View_CrossCampMainPanel.instance.visible == true)
         {
            View_CrossCampMainPanel.instance.visible = false;
         }
         GameUnitManager.hero.campId = Model_CrossCampBattle.ownCampId;
         GameUnitManager.hero.nameBar.show();
         Model_baby.isEnableRole_beside_icon = false;
         GameUnitManager.hero.name = HtmlUtil.font(GameUnitManager.hero.name,ColorConstant.getColorStr(ColorConstant.BLUE));
      }
      
      public function hide() : void
      {
         this.visible = false;
         View_ExitPanel.instance.visible = false;
         UIManager.questTraceView.visible = true;
         UIManager.newMainBtnContainer.visible = true;
         UIManager.mainUiBtnContainer.visible = true;
         UIManager.tipBtnContainer.visible = true;
         UIManager.mainMenu.updateCrossClanBtn(true);
         UIManager.mainMenu.visible = true;
         UIManager.special_btn.visible = true;
         UIManager.smallMap.changeBtnEnable(true);
         UIManager.mainMenu.resetPosition();
         UIManager.special_btn.resetPosition();
         UIManager.mainUiBtnContainer.resetPosition();
         View_CrossCampBattleRulePanel.instance.visible = false;
         UIManager.chatPanel.setCrossCampChannal("跨服");
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
         Model_baby.isEnableRole_beside_icon = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         var arr:Array = null;
         if(value)
         {
            if(!this.isUIComplete)
            {
               if(!Global.crossCampBattle_Imgdm)
               {
                  arr = [];
                  arr.push(["lang/ch/JCYB.swf",function(info:Object):void
                  {
                     Global.crossCampBattle_Imgdm = info.applicationDomain;
                  },LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
                  View_loading.instance.load(arr,function():void
                  {
                     initT();
                     visible = true;
                     View_loading.instance.visible = false;
                  });
                  return;
               }
               this.initT();
            }
            this.resetPosition();
         }
         super.visible = value;
      }
      
      private function initT() : void
      {
         ComponentUtil.getBitmap("Flag_Hu",this,{
            "x":48,
            "y":78
         },Global.crossCampBattle_Imgdm);
         ComponentUtil.getBitmap("Flag_Long",this,{
            "x":48,
            "y":42
         },Global.crossCampBattle_Imgdm);
         this.selfBloodBar.bitmapData = ComponentUtil.getBitmapData("Slip_JDT",Global.crossCampBattle_Imgdm);
         this.selfBloodBg.bitmapData = ComponentUtil.getBitmapData("Slip_JDTD",Global.crossCampBattle_Imgdm);
         this.enemyBloodBar.bitmapData = ComponentUtil.getBitmapData("Slip_JDT",Global.crossCampBattle_Imgdm);
         this.enemyBloodBg.bitmapData = ComponentUtil.getBitmapData("Slip_JDTD",Global.crossCampBattle_Imgdm);
         this.crystalBar.bitmapData = ComponentUtil.getBitmapData("Slip_JDT",Global.crossCampBattle_Imgdm);
         this.crystalBg.bitmapData = ComponentUtil.getBitmapData("Slip_JDTD",Global.crossCampBattle_Imgdm);
         this.buffBar.bitmapData = ComponentUtil.getBitmapData("Slip_JDT",Global.crossCampBattle_Imgdm);
         this.buffBg.bitmapData = ComponentUtil.getBitmapData("Slip_JDTD",Global.crossCampBattle_Imgdm);
         this.pointsBar.bitmapData = ComponentUtil.getBitmapData("Slip_JDT",Global.crossCampBattle_Imgdm);
         this.pointsBg.bitmapData = ComponentUtil.getBitmapData("Slip_JDTD",Global.crossCampBattle_Imgdm);
         this.isUIComplete = true;
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - this.width;
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

