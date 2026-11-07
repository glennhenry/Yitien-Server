package com.yiTian.view.modules.xiaozhao
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_XiaoZhaoDesWin extends Panel123
   {
      
      private static var instance:View_XiaoZhaoDesWin;
      
      public function View_XiaoZhaoDesWin()
      {
         super();
         this.initUI2();
      }
      
      public static function getInstance() : View_XiaoZhaoDesWin
      {
         if(!instance)
         {
            instance = new View_XiaoZhaoDesWin();
         }
         return instance;
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":290,
            "height":555 - 180
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":247,
            "height":505 - 180
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WFSM",this,{
            "x":65,
            "y":5
         },Global.XZJZdm);
         move = new Rectangle(0,0,280,36);
         var tf_main:MyTextField = ComponentUtil.getTextField("",this,{
            "x":36,
            "y":50,
            "realWidth":226,
            "multiline":true,
            "leading":5,
            "color":14662240
         });
         tf_main.wordWrap = true;
         tf_main.size = 14;
         tf_main.htmlText = "<font color=\'#04ff00\'>玩法规则</font>" + "<font color=\'#f9ff00\' size=\'12\'>\n1.点击活动图标，弹出活动窗口10张牌显示本轮奖励物品，玩家点击洗牌后，所有牌面向后，道具位置随机摆放。" + "\n2.点击向后的牌面消耗道具或者元宝进行翻牌，翻牌后可获得相应奖励。" + "\n3.每轮可进行10次翻牌，每次翻牌花费递增。" + "\n4.每轮10张牌为一个奖励组合，玩家若不满意组合奖励，可点击重置开始新的一轮，重置需花费元宝。" + "\n5.重置后将出现新的组合奖励，重置次数越多含有大奖的组合奖励出现的机会越大，冥级天命宝箱、英雄令(紫)、天命宝箱（5星）、附橙石、翅膀羽毛等各种丰厚奖励等你探寻。";
         ComponentUtil.getButton("","Button_Close",this,{
            "x":263,
            "y":6,
            "textColor":16771436,
            "callBack":this.onClose
         },Global.Img_Cdm);
      }
      
      private function onClose(evt:MouseEvent) : void
      {
         this.visible = false;
      }
   }
}

