package com.yiTian.view.modules.guangMingDing
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_gmdRewardTrace extends Panel123
   {
      
      private var _bg:DisplayObject;
      
      private var _tfTrace:MyTextField;
      
      private var _tfLevel:MyTextField;
      
      public function View_gmdRewardTrace()
      {
         super();
         bindParent = GameScene.sysLayer;
         this._bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":368,
            "height":255
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":320,
            "height":205
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":34,
            "y":109,
            "width":300,
            "height":96
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TitleBule",[5,5,2,2],this,{
            "x":35,
            "y":112,
            "width":297,
            "height":28
         },Global.Img_Cdm);
         move = new Rectangle(0,0,308,35);
         this._tfLevel = ComponentUtil.getTextField("",this,{
            "x":this._bg.width / 2,
            "y":62,
            "color":13424242,
            "size":18
         });
         this._tfLevel.autoSize = TextFieldAutoSize.CENTER;
         ComponentUtil.getTextField("挑战奖励",this,{
            "x":154,
            "y":114,
            "color":16764206,
            "size":14
         });
         ComponentUtil.getButton("","Button_Close",this,{
            "x":334,
            "y":6,
            "textColor":16184781,
            "callBack":this.hide
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Prompt",this,{
            "x":109,
            "y":5
         },Global.Img_Cdm);
         ComponentUtil.getButton("确定","Button_Four",this,{
            "x":155,
            "y":212,
            "textColor":16184781,
            "callBack":this.hide
         },Global.Img_Cdm);
         this._tfTrace = ComponentUtil.getTextField("",this,{
            "x":73,
            "y":147,
            "leading":6
         });
         ratio = 4;
         powerr = 1.5;
      }
      
      public static function get instance() : View_gmdRewardTrace
      {
         return Singleton.getInstance(View_gmdRewardTrace);
      }
      
      public function show(p:* = null) : void
      {
         pop(0.5,0.5,0.5,0.5,0.3,1,800);
         visible = true;
      }
      
      public function hide(p:* = null) : void
      {
         visible = false;
      }
      
      override public function get width() : Number
      {
         return this._bg.width;
      }
      
      override public function get height() : Number
      {
         return this._bg.height;
      }
      
      public function update() : void
      {
         var lv:int = Model_guangMingDing.rewardLv;
         this._tfLevel.htmlText = LangConfig.reTxt("恭喜挑战至光眀顶第 <font color=\'#ffff33\'>{0}</font> 层",lv);
         var txts:Array = GuangMingDingConfig.getRewardArrs(lv);
         var txt:String = "";
         var i:int = 0;
         while(i < txts.length)
         {
            if(i % 2 == 0)
            {
               txt += i == 0 ? txts[i] : "\n" + txts[i];
            }
            else
            {
               txt += "          " + txts[i];
            }
            i += 1;
         }
         this._tfTrace.htmlText = txt;
      }
   }
}

