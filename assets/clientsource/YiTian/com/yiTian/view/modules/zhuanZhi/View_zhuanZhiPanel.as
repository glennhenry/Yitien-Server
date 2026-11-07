package com.yiTian.view.modules.zhuanZhi
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.ZhuanZhiCGMessage;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.specialBtnDill.Model_specialD;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_zhuanZhiPanel extends Panel123
   {
      
      public function View_zhuanZhiPanel()
      {
         super();
         regResource("lang/ch/ZhuanZhi_Imgs.swf","ZhuanZhi_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":393,
            "height":330
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":345,
            "height":280
         },Global.Img_Cdm);
         move = new Rectangle(0,0,width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":359,
            "y":6
         },Global.Img_Cdm);
         var tmp:MyTextField = ComponentUtil.getTextField("",this,{
            "x":44,
            "y":50,
            "color":14662240,
            "multiline":true
         });
         tmp.htmlText = LangConfig.getWord("29436",2);
         tmp = ComponentUtil.getTextField("",this,{
            "x":44,
            "y":121,
            "color":14662240,
            "multiline":true
         });
         tmp.htmlText = LangConfig.getWord("29437",2);
         var tf:MyTextField = ComponentUtil.getTextField("",this,{
            "x":44,
            "y":164,
            "color":8896312,
            "size":14
         });
         tf.htmlText = LangConfig.getWord("29438",2);
         tf = ComponentUtil.getTextField("",this,{
            "x":44,
            "y":193,
            "color":8896312,
            "size":14
         });
         tf.htmlText = LangConfig.getWord("29439",2);
         tf = ComponentUtil.getTextField("",this,{
            "x":44,
            "y":222,
            "color":8896312,
            "size":14
         });
         tf.htmlText = LangConfig.getWord("29440",2);
         ComponentUtil.getButton(LangConfig.getWord("29441",2),"Button_Four",this,{
            "x":160,
            "y":285,
            "textColor":16184781,
            "callBack":this.commitClickHd
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_JinJie",this,{
            "x":117,
            "y":5
         },Global.ZhuanZhi_Imgsdm);
         super.initDynamicView();
      }
      
      private function commitClickHd(e:MouseEvent) : void
      {
         ZhuanZhiCGMessage.CG_ZZ_WOYAOZHUANZHI();
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(!value)
         {
            Model_specialD.visFalseComp(this,ZhuanZhiUtil.zhuanZhiTipBtn,this.superHide);
         }
         else
         {
            super.visible = value;
         }
      }
      
      private function superHide() : void
      {
         super.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

