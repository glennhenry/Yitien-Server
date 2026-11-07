package com.yiTian.view.modules.chunjiehuodong
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.PaoBiaoCGMessage;
   import com.yiTian.view.Panel123;
   
   public class View_ZiBiao extends Panel123
   {
      
      private static var _instance:View_ZiBiao;
      
      public function View_ZiBiao()
      {
         super();
         regResource("lang/ch/NSHS.swf","NSHSdm");
      }
      
      public static function get instance() : View_ZiBiao
      {
         if(!_instance)
         {
            _instance = new View_ZiBiao();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var btn:Button;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":458,
            "height":308
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":410,
            "height":259
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WXPrompt",this,{
            "x":149,
            "y":5
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":423,
            "y":6,
            "textColor":16771436,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":34,
            "y":50,
            "width":390,
            "height":211
         },Global.NSHSdm);
         ComponentUtil.getBitmap("Back_CJZB",this,{
            "x":39,
            "y":55
         },Global.NSHSdm);
         btn = ComponentUtil.getButton("","Button_TwoBule91",this,{
            "x":184,
            "y":265,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getTextField("确定",this,{
            "x":216,
            "y":268,
            "color":16184781,
            "size":12,
            "leading":0
         });
         btn.callBack = function():void
         {
            PaoBiaoCGMessage.CG_ZHI_BIAO(0);
            visible = false;
         };
      }
   }
}

