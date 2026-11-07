package com.yiTian.view
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.scene.GameScene;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_Cost_TipWin extends Panel123
   {
      
      private static var tf_info:MyTextField;
      
      private static var btn_ok:Button;
      
      private static var btn_cancel:Button;
      
      private static var bg:DisplayObject;
      
      private static var bg1:DisplayObject;
      
      private static var bg2:DisplayObject;
      
      private static var checkBox:CheckBox;
      
      private static var blackBoard:Sprite;
      
      private static var _okCB:Function;
      
      private static var canelFun:Function;
      
      private static var instance:View_Cost_TipWin;
      
      private static var contentTxt:String;
      
      private static var keys:String = "";
      
      public function View_Cost_TipWin()
      {
         super();
      }
      
      public static function show(key:String = "", content:String = "", OKfun:Function = null, cannel:Function = null, isModal:Boolean = true, isSelected:Boolean = false) : void
      {
         if(!instance)
         {
            instance = new View_Cost_TipWin();
            instance.init();
         }
         keys = key;
         if(Boolean(Model_CostTip.keyDic[keys]))
         {
            if(OKfun != null)
            {
               OKfun();
            }
            return;
         }
         if(isModal)
         {
            if(Boolean(blackBoard))
            {
               blackBoard.visible = false;
            }
         }
         canelFun = cannel;
         _okCB = OKfun;
         checkBox.selected = isSelected;
         tf_info.htmlText = content;
         alginWin();
         instance.visible = true;
      }
      
      private static function alginWin() : void
      {
         tf_info.y = 67 - int(tf_info.height / 14) * 7;
      }
      
      override protected function initStaticView() : void
      {
         bindParent = GameScene.sysLayer;
         move = new Rectangle(0,0,308,38);
         bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":308,
            "height":185
         },Global.Img_Cdm);
         bg1 = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":260,
            "height":110
         },Global.Img_Cdm);
         bg2 = ComponentUtil.getBitmap("Title_Prompt",this,{
            "x":74,
            "y":5
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":274,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         tf_info = ComponentUtil.getTextField("",this,{
            "x":60,
            "y":67,
            "color":16184781,
            "realWidth":188
         });
         tf_info.autoSize = TextFieldAutoSize.CENTER;
         btn_ok = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Four",this,{
            "x":55,
            "y":152,
            "textColor":16184781
         },Global.Img_Cdm);
         btn_cancel = ComponentUtil.getButton(LangConfig.getWord("29035",2),"Button_Four",this,{
            "x":175,
            "y":152,
            "textColor":16184781
         },Global.Img_Cdm);
         checkBox = ComponentUtil.getCheckBox(LangConfig.getWord("29115",2),"CheckBox01",this,{
            "x":120,
            "y":112
         },Global.Img_Cdm);
         blackBoard = new Sprite();
         blackBoard.addChild(ComponentUtil.getShape(Global.stage.stageWidth,Global.stage.stageHeight,0,0.2));
      }
      
      override protected function initDynamicView() : void
      {
         btn_ok.callBack = this.okClick;
         btn_cancel.callBack = this.hide;
         CloseButton.callBack = this.hide;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
      
      private function okClick(evt:MouseEvent) : void
      {
         if(_okCB != null)
         {
            _okCB();
         }
         this.visible = false;
         this.saveStatus();
      }
      
      private function hide(e:MouseEvent = null) : void
      {
         this.visible = false;
         if(canelFun != null)
         {
            canelFun();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(!value)
         {
            _okCB = null;
         }
         super.visible = value;
         if(value)
         {
            GameScene.uiLayer.addChild(blackBoard);
         }
         else
         {
            GameScene.uiLayer.removeChild(blackBoard);
         }
      }
      
      private function saveStatus() : void
      {
         if(keys != "")
         {
            Model_CostTip.keyDic[keys] = checkBox.selected;
         }
      }
   }
}

import flash.utils.Dictionary;

class Model_CostTip
{
   
   public static var keyDic:Dictionary = new Dictionary(false);
   
   public function Model_CostTip()
   {
      super();
   }
}
