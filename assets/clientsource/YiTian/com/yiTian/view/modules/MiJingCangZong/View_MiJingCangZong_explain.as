package com.yiTian.view.modules.MiJingCangZong
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.view.Panel123;
   import flash.geom.Rectangle;
   
   public class View_MiJingCangZong_explain extends Panel123
   {
      
      private static var _instance:View_MiJingCangZong_explain;
      
      private var btn:Button;
      
      private var closeBtn:Button;
      
      private var timeTxt:MyTextField;
      
      private var freshTime:MyTextField;
      
      public function View_MiJingCangZong_explain()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/MiJingCangZong_Imgs.swf","MiJingCangZong_Imgs");
      }
      
      public static function get instance() : View_MiJingCangZong_explain
      {
         if(!_instance)
         {
            _instance = new View_MiJingCangZong_explain();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         move = new Rectangle(0,0,436,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":436,
            "height":315
         },Global.Img_Cdm);
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
            "height":70
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_NianGao",this,{
            "x":138,
            "y":5
         },Global.MiJingCangZong_Imgs);
         this.timeTxt = ComponentUtil.getTextField("活动时间：00月00日 - 00月00日\n" + "活动规则：在朋友网秘境累计刷新10次，可获得【粽子】1个。\n" + "通过邮件形式发送，在背包内双击粽子可打开粽子商城",this,{
            "x":55,
            "y":72,
            "color":16184781,
            "size":12,
            "leading":3
         });
         this.timeTxt.multiline = true;
         this.freshTime = ComponentUtil.getTextField("已刷新秘境X次",this,{
            "x":305,
            "y":134,
            "color":16184781,
            "size":12,
            "leading":3
         });
         this.btn = ComponentUtil.getButton("","Button_Join",this,{
            "x":101,
            "y":159,
            "textColor":16184781
         },Global.MiJingCangZong_Imgs);
         this.btn.callBack = function():void
         {
            UIManager.sm_shop.visible = true;
            visible = false;
         };
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":402,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.closeBtn.callBack = function():void
         {
            visible = false;
         };
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         DailyActCGMessage.CG_MiJingCangZong_FRESH();
      }
      
      public function UpdateDate(startTime:int, endTime:int) : void
      {
         this.timeTxt.htmlText = "活动时间：" + DateUtil.getYMDHM(startTime) + " 至 " + DateUtil.getYMDHM(endTime) + "<br/>" + "活动规则：在秘境累计刷新<font color=\'#00FF00\'>10次</font>，可获得<font color=\'#00FF00\'>【粽子】1个</font>。<br/>" + "通过<font color=\'#00FF00\'>邮件</font>形式发送，在背包内双击粽子可打开粽子商城。";
      }
      
      public function UpdateFresh(times:int) : void
      {
         this.freshTime.htmlText = "已刷新秘境<font color=\'#00FF00\'>" + times + "次</font>";
      }
   }
}

