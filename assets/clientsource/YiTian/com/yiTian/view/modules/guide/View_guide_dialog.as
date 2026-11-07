package com.yiTian.view.modules.guide
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_ChongChuJiangHu;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.GuideManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.UIBase;
   import com.yiTian.view.modules.newerGuide.Model_newer;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class View_guide_dialog extends UIBase
   {
      
      private var heroHead:Bitmap;
      
      private var npcHead:Bitmap;
      
      private var heroDialog:MyTextField;
      
      private var npcDialog:MyTextField;
      
      private var continueTF:MyTextField;
      
      private var endBtn:Button;
      
      private var upBg:Shape;
      
      private var downBg:Shape;
      
      public var isPlaying:Boolean = false;
      
      private var _addStrLen:int;
      
      private var _headStr:String;
      
      private var _addStr:String;
      
      private var _changeTf:MyTextField;
      
      private var _nowIndex:int;
      
      private var _beginTime:int;
      
      private var _mouse:Effect;
      
      public function View_guide_dialog()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.upBg = ComponentUtil.getShape(1,70,0,1);
         addChild(this.upBg);
         this.downBg = ComponentUtil.getShape(1,110,0,1);
         addChild(this.downBg);
         this.heroHead = new Bitmap();
         addChild(this.heroHead);
         this.npcHead = new Bitmap();
         addChild(this.npcHead);
         this.heroDialog = ComponentUtil.getTextField("",this,{
            "realWidth":400,
            "wordWrap":true,
            "size":16,
            "leading":10
         });
         this.npcDialog = ComponentUtil.getTextField("",this,{
            "realWidth":500,
            "wordWrap":true,
            "size":16,
            "leading":10
         });
         this.continueTF = ComponentUtil.getTextField(LangConfig.getWord("50022",5),this,{
            "color":16777130,
            "size":14,
            "underline":true
         });
         GameScene.sysLayer.addChild(this);
      }
      
      public function update(id:int, dialog:String) : void
      {
         this.hide();
         if(id == 1)
         {
            Utils.getLoadBitmap(Const_strImg.getPlayerHead(GameUnitManager.hero.job,GameUnitManager.hero.sex,7),this.heroHead,null,function():void
            {
               heroHead.x = Global.stage.stageWidth - heroHead.width;
               heroHead.y = Global.stage.stageHeight - heroHead.height;
               heroHead.visible = true;
            });
            this.heroDialog.htmlText = HtmlUtil.bold(HtmlUtil.fontBr(GameUnitManager.hero.name + "：",ColorConstant.getColorStr(ColorConstant.NPC_NAME),16));
            this.play(HtmlUtil.bold(HtmlUtil.fontBr(GameUnitManager.hero.name + "：",ColorConstant.getColorStr(ColorConstant.NPC_NAME),16)),dialog,this.heroDialog);
            this.heroDialog.visible = true;
         }
         else
         {
            Utils.getLoadBitmap(Const_strImg.getGuideNpcHeadUrl(Data_lib.npc[id][Npc.HEAD]),this.npcHead,null,function():void
            {
               npcHead.y = Global.stage.stageHeight - npcHead.height;
               npcHead.visible = true;
            });
            this.npcDialog.htmlText = HtmlUtil.bold(HtmlUtil.fontBr(Data_lib.npc[id][Npc.NAME] + "：",ColorConstant.getColorStr(ColorConstant.NPC_NAME),16));
            this.play(HtmlUtil.bold(HtmlUtil.fontBr(Data_lib.npc[id][Npc.NAME] + "：",ColorConstant.getColorStr(ColorConstant.NPC_NAME),16)),dialog,this.npcDialog);
            this.npcDialog.visible = true;
         }
         this.continueTF.visible = false;
      }
      
      private function play(headStr:String, addstr:String, tf:MyTextField) : void
      {
         this._addStrLen = addstr.length;
         this._headStr = headStr;
         this._addStr = addstr;
         this._changeTf = tf;
         this._nowIndex = 1;
         this._beginTime = getTimer();
         GameScene.instance.addFrameCallBack(this.run);
      }
      
      private function run() : void
      {
         var now:int = getTimer();
         if(now - this._beginTime < 30)
         {
            return;
         }
         this._beginTime = now;
         if(this._nowIndex <= this._addStrLen)
         {
            this._changeTf.htmlText = this._headStr + this._addStr.substr(0,this._nowIndex);
            ++this._nowIndex;
         }
         else
         {
            GameScene.instance.removeFrameCallBack(this.run);
            Global.stage.addEventListener(MouseEvent.CLICK,this.doClick);
            this._mouse = EffectManager.addEffect("mouse",this,500,this._changeTf == this.npcDialog ? int(Global.stage.stageWidth - 200) : 150,Global.stage.stageHeight - 40,true);
            this.continueTF.x = this._mouse.px + 25;
            this.continueTF.y = this._mouse.py - 5;
            this.continueTF.visible = true;
         }
      }
      
      private function doClick(e:MouseEvent) : void
      {
         Global.stage.removeEventListener(MouseEvent.CLICK,this.doClick);
         if(Model_newer.isRunning)
         {
            Model_newer.newerHandle();
            return;
         }
         if(Boolean(this._mouse))
         {
            EffectManager.removeEffect(this._mouse);
            this._mouse = null;
         }
         this.continueTF.visible = false;
         dispatchEvent(new Event("GUIDE_DIALOD_END"));
      }
      
      public function hideJumpBtn() : void
      {
         if(Boolean(this.endBtn) && this.endBtn.visible)
         {
            this.endBtn.visible = false;
         }
      }
      
      public function showJumpBtn() : void
      {
         if(Boolean(this.endBtn) && !this.endBtn.visible)
         {
            this.endBtn.visible = true;
         }
      }
      
      public function hide() : void
      {
         this.heroHead.visible = false;
         this.npcHead.visible = false;
         this.heroDialog.visible = false;
         this.npcDialog.visible = false;
         if(Boolean(this._mouse))
         {
            EffectManager.removeEffect(this._mouse);
            this._mouse = null;
         }
         if(Boolean(this.continueTF))
         {
            this.continueTF.visible = false;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(Enum_ChongChuJiangHu.CAN_JUMP)
            {
               if(!this.endBtn)
               {
                  MassLoader.add("lang/ch/jumpCG.swf",this.loadCom);
               }
               else
               {
                  this.endBtn.visible = true;
               }
            }
            else if(Boolean(this.endBtn))
            {
               this.endBtn.visible = false;
            }
         }
      }
      
      private function loadCom(info:Object) : void
      {
         Global.jumpCG_dm = info.applicationDomain;
         this.dealEndBtn();
      }
      
      private function dealEndBtn() : void
      {
         this.endBtn = ComponentUtil.getButton("","Button_Jump",this,null,Global.jumpCG_dm);
         this.endBtn.callBack = function():void
         {
            GuideManager.jumpFlash();
         };
         this.endBtn.x = (Global.stage.stageWidth - this.endBtn.width) / 2;
         this.endBtn.y = Global.stage.stageHeight - this.endBtn.height - 110;
      }
      
      override public function resetPosition() : void
      {
         this.upBg.width = Global.stage.stageWidth;
         this.downBg.width = Global.stage.stageWidth;
         this.downBg.y = Global.stage.stageHeight - 110;
         this.heroDialog.x = Global.stage.stageWidth - 700;
         this.heroDialog.y = Global.stage.stageHeight - 100;
         this.npcDialog.x = 300;
         this.npcDialog.y = Global.stage.stageHeight - 100;
         this.heroHead.x = Global.stage.stageWidth - this.heroHead.width;
         this.heroHead.y = Global.stage.stageHeight - this.heroHead.height;
         this.npcHead.y = Global.stage.stageHeight - this.npcHead.height;
         if(Boolean(this._mouse))
         {
            this._mouse.px = this._changeTf == this.npcDialog ? int(Global.stage.stageWidth - 200) : 150;
            this._mouse.py = Global.stage.stageHeight - 40;
            this.continueTF.x = this._mouse.px + 25;
            this.continueTF.y = this._mouse.py - 5;
         }
      }
   }
}

