package com.yiTian.view.modules.kuafujingjichang
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class DRKFJieShao extends Panel123
   {
      
      private static var _instance:DRKFJieShao;
      
      private var tf:MyTextField;
      
      private var back:ScaleBitmap;
      
      public function DRKFJieShao()
      {
         super();
         regResource("lang/ch/DuoRenKuaFu_Imgs.swf","DuoRenKuaFu_Imgsdm");
      }
      
      public static function get instance() : DRKFJieShao
      {
         if(!_instance)
         {
            _instance = new DRKFJieShao();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":348,
            "height":490
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":300,
            "height":440
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,35);
         this.tf = ComponentUtil.getTextField("",this,{
            "x":41,
            "y":50,
            "color":11904647,
            "size":12,
            "leading":5
         });
         this.tf.multiline = true;
         this.tf.htmlText = LangConfig.getWord("60498",6);
         ComponentUtil.getBitmap("Title_JieShao",this,{
            "x":94,
            "y":5
         },Global.DuoRenKuaFu_Imgsdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":314,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.callBack = this.close;
      }
      
      public function show() : void
      {
         visible = !visible;
      }
      
      private function close(e:MouseEvent) : void
      {
         visible = false;
      }
   }
}

