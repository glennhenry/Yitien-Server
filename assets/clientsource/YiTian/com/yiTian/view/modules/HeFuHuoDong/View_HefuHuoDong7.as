package com.yiTian.view.modules.HeFuHuoDong
{
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_HeFuHuoDong;
   import flash.display.Sprite;
   
   public class View_HefuHuoDong7 extends Sprite
   {
      
      private static var _instance:View_HefuHuoDong7;
      
      public function View_HefuHuoDong7()
      {
         super();
         this.Init();
      }
      
      public static function get instance() : View_HefuHuoDong7
      {
         if(!_instance)
         {
            _instance = new View_HefuHuoDong7();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         var i:int = 0;
         var itemList:RankJLItem = null;
         ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
            "x":0,
            "y":180,
            "width":744,
            "height":270
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Text_Back",this,{
            "x":2,
            "y":10
         },Global.HeFu_Imgsdm);
         ComponentUtil.getTextField("活动详情：",this,{
            "x":20,
            "y":80,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("活动时间：",this,{
            "x":20,
            "y":109,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(DateUtil.getYMDHM(Model_HeFuHuoDong.startTime) + " 至 " + DateUtil.getYMDHM(Model_HeFuHuoDong.endTime),this,{
            "x":80,
            "y":109,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("活动期间，宠物战力排行榜前10名的玩家可以获得礼包奖励",this,{
            "x":80,
            "y":80,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("领取方式：",this,{
            "x":20,
            "y":138,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(DateUtil.getYMDHM(Model_HeFuHuoDong.endTime) + " 邮件发送",this,{
            "x":80,
            "y":138,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Text_ChongWu",this,{
            "x":89,
            "y":20
         },Global.HeFu_Imgsdm);
         i = 0;
         while(i < Data_lib.hefuchongwu.getLength())
         {
            itemList = new RankJLItem(7,i);
            itemList.x = 16;
            itemList.y = 190 + i * 64;
            addChild(itemList);
            i++;
         }
      }
      
      public function updateMenu() : void
      {
      }
   }
}

