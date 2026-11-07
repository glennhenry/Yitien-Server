package com.yiTian.view.modules.shenBing
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.net.message.cg.ShenBingCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_ShenBingSkillUpdate extends Panel123
   {
      
      private var _back:DisplayObject;
      
      private var _curGrid:View_Grid;
      
      private var _curQuality:MyTextField;
      
      private var _nxtQuality:MyTextField;
      
      private var _curAtb:MyTextField;
      
      private var _nxtAtb:MyTextField;
      
      private var _btnUpdate:Button;
      
      private var _tfNum:MyTextField;
      
      private var _tfCost:MyTextField;
      
      private var _targetGrid:View_Grid;
      
      private var _vo:Vo_ShenBingSkill;
      
      private var _effBm:Bitmap;
      
      public function View_ShenBingSkillUpdate()
      {
         super();
         bindParent = GameScene.modalLayer;
         regResource("lang/ch/ShenBing.swf","ShenBingdm");
         regResource("lang/ch/wordEffects.swf","wordEffect");
      }
      
      override protected function initUI2() : void
      {
         this._back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":429,
            "height":273
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":392,
            "y":6,
            "callBack":this.hide
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":379,
            "height":223
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":35,
            "y":49,
            "width":359,
            "height":153
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("BG_HW",this,{
            "x":125,
            "y":55
         },Global.ShenBingdm);
         ComponentUtil.getBitmap("Title_JNSJ",this,{
            "x":134,
            "y":5
         },Global.ShenBingdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":49,
            "y":135,
            "width":142,
            "height":53
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":237,
            "y":135,
            "width":142,
            "height":53
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("BG_BJT",this,{
            "x":199,
            "y":143
         },Global.ShenBingdm);
         this._curQuality = ComponentUtil.getTextField("",this,{
            "x":117,
            "y":90
         },TextFieldAutoSize.CENTER);
         this._nxtQuality = ComponentUtil.getTextField("",this,{
            "x":306,
            "y":90
         },TextFieldAutoSize.CENTER);
         this._curAtb = ComponentUtil.getTextField("",this,{
            "x":57,
            "y":138,
            "color":15856113,
            "realWidth":135,
            "wordWrap":true
         });
         this._curAtb.autoSize = TextFieldAutoSize.CENTER;
         this._nxtAtb = ComponentUtil.getTextField("",this,{
            "x":246,
            "y":138,
            "color":15856113,
            "realWidth":135,
            "wordWrap":true
         });
         this._nxtAtb.autoSize = TextFieldAutoSize.CENTER;
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":130,
            "y":232,
            "width":93,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":130,
            "y":207,
            "width":93,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Ico_JNSP28",this,{
            "x":93,
            "y":204
         },Global.ShenBingdm);
         ComponentUtil.getTextField("升级费用",this,{
            "x":71,
            "y":234,
            "color":11904647
         });
         this._tfNum = ComponentUtil.getTextField("",this,{
            "x":174,
            "y":208,
            "color":14013822
         },TextFieldAutoSize.CENTER);
         this._tfCost = ComponentUtil.getTextField("",this,{
            "x":174,
            "y":233,
            "color":14013822
         },TextFieldAutoSize.CENTER);
         this._curGrid = new View_Grid();
         this._curGrid.set_bmp_bg(null);
         this._curGrid.set_bmp_over(true,null);
         this._curGrid.x = 196;
         this._curGrid.y = 71;
         addChild(this._curGrid);
         this._btnUpdate = ComponentUtil.getButton("","BT_JNSJ",this,{
            "x":237,
            "y":210,
            "callBack":this.btnUpdateClickHd
         },Global.ShenBingdm);
      }
      
      public function show(prm:* = null) : void
      {
         if(Boolean(this._targetGrid))
         {
            this._targetGrid.removeEventListener(Event.CHANGE,this.handlerGridChange);
         }
         ModalUIManager.POPUP(this);
         if(prm is Vo_ShenBingSkill)
         {
            this._curGrid.vo = prm as Vo_ShenBingSkill;
            this._vo = prm as Vo_ShenBingSkill;
            this.update(prm as Vo_ShenBingSkill);
         }
         else if(prm is View_Grid)
         {
            this._targetGrid = prm as View_Grid;
            this._targetGrid.addEventListener(Event.CHANGE,this.handlerGridChange);
            this.update(this._targetGrid.vo as Vo_ShenBingSkill);
            this._vo = this._targetGrid.vo as Vo_ShenBingSkill;
         }
         if(Boolean(this._vo) && this._vo.gridType == 1)
         {
            this._curGrid.x = 188;
            this._curGrid.y = 63;
         }
         else if(Boolean(this._vo))
         {
            this._curGrid.x = 196;
            this._curGrid.y = 71;
         }
      }
      
      private function handlerGridChange(e:Event) : void
      {
         this.update(e.target.vo);
      }
      
      public function update(vo:Vo_ShenBingSkill = null) : void
      {
         var color1:int = 0;
         var color2:int = 0;
         this._vo = null;
         var v:Vo_ShenBingSkill = vo || this._targetGrid.vo as Vo_ShenBingSkill;
         if(Boolean(v) && v.nextID != 0)
         {
            this._curQuality.htmlText = "当前品质：" + Enum_BroadCastTool.instance.getColorStr(ShenBingUtil.colorLabel[v.quality],v.quality);
            this._nxtQuality.htmlText = "下一品质：" + Enum_BroadCastTool.instance.getColorStr(ShenBingUtil.colorLabel[Data_lib.sbSkill[v.nextID][Enum_ShenBing.SKILL_QUALITY]],Data_lib.sbSkill[v.nextID][Enum_ShenBing.SKILL_QUALITY]);
            this._curGrid.vo = v;
            this._curAtb.htmlText = v.discription;
            this._nxtAtb.htmlText = Data_lib.sbSkill[v.nextID][Enum_ShenBing.SKILL_DISCRIPTION];
            color1 = CommandManager.get_bag_count(ShenBingUtil.SHENBING_CHIP_ID) >= v.num_itemCost ? 3407667 : 16724787;
            color2 = GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver >= v.num_sliverCost ? 3407667 : 16724787;
            this._tfNum.color = color1;
            this._tfNum.htmlText = v.num_itemCost.toString();
            this._tfCost.color = color2;
            this._tfCost.htmlText = v.num_sliverCost.toString();
         }
         else
         {
            this.hide();
         }
      }
      
      private function check() : void
      {
      }
      
      public function hide(prm:* = null) : void
      {
         if(Boolean(this._targetGrid))
         {
            this._targetGrid.removeEventListener(Event.CHANGE,this.handlerGridChange);
         }
         ModalUIManager.UNPOP();
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            Global.control.registerCallBack(MSG_ShenBing.SB_SKILL_UPDATE_SUCCESS,this.updateSuccessHd);
         }
         else
         {
            Global.control.removeCallBack(MSG_ShenBing.SB_SKILL_UPDATE_SUCCESS,this.updateSuccessHd);
         }
         super.visible = value;
      }
      
      private function btnUpdateClickHd(e:MouseEvent) : void
      {
         var idx:int = 0;
         this._btnUpdate.enabled = false;
         idx = int(setTimeout(function():void
         {
            _btnUpdate.enabled = true;
            clearTimeout(idx);
         },1500));
         if(Boolean(this._targetGrid) && Boolean(this._targetGrid.vo))
         {
            ShenBingCGMessage.CG_SHENBING_UPDATE_SKILL(this._targetGrid.tabIndex,(this._targetGrid.vo as Vo_ShenBingSkill).gridType);
         }
      }
      
      private function updateSuccessHd() : void
      {
         this._effBm = this._effBm || new Bitmap();
         this._effBm.bitmapData = ComponentUtil.getBitmapData("shengji",Global.wordEffect);
         GameScene.upUILayer.addChild(this._effBm);
         EffectManager.addEffect("35063",GameScene.upUILayer,1500,Global.stage.stageWidth / 2,Global.stage.stageHeight / 2);
         this._effBm.x = (Global.stage.stageWidth - this._effBm.width) / 2;
         this._effBm.y = Global.stage.stageHeight / 2 - 70;
         Tween.to(this._effBm,3000,{"alpha":[1,0]});
      }
      
      private function bmCompleteHd() : void
      {
         if(Boolean(this._effBm.parent))
         {
            this._effBm.parent.removeChild(this._effBm);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.width - this._back.width) / 2;
         y = (Global.stage.height - this._back.height) / 2;
      }
   }
}

