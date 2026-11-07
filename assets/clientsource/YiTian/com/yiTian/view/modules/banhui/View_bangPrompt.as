package com.yiTian.view.modules.banhui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_bangPrompt extends Panel
   {
      
      private var Button_OK:Button;
      
      private var Button_Cancel:Button;
      
      public var Informat_text:MyTextField;
      
      public var Informat02_text:MyTextField;
      
      public var Informat03_text:MyTextField;
      
      public var Informat04_text:MyTextField;
      
      public var Informat05_text:MyTextField;
      
      public var Informat06_text:MyTextField;
      
      public var invide_host:String;
      
      public var partyName:String;
      
      public var heroName:String;
      
      public var heroId:Number = 0;
      
      private var _label_arr:Array;
      
      private var type:int;
      
      public var _cur_page:int;
      
      public var partyId:Number = 0;
      
      public function View_bangPrompt()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":320,
            "height":178
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":29,
            "y":45,
            "width":262,
            "height":120
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Prompt",this,{
            "x":80,
            "y":5
         },Global.Img_Cdm);
         move = new Rectangle(0,0,246,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":286,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_OK = ComponentUtil.getButton(LangConfig.getWord("29031",2),"Button_Four",this,{
            "x":60,
            "y":125,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Cancel = ComponentUtil.getButton(LangConfig.getWord("29032",2),"Button_Four",this,{
            "x":185,
            "y":125,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Informat_text = ComponentUtil.getTextField("",this,{
            "y":81,
            "x":23,
            "realWidth":286
         });
         this.Informat_text.align = TextAlign.CENTER;
         this.Informat02_text = ComponentUtil.getTextField("",this,{
            "y":81,
            "x":23,
            "realWidth":286
         });
         this.Informat02_text.align = TextAlign.CENTER;
         this.Informat03_text = ComponentUtil.getTextField("",this,{
            "y":81,
            "x":23,
            "realWidth":286
         });
         this.Informat03_text.align = TextAlign.CENTER;
         this.Informat04_text = ComponentUtil.getTextField("" + this.heroName,this,{
            "y":81,
            "x":23,
            "realWidth":286
         });
         this.Informat04_text.align = TextAlign.CENTER;
         this.Informat05_text = ComponentUtil.getTextField("",this,{
            "y":81,
            "x":23,
            "realWidth":286
         });
         this.Informat05_text.htmlText = "";
         this.Informat05_text.align = TextAlign.CENTER;
         this.Informat06_text = ComponentUtil.getTextField("" + this.heroName,this,{
            "y":81,
            "x":23,
            "realWidth":286
         });
         this.Informat06_text.align = TextAlign.CENTER;
         this.Informat_text.visible = false;
         this.Informat02_text.visible = false;
         this.Informat03_text.visible = false;
         this.Informat04_text.visible = false;
         this.Informat05_text.visible = false;
         this.Informat06_text.visible = false;
         this.Button_OK.addEventListener(MouseEvent.CLICK,this.getFuliHandle);
         this.Button_Cancel.addEventListener(MouseEvent.CLICK,this.cancelHandle);
      }
      
      private function getFuliHandle(e:MouseEvent) : void
      {
         if(this.type == 1)
         {
            trace("1...");
            BangCGMessage.CG_BANG_INVIDE_N(1,this.partyId,this.heroId);
            this.Informat_text.text = "";
         }
         else if(this.type == 2)
         {
            trace("2...");
            this.Informat02_text.text = "";
            BangCGMessage.CG_BANG_RIGHT(1);
         }
         else if(this.type == 3)
         {
            trace("3...");
            this.Informat03_text.text = "";
            BangCGMessage.CG_BANG_RIGHT(4);
         }
         else if(this.type == 4)
         {
            trace("4...");
            this.Informat04_text.text = "";
            BangCGMessage.CG_BANG_LEADER_RIGHT(this.heroId);
         }
         else if(this.type == 5)
         {
            trace("5...");
            this.Informat05_text.text = "";
            BangCGMessage.CG_BANG_TUIWEI();
         }
         else if(this.type == 6)
         {
            trace("4...");
            this.Informat06_text.text = "";
            BangCGMessage.CG_BANG_EXPEL(this.heroId,this._cur_page);
         }
         visible = false;
      }
      
      public function get label_arr() : Array
      {
         if(!this._label_arr)
         {
            this._label_arr = [[LangConfig.getWord("29031",2),LangConfig.getWord("29032",2)],[LangConfig.getWord("29031",2),LangConfig.getWord("29032",2)],[LangConfig.getWord("29034",2),LangConfig.getWord("29035",2)],[LangConfig.getWord("29034",2),LangConfig.getWord("29035",2)],[LangConfig.getWord("29034",2),LangConfig.getWord("29035",2)],[LangConfig.getWord("29034",2),LangConfig.getWord("29035",2)]];
         }
         return this._label_arr;
      }
      
      public function updateText(_type:int) : void
      {
         this.Informat_text.visible = false;
         this.Informat02_text.visible = false;
         this.Informat03_text.visible = false;
         this.Informat04_text.visible = false;
         this.Informat05_text.visible = false;
         this.Informat06_text.visible = false;
         this.type = _type;
         if(_type == 1)
         {
            this.Informat_text.visible = true;
            this.Informat_text.htmlText = LangConfig.getWord("29178",2,this.invide_host);
         }
         else if(_type == 2)
         {
            this.Informat02_text.htmlText = LangConfig.getWord("29179",2,Model_bang.partyInfo.party_benefit_cost.toString(),Model_bang.partyInfo.party_benefit.toString());
            this.Informat02_text.visible = true;
         }
         else if(_type == 3)
         {
            this.Informat03_text.htmlText = LangConfig.getWord("29180",2);
            this.Informat03_text.visible = true;
         }
         else if(_type == 4)
         {
            this.Informat04_text.visible = true;
            this.Informat04_text.htmlText = LangConfig.getWord("29181",2,this.heroName);
         }
         else if(_type == 5)
         {
            this.Informat05_text.visible = true;
            this.Informat05_text.htmlText = LangConfig.getWord("29182",2);
         }
         else if(_type == 6)
         {
            this.Informat06_text.visible = true;
            this.Informat06_text.htmlText = LangConfig.getWord("29183",2,this.heroName);
         }
         this.Button_OK.label = this.label_arr[_type - 1][0];
         this.Button_Cancel.label = this.label_arr[_type - 1][1];
      }
      
      private function cancelHandle(e:MouseEvent) : void
      {
         visible = false;
         if(this.type == 1)
         {
            trace("1...");
            BangCGMessage.CG_BANG_INVIDE_N(2,this.partyId,this.heroId);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

