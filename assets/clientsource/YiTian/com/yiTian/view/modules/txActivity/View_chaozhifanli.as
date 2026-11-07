package com.yiTian.view.modules.txActivity
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.geom.Rectangle;
   
   public class View_chaozhifanli extends Panel123
   {
      
      private static var _instance:View_chaozhifanli;
      
      public function View_chaozhifanli()
      {
         super();
         regResource("lang/ch/CJFL.swf","CJFLdm");
      }
      
      public static function get instance() : View_chaozhifanli
      {
         return Singleton.getInstance(View_chaozhifanli);
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":574,
            "height":398
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":524,
            "height":348
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":499,
            "height":141
         },Global.CJFLdm);
         ComponentUtil.getBitmap("Title_CJFL",this,{
            "x":207,
            "y":5
         },Global.CJFLdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":539,
            "y":6,
            "textColor":16771436,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_CJFLR",this,{
            "x":45,
            "y":59
         },Global.CJFLdm);
         ComponentUtil.getBitmap("Text_CJFLR",this,{
            "x":56,
            "y":72
         },Global.CJFLdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":38,
            "y":196,
            "width":499,
            "height":180
         },Global.CJFLdm);
         ComponentUtil.getBitmap("Text_FLXSSM",this,{
            "x":43,
            "y":198
         },Global.CJFLdm);
         ComponentUtil.getTextField("1.返利金额计算:2014年5月17日，用户在游戏内以Q币Q点消费、财付通直付消费、游戏\n内可充值货币消费，消费10Q点以上即可参与返利，返利比例为10%。返利计算额度小\n数点部分自动舍弃，如用户消费56Q点，按比例计算为5.6金券，实际获返5金券。",this,{
            "x":55,
            "y":227,
            "color":16777215,
            "size":12,
            "leading":3
         });
         ComponentUtil.getTextField("2.返利活动时间：2014年5月17日0点至24点。",this,{
            "x":55,
            "y":287,
            "color":16777215,
            "size":12,
            "leading":3
         });
         ComponentUtil.getTextField("3.返利发放规则及时间:活动结束后，次日本活动页面告知用户获得返利金额，6月15日到\n6月30日可在QQ空间活动中心领取。",this,{
            "x":55,
            "y":311,
            "color":16777215,
            "size":12,
            "leading":3
         });
         ComponentUtil.getTextField("4.腾讯保留在法律规定的范围内对上述规则进行解释的权利。",this,{
            "x":55,
            "y":352,
            "color":16777215,
            "size":12,
            "leading":3
         });
         ComponentUtil.getButton("我知道了","Button_Orange",this,{
            "x":443,
            "y":347,
            "textColor":16771436,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         move = new Rectangle(0,0,540,38);
      }
   }
}

