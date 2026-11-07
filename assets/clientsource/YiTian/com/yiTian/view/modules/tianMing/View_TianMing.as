package com.yiTian.view.modules.tianMing
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_TianMing;
   import com.yiTian.data.model.Model_Tianming;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TianMingCGMessage;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.tianmingjj.TianMingJJCursorManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_TianMing extends Panel123
   {
      
      private static var _instance:View_TianMing;
      
      private var effSprite:Sprite;
      
      private var back:Sprite;
      
      private var titleBg:Bitmap;
      
      public function View_TianMing()
      {
         super();
         init();
      }
      
      public static function get instance() : View_TianMing
      {
         if(!_instance)
         {
            _instance = new View_TianMing();
         }
         return _instance;
      }
      
      public function addEff(type:int) : void
      {
         if(!this.effSprite)
         {
            this.effSprite = new Sprite();
            addChild(this.effSprite);
            ComponentUtil.setPropertie(this.effSprite,{
               "x":width / 2,
               "y":height / 2
            });
         }
         TianMing_Effect.addEff(type,this.effSprite);
      }
      
      override protected function initStaticView() : void
      {
         var questBtn:Button;
         var upTip:MyTextField;
         var onOut:Function = null;
         onOut = function(e:MouseEvent):void
         {
            if(Model_Tianming.isLock)
            {
               Model_Tianming.isLock = false;
               TianMingJJCursorManager.hide();
            }
         };
         this.back = new Sprite();
         addChild(this.back);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.back,{
            "x":0,
            "y":0,
            "width":663,
            "height":550
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.back,{
            "x":24,
            "y":40,
            "width":615,
            "height":500
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.back,{
            "x":34,
            "y":50,
            "width":595,
            "height":235
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.back,{
            "x":34,
            "y":290,
            "width":350,
            "height":170
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.back,{
            "x":389,
            "y":290,
            "width":240,
            "height":170
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":182,
            "y":214 + 14,
            "width":50,
            "height":22
         },Global.Img_Cdm);
         move = new Rectangle(0,0,663,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":629,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         questBtn = ComponentUtil.getButton("","Button_Quest",this,{
            "x":602,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         questBtn.callBack = function(e:MouseEvent):void
         {
            TianMing_Help.instance.visible = true;
         };
         upTip = ComponentUtil.getTextField("",this,{
            "x":39,
            "y":515,
            "color":14662240,
            "size":12,
            "leading":0
         });
         upTip.htmlText = LangConfig.getWord("80115",8);
         this.addEventListener(MouseEvent.ROLL_OUT,onOut);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         var tianMing:TianMing_Container = TianMing_Container.instance;
         addChild(tianMing);
         ComponentUtil.setPropertie(tianMing,{
            "x":59,
            "y":60
         });
         var myTianMing:View_MyTianMing = View_MyTianMing.instance;
         addChild(myTianMing);
         ComponentUtil.setPropertie(myTianMing,{
            "x":387,
            "y":51
         });
         var tianFu:View_TianFu = View_TianFu.instance;
         addChild(tianFu);
         ComponentUtil.setPropertie(tianFu,{
            "x":34,
            "y":290
         });
      }
      
      override protected function initUI2() : void
      {
         View_MyTianMing.instance.initUI();
         View_TianFu.instance.tianFu_bar.initUI();
         ComponentUtil.getBitmap("Title_DangQian",this.back,{
            "x":45,
            "y":298
         },Global.TianMing_Imgsdm);
         ComponentUtil.getBitmap("Title_TiSheng",this.back,{
            "x":219,
            "y":297
         },Global.TianMing_Imgsdm);
         ComponentUtil.getBitmap("Cut_Line",this.back,{
            "x":207,
            "y":294
         },Global.TianMing_Imgsdm);
         this.titleBg = ComponentUtil.getBitmap("Title_TianMing",this,{
            "x":251,
            "y":5
         },Global.TianMing_Imgsdm);
         this.resetPosition();
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         super.visible = value;
         if(visible)
         {
            TianMingCGMessage.CG_OPEN_TIANMING();
            if(!Global.TianMing_Imgsdm)
            {
               regResource(Enum_TianMing.TIANMINGSOURCE,"TianMing_Imgsdm");
               preFun();
            }
            else if(!this.titleBg)
            {
               this.initUI2();
            }
         }
         else
         {
            View_BlessingFruit.instance.visible = value;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
   }
}

