package com.yiTian.view.modules.broadcast
{
   import com.utils.ColorConstant;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.UIBase;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class View_SelfBroadcast extends UIBase
   {
      
      public static const SPACING:int = 4;
      
      public static const FONTSIZE:int = 14;
      
      public static const ITEMHEIGHT:int = 14 + 4;
      
      public static const BOTTOMHEIGHT:int = 65;
      
      public static const TOPHEIGHT:int = 430;
      
      private var _mask:Sprite;
      
      private var rollScreen:RollScreen;
      
      private var data:Array = [];
      
      private var _isInit:Boolean = false;
      
      private var lastTime:Number;
      
      private var playStr:Vector.<String> = new Vector.<String>();
      
      public function View_SelfBroadcast()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         GameScene.downUILayer.addChild(this);
         this._mask = new Sprite();
         this._mask.graphics.beginFill(16777215,0.5);
         this._mask.graphics.drawRect(0,0,185,ITEMHEIGHT * 2);
         this._mask.graphics.endFill();
         addChild(this._mask);
         this.rollScreen = new RollScreen();
         addChild(this.rollScreen);
         this.rollScreen.y = this._mask.height;
         this.rollScreen.mask = this._mask;
         addEventListener(MouseEvent.CLICK,GameScene.instance.uiOnGo);
         this._isInit = true;
      }
      
      public function onClick() : void
      {
         UIManager.checkAllTip.visible = !UIManager.checkAllTip.visible;
         if(UIManager.checkAllTip.visible)
         {
            UIManager.checkAllTip.updata(this.data);
         }
      }
      
      public function showGetItemGC(array:Array, isCenterTip:Boolean = false) : void
      {
         var dId:int = 0;
         var itemStr:String = null;
         var type:int = int(array[0]);
         var id:Number = Number(array[1]);
         var count:Number = Number(array[2]);
         var hasBg:int = 0;
         var text:String = "";
         switch(type)
         {
            case 15:
               dId = 29322;
               break;
            case 16:
               dId = 29402;
               break;
            case 18:
               dId = 29494;
               hasBg = 1;
               isCenterTip = true;
               break;
            case 19:
               dId = 29001;
               break;
            case 20:
               dId = 29001;
               break;
            case 21:
               dId = 29001;
               break;
            case 100:
               dId = 29001;
               break;
            default:
               dId = 29000 + type;
         }
         if(type == 1)
         {
            itemStr = Enum_BroadCastTool.instance.getItemText(id) + "<font color=\'#f9ff00\'>×" + count.toString() + "</font>";
         }
         else if(type == 2)
         {
            itemStr = Enum_BroadCastTool.instance.getEquipText(id);
         }
         else if(type == 100)
         {
            if(id == 44518)
            {
               itemStr = 1 * count + "点基金";
            }
            else if(id == 44519)
            {
               itemStr = 10 * count + "点基金";
            }
            else if(id == 44520)
            {
               itemStr = 100 * count + "点基金";
            }
         }
         else if(type == 19)
         {
            itemStr = HtmlUtil.fontNoSize(Data_lib.card[id][2],ColorConstant.getItemColorStr(Data_lib.card[id][4])) + "×" + count;
         }
         else if(type == 20)
         {
            itemStr = "卡牌残页×" + count;
         }
         else if(type == 21)
         {
            itemStr = count + "点卡牌经验";
         }
         else
         {
            itemStr = count.toString();
         }
         text = LangConfig.getWord(dId.toString(),2,itemStr);
         this.addMsg(text);
         if(isCenterTip)
         {
            UIManager.centerBroadcast.addMsg(text,hasBg);
         }
      }
      
      private function getColorStr(str:String, level:int = 1) : String
      {
         if(level == Enum_color.WHITE)
         {
            str = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.WHITE),12);
         }
         else if(level == Enum_color.GREEN)
         {
            str = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.GREEN),12);
         }
         else if(level == Enum_color.BLUE)
         {
            str = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.BLUE),12);
         }
         else if(level == Enum_color.PURPLE)
         {
            str = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.PURPLE),12);
         }
         return str;
      }
      
      public function addMsg(htmlText1:String, type:int = 0) : void
      {
         if(!this._isInit)
         {
            return;
         }
         var str:String = "";
         switch(type)
         {
            case 0:
               str += "<font color=\'#f9ff00\'>" + htmlText1 + "</font>";
               break;
            case 1:
               str += "<font color=\'#f9ff00\'>" + htmlText1 + "</font>";
         }
         this.data.push(str);
         this.playStr.push(str);
         this.play();
      }
      
      private function getTimesCost() : int
      {
         if(this.playStr.length == 0)
         {
            return 500;
         }
         return (1 - Math.atan((this.playStr.length - 1) * 0.1)) * 350 + 150;
      }
      
      private function play() : void
      {
         var height:int = 0;
         if(this.playStr.length == 1)
         {
            height = this.rollScreen.addItem(this.playStr[0]);
            Tween.to(this.rollScreen,this.getTimesCost(),{"y":[this.rollScreen.y,this.rollScreen.y - height]},this.onComplete,null,Tween.SIN);
         }
      }
      
      private function onComplete() : void
      {
         this.playStr.shift();
         if(Boolean(this.playStr.length))
         {
            if(!GameScene.instance.hasFrameCallBack(this.interval))
            {
               GameScene.instance.addFrameCallBack(this.interval);
            }
            this.lastTime = getTimer();
         }
         else
         {
            this.rollScreen.dispose(this._mask.height);
         }
      }
      
      private function interval(value:int) : void
      {
         var height:int = 0;
         var now:int = getTimer();
         if(now - this.lastTime >= 100)
         {
            GameScene.instance.removeFrameCallBack(this.interval);
            if(Boolean(this.playStr.length))
            {
               height = this.rollScreen.addItem(this.playStr[0]);
               Tween.to(this.rollScreen,this.getTimesCost(),{"y":[this.rollScreen.y,this.rollScreen.y - height]},this.onComplete);
            }
         }
      }
      
      override public function get height() : Number
      {
         return this._mask.y + this._mask.height;
      }
      
      override public function resetPosition() : void
      {
         var s:Stage = null;
         var i:int = 0;
         s = Global.stage;
         var h:Number = s.stageHeight - (BOTTOMHEIGHT + TOPHEIGHT);
         i = h / ITEMHEIGHT;
         if(i <= 2)
         {
            this._mask.height = ITEMHEIGHT * 2;
            this._mask.y = 0;
         }
         else if(i > 2 && i <= 10)
         {
            this._mask.height = ITEMHEIGHT * i;
            this._mask.y = ITEMHEIGHT * 2 - ITEMHEIGHT * i;
         }
         else if(i > 10)
         {
            this._mask.height = ITEMHEIGHT * 10;
            this._mask.y = ITEMHEIGHT * 2 - ITEMHEIGHT * 10;
         }
         x = s.stageWidth - width;
         y = s.stageHeight - this.height - BOTTOMHEIGHT;
      }
      
      public function clear() : void
      {
         Tween.stop(this.rollScreen);
         this.playStr.length = 0;
         this._mask.height = ITEMHEIGHT * 2;
         this._mask.y = 0;
         this.rollScreen.y = 36;
         this.rollScreen.dispose(0,true);
         this.resetPosition();
      }
   }
}

