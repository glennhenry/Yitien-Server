package com.yiTian.view.modules.yellowDiamond
{
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.New_mainBtnContainer;
   import flash.events.MouseEvent;
   
   public class Model_txAction
   {
      
      private static var _instance:Model_txAction;
      
      public static var startTime:String;
      
      public static var endTime:String;
      
      private static var _hzStrAdd:String;
      
      private static var _huiYuanStr:String;
      
      public static var QZoneArr:Array = [];
      
      public static var leastLvl:int = 0;
      
      public static var QQGAME_URL:String = "http://pay.qq.com/qqgame/index.shtml?aid=VIP.APP100621282.PLATqqgame&ADTAG=VIP.APP100621282.PLATqqgame";
      
      public static var QQGAME_YEAR_URL:String = "http://pay.qq.com/qqgame/index.shtml?ch=self&cm=tenpay&paytime=year&aid=VIP.APP100621282.PLATqqgameyear&ADTAG=VIP.APP100621282.PLATqqgameyear";
      
      public static var QQ3366_URL:String = "http://pay.qq.com/qqgame/index.shtml?aid=VIP.APP100621282.PLAT3366&ADTAG=VIP.APP100621282.PLAT3366";
      
      public static var QQ3366_YEAR_URL:String = "http://pay.qq.com/qqgame/index.shtml?ch=self&cm=tenpay&paytime=year&aid=VIP.APP100621282.PLAT3366year&ADTAG=VIP.APP100621282.PLAT3366year";
      
      public static var isShowIconCtrHZ:Boolean = true;
      
      public var overStr:String;
      
      public var outStr:String;
      
      public var yellowBtn:MainUIBtn;
      
      public function Model_txAction()
      {
         super();
      }
      
      public static function get instance() : Model_txAction
      {
         if(!_instance)
         {
            _instance = new Model_txAction();
         }
         return _instance;
      }
      
      public static function set hzStrAdd(value:String) : void
      {
         _hzStrAdd = value;
      }
      
      public static function get hzStrAdd() : String
      {
         return Boolean(_hzStrAdd) ? _hzStrAdd : LangConfig.getWord("1176",0);
      }
      
      public static function wordsShow(value:Boolean) : void
      {
         if(value)
         {
            hzStrAdd = LangConfig.getWord("1176",0);
         }
         else
         {
            hzStrAdd = "";
         }
      }
      
      public static function iconCtrl(value:Boolean) : void
      {
         if(value)
         {
            View_qqHuiyuan.instance.show();
         }
         else
         {
            Model_txAction.isShowIconCtrHZ = false;
            View_qqHuiyuan.instance.remove();
         }
      }
      
      public static function set huiYuanStr(value:String) : void
      {
         _huiYuanStr = value;
      }
      
      public static function get huiYuanStr() : String
      {
         return Boolean(_huiYuanStr) ? _huiYuanStr : LangConfig.getWord("1175",0);
      }
      
      public static function wordsCtrl(value:Boolean) : void
      {
         if(value)
         {
            huiYuanStr = LangConfig.getWord("1175",0);
         }
         else
         {
            huiYuanStr = "";
         }
      }
      
      public function showYellowBtn(hasEff:Boolean = false) : void
      {
         if(!this.overStr || !this.outStr)
         {
            this.getPf();
         }
         if(!this.yellowBtn)
         {
            this.yellowBtn = new MainUIBtn("resource/image/Diamond/" + this.overStr + ".png");
            this.yellowBtn.addEventListener(MouseEvent.CLICK,function():void
            {
               UIManager.yellowDiamond.visible = !UIManager.yellowDiamond.visible;
            });
            this.yellowBtn.addEventListener(MouseEvent.MOUSE_OVER,this.overHd);
            this.yellowBtn.addEventListener(MouseEvent.MOUSE_OUT,this.outHd);
         }
         if(New_mainBtnContainer.isUsingNewBtn)
         {
            UIManager.newMainBtnContainer.addBtn(this.yellowBtn);
         }
         else if(!UIManager.mainUiBtnContainer.hasBTN(this.yellowBtn))
         {
            UIManager.mainUiBtnContainer.addBTN(this.yellowBtn);
         }
         if(hasEff)
         {
            if(!MainUIBtn.isPlaying)
            {
               this.showYelEff();
            }
         }
      }
      
      public function getPf() : void
      {
         if(Global.pf == "qqgame" || Global.pf == "3366")
         {
            this.overStr = "blueDia_1";
            this.outStr = "blueDia_2";
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            this.overStr = "Icon_HYTQ";
            this.outStr = "Icon_HYTQ";
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            this.overStr = "yellowDia_1";
            this.outStr = "yellowDia_2";
         }
      }
      
      public function removeEff() : void
      {
         if(Enum_SPStr.isUnion(Global.pf))
         {
            return;
         }
         MainUIBtn._stop = true;
      }
      
      public function showYelEff() : void
      {
         MainUIBtn._stop = false;
         if(New_mainBtnContainer.isUsingNewBtn)
         {
            if(UIManager.newMainBtnContainer.hasBtn(this.yellowBtn))
            {
               this.yellowBtn.showEff();
            }
         }
         else if(UIManager.mainUiBtnContainer.hasBTN(this.yellowBtn))
         {
            this.yellowBtn.showEff();
         }
      }
      
      private function overHd(e:MouseEvent) : void
      {
         this.yellowBtn.setSource("resource/image/Diamond/" + this.outStr + ".png");
      }
      
      private function outHd(e:MouseEvent) : void
      {
         this.yellowBtn.setSource("resource/image/Diamond/" + this.overStr + ".png");
      }
   }
}

