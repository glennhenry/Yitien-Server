package com.yiTian.view.modules.baby.babyPan
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.BabyCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.geom.Rectangle;
   
   public class BabyInBattleRule extends Panel123
   {
      
      private var id:Number;
      
      public function BabyInBattleRule()
      {
         super();
         regResource("lang/ch/ZN.swf","ZNdm");
      }
      
      public static function get instance() : BabyInBattleRule
      {
         return Singleton.getInstance(BabyInBattleRule);
      }
      
      override protected function initUI2() : void
      {
         var tt:MyTextField;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":504,
            "height":299
         },Global.Img_Cdm);
         move = new Rectangle(0,0,504,38);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":454,
            "height":249
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":429,
            "height":225
         },Global.ZNdm);
         ComponentUtil.getBitmap("Back_CZGZ",this,{
            "x":26,
            "y":59
         },Global.ZNdm);
         tt = ComponentUtil.getTextField("",this,{
            "x":199,
            "y":64,
            "color":16772287,
            "size":12,
            "leading":7,
            "realWidth":266,
            "realHeight":266,
            "wordWrap":true,
            "multiline":true
         });
         tt.htmlText = LangConfig.getWord("1179",0);
         ComponentUtil.getBitmap("Title_CZGZ",this,{
            "x":172,
            "y":5
         },Global.ZNdm);
         ComponentUtil.getButton("携带出游","Button_Orange7026",this,{
            "x":300,
            "y":229,
            "textColor":16771436,
            "callBack":function():void
            {
               BabyCGMessage.CG_BRING_BABY_OUT(id);
            }
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":469,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         super.initDynamicView();
      }
      
      public function show(id:Number) : void
      {
         this.id = id;
         visible = visible || true;
      }
      
      public function hide() : void
      {
         visible = visible && false;
      }
   }
}

