package com.yiTian.view.modules.onlineValidate
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.KeyboardManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.LoginCGMessage;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.utils.Dictionary;
   
   public class OnlineValidate extends Sprite
   {
      
      private static var _instance:OnlineValidate;
      
      private static var lib:Dictionary = new Dictionary();
      
      private static var rect:Rectangle = new Rectangle(0,0,26,31);
      
      private var list:Array;
      
      private var shape:Shape;
      
      private var container:Sprite;
      
      private var back:ScaleBitmap;
      
      private var tf1:MyTextField;
      
      private var tf2:MyTextField;
      
      private var resultTf:MyTextField;
      
      private var infoBm:Bitmap;
      
      private var okBtn:Button;
      
      public function OnlineValidate()
      {
         super();
         this.init();
      }
      
      public static function getInstance() : OnlineValidate
      {
         if(!_instance)
         {
            _instance = new OnlineValidate();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this.shape = ComponentUtil.getShape(Global.stage.stageWidth,Global.stage.stageHeight,0,0.2);
         addChild(this.shape);
         this.container = new Sprite();
         addChild(this.container);
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.container,{
            "x":0,
            "y":0,
            "width":338,
            "height":190
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.container,{
            "x":24,
            "y":40,
            "width":290,
            "height":140
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,16],this.container,{
            "x":31,
            "y":47,
            "width":280,
            "height":90
         },Global.Img_Cdm);
         this.tf1 = ComponentUtil.getTextField(LangConfig.getWord("30009",3),this.container,{
            "x":65,
            "y":55,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.tf2 = ComponentUtil.getTextField(LangConfig.getWord("30010",3),this.container,{
            "x":83,
            "y":147,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.container,{
            "x":129,
            "y":147,
            "width":44,
            "height":21
         },Global.Img_Cdm);
         this.resultTf = ComponentUtil.getTextField("",this.container,{
            "x":138,
            "y":148,
            "color":16764206,
            "type":TextFieldType.INPUT,
            "maxChars":2,
            "realWidth":40,
            "height":28
         });
         this.resultTf.restrict = "0-9";
         this.infoBm = new Bitmap();
         this.infoBm.x = 68;
         this.infoBm.y = 89;
         this.container.addChild(this.infoBm);
         this.okBtn = ComponentUtil.getButton(LangConfig.getWord("6",0),"Button_Two64",this.container,{
            "x":187,
            "y":144,
            "textColor":16773818
         },Global.Img_Cdm);
         this.okBtn.addEventListener(MouseEvent.CLICK,this.converResult);
         addEventListener(MouseEvent.ROLL_OVER,this.rollOver);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOut);
         var titleBm:Bitmap = new Bitmap();
         Utils.loadTitle("lang/ch/YanZheng.swf","yanzheng",titleBm,{
            "x":89,
            "y":5
         },this.container);
      }
      
      private function rollOver(e:MouseEvent) : void
      {
         Util.isOnUI = true;
      }
      
      private function rollOut(e:MouseEvent) : void
      {
         Util.isOnUI = false;
      }
      
      public function show(info:int) : void
      {
         this.addData(info);
         Global.stage.addChild(this);
         this.resize();
         Global.focus = this.resultTf;
         KeyboardManager.isEnabled = false;
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resize);
      }
      
      private function resize() : void
      {
         this.shape.width = Global.stage.stageWidth;
         this.shape.height = Global.stage.stageHeight;
         this.container.x = (Global.stage.stageWidth - this.container.width) / 2;
         this.container.y = (Global.stage.stageHeight - this.container.height) / 2;
      }
      
      private function hide() : void
      {
         this.resultTf.text = "";
         if(Global.stage.contains(this))
         {
            Global.stage.removeChild(this);
         }
         KeyboardManager.isEnabled = true;
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resize);
      }
      
      private function addData(info:int) : void
      {
         var type:int = info >> 24;
         var value1:int = (info & 0xFF0000) >> 16;
         var oper:int = (info & 0xFF00) >> 8;
         var value2:int = info & 0xFF;
         if(Boolean(this.infoBm.bitmapData))
         {
            this.infoBm.bitmapData.dispose();
            this.infoBm.bitmapData = null;
         }
         this.infoBm.bitmapData = new BitmapData(185,32,true,0);
         var nowX:int = 0;
         this.list = [];
         this.decode(value1);
         var j:int = this.list.length - 1;
         while(j >= 0)
         {
            if(!lib["_" + this.list[j]])
            {
               lib["_" + this.list[j]] = ComponentUtil.getBitmapData("_" + this.list[j],Global.effectWord);
            }
            Utils.point.x = nowX;
            Utils.point.y = 0;
            this.infoBm.bitmapData.copyPixels(lib["_" + this.list[j]],rect,Utils.point,null,null,true);
            nowX += 26;
            j--;
         }
         var operStr:String = this.getOperStr(oper);
         if(!lib[operStr])
         {
            lib[operStr] = ComponentUtil.getBitmapData(operStr,Global.effectWord);
         }
         Utils.point.x = nowX;
         this.infoBm.bitmapData.copyPixels(lib[operStr],rect,Utils.point,null,null,true);
         nowX += 26;
         this.list = [];
         this.decode(value2);
         j = this.list.length - 1;
         while(j >= 0)
         {
            if(!lib["_" + this.list[j]])
            {
               lib["_" + this.list[j]] = ComponentUtil.getBitmapData("_" + this.list[j],Global.effectWord);
            }
            Utils.point.x = nowX;
            this.infoBm.bitmapData.copyPixels(lib["_" + this.list[j]],rect,Utils.point,null,null,true);
            nowX += 26;
            j--;
         }
         if(!lib["="])
         {
            lib["="] = ComponentUtil.getBitmapData("=",Global.effectWord);
         }
         Utils.point.x = nowX;
         this.infoBm.bitmapData.copyPixels(lib["="],rect,Utils.point,null,null,true);
         nowX += 28;
         if(!lib["?"])
         {
            lib["?"] = ComponentUtil.getBitmapData("?",Global.effectWord);
         }
         Utils.point.x = nowX;
         this.infoBm.bitmapData.copyPixels(lib["?"],rect,Utils.point,null,null,true);
      }
      
      private function getOperStr(operType:int) : String
      {
         if(operType == 1)
         {
            return "+";
         }
         return "-";
      }
      
      private function decode(number:int) : void
      {
         if(number == 0)
         {
            return;
         }
         this.list.push(number % 10);
         this.decode(int(number / 10));
      }
      
      private function converResult(e:MouseEvent) : void
      {
         var value:int = int(this.resultTf.text);
         var result:int = (value << 1) + ((0x4E & value) << 9);
         LoginCGMessage.CG_VALIDATE(result);
         this.hide();
      }
   }
}

