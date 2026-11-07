package com.yiTian.view.modules.pata
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.PataCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.utils.getTimer;
   
   public class PataTipPanel extends Panel
   {
      
      private var Button_Yes:Button;
      
      private var Button_No:Button;
      
      private var Imformate_text:MyTextField;
      
      private var lastTime:int;
      
      private var totalTime:int;
      
      private var Time_text:MyTextField;
      
      private var _roleId:int;
      
      private var _teamId:int;
      
      private var isLock:Boolean;
      
      private var cdParam:Boolean;
      
      private var f:Boolean = true;
      
      public function PataTipPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":348,
            "height":188
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":300,
            "height":138
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,38);
         this.Imformate_text = ComponentUtil.getTextField("",this,{
            "x":46,
            "y":56,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.Imformate_text.htmlText = "";
         this.Button_Yes = ComponentUtil.getButton(LangConfig.getWord("10125",1),"Button_Four",this,{
            "x":76,
            "y":137,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_No = ComponentUtil.getButton(LangConfig.getWord("10146",1),"Button_Four",this,{
            "x":201,
            "y":137,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Time_text = ComponentUtil.getTextField("",this,{
            "x":156,
            "y":83,
            "color":16776960,
            "size":30,
            "leading":0
         });
         this.Time_text.type = TextFieldType.DYNAMIC;
         this.Time_text.htmlText = "<font size=\'30\' color=\'#F9FF00\'>30<font>";
         this.Button_Yes.addEventListener(MouseEvent.CLICK,this.clickHandler);
         this.Button_No.addEventListener(MouseEvent.CLICK,this.clickHandler);
      }
      
      public function countDown(value:Boolean) : void
      {
         var layers:int = 0;
         var index:int = 0;
         var isOverlord:Boolean = false;
         var str:String = null;
         this.cdParam = value;
         var arr:Array = PataVO.layersOverlordsArr;
         var i:uint = 0;
         while(i < arr.length)
         {
            str = PataVO.layersOverlordsArr[i];
            if(str.indexOf(GameUnitManager.hero.id + "_" + GameUnitManager.hero.name) != -1)
            {
               index = int(i);
               isOverlord = true;
               break;
            }
            i++;
         }
         if(isOverlord)
         {
            layers = (index + 1) * 12;
            if(value)
            {
               this.Imformate_text.htmlText = LangConfig.getWord("10382",1,layers);
            }
            else
            {
               this.Imformate_text.htmlText = LangConfig.getWord("10383",1,layers);
            }
            this.addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
            this.totalTime = 30;
            this.lastTime = getTimer();
            this.isLock = false;
            return;
         }
      }
      
      protected function clickHandler(event:MouseEvent) : void
      {
         if(event.target.label == LangConfig.getWord("10125",1))
         {
            if(this.cdParam)
            {
               PataCGMessage.CG_CHALLENGE_OVERLORD(1,PataVO.layers,1);
            }
            else
            {
               PataCGMessage.CG_CHALLENGE_OVERLORD(2,PataVO.layers,1);
            }
         }
         else if(event.target.label == LangConfig.getWord("10146",1))
         {
            this.isLock = true;
         }
         this.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         this.visible = false;
      }
      
      protected function enterFrameHandler(event:Event) : void
      {
         var now:int = getTimer();
         this.Time_text.text = (this.totalTime - Math.ceil((now - this.lastTime) / 1000)).toString();
         if(this.totalTime - Math.ceil((now - this.lastTime) / 1000) <= 0)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
            this.Button_No.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else if(this.isLock)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value && this.f)
         {
            this.f = false;
            Utils.loadTitle("lang/ch/PaTa_Imgs.swf","Title_Prompt",new Bitmap(),{
               "x":94,
               "y":5
            },this);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

