package com.yiTian.view.modules.baby.babyPan
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.baby.babyIcon.BabyBtnBesideRole;
   import com.yiTian.view.modules.baby.babyManager.Model_baby;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class BabyPYTipsPan extends Panel123
   {
      
      private var daysTf:MyTextField;
      
      private var timesTf:MyTextField;
      
      public function BabyPYTipsPan()
      {
         super();
         regResource("lang/ch/ZN.swf","ZNdm");
      }
      
      public static function get instance() : BabyPYTipsPan
      {
         return Singleton.getInstance(BabyPYTipsPan);
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":620,
            "height":383
         },Global.Img_Cdm);
         move = new Rectangle(0,0,620,38);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":570,
            "height":333
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":546,
            "height":268
         },Global.ZNdm);
         ComponentUtil.getScaleBitmap("Back_LBD",[4,4,1,1],this,{
            "x":44,
            "y":145,
            "width":532,
            "height":82
         },Global.ZNdm);
         ComponentUtil.getScaleBitmap("Back_LBD",[4,4,1,1],this,{
            "x":44,
            "y":231,
            "width":532,
            "height":82
         },Global.ZNdm);
         ComponentUtil.getBitmap("light_PYTS",this,{
            "x":44,
            "y":114
         },Global.ZNdm);
         ComponentUtil.getBitmap("Dot_JJTS",this,{
            "x":93,
            "y":171
         },Global.ZNdm);
         ComponentUtil.getBitmap("Dot_JJTS",this,{
            "x":93,
            "y":258
         },Global.ZNdm);
         ComponentUtil.getTextField("什么是未成年期",this,{
            "x":116,
            "y":164,
            "color":15660032,
            "size":14,
            "leading":0
         });
         var tf:MyTextField = ComponentUtil.getTextField("",this,{
            "x":116,
            "y":188,
            "color":327424,
            "size":12,
            "leading":0
         });
         tf.htmlText = "是指崽崽在未成年期可以培养，<font color=\'#fe0000\'>15天后成年将不能培养</font>,建议大家加紧时间培养";
         ComponentUtil.getTextField("什么是培养次数",this,{
            "x":116,
            "y":252,
            "color":15660032,
            "size":14,
            "leading":0
         });
         ComponentUtil.getTextField("是指未成年期可进行每天最高10次培养，在未成年期每日培养次数可累计",this,{
            "x":116,
            "y":275,
            "color":327424,
            "size":12,
            "leading":0
         });
         ComponentUtil.getButton("","Button_JXPY",this,{
            "x":155,
            "y":330,
            "textColor":16771436,
            "callBack":this.showPY
         },Global.ZNdm);
         ComponentUtil.getButton("","Button_SHZS",this,{
            "x":374,
            "y":330,
            "textColor":16771436,
            "callBack":this.hide
         },Global.ZNdm);
         ComponentUtil.getBitmap("Text_PYCS",this,{
            "x":189,
            "y":108
         },Global.ZNdm);
         ComponentUtil.getBitmap("Text_CNTS",this,{
            "x":189,
            "y":73
         },Global.ZNdm);
         ComponentUtil.getBitmap("Title_PYTS",this,{
            "x":230,
            "y":5
         },Global.ZNdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":586,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         this.daysTf = ComponentUtil.getTextField("14天",this,{
            "x":391,
            "y":71,
            "color":16711680,
            "size":16,
            "leading":0,
            "bold":true
         });
         this.timesTf = ComponentUtil.getTextField("5次",this,{
            "x":391,
            "y":106,
            "color":16711680,
            "size":16,
            "leading":0,
            "bold":true
         });
         super.initDynamicView();
         Global.control.registerCallBack(BabyBtnBesideRole.BABYPAN_MSG_BACK,this.update);
      }
      
      private function update() : void
      {
         var transDate:Function = function(value:Number):String
         {
            var da:int = Math.floor(value / 60 / 60 / 24);
            var hour:int = Math.ceil(value / 60 / 60 % 24);
            if(da <= 0)
            {
               return hour + "小时";
            }
            return da + "天" + hour + "小时";
         };
         this.daysTf.htmlText = transDate(Model_baby.days);
         this.timesTf.htmlText = Model_baby.times + "次";
      }
      
      private function showPY(e:MouseEvent) : void
      {
         Model_baby.show(View_babyPan.instance,"showPartOf",1);
         this.hide();
      }
      
      private function hide(e:MouseEvent = null) : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.update();
         }
      }
   }
}

