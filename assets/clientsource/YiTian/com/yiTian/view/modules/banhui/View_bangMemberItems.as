package com.yiTian.view.modules.banhui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.ChatCGMessage;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_bangMemberItems extends Sprite
   {
      
      private var SeachButton:Button;
      
      private var ChatButton:Button;
      
      private var MailButton:Button;
      
      private var _position:int;
      
      public var Lever_text:MyTextField;
      
      public var MenPai_text:MyTextField;
      
      public var ZhiWei_text:MyTextField;
      
      public var BangPai_text:MyTextField;
      
      public var GRGongXian_text:MyTextField;
      
      public var LastOnLine_text:MyTextField;
      
      private var _str_back_bmp:DisplayObject;
      
      public var _select:Boolean;
      
      public var heroId:Number = 0;
      
      public var _name:String;
      
      public function View_bangMemberItems()
      {
         super();
         this.init();
         addEventListener(MouseEvent.MOUSE_OVER,this.overHandle);
         addEventListener(MouseEvent.MOUSE_OUT,this.outHandle);
      }
      
      public function set position(value:int) : void
      {
         this._position = value;
      }
      
      public function get position() : int
      {
         return this._position;
      }
      
      public function init() : void
      {
         var line:ScaleBitmap;
         var spr:Sprite = null;
         spr = new Sprite();
         spr.graphics.beginFill(0,0);
         spr.graphics.drawRect(0,0,646,26);
         spr.graphics.endFill();
         spr.mouseEnabled = false;
         addChild(spr);
         this._str_back_bmp = ComponentUtil.getDisplayObject("Item_Select",this,{
            "width":646,
            "height":26,
            "y":0
         });
         (this._str_back_bmp as Sprite).mouseEnabled = false;
         (this._str_back_bmp as Sprite).mouseChildren = false;
         this._str_back_bmp.visible = false;
         line = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":10,
            "y":26,
            "width":656,
            "height":2
         },Global.Img_Cdm);
         this.SeachButton = ComponentUtil.getButton("","Button_SiLiao_chakanxinxi",this,{
            "x":543,
            "y":5,
            "textColor":16184781
         },Global.Img_Cdm);
         this.ChatButton = ComponentUtil.getButton("","Button_Chat",this,{
            "x":581,
            "y":5,
            "textColor":16184781
         },Global.Img_Cdm);
         this.MailButton = ComponentUtil.getButton("","Button_SiLiao_sendEmial",this,{
            "x":619,
            "y":5,
            "textColor":16184781
         },Global.Img_Cdm);
         this.BangPai_text = ComponentUtil.getTextField(LangConfig.getWord("60027",6),this,{
            "x":5,
            "y":3.75,
            "color":11904647,
            "size":12,
            "leading":0,
            "realWidth":88,
            "align":TextAlign.CENTER
         });
         this.ZhiWei_text = ComponentUtil.getTextField(LangConfig.getWord("60028",6),this,{
            "x":120,
            "y":3.75,
            "color":11904647,
            "size":12,
            "leading":0,
            "realWidth":44,
            "align":TextAlign.CENTER
         });
         this.MenPai_text = ComponentUtil.getTextField(LangConfig.getWord("60029",6),this,{
            "x":187,
            "y":3.75,
            "size":12,
            "leading":0,
            "realWidth":68,
            "align":TextAlign.CENTER
         });
         this.Lever_text = ComponentUtil.getTextField(LangConfig.getWord("60004",6),this,{
            "x":278,
            "y":3.75,
            "color":11904647,
            "size":12,
            "leading":0,
            "realWidth":46,
            "align":TextAlign.CENTER
         });
         this.GRGongXian_text = ComponentUtil.getTextField(LangConfig.getWord("60030",6),this,{
            "x":335,
            "y":3.75,
            "color":11904647,
            "size":12,
            "leading":0,
            "realWidth":92,
            "align":TextAlign.CENTER
         });
         this.LastOnLine_text = ComponentUtil.getTextField("0000-00-00",this,{
            "x":436,
            "y":3.75,
            "color":11904647,
            "size":12,
            "leading":0,
            "realWidth":87,
            "align":TextAlign.CENTER
         });
         this.SeachButton.callBack = function(e:MouseEvent):void
         {
            Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,heroId);
         };
         this.MailButton.callBack = function(e:MouseEvent):void
         {
            Global.control.sendNotification(Enum_MsgType.MSG_SENDMAIL,_name);
         };
         this.ChatButton.callBack = function(e:MouseEvent):void
         {
            ChatCGMessage.CG_SID_CHAT(heroId);
         };
      }
      
      public function set select(value:Boolean) : void
      {
         this._select = value;
         this._str_back_bmp.visible = value;
      }
      
      override public function set name(str:String) : void
      {
         str = Model_heFu.repNameByHero(str);
         this._name = str;
         this.BangPai_text.text = str;
      }
      
      public function set enable(value:Boolean) : void
      {
         this.SeachButton.useHandCursor = value;
         this.ChatButton.useHandCursor = value;
         this.MailButton.useHandCursor = value;
         this.SeachButton.enabled = value;
         this.ChatButton.enabled = value;
         this.MailButton.enabled = value;
      }
      
      public function overHandle(e:MouseEvent) : void
      {
         this._str_back_bmp.visible = true;
      }
      
      public function outHandle(e:MouseEvent) : void
      {
         if(!this._select)
         {
            this._str_back_bmp.visible = false;
         }
      }
   }
}

