package com.yiTian.view.modules.canggao
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.NewYearCGMessage;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.newYear.NewYearVO;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class CangGaoPanel extends Panel123
   {
      
      private static var _instance:CangGaoPanel;
      
      public static var isInit:Boolean = false;
      
      private var back:ScaleBitmap;
      
      private var join:Button;
      
      private var tf:MyTextField;
      
      public function CangGaoPanel()
      {
         super();
         regResource("lang/ch/NianGao_Imgs.swf","NianGao_Imgsdm");
      }
      
      public static function get instance() : CangGaoPanel
      {
         if(!_instance)
         {
            _instance = new CangGaoPanel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":436,
            "height":315
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_NianGao",this,{
            "x":138,
            "y":5
         },Global.NianGao_Imgsdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":388,
            "height":265
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Diamond01",[11,11,1,1],this,{
            "x":34,
            "y":50,
            "width":368,
            "height":245
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back4",[3,3,1,1],this,{
            "x":44,
            "y":63,
            "width":348,
            "height":90
         },Global.Img_Cdm);
         this.join = ComponentUtil.getButton("","Button_Join",this,{
            "x":101,
            "y":165,
            "textColor":16184781
         },Global.NianGao_Imgsdm);
         this.tf = ComponentUtil.getTextField("",this,{
            "x":55,
            "y":72,
            "color":16184781,
            "size":12,
            "leading":3
         });
         this.tf.multiline = true;
         this.tf.htmlText = "活动时间：" + CangGaoVO.time + "<br>活动规则：在<font color =\'#00ff00\'>" + Global.pfName + "</font>秘境累计刷新<font color =\'#00ff00\'>10次</font>，可获得<font color =\'#00ff00\'>【年糕】1个，</font><br>               通过<font color =\'#00ff00\'>邮件</font>形式发送，在背包内双击年糕可打开年糕<br>               商城";
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":402,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.join.addEventListener(MouseEvent.CLICK,this.joinClick);
         isInit = true;
         this.updateTip();
         this.initDynamicView();
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      private function joinClick(e:MouseEvent) : void
      {
         this.visible = false;
         UIManager.sm_shop.visible = true;
      }
      
      public function updateTip() : void
      {
         TipManager.bind(this.join,LangConfig.getWord("70025",7,NewYearVO.SMSIndex));
      }
      
      public function show() : void
      {
         this.visible = true;
         NewYearCGMessage.CG_SMS_GET_INDEX();
      }
      
      private function click() : void
      {
         UIManager.sm_shop.visible = true;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
   }
}

