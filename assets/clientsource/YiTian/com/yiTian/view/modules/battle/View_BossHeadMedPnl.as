package com.yiTian.view.modules.battle
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.BattleUnit;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.UIBase;
   import com.yiTian.view.modules.guangMingDing.Enum_guangMingDing;
   import com.yiTian.view.modules.guangMingDing.Model_guangMingDing;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Dictionary;
   
   public class View_BossHeadMedPnl extends UIBase
   {
      
      public var _bbb:BattleBloodBar;
      
      public var _tfRemain:MyTextField;
      
      public var _targerID:Number;
      
      public var _targer:BattleUnit;
      
      public var _icon:Bitmap2;
      
      public var _bmBG:Bitmap;
      
      private var _tfName:MyTextField;
      
      private var shpMask:Shape;
      
      public var matchingMethods:Array = [];
      
      public var staticWidth:Number = 404;
      
      private var bloodSp:Sprite;
      
      private var iconSP:Sprite;
      
      private var iconSP2:Sprite;
      
      private var _tfIndex:MyTextField;
      
      private var _tfJumpInfo:MyTextField;
      
      private var _isLoad:Boolean = false;
      
      public function View_BossHeadMedPnl()
      {
         super();
         this.bloodSp = new Sprite();
         addChild(this.bloodSp);
         this.iconSP = new Sprite();
         addChild(this.iconSP);
         this.iconSP2 = new Sprite();
         addChild(this.iconSP2);
         this.initStaticView();
         this.initDynamicView();
         bindParent = GameScene.battleLayer.uiLayer;
         super.visible = false;
         this.updateJumpTxt();
      }
      
      public static function isGMDBoss(unit:BattleUnit) : int
      {
         var k:int = 0;
         var info:Array = null;
         var bosId:int = 0;
         if(Global.sceneMap >= 12410 && Global.sceneMap <= 12414 && unit.type == UnitType.NPC)
         {
            k = 12409 + Model_guangMingDing._disFloor;
            info = Data_lib.ycgmd[k];
            bosId = int(info[Enum_guangMingDing.LIB_MAP_BOSSID]);
            if(bosId != 0 && bosId == unit.sysId)
            {
               return 1;
            }
            return -1;
         }
         return -1;
      }
      
      public function tryLoadSource() : void
      {
         var len:int;
         var patch:String;
         var srcs:Array;
         var i:int;
         var bm:Bitmap = null;
         if(this._isLoad)
         {
            return;
         }
         this._isLoad = true;
         len = 4;
         patch = "lang/ch/Fight_Imgs.swf";
         Utils.loadTitle(patch,"ProgressBack",this._bmBG,{},null,function(info:Object):void
         {
            Global.Fight_Imgsdm = info.applicataionDomain;
         });
         srcs = ["Progress_01","Progress_02","Progress_03","Progress_04","Progress_05"];
         i = 0;
         while(i < srcs.length)
         {
            bm = new Bitmap();
            this._bbb.appendBar(bm);
            Utils.loadTitle(patch,srcs[i],bm,{},null);
            i += 1;
         }
         bm = new Bitmap();
         this.iconSP.addChild(bm);
         Utils.loadTitle(patch,"HeadBack",bm,{
            "x":403,
            "y":6
         });
      }
      
      override protected function initStaticView() : void
      {
         this._bmBG = new Bitmap();
         this.bloodSp.addChild(this._bmBG);
         this._icon = new Bitmap2();
         this.iconSP2.addChild(this._icon);
         this._bmBG.y = 58;
         this._bbb = new BattleBloodBar();
         this._bbb.x = this._bmBG.x + 11;
         this._bbb.y = this._bmBG.y + 6;
         this.bloodSp.addChild(this._bbb);
         this.shpMask = new Shape();
         this.shpMask.graphics.beginFill(0,1);
         this.shpMask.graphics.drawRect(0,0,this.staticWidth,30);
         this.shpMask.graphics.endFill();
         this.shpMask.x = this._bbb.x;
         this.shpMask.y = this._bbb.y;
         this.bloodSp.addChild(this.shpMask);
         this._tfRemain = ComponentUtil.getTextField("",this,{
            "x":205,
            "y":67,
            "color":16776960,
            "bold":true
         });
         this._tfRemain.autoSize = TextFieldAutoSize.CENTER;
         this._tfIndex = ComponentUtil.getTextField("",this,{
            "x":427,
            "y":68,
            "bold":true,
            "size":14,
            "color":16776960
         });
         this._tfIndex.autoSize = TextFieldAutoSize.CENTER;
         this._tfName = ComponentUtil.getTextField("",this,{
            "size":18,
            "color":16768273,
            "x":396,
            "y":30
         });
         this._tfName.autoSize = TextFieldAutoSize.RIGHT;
         this._tfJumpInfo = ComponentUtil.getTextField("",this,{
            "x":100,
            "y":100,
            "size":16,
            "color":16746496,
            "bold":true
         });
         this._tfJumpInfo.filters = [new DropShadowFilter(2,315,13404194)];
         this._tfJumpInfo.htmlText = Model_guangMingDing.jumpInfo;
      }
      
      override protected function initDynamicView() : void
      {
         Global.control.registerCallBack(Enum_MsgType.BATTLEUNIT_INIT,this.onUnitInit);
         this.matchingMethods.push(isGMDBoss);
      }
      
      public function updateJumpTxt() : void
      {
         if(Boolean(this._tfJumpInfo))
         {
            this._tfJumpInfo.htmlText = Model_guangMingDing.jumpInfo;
         }
      }
      
      public function show(p:* = null) : void
      {
         this.visible = true;
         GameScene.battleLayer.resize();
      }
      
      public function hide(p:* = null) : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            this.tryLoadSource();
            Global.control.registerCallBack(Enum_MsgType.BATTLEUNIT_UPDATE,this.onUnitUpdate);
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_PRE_END,this.hide);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.BATTLEUNIT_UPDATE,this.onUnitUpdate);
            Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_PRE_END,this.hide);
            Tween.stop(this._bbb);
         }
         super.visible = value;
      }
      
      private function onUnitInit(unit:BattleUnit) : void
      {
         var method:Function = null;
         var dic:Dictionary = null;
         var sid:int = 0;
         var url:String = null;
         this.tryLoadSource();
         var b:Boolean = false;
         for each(method in this.matchingMethods)
         {
            if(method(unit) == 1)
            {
               b = true;
               break;
            }
         }
         if(b)
         {
            this._targerID = unit.id;
            this._targer = unit;
            this._tfRemain.text = this._targer.hp.toString() + "/" + this._targer.hpMax.toString();
            this._bbb.percent = unit.hp / unit.hpMax;
            this.shpMask.scaleX = this._bbb.curPercent;
            this._tfIndex.text = "×" + this._bbb.playIndex.toString();
            this._bbb.bars[this._bbb.playIndex].mask = this.shpMask;
            dic = Data_lib.ycgmd;
            sid = Global.sceneID;
            if(Boolean(dic[sid]))
            {
               url = "resource/image/battleIcon/" + dic[sid][Enum_guangMingDing.LIB_MAP_BOSSHEAD] + ".png";
               this._icon.load(url,1,this.iconLoadingComplete);
            }
            this.show();
            this._tfName.text = unit.name;
            this.resetPosition();
         }
      }
      
      private function iconLoadingComplete(info:Object) : void
      {
         this._icon.x = 423;
         this._icon.y = -this._icon.height + 92;
      }
      
      private function onTick() : void
      {
         this._tfRemain.text = (this._bbb.percent * this._targer.hpMax >> 0).toString() + "/" + this._targer.hpMax.toString();
         this.shpMask.scaleX = this._bbb.curPercent;
         this._bbb.bars[this._bbb.playIndex].mask = this.shpMask;
         this._tfIndex.text = "×" + this._bbb.playIndex.toString();
      }
      
      private function onUnitUpdate(unit:BattleUnit) : void
      {
         var bbbPercent:Number = NaN;
         if(this._targerID == unit.id)
         {
            bbbPercent = unit.hp / unit.hpMax;
            Tween.curTo(this._bbb,700,{"percent":bbbPercent},null,this.onTick,Tween.SIN);
         }
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - 600;
         y = 10;
      }
   }
}

