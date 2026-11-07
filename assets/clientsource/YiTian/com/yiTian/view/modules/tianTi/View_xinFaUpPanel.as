package com.yiTian.view.modules.tianTi
{
   import com.ui.controls.Button;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.TianTiCGMessage;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class View_xinFaUpPanel extends Panel123
   {
      
      private static var instance:View_xinFaUpPanel;
      
      private var bg:ScaleBitmap;
      
      private var btn_submit:Button;
      
      private var btn_cannel:Button;
      
      private var titleBg:Bitmap;
      
      public function View_xinFaUpPanel()
      {
         super();
         regResource("lang/ch/XFJJ.swf","XFJJdm");
      }
      
      public static function getInstance() : View_xinFaUpPanel
      {
         if(!instance)
         {
            instance = new View_xinFaUpPanel();
         }
         return instance;
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":416,
            "height":196
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":377,
            "y":6,
            "textColor":16771436,
            "callBack":this.onCannel
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":365,
            "height":146
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Four",this,{
            "x":113,
            "y":155,
            "textColor":16771436,
            "callBack":this.onSubmit
         },Global.Img_Cdm);
         ComponentUtil.getTextField("确定",this,{
            "x":135,
            "y":158,
            "color":16184781,
            "size":12,
            "leading":0
         });
         ComponentUtil.getButton("","Button_Four",this,{
            "x":225,
            "y":155,
            "textColor":16771436,
            "callBack":this.onCannel
         },Global.Img_Cdm);
         ComponentUtil.getTextField("取消",this,{
            "x":247,
            "y":158,
            "color":16184781,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("您的所有心法已经达到100级，是否升级为神级心法？",this,{
            "x":37,
            "y":64,
            "color":16776960,
            "size":13,
            "leading":7
         });
         ComponentUtil.getTextField("注：升级后的心法变为神级，每次摇杆消耗5000心法",this,{
            "x":49,
            "y":113,
            "color":327424,
            "size":12,
            "leading":0
         });
         this.titleBg = ComponentUtil.getBitmap("Title_XFJJ",this,{
            "x":128,
            "y":5
         },Global.XFJJdm);
      }
      
      private function onSubmit(e:MouseEvent) : void
      {
         TianTiCGMessage.CG_XINFAUP();
         this.visible = false;
      }
      
      private function onCannel(e:MouseEvent) : void
      {
         this.visible = false;
      }
   }
}

