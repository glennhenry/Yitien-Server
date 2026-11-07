package com.yiTian.view.modules.olympic
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.OlympicCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextFieldType;
   
   public class View_daysWards extends Panel
   {
      
      private static var STRDESCIP:String;
      
      private static const BtnLen:int = 2;
      
      private static var btnStr:Array = ["Button_DuiHuan","Button_HQLiBao"];
      
      private static var isLoad:Boolean = false;
      
      private var bmp:Bitmap;
      
      private var btnVec:Vector.<Button> = new Vector.<Button>();
      
      private var btnKaiqi:Button;
      
      private var tfJHM:MyTextField;
      
      public var showDaysA:MainUIBtn;
      
      private var daysAEff:Effect;
      
      public function View_daysWards()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var url:String;
         var i:int;
         var tf:MyTextField = null;
         var back:DisplayObject = ComponentUtil.getDisplayObject("MRChouJiang",this);
         this.bmp = new Bitmap();
         this.bmp.x = 10;
         this.bmp.y = 10;
         addChild(this.bmp);
         move = new Rectangle(0,0,553,38);
         url = "resource/image/shouchong/Quick_Menus_01.png";
         this.showDaysA = new MainUIBtn(url,{
            "x":(65 - 54) / 2,
            "y":(70 - 54) / 2
         });
         this.showDaysA.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            visible = !visible;
         });
         STRDESCIP = LangConfig.getWord("60219",6);
         CloseButton = ComponentUtil.getButton("","Button_HDClose",this,{
            "x":542.5,
            "y":17.5
         });
         i = 0;
         while(i < BtnLen)
         {
            this.btnVec.push(ComponentUtil.getButton("",btnStr[i],this,{
               "x":397 + 73 * i,
               "y":442,
               "tabIndex":i
            },ComponentUtil.domain));
            this.btnVec[i].callBack = function(e:MouseEvent):void
            {
               var request:URLRequest = null;
               var _n:int = (e.target as Button).tabIndex;
               if(_n == 0)
               {
                  OlympicCGMessage.CG_DAYS_OLM_REWARD(tfJHM.text);
               }
               else if(_n == 1)
               {
                  request = new URLRequest("http://rc.qzone.qq.com/appsetup/dailycoupon?from=100621282");
                  navigateToURL(request,"_blank");
               }
            };
            i++;
         }
         this.btnKaiqi = ComponentUtil.getButton("","Button_MRCK",this,{
            "x":233,
            "y":297
         },ComponentUtil.domain);
         this.btnKaiqi.callBack = function(e:MouseEvent):void
         {
            btnVec[1].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         };
         this.tfJHM = ComponentUtil.getTextField(STRDESCIP,this,{
            "type":TextFieldType.INPUT,
            "x":50,
            "y":444,
            "realWidth":323,
            "realHeight":22,
            "size":14,
            "color":11972527,
            "bold":true
         });
         this.tfJHM.filters = [];
         this.tfJHM.addEventListener(FocusEvent.FOCUS_IN,function(e:FocusEvent):void
         {
            tf = e.target as MyTextField;
            if(tf.text == STRDESCIP)
            {
               tf.text = "";
            }
         });
         this.tfJHM.addEventListener(FocusEvent.FOCUS_OUT,function(e:FocusEvent):void
         {
            tf = e.target as MyTextField;
            if(tf.text == "")
            {
               tf.text = STRDESCIP;
            }
         });
         if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            this.showDaysAwards(false);
         }
      }
      
      public function showDaysAwards(hasEff:Boolean) : void
      {
      }
      
      public function removeDaysAwards() : void
      {
         if(UIManager.mainUiBtnContainer.hasBTN(this.daysAEff))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.daysAEff);
         }
         if(Boolean(this.daysAEff))
         {
            EffectManager.removeEffect(this.daysAEff);
            this.daysAEff = null;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            super.visible = value;
            if(!isLoad)
            {
               Utils.getLoadBitmap("resource/image/shouchong/daysAwards_03.png",this.bmp,function():void
               {
                  isLoad = true;
               });
            }
            Tween.to(this,400,{
               "alpha":[0,1],
               "y":[(Global.stage.stageHeight - 486) / 2 - 50,(Global.stage.stageHeight - 486) / 2]
            });
         }
         else
         {
            Tween.to(this,400,{
               "alpha":[1,0],
               "y":[(Global.stage.stageHeight - 486) / 2,(Global.stage.stageHeight - 486) / 2 - 50]
            },this._comp);
         }
      }
      
      private function _comp() : void
      {
         super.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 553) / 2;
         y = (Global.stage.stageHeight - 486) / 2;
      }
   }
}

