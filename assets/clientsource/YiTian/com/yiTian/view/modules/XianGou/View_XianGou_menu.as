package com.yiTian.view.modules.XianGou
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_XianGou;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   
   public class View_XianGou_menu extends Panel123
   {
      
      private static var _instance:View_XianGou_menu;
      
      private var closeBtn:Button;
      
      private var listItem0:View_XianGou_listItem;
      
      private var listItem1:View_XianGou_listItem;
      
      private var listItem2:View_XianGou_listItem;
      
      private var noItemBM0:Bitmap;
      
      private var noItemBM1:Bitmap;
      
      private var noItemBM2:Bitmap;
      
      private var duringTime:MyTextField;
      
      private var rechargeBtn:Button;
      
      public function View_XianGou_menu()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/XianGou.swf","XianGoudm");
      }
      
      public static function get instance() : View_XianGou_menu
      {
         if(!_instance)
         {
            _instance = new View_XianGou_menu();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         move = new Rectangle(0,0,659,443);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":88,
            "y":0,
            "width":659,
            "height":443
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":113,
            "y":40,
            "width":609,
            "height":394
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_ChuangWen",[11,11,1,1],this,{
            "x":114,
            "y":41,
            "width":607,
            "height":392
         },Global.XianGoudm);
         ComponentUtil.getBitmap("BG_XGMM",this,{
            "x":0,
            "y":26
         },Global.XianGoudm);
         ComponentUtil.getScaleBitmap("Back_XGD",[3,3,1,1],this,{
            "x":256,
            "y":64,
            "width":445,
            "height":350
         },Global.XianGoudm);
         ComponentUtil.getBitmap("BG_GuangGao",this,{
            "x":262,
            "y":69
         },Global.XianGoudm);
         ComponentUtil.getBitmap("BG_Light",this,{
            "x":259,
            "y":177
         },Global.XianGoudm);
         ComponentUtil.getScaleBitmap("Back_XianGou",[13,5,1,1],this,{
            "x":263,
            "y":182,
            "width":432,
            "height":63
         },Global.XianGoudm);
         ComponentUtil.getScaleBitmap("Back_XianGou",[13,5,1,1],this,{
            "x":263,
            "y":247,
            "width":432,
            "height":63
         },Global.XianGoudm);
         ComponentUtil.getScaleBitmap("Back_XianGou",[13,5,1,1],this,{
            "x":263,
            "y":312,
            "width":432,
            "height":63
         },Global.XianGoudm);
         ComponentUtil.getBitmap("TiTle_JHHeiShi",this,{
            "x":340,
            "y":5
         },Global.XianGoudm);
         ComponentUtil.getBitmap("Text_HDShiJian",this,{
            "x":267,
            "y":383
         },Global.XianGoudm);
         this.duringTime = ComponentUtil.getTextField("",this,{
            "x":364,
            "y":385,
            "color":327424,
            "size":12,
            "leading":0
         });
         this.listItem0 = new View_XianGou_listItem();
         this.listItem0.x = 263;
         this.listItem0.y = 182;
         addChild(this.listItem0);
         this.listItem1 = new View_XianGou_listItem();
         this.listItem1.x = 263;
         this.listItem1.y = 247;
         addChild(this.listItem1);
         this.listItem2 = new View_XianGou_listItem();
         this.listItem2.x = 263;
         this.listItem2.y = 312;
         addChild(this.listItem2);
         this.noItemBM0 = ComponentUtil.getBitmap("Text_ZWShangPin",this,{
            "x":424,
            "y":193
         },Global.XianGoudm);
         this.noItemBM1 = ComponentUtil.getBitmap("Text_ZWShangPin",this,{
            "x":424,
            "y":258
         },Global.XianGoudm);
         this.noItemBM2 = ComponentUtil.getBitmap("Text_ZWShangPin",this,{
            "x":424,
            "y":323
         },Global.XianGoudm);
         this.noItemBM0.visible = false;
         this.noItemBM1.visible = false;
         this.noItemBM2.visible = false;
         this.rechargeBtn = ComponentUtil.getButton("","Button_Recharge",this,{
            "x":602,
            "y":379,
            "textColor":16771436
         },Global.XianGoudm);
         this.rechargeBtn.callBack = function():void
         {
            UIManager.yuanBaoXiang.visible = !UIManager.yuanBaoXiang.visible;
         };
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":710,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         this.closeBtn.callBack = function():void
         {
            _instance.visible = false;
         };
      }
      
      public function SetItem() : void
      {
         var i:int = 0;
         if(this.duringTime.text != Model_XianGou.duringTime)
         {
            this.duringTime.htmlText = Model_XianGou.duringTime;
         }
         i = 0;
         while(i < 3)
         {
            if(Boolean(Model_XianGou.ItemArr[i]) && Model_XianGou.ItemArr[i][0] != 0)
            {
               View_XianGou_listItem(this["listItem" + i]).visible = true;
               Bitmap(this["noItemBM" + i]).visible = false;
               this.setListItem(i);
            }
            else
            {
               View_XianGou_listItem(this["listItem" + i]).visible = false;
               Bitmap(this["noItemBM" + i]).visible = true;
            }
            i++;
         }
      }
      
      private function setListItem(_listID:int) : void
      {
         var id:int = int(Model_XianGou.ItemArr[_listID][0]);
         View_XianGou_listItem(this["listItem" + _listID]).id = id;
         View_XianGou_listItem(this["listItem" + _listID]).xiangou = Data_lib.xiangou[id][22] - Model_XianGou.ItemArr[_listID][1];
         View_XianGou_listItem(this["listItem" + _listID]).yuanjia = Data_lib.xiangou[id][20];
         View_XianGou_listItem(this["listItem" + _listID]).heishijia = Data_lib.xiangou[id][21];
         View_XianGou_listItem(this["listItem" + _listID]).kucun = Model_XianGou.ItemArr[_listID][2];
         View_XianGou_listItem(this["listItem" + _listID]).item = [[Data_lib.xiangou[id][1],Data_lib.xiangou[id][2],Data_lib.xiangou[id][3]],[Data_lib.xiangou[id][4],Data_lib.xiangou[id][5],Data_lib.xiangou[id][6]],[Data_lib.xiangou[id][7],Data_lib.xiangou[id][8],Data_lib.xiangou[id][9]],[Data_lib.xiangou[id][10],Data_lib.xiangou[id][11],Data_lib.xiangou[id][12]],[Data_lib.xiangou[id][13],Data_lib.xiangou[id][14],Data_lib.xiangou[id][15]]];
      }
      
      public function FlyToBag(_id:int) : void
      {
         var i:int = 0;
         while(i < 3)
         {
            if(this["listItem" + i].id == _id)
            {
               this["listItem" + i].FlyToBag();
            }
            i++;
         }
      }
      
      override public function resetPosition() : void
      {
         this.x = (Global.stage.stageWidth - this.width) / 2;
         this.y = (Global.stage.stageHeight - this.height) / 2;
      }
   }
}

