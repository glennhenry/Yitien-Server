package com.yiTian.view.modules.ChongChuJiangHu
{
   import com.ui.controls.Button;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_ChongChuJiangHu;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.ChongChuJinagHuCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_ChongChuJiangHu_menu extends Panel123
   {
      
      private static var _instance:View_ChongChuJiangHu_menu;
      
      private var closeBtn:Button;
      
      private var helpBtn:Button;
      
      private var tabBtn_HuiGui:TabButton;
      
      private var tabBtn_ZhuanShu:TabButton;
      
      private var spr_HuiGui:Sprite;
      
      private var spr_ZhuanShu:Sprite;
      
      private var startTime:int;
      
      private var endTime:int;
      
      private var progressBM:Bitmap;
      
      private var mask_progress:Shape;
      
      private var progressLength:int;
      
      private var itemList_0:ChongChuJiangHu_itemList;
      
      private var itemList_1:ChongChuJiangHu_itemList;
      
      private var itemList_2:ChongChuJiangHu_itemList;
      
      private var itemList_3:ChongChuJiangHu_itemList;
      
      private var itemList_4:ChongChuJiangHu_itemList;
      
      private var haveGotBM_0:Bitmap;
      
      private var haveGotBM_1:Bitmap;
      
      private var haveGotBM_2:Bitmap;
      
      private var haveGotBM_3:Bitmap;
      
      private var haveGotBM_4:Bitmap;
      
      private var point_0:Bitmap;
      
      private var point_1:Bitmap;
      
      private var point_2:Bitmap;
      
      private var point_3:Bitmap;
      
      private var point_4:Bitmap;
      
      private var getBtn:Button;
      
      public function View_ChongChuJiangHu_menu()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/CCJH_Imgs.swf","CCJH_Imgsdm");
      }
      
      public static function get instance() : View_ChongChuJiangHu_menu
      {
         if(!_instance)
         {
            _instance = new View_ChongChuJiangHu_menu();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var i:int;
         move = new Rectangle(0,0,630,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":630,
            "height":490
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":68,
            "width":582,
            "height":412
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_Img",this,{
            "x":34,
            "y":78
         },Global.CCJH_Imgsdm);
         ComponentUtil.getBitmap("Title_CCJH",this,{
            "x":235,
            "y":5
         },Global.CCJH_Imgsdm);
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":596,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.closeBtn.callBack = function():void
         {
            _instance.visible = false;
         };
         this.helpBtn = ComponentUtil.getButton("","Button_HDTips",this,{
            "x":566,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         TipManager.bind(this.helpBtn,"1.拥有70级以上角色且有充值过的玩家，在其他区创建角色即满足重出江湖条件。\n" + "2.角色升到对应的等级即可领取对应的回归大礼。\n" + "3.领取完所有的回归大礼奖励后，图标消失，特权关闭。\n");
         this.spr_HuiGui = new Sprite();
         this.addChild(this.spr_HuiGui);
         i = 0;
         while(i < 5)
         {
            this["itemList_" + i] = new ChongChuJiangHu_itemList(i);
            this["itemList_" + i].x = 122 + i * 87;
            this["itemList_" + i].y = 113;
            this.spr_HuiGui.addChild(this["itemList_" + i]);
            i++;
         }
         ComponentUtil.getBitmap("Image_HGDL",this.spr_HuiGui,{
            "x":92,
            "y":143
         },Global.CCJH_Imgsdm);
         ComponentUtil.getTextField("为回馈《倚天》老玩家重出江湖" + "\n" + "在此我们特定奉上：",this.spr_HuiGui,{
            "x":95,
            "y":102,
            "color":16764206,
            "size":12,
            "leading":4
         });
         ComponentUtil.getBitmap("Progress_Back",this.spr_HuiGui,{
            "x":54,
            "y":383
         },Global.CCJH_Imgsdm);
         this.progressBM = ComponentUtil.getBitmap("Progress",this.spr_HuiGui,{
            "x":58,
            "y":386
         },Global.CCJH_Imgsdm);
         this.mask_progress = ComponentUtil.getShape(1,8,0,1);
         this.addChild(this.mask_progress);
         this.progressLength = this.progressBM.width / 6;
         this.mask_progress.x = this.progressBM.x;
         this.mask_progress.y = this.progressBM.y;
         this.progressBM.mask = this.mask_progress;
         ComponentUtil.getTextField("20级领取",this.spr_HuiGui,{
            "x":119,
            "y":400,
            "color":16776960,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("30级领取",this.spr_HuiGui,{
            "x":200,
            "y":400,
            "color":16776960,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("40级领取",this.spr_HuiGui,{
            "x":288,
            "y":400,
            "color":16776960,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("50级领取",this.spr_HuiGui,{
            "x":376,
            "y":400,
            "color":16776960,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("60级领取",this.spr_HuiGui,{
            "x":464,
            "y":400,
            "color":16776960,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Point_Disabled",this.spr_HuiGui,{
            "x":133,
            "y":382
         },Global.CCJH_Imgsdm);
         ComponentUtil.getBitmap("Point_Disabled",this.spr_HuiGui,{
            "x":220,
            "y":382
         },Global.CCJH_Imgsdm);
         ComponentUtil.getBitmap("Point_Disabled",this.spr_HuiGui,{
            "x":307,
            "y":382
         },Global.CCJH_Imgsdm);
         ComponentUtil.getBitmap("Point_Disabled",this.spr_HuiGui,{
            "x":394,
            "y":382
         },Global.CCJH_Imgsdm);
         ComponentUtil.getBitmap("Point_Disabled",this.spr_HuiGui,{
            "x":481,
            "y":382
         },Global.CCJH_Imgsdm);
         this.point_0 = ComponentUtil.getBitmap("Progress_Point",this.spr_HuiGui,{
            "x":133,
            "y":382
         },Global.CCJH_Imgsdm);
         this.point_1 = ComponentUtil.getBitmap("Progress_Point",this.spr_HuiGui,{
            "x":220,
            "y":382
         },Global.CCJH_Imgsdm);
         this.point_2 = ComponentUtil.getBitmap("Progress_Point",this.spr_HuiGui,{
            "x":307,
            "y":382
         },Global.CCJH_Imgsdm);
         this.point_3 = ComponentUtil.getBitmap("Progress_Point",this.spr_HuiGui,{
            "x":394,
            "y":382
         },Global.CCJH_Imgsdm);
         this.point_4 = ComponentUtil.getBitmap("Progress_Point",this.spr_HuiGui,{
            "x":481,
            "y":382
         },Global.CCJH_Imgsdm);
         this.getBtn = ComponentUtil.getButton("","Button_Get",this.spr_HuiGui,{
            "x":258,
            "y":425,
            "textColor":16184781
         },Global.CCJH_Imgsdm);
         this.getBtn.callBack = this.getPrizeHandel;
         this.getBtn.enabled = false;
         this.haveGotBM_0 = ComponentUtil.getBitmap("Gotted_Img",this.spr_HuiGui,{
            "x":90,
            "y":277
         },Global.CCJH_Imgsdm);
         this.haveGotBM_1 = ComponentUtil.getBitmap("Gotted_Img",this.spr_HuiGui,{
            "x":177,
            "y":277
         },Global.CCJH_Imgsdm);
         this.haveGotBM_2 = ComponentUtil.getBitmap("Gotted_Img",this.spr_HuiGui,{
            "x":264,
            "y":277
         },Global.CCJH_Imgsdm);
         this.haveGotBM_3 = ComponentUtil.getBitmap("Gotted_Img",this.spr_HuiGui,{
            "x":351,
            "y":277
         },Global.CCJH_Imgsdm);
         this.haveGotBM_4 = ComponentUtil.getBitmap("Gotted_Img",this.spr_HuiGui,{
            "x":438,
            "y":277
         },Global.CCJH_Imgsdm);
         this.spr_ZhuanShu = new Sprite();
         this.addChild(this.spr_ZhuanShu);
         ComponentUtil.getBitmap("TGJQ_Img",this.spr_ZhuanShu,{
            "x":195,
            "y":139
         },Global.CCJH_Imgsdm);
         ComponentUtil.getBitmap("TGZD_Img",this.spr_ZhuanShu,{
            "x":195,
            "y":314
         },Global.CCJH_Imgsdm);
         ComponentUtil.getTextField("为回馈《倚天》老玩家重出江湖，在此我们特定奉上：",this.spr_ZhuanShu,{
            "x":100,
            "y":103,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("专属特权1：跳过剧情",this.spr_ZhuanShu,{
            "x":130,
            "y":123,
            "color":16776960,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("新手期1-32级的剧情动画可以点击中间跳过剧情",this.spr_ZhuanShu,{
            "x":195,
            "y":269,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("专属特权2：跳过战斗",this.spr_ZhuanShu,{
            "x":130,
            "y":298,
            "color":16776960,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("新手期1-32级可直接跳过任务副本战斗，助您快速升级！",this.spr_ZhuanShu,{
            "x":195,
            "y":444,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.tabBtn_HuiGui = ComponentUtil.getTabButton("回归大礼","TabButton_Four",this,{
            "x":34,
            "y":47,
            "textColor":11770414,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.tabBtn_HuiGui.binding = this.spr_HuiGui;
         this.tabBtn_HuiGui.choose = true;
         this.tabBtn_HuiGui.addEventListener(MouseEvent.CLICK,this.tabBtnHandle);
         this.tabBtn_ZhuanShu = ComponentUtil.getTabButton("专属特权","TabButton_Four",this,{
            "x":110,
            "y":47,
            "textColor":11770414,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.tabBtn_ZhuanShu.binding = this.spr_ZhuanShu;
         this.tabBtn_ZhuanShu.choose = false;
         this.tabBtn_ZhuanShu.addEventListener(MouseEvent.CLICK,this.tabBtnHandle);
      }
      
      public function UpdateGetPrizeStatus() : void
      {
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(instance,function():void
         {
            UpdateGetPrizeStatus2();
         });
      }
      
      private function UpdateGetPrizeStatus2() : void
      {
         var j:* = undefined;
         var i:int = 0;
         while(i < 5)
         {
            switch(Model_ChongChuJiangHu.getPrizeStatus[i])
            {
               case 0:
                  this["haveGotBM_" + i].visible = false;
                  this["point_" + i].visible = false;
                  break;
               case 1:
                  this["haveGotBM_" + i].visible = false;
                  this["point_" + i].visible = false;
                  break;
               case 2:
                  this["haveGotBM_" + i].visible = true;
                  this["point_" + i].visible = true;
                  break;
               default:
                  trace("谁TM又乱发数据！！！！");
            }
            i++;
         }
         this.getBtn.enabled = false;
         for(j in Model_ChongChuJiangHu.getPrizeStatus)
         {
            if(Model_ChongChuJiangHu.getPrizeStatus[j] == 1)
            {
               this.getBtn.enabled = true;
            }
            if(Model_ChongChuJiangHu.getPrizeStatus[j] == 0)
            {
               this.mask_progress.width = j * this.progressLength;
               break;
            }
            if(j == 4)
            {
               if(Model_ChongChuJiangHu.getPrizeStatus[j] == 1)
               {
                  this.mask_progress.width = (j + 1) * this.progressLength;
               }
               else
               {
                  this.mask_progress.width = (j + 2) * this.progressLength;
               }
            }
         }
      }
      
      private function tabBtnHandle(e:MouseEvent) : void
      {
         if(e.currentTarget == this.tabBtn_HuiGui)
         {
            this.tabBtn_HuiGui.choose = true;
            this.tabBtn_ZhuanShu.choose = false;
         }
         else
         {
            this.tabBtn_HuiGui.choose = false;
            this.tabBtn_ZhuanShu.choose = true;
         }
      }
      
      private function getPrizeHandel(e:*) : void
      {
         var i:* = undefined;
         for(i in Model_ChongChuJiangHu.getPrizeStatus)
         {
            if(Model_ChongChuJiangHu.getPrizeStatus[i] == 1)
            {
               ChongChuJinagHuCGMessage.GetPrize(i + 1);
               break;
            }
         }
      }
      
      public function FlyToBag() : void
      {
         var i:* = undefined;
         for(i in Model_ChongChuJiangHu.getPrizeStatus)
         {
            if(Model_ChongChuJiangHu.getPrizeStatus[i] == 1)
            {
               ChongChuJiangHu_itemList(this["itemList_" + i]).FlyToBag();
               break;
            }
         }
      }
      
      override public function resetPosition() : void
      {
         this.x = (Global.stage.stageWidth - this.width) / 2;
         this.y = (Global.stage.stageHeight - this.height) / 2;
      }
   }
}

