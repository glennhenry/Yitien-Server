package com.yiTian.view.modules.baby.babyPan
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class BabyPanGuide extends Panel123
   {
      
      private static var step:uint = 1;
      
      private var unit1:Sprite = new Sprite();
      
      private var btn:Button;
      
      private var unit2:Sprite = new Sprite();
      
      public function BabyPanGuide()
      {
         super();
         regResource("lang/ch/ZN.swf","ZNdm");
      }
      
      public static function get instance() : BabyPanGuide
      {
         return Singleton.getInstance(BabyPanGuide);
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":504,
            "height":346
         },Global.Img_Cdm);
         move = new Rectangle(0,0,504,38);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":454,
            "height":296
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":430,
            "height":244
         },Global.ZNdm);
         addChild(this.unit1);
         addChild(this.unit2);
         ComponentUtil.getBitmap("Back_LYZZZD",this.unit1,{
            "x":44,
            "y":59
         },Global.ZNdm);
         var tf:MyTextField = ComponentUtil.getTextField("",this.unit1,{
            "x":99,
            "y":249,
            "color":16383744,
            "size":12,
            "leading":3,
            "realWidth":326,
            "multiline":true,
            "wordWrap":true
         });
         var ss:String = "须" + HtmlUtil.font("夫妻满足100级组队","#fe0000") + "点击“领养崽崽”（最多领养两个崽崽）同时领养者拥有" + HtmlUtil.font("千年人参","#fe0000") + "道具（商城可购买）即可领养崽崽";
         tf.htmlText = ss;
         ComponentUtil.getBitmap("Icon_JianTou",this.unit1,{
            "x":234,
            "y":138
         },Global.ZNdm);
         ComponentUtil.getBitmap("Title_ZZZD",this,{
            "x":172,
            "y":5
         },Global.ZNdm);
         this.btn = ComponentUtil.getButton("下一步","Button_TwoBule91",this,{
            "x":207,
            "y":302,
            "textColor":16771436,
            "callBack":this.btnEvent
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":470,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         super.initDynamicView();
         this.init_part2();
         this.unit2.visible = false;
      }
      
      private function init_part2() : void
      {
         ComponentUtil.getScaleBitmap("Back_LBD",[4,4,1,1],this.unit2,{
            "x":44,
            "y":59,
            "width":416,
            "height":73
         },Global.ZNdm);
         ComponentUtil.getScaleBitmap("Back_LBD",[4,4,1,1],this.unit2,{
            "x":44,
            "y":138,
            "width":416,
            "height":73
         },Global.ZNdm);
         ComponentUtil.getScaleBitmap("Back_LBD",[4,4,1,1],this.unit2,{
            "x":44,
            "y":216,
            "width":416,
            "height":73
         },Global.ZNdm);
         ComponentUtil.getBitmap("Dot_JJTS",this.unit2,{
            "x":65,
            "y":72
         },Global.ZNdm);
         ComponentUtil.getBitmap("Dot_JJTS",this.unit2,{
            "x":65,
            "y":152
         },Global.ZNdm);
         ComponentUtil.getBitmap("Dot_JJTS",this.unit2,{
            "x":65,
            "y":237
         },Global.ZNdm);
         ComponentUtil.getTextField("崽崽功能：魅力作用",this.unit2,{
            "x":84,
            "y":66,
            "color":15660032,
            "size":14,
            "leading":0
         });
         var tf1:MyTextField = ComponentUtil.getTextField("",this.unit2,{
            "x":84,
            "y":88,
            "color":16777215,
            "size":12,
            "leading":3,
            "realWidth":373,
            "wordWrap":true,
            "multiline":true
         });
         var ss1:String = "魅力等级高低决定崽崽附加给宠物的属性高低，" + HtmlUtil.font("同时魅力值每天会下降5%","#04ff00");
         tf1.htmlText = ss1;
         ComponentUtil.getTextField("崽崽功能：培养作用",this.unit2,{
            "x":84,
            "y":146,
            "color":15660032,
            "size":14,
            "leading":0
         });
         var tf2:MyTextField = ComponentUtil.getTextField("",this.unit2,{
            "x":84,
            "y":169,
            "realWidth":373,
            "wordWrap":true,
            "multiline":true,
            "color":16777215,
            "size":12,
            "leading":3
         });
         var ss2:String = HtmlUtil.font("培养等级高低决定崽崽增加宠物基础属性百分比加成，切记只有在未成年期间（15天后成年）","#ffffff") + HtmlUtil.font("可每天培养十次，","#04ff00") + HtmlUtil.font("建议提前备好培养材料。","#fe0000");
         tf2.htmlText = ss2;
         ComponentUtil.getTextField("崽崽功能：武功作用",this.unit2,{
            "x":84,
            "y":231,
            "color":15660032,
            "size":14,
            "leading":0
         });
         ComponentUtil.getTextField("崽崽武功可以使宠物拥有强大的武功",this.unit2,{
            "x":84,
            "y":254,
            "color":16777215,
            "size":12,
            "leading":0
         });
      }
      
      public function show(e:* = null) : void
      {
         visible = !visible;
         if(visible)
         {
            this.unit1.visible = true;
            this.unit2.visible = false;
            this.btn.label = "下一步";
            step = 1;
         }
      }
      
      public function btnEvent(e:* = null) : void
      {
         if(step == 1)
         {
            this.unit1.visible = false;
            this.unit2.visible = true;
            this.btn.label = "确定";
            ++step;
         }
         else
         {
            visible = false;
         }
      }
      
      public function hide(e:* = null) : void
      {
         visible = visible && false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

