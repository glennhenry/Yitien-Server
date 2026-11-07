package com.yiTian.view.modules.shenMiShop
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.model.Model_sms;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.cast.View_equip_CZ_xilian;
   import com.yiTian.view.modules.cast.View_equip_polish;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_SMS_tishi extends Panel
   {
      
      private var Button_Yes:Button;
      
      private var Button_No:Button;
      
      private var Imformate_text:MyTextField;
      
      private var SMS_CheckBox:CheckBox;
      
      private var refres_tm:int;
      
      private var refes_type:int;
      
      public var IS_EXP:int = 1;
      
      public var SHUA_XIN:int = 2;
      
      public var _type:int;
      
      private var tip_type:String = "mestry";
      
      private var _costTB:int;
      
      private var func:Function;
      
      public function View_SMS_tishi()
      {
         super();
         bindParent = GameScene.popupLayer;
         GameScene.popupLayer.addChild(this);
         addChild(new AddMask());
      }
      
      override protected function initStaticView() : void
      {
         var _w:int = 60;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":328 + _w,
            "height":188
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":280 + _w,
            "height":110
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WXPrompt",this,{
            "x":90 + _w / 2,
            "y":5
         },Global.Img_Cdm);
         move = new Rectangle(0,0,306,38);
         this.Button_No = ComponentUtil.getButton(LangConfig.getWord("5",0),"Button_Four",this,{
            "x":195 + _w / 2,
            "y":155,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Yes = ComponentUtil.getButton(LangConfig.getWord("6",0),"Button_Four",this,{
            "x":75 + _w / 2,
            "y":155,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Imformate_text = ComponentUtil.getTextField(LangConfig.getWord("42",0),this,{
            "x":59,
            "y":60,
            "color":16764206,
            "realWidth":260,
            "multiline":true,
            "wordWrap":true,
            "leading":5
         });
         this.SMS_CheckBox = new CheckBox("","CheckBox01",Global.Img_Cdm);
         this.SMS_CheckBox.text = LangConfig.getWord("43",0);
         this.SMS_CheckBox.textColor = 11904647;
         this.SMS_CheckBox.x = 108 + _w / 2;
         this.SMS_CheckBox.y = 103 + 15;
         addChild(this.SMS_CheckBox);
         this.Imformate_text.align = TextAlign.CENTER;
         this.Button_Yes.addEventListener(MouseEvent.CLICK,this.sureHandle);
         this.Button_No.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            visible = false;
         });
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      public function setSelectVis(value:Boolean) : void
      {
         this.SMS_CheckBox.visible = value;
         if(!value)
         {
            this.Imformate_text.y = 80;
         }
         else
         {
            this.Imformate_text.y = 60;
         }
      }
      
      public function update_1txt(arr:Array, _refresh_tm:int) : void
      {
         this.tip_type = "mestry";
         this.refres_tm = _refresh_tm;
         var temStr:String = "";
         var i:int = 0;
         while(i < arr.length)
         {
            temStr += HtmlUtil.font(arr[i][0],Model_shop.get_color_arr[arr[i][1] - 1]);
            i++;
         }
         if(this.refres_tm == 0)
         {
            this.refes_type = 1;
            this.Imformate_text.htmlText = LangConfig.getWord("44",0) + temStr + LangConfig.getWord("45",0);
         }
         else if(this.refres_tm == -1)
         {
            this.refes_type = -1;
            this.Imformate_text.htmlText = LangConfig.getWord("44",0) + temStr + LangConfig.getWord("45",0);
         }
         else
         {
            this.refes_type = 2;
            this.Imformate_text.htmlText = LangConfig.getWord("44",0) + temStr + LangConfig.getWord("46",0);
         }
      }
      
      private function sureHandle(e:MouseEvent) : void
      {
         if(this.tip_type == "mestry")
         {
            Model_sms.selection = this.SMS_CheckBox.selected;
            if(this.refes_type == 1)
            {
               UIManager.sm_shop.getEffect();
            }
            else if(this.refes_type == -1)
            {
               if(GameUnitManager.hero.money < 10)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("47",0));
                  return;
               }
               UIManager.sm_shop.getEffect();
            }
            else
            {
               if(GameUnitManager.hero.money < 10)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("47",0));
                  return;
               }
               UIManager.sm_shop.getEffect();
            }
         }
         else if(this.tip_type == "polish")
         {
            View_equip_polish.is_selection = this.SMS_CheckBox.selected;
            if(GameUnitManager.hero.money < this._costTB)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("47",0));
               return;
            }
            if(this.func != null)
            {
               this.func.call(null);
            }
         }
         else if(this.tip_type == "skill")
         {
            View_equip_CZ_xilian.isCheck = this.SMS_CheckBox.selected;
            if(this.func != null)
            {
               this.func.call(null);
            }
         }
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            this.func = null;
         }
      }
      
      public function updata_txt_polish(_str:String, costYB:int, callBakc:Function = null) : void
      {
         this.tip_type = "polish";
         this._costTB = costYB;
         this.func = callBakc;
         this.Imformate_text.htmlText = _str;
      }
      
      public function updata_txt_skill(_str:String, _callBack:Function) : void
      {
         this.visible = true;
         this.tip_type = "skill";
         this.func = _callBack;
         this.Imformate_text.htmlText = _str;
      }
      
      public function freshHandle() : void
      {
         if(GameUnitManager.hero.money < 10)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29",0));
            return;
         }
         UIManager.sm_shop.getEffect();
         this.visible = false;
      }
      
      public function update_2txt(str:String, _refresh_tm:int) : void
      {
         this.tip_type = "mestry";
         this.refres_tm = _refresh_tm;
         this.Imformate_text.text = str;
      }
   }
}

import com.yiTian.Global;
import flash.display.Sprite;

class AddMask extends Sprite
{
   
   public function AddMask()
   {
      super();
      width = Global.stage.width;
      height = Global.stage.height;
      mouseChildren = false;
      mouseEnabled = false;
   }
}
