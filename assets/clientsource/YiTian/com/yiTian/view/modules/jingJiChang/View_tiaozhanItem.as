package com.yiTian.view.modules.jingJiChang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_jingJiChang;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.JingJiChangCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextFormatAlign;
   
   public class View_tiaozhanItem extends Sprite
   {
      
      private var Button_CaoZuo:Button;
      
      private var Name_text:MyTextField;
      
      private var PaiMing_text:MyTextField;
      
      private var Lever_text:MyTextField;
      
      private var job_text:MyTextField;
      
      private var power_text:MyTextField;
      
      private var mouseBack:DisplayObject;
      
      private var _price:int = 1;
      
      public var _name:String;
      
      public var _level:int;
      
      public var _job:int;
      
      public var _sex:int;
      
      public var _petId:int;
      
      public var _roleId:Number = 0;
      
      public var _lfTime:int;
      
      public var _zhanLi:int;
      
      private var hr_position:int;
      
      private var pet_position:int;
      
      private var petIcon:int;
      
      private var luckyStar:Bitmap;
      
      private var luckyNum:int = -1;
      
      private var _isChoose:Boolean;
      
      public function View_tiaozhanItem()
      {
         super();
         this.init();
      }
      
      public function init() : void
      {
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":27,
            "width":356,
            "height":2
         },Global.Img_Cdm);
         this.mouseBack = ComponentUtil.getDisplayObject("Item_Select",this,{
            "width":350,
            "height":28,
            "y":-2
         });
         this.choose = false;
         this.mouseBack.addEventListener(MouseEvent.MOUSE_OVER,this.onOverHandler);
         this.mouseBack.addEventListener(MouseEvent.MOUSE_OUT,this.onOutHandler);
         this.Button_CaoZuo = ComponentUtil.getButton(LangConfig.getWord("138",0),"Button_Two",this,{
            "x":284,
            "y":3,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Name_text = ComponentUtil.getTextField(LangConfig.getWord("344",0),this,{
            "x":-2,
            "y":4.75,
            "realWidth":100,
            "realHeight":20
         });
         this.Name_text.align = TextFormatAlign.CENTER;
         this.Name_text.mouseEnabled = true;
         this.Lever_text = ComponentUtil.getTextField("LV.000",this,{
            "x":158,
            "y":4.75,
            "realWidth":48
         });
         this.Lever_text.align = TextFormatAlign.CENTER;
         this.job_text = ComponentUtil.getTextField(LangConfig.getWord("345",0),this,{
            "x":160,
            "y":4.75,
            "realWidth":50
         });
         this.job_text.visible = false;
         this.power_text = ComponentUtil.getTextField(LangConfig.getWord("346",0),this,{
            "x":92.65,
            "y":4.75,
            "realWidth":60
         });
         this.job_text.align = TextFormatAlign.CENTER;
         this.power_text.align = TextFormatAlign.CENTER;
         this.power_text.textColor = 14013822;
         this.PaiMing_text = ComponentUtil.getTextField("000",this,{
            "x":229.3,
            "y":4.75,
            "realWidth":40
         });
         this.PaiMing_text.align = TextFormatAlign.CENTER;
         this.Button_CaoZuo.addEventListener(MouseEvent.CLICK,this.tzHandle);
      }
      
      private function tzHandle(e:MouseEvent) : void
      {
         var temPay:int = 0;
         temPay = 0;
         UIManager.storeTip.wpid = 0;
         UIManager.storeTip.isStore = false;
         UIManager.storeTip.isStore_youhui = false;
         if(UIManager.jjc_panel._leftTime % 60 == 0)
         {
            temPay = int(UIManager.jjc_panel._leftTime / 60);
         }
         else
         {
            temPay = int(UIManager.jjc_panel._leftTime / 60) + 1;
         }
         if(GameUnitManager.hero.level < 25)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("338",0));
            return;
         }
         if(UIManager.jjc_panel.TXChiShu_text.text == "0")
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("339",0));
            return;
         }
         this._lfTime = UIManager.jjc_panel._leftTime;
         if(this._lfTime > 0)
         {
            UIManager.storeTip.visible = true;
            UIManager.storeTip._nameStr = this.Name_text.text;
            UIManager.storeTip._pai_ming = int(this.PaiMing_text.text);
            UIManager.storeTip._roleId = this._roleId;
            UIManager.storeTip._type = LangConfig.getWord("138",0);
            UIManager.storeTip.tiaoZhan_cost = temPay;
            UIManager.storeTip.Imformate_text.text = LangConfig.getWord("341",0) + String(temPay) + LangConfig.getWord("342",0);
         }
         else
         {
            JingJiChangCGMessage.CG_DEKARON(this._roleId,int(this.PaiMing_text.text),this.Name_text.text);
         }
      }
      
      private function linkHandler(e:TextEvent) : void
      {
         Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,this._roleId);
      }
      
      public function set TZName(str:String) : void
      {
         if(this._job == 0)
         {
            this._job = 1;
         }
         this.Name_text.textColor = Model_jingJiChang.getColor[Enum_job.getBaseJob(this._job) - 1];
         this.Name_text.text = Model_heFu.repNameByHero(str);
         this.job_text.textColor = Model_jingJiChang.getColor[Enum_job.getBaseJob(this._job) - 1];
         this.job_text.text = Model_jingJiChang.getJob[Enum_job.getBaseJob(this._job) - 1];
         this._name = Model_heFu.repNameByHero(str);
         this.power_text.text = String(this._zhanLi);
         this.Name_text.htmlText = "<u>" + HtmlUtil.link(this._name,"") + "</u>";
         this.Name_text.addEventListener(TextEvent.LINK,this.linkHandler);
         this.Name_text.addEventListener(MouseEvent.MOUSE_DOWN,this.mDownHandle);
      }
      
      private function mDownHandle(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      public function update_pos(hr_pos:int, pet_pos:int, pet_icon:int) : void
      {
         this.hr_position = hr_pos;
         this.pet_position = pet_pos;
         this.petIcon = pet_icon;
      }
      
      public function set paiMing(_paiming:int) : void
      {
         this.PaiMing_text.textColor = 16711680;
         this.PaiMing_text.text = String(_paiming);
         this.showLuckyStar(this.luckyNum);
      }
      
      public function showLuckyStar(num:int) : void
      {
         this.luckyNum = num;
         if(num == -1)
         {
            if(Boolean(this.luckyStar))
            {
               this.luckyStar.visible = false;
            }
            return;
         }
         var _paiMing:String = this.PaiMing_text.text;
         if(int(_paiMing.substr(_paiMing.length - 1,1)) == num)
         {
            if(!this.luckyStar)
            {
               this.luckyStar = new Bitmap();
               addChild(this.luckyStar);
               Utils.getLoadBitmap("resource/image/star/orangeFull.png",this.luckyStar,{
                  "x":this.PaiMing_text.x - 23,
                  "y":2
               });
            }
            this.luckyStar.visible = true;
         }
         else if(Boolean(this.luckyStar))
         {
            this.luckyStar.visible = false;
         }
         if(int(_paiMing) == 1)
         {
            if(!this.luckyStar)
            {
               this.luckyStar = new Bitmap();
               addChild(this.luckyStar);
               Utils.getLoadBitmap("resource/image/star/orangeFull.png",this.luckyStar,{
                  "x":this.PaiMing_text.x - 23,
                  "y":4.75
               });
            }
            this.luckyStar.visible = true;
         }
      }
      
      public function set level(_lvl:int) : void
      {
         this._level = _lvl;
         this.Lever_text.textColor = 16763955;
         this.Lever_text.text = "LV." + String(_lvl);
      }
      
      private function onOutHandler(e:MouseEvent) : void
      {
         if(this._isChoose)
         {
            return;
         }
         this.mouseBack.alpha = 0;
      }
      
      private function onOverHandler(e:MouseEvent) : void
      {
         if(this._isChoose)
         {
            return;
         }
         this.mouseBack.alpha = 1;
      }
      
      public function set choose(value:Boolean) : void
      {
         if(value)
         {
            this.mouseBack.alpha = 1;
         }
         else
         {
            this.mouseBack.alpha = 0;
         }
         this._isChoose = value;
      }
      
      public function get isChoose() : Boolean
      {
         return this._isChoose;
      }
   }
}

