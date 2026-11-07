package com.yiTian.view.comp
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_initStr;
   import com.yiTian.manager.CursorManager;
   import com.yiTian.manager.KeyboardManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.utils.MassLoader;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.system.ApplicationDomain;
   import flash.text.TextFormatAlign;
   
   public class View_Alert extends Sprite
   {
      
      public static var alertDm:ApplicationDomain;
      
      public static var isShow:Boolean;
      
      public static var isLock:Boolean;
      
      private static var inited:Boolean;
      
      private static var _instance:View_Alert;
      
      public static const OK:int = 1;
      
      public static const OK_CANCAL:int = 2;
      
      public static const NO_BTN:int = 3;
      
      private var _okCallBack:Function;
      
      private var _escCallBack:Function;
      
      private var _textLink:Function;
      
      private var _data:Object;
      
      private var style:int;
      
      private var _width:int;
      
      private var _okLabel:String = "";
      
      private var _escLabel:String = "";
      
      private var shape:Shape;
      
      private var back:ScaleBitmap;
      
      private var kuang:ScaleBitmap;
      
      private var titleTF:Bitmap;
      
      private var infoTF:MyTextField;
      
      public var okBtn:Button;
      
      private var cancalBtn:Button;
      
      private var _checkFun:Function;
      
      private var checkBox:CheckBox;
      
      private var _resourceType:int = 0;
      
      private var _showCheckBox:Boolean = false;
      
      public function View_Alert()
      {
         super();
         this.shape = ComponentUtil.getShape(Global.stage.stageWidth,Global.stage.stageHeight,0,0.2);
         addChild(this.shape);
         this.infoTF = ComponentUtil.getTextField("",null,{
            "color":ColorConstant.getColorInt(4),
            "leading":5,
            "realWidth":270,
            "wordWrap":true,
            "multiline":true
         });
         this.infoTF.mouseEnabled = true;
         this.infoTF.addEventListener(TextEvent.LINK,this.linkEvent);
         addChild(this.infoTF);
         if(Boolean(alertDm))
         {
            this.init(null);
         }
         else
         {
            MassLoader.add("lang/" + Global.config.lang + "/Alert.swf",function(info:Object):void
            {
               init(info);
            },null,MassLoader.LEVEL1);
         }
         this.initCheckBox();
         addEventListener(MouseEvent.ROLL_OVER,this.rollOver);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOut);
      }
      
      public static function get instance() : View_Alert
      {
         if(!_instance)
         {
            _instance = new View_Alert();
         }
         return _instance;
      }
      
      public static function show(text:String, style:int, okCallBack:Function = null, escCallBack:Function = null, data:Object = null, textLink:Function = null, width:int = 310, okLabel:String = "", escLabel:String = "", alignStr:String = "left", showCheckBox:Boolean = false, resourceType:int = 0) : void
      {
         if(isLock)
         {
            return;
         }
         instance.showalert(text,style,okCallBack,escCallBack,data,textLink,width,okLabel,escLabel,alignStr,showCheckBox,resourceType);
      }
      
      public static function resize() : void
      {
         instance.resize();
      }
      
      public static function set text(s:String) : void
      {
         instance.infoTF.htmlText = s;
      }
      
      public static function setOkBtnLabel(str:String) : void
      {
         instance.okBtn.label = str;
      }
      
      public static function checkStatus(boo:Boolean) : void
      {
         if(Boolean(instance.checkBox))
         {
            instance.checkBox.selected = boo;
         }
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      private function rollOver(e:MouseEvent) : void
      {
         Util.isOnUI = true;
      }
      
      private function rollOut(e:MouseEvent) : void
      {
         Util.isOnUI = false;
      }
      
      private function init(info:Object) : void
      {
         if(!alertDm && Boolean(info))
         {
            alertDm = info.applicationDomain;
         }
         this.initView();
         inited = true;
         this.resize();
      }
      
      private function initView() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":310,
            "height":433
         },alertDm);
         addChildAt(this.back,1);
         this.kuang = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":27,
            "y":70,
            "width":263,
            "height":310
         },alertDm);
         addChildAt(this.kuang,2);
         this.titleTF = ComponentUtil.getBitmap("Title_WXPrompt",null,null,alertDm);
         addChildAt(this.titleTF,3);
         this.okBtn = ComponentUtil.getButton(LangConfig.getWord("10597",1),"Button_Four",this,null,alertDm);
         this.okBtn.addEventListener(MouseEvent.CLICK,this.okEvent);
         this.cancalBtn = ComponentUtil.getButton(LangConfig.getWord("10598",1),"Button_Four",this,null,alertDm);
         this.cancalBtn.addEventListener(MouseEvent.CLICK,this.escEvent);
      }
      
      private function initCheckBox() : void
      {
         if(!this.checkBox)
         {
            this.checkBox = ComponentUtil.getCheckBox(LangConfig.getWord("80213",8),"CheckBox01",this,null,Global.Img_Cdm);
         }
         this.checkBox.visible = false;
      }
      
      public function set showCheckBox(fun:Function) : void
      {
         this._checkFun = fun;
         instance.checkBox.clickFun = this._checkFun;
      }
      
      private function showalert(text:String, style:int, okCallBack:Function = null, escCallBack:Function = null, data:Object = null, textLink:Function = null, width:int = 310, okLabel:String = "", escLabel:String = "", alignStr:String = "left", showCheckBox:Boolean = false, resourceType:int = 0) : void
      {
         this.style = style;
         this._showCheckBox = showCheckBox;
         this.showCheckBox = null;
         this._width = width;
         if(okLabel == "" && Boolean(Data_lib.lang0))
         {
            this._okLabel = Model_initStr.VIEW_ALERT_OK;
         }
         else if(okLabel == null)
         {
            this._okLabel = "";
         }
         else
         {
            this._okLabel = okLabel;
         }
         if(escLabel == "" && Boolean(Data_lib.lang0))
         {
            this._escLabel = LangConfig.getWord("5",0);
         }
         else if(escLabel == null)
         {
            this._escLabel = "";
         }
         else
         {
            this._escLabel = escLabel;
         }
         this._okCallBack = okCallBack;
         this._escCallBack = escCallBack;
         this._data = data;
         this._textLink = textLink;
         this.infoTF.realWidth = width - 70;
         this.infoTF.align = alignStr;
         this.infoTF.htmlText = text;
         Global.stage.addChild(_instance);
         if(CursorManager.isShow)
         {
            CursorManager.hide();
         }
         KeyboardManager.isEnabled = false;
         this.resize();
         isShow = true;
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resize);
         if(this._showCheckBox)
         {
            this.checkBox.visible = true;
            this.checkBox.x = this.back.x + (this.back.width - this.checkBox.width) / 2;
            this.checkBox.y = this.back.y + this.back.height - 75;
         }
         else if(Boolean(this.checkBox))
         {
            this.checkBox.visible = false;
         }
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_START,this.hide);
         if(this._resourceType != resourceType)
         {
            this.removeResourceType();
            switch(resourceType)
            {
               case 0:
                  this.initView();
                  break;
               case 1:
               case 2:
                  this.back = ComponentUtil.getScaleBitmap("Back_WXTS",[0,0,0,0],this,{
                     "x":0,
                     "y":4,
                     "width":322,
                     "height":162
                  },Global.KFPDdm);
                  addChildAt(this.back,1);
                  this.titleTF = ComponentUtil.getBitmap("Title_WXTS",this,{
                     "x":116,
                     "y":0
                  },Global.KFPDdm);
                  addChildAt(this.titleTF,3);
                  this.okBtn = ComponentUtil.getButton("","Button_QueDing",this,{
                     "x":66,
                     "y":112,
                     "textColor":16771436
                  },Global.KFPDdm);
                  this.okBtn.addEventListener(MouseEvent.CLICK,this.okEvent);
                  if(resourceType == 1)
                  {
                     this.cancalBtn = ComponentUtil.getButton("","Button_JuJue",this,{
                        "x":180,
                        "y":112,
                        "textColor":16771436
                     },Global.KFPDdm);
                  }
                  else if(resourceType == 2)
                  {
                     this.cancalBtn = ComponentUtil.getButton("","Button_QuXiao",this,{
                        "x":180,
                        "y":112,
                        "textColor":16771436
                     },Global.KFPDdm);
                  }
                  this.cancalBtn.addEventListener(MouseEvent.CLICK,this.escEvent);
            }
            this._resourceType = resourceType;
            this.resize();
         }
      }
      
      private function removeResourceType() : void
      {
         switch(this._resourceType)
         {
            case 0:
               removeChild(this.back);
               removeChild(this.kuang);
               removeChild(this.titleTF);
               removeChild(this.okBtn);
               removeChild(this.cancalBtn);
               break;
            case 1:
            case 2:
               removeChild(this.back);
               removeChild(this.titleTF);
               removeChild(this.okBtn);
               removeChild(this.cancalBtn);
         }
         this.okBtn.removeEventListener(MouseEvent.CLICK,this.okEvent);
         this.cancalBtn.removeEventListener(MouseEvent.CLICK,this.escEvent);
      }
      
      private function resize() : void
      {
         this.shape.width = Global.stage.stageWidth;
         this.shape.height = Global.stage.stageHeight;
         if(this.infoTF.defaultTextFormat.align == TextFormatAlign.CENTER)
         {
            this.infoTF.x = (Global.stage.stageWidth - this.infoTF.width) / 2;
         }
         else
         {
            this.infoTF.x = (Global.stage.stageWidth - this.infoTF.textWidth) / 2;
         }
         this.infoTF.y = (Global.stage.stageHeight - this.infoTF.textHeight - 100) / 2 + 46;
         if(!inited)
         {
            return;
         }
         this.back.width = this._width;
         if(this.infoTF.textHeight > 68)
         {
            this.back.height = this.infoTF.textHeight + 100;
         }
         else
         {
            this.back.height = 168;
         }
         this.back.x = (Global.stage.stageWidth - this.back.width) / 2;
         this.back.y = (Global.stage.stageHeight - this.back.height) / 2;
         this.kuang.width = this._width - 58;
         this.kuang.height = this.back.height - 58;
         this.kuang.x = (Global.stage.stageWidth - this.kuang.width) / 2;
         this.kuang.y = this.back.y + 45;
         this.titleTF.x = this.back.x + (this.back.width - this.titleTF.width) / 2;
         this.titleTF.y = this.back.y + 5;
         if(this._showCheckBox)
         {
            this.back.height += 15;
            this.kuang.height += 15;
         }
         if(this.style == OK)
         {
            this.okBtn.visible = true;
            this.cancalBtn.visible = false;
         }
         else if(this.style == OK_CANCAL)
         {
            this.okBtn.visible = true;
            this.cancalBtn.visible = true;
         }
         else if(this.style == NO_BTN)
         {
            this.okBtn.visible = false;
            this.cancalBtn.visible = false;
         }
         this.okBtn.label = this._okLabel;
         this.cancalBtn.label = this._escLabel;
         this.okBtn.y = this.back.y + this.back.height - 50;
         this.cancalBtn.y = this.back.y + this.back.height - 50;
         if(this.style == 1)
         {
            this.okBtn.x = this.back.x + (this.back.width - this.okBtn.width) / 2;
         }
         else if(this.style == 2)
         {
            this.okBtn.x = this.back.x + this.back.width / 2 - this.okBtn.width - 20;
            this.cancalBtn.x = this.back.x + this.back.width / 2 + 20;
         }
      }
      
      private function okEvent(e:MouseEvent) : void
      {
         if(this._okCallBack != null)
         {
            if(Boolean(this._okCallBack.length))
            {
               this._okCallBack(this._data);
            }
            else
            {
               this._okCallBack();
            }
         }
         this.hide();
      }
      
      private function escEvent(e:MouseEvent) : void
      {
         if(this._escCallBack != null)
         {
            if(Boolean(this._escCallBack.length))
            {
               this._escCallBack(this._data);
            }
            else
            {
               this._escCallBack();
            }
         }
         this.hide();
      }
      
      private function linkEvent(e:TextEvent) : void
      {
         if(this._textLink != null)
         {
            this._textLink(e);
            this.hide();
         }
      }
      
      public function hide() : void
      {
         if(Global.stage.contains(_instance))
         {
            Global.stage.removeChild(_instance);
         }
         if(!ModalUIManager.getCurViewer())
         {
            KeyboardManager.isEnabled = true;
         }
         if(isLock)
         {
            isLock = false;
         }
         isShow = false;
         Global.control.removeCallBack(Enum_MsgType.STAGE_RESIZE,this.resize);
         this._okCallBack = null;
         this.checkBox.selected = false;
         this._escCallBack = null;
         this._textLink = null;
         this._showCheckBox = false;
         this._checkFun = null;
         this._data = null;
         this.okBtn.label = LangConfig.getWord("10597",1);
         Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_START,this.hide);
      }
   }
}

