package com.yiTian.view.modules.FangXinHuiJia
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.net.message.cg.FangXinHuiJiaCGMessage;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_FangXinHuiJia_menu extends Panel123
   {
      
      private static var _instance:View_FangXinHuiJia_menu;
      
      private var getPrizeBtn:Button;
      
      public var icon:MainUIBtn;
      
      private var dayBmdt:Array;
      
      private var dayBm:Array;
      
      private var gridArray:Array;
      
      private var needTips:Boolean;
      
      private var blueDiamondBitmap:Bitmap;
      
      public function View_FangXinHuiJia_menu()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/FXHJ.swf","FXHJdm");
      }
      
      public static function get instance() : View_FangXinHuiJia_menu
      {
         if(!_instance)
         {
            _instance = new View_FangXinHuiJia_menu();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var day:int;
         var i:int = 0;
         var grid:View_Grid = null;
         var vo:Vo_valuable = null;
         var prizeString:Array = null;
         this.icon = new MainUIBtn("resource/image/FangXinHuiJia/icon.png");
         this.icon.addEventListener(MouseEvent.CLICK,this.onIconClick);
         move = new Rectangle(0,0,572,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":572,
            "height":356
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":25,
            "y":40,
            "width":522,
            "height":306
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":537,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_FXHJ",this,{
            "x":206,
            "y":5
         },Global.FXHJdm);
         ComponentUtil.getBitmap("Back_FXHJ",this,{
            "x":36,
            "y":50
         },Global.FXHJdm);
         ComponentUtil.getBitmap("Text_FHLB",this,{
            "x":53,
            "y":63
         },Global.FXHJdm);
         ComponentUtil.getBitmap("Text_XTian",this,{
            "x":364,
            "y":185
         },Global.FXHJdm);
         this.dayBmdt = [];
         this.dayBm = [];
         day = 0;
         while(day < 10)
         {
            this.dayBmdt.push(ComponentUtil.getBitmapData("Number_" + day,Global.FXHJdm));
            day++;
         }
         this.dayBm.push(ComponentUtil.getBitmap("Number_0",this,{
            "x":385,
            "y":170
         },Global.FXHJdm));
         this.dayBm.push(ComponentUtil.getBitmap("Number_0",this,{
            "x":385,
            "y":170
         },Global.FXHJdm));
         this.dayBm[0].visible = false;
         this.dayBm[1].visible = false;
         this.getPrizeBtn = ComponentUtil.getButton("","Button_HJLQ",this,{
            "x":440,
            "y":178,
            "textColor":16771436
         },Global.FXHJdm);
         ComponentUtil.getTextField(Data_lib.FangXinHuiJia[2][0] + "\n" + Data_lib.FangXinHuiJia[3][0],this,{
            "x":73,
            "y":248,
            "color":13631385,
            "size":12,
            "leading":3
         });
         ComponentUtil.getTextField(Data_lib.FangXinHuiJia[4][0],this,{
            "x":73,
            "y":288,
            "color":12910592,
            "size":13,
            "leading":0
         });
         CloseButton.callBack = function():void
         {
            visible = false;
         };
         this.getPrizeBtn.callBack = this.onGetPrizeBtnClick;
         this.getPrizeBtn.enabled = false;
         this.gridArray = [];
         i = 0;
         while(i < 4)
         {
            grid = new View_Grid(true);
            addChild(grid);
            this.gridArray.push(grid);
            grid.x = 57 + i * 73;
            grid.y = 140;
            grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
            grid.set_bmp_over(true,null);
            grid.set_tf_count();
            prizeString = Data_lib.FangXinHuiJia[1][i].split("_");
            if(prizeString[0] == 1)
            {
               vo = new Vo_item();
            }
            else
            {
               vo = new Vo_equip();
            }
            vo.id = prizeString[1];
            vo.count = prizeString[2];
            vo.Init_lib();
            grid.vo = vo;
            i++;
         }
         this.blueDiamondBitmap = ComponentUtil.getBitmap("Icon_LZZY",this,{
            "x":305,
            "y":124
         },Global.FXHJdm);
      }
      
      public function onIconClick(e:* = null) : void
      {
         FangXinHuiJiaCGMessage.CG_FangXinHuiJia_OPEN();
         this.visible = !this.visible;
      }
      
      private function onGetPrizeBtnClick(e:MouseEvent) : void
      {
         if(this.needTips)
         {
            View_Alert.show("<font color=\'#ffffff\'>您不是蓝钻用户，将不能领取蓝钻奖励</font><br/><font color=\'#00ff00\'>（续费蓝钻后，可领取下次蓝钻奖励）</font>",2,FangXinHuiJiaCGMessage.CG_FangXinHuiJia_GET_PRIZE,null,null,null,310,"","","center");
         }
         else
         {
            FangXinHuiJiaCGMessage.CG_FangXinHuiJia_GET_PRIZE();
         }
      }
      
      public function setData(show1:int, show2:int, day:int, btnStatus:int) : void
      {
         if(show1 == 2)
         {
            this.gridArray[0].visible = false;
            this.gridArray[1].visible = false;
            this.gridArray[2].visible = false;
         }
         else
         {
            this.gridArray[0].visible = true;
            this.gridArray[1].visible = true;
            this.gridArray[2].visible = true;
            if(show1 == 1)
            {
               this.gridArray[0].filters = [];
               this.gridArray[1].filters = [];
               this.gridArray[2].filters = [];
            }
            else
            {
               this.gridArray[0].filters = Util.disabled;
               this.gridArray[1].filters = Util.disabled;
               this.gridArray[2].filters = Util.disabled;
            }
         }
         if(show2 == 2)
         {
            this.gridArray[3].visible = false;
            this.blueDiamondBitmap.visible = false;
            this.gridArray[1].x = 166;
            this.gridArray[2].x = 276;
            this.needTips = false;
         }
         else
         {
            this.gridArray[3].visible = true;
            this.blueDiamondBitmap.visible = true;
            this.gridArray[1].x = 130;
            this.gridArray[2].x = 203;
            if(show2 == 1)
            {
               this.gridArray[3].filters = [];
               this.blueDiamondBitmap.filters = [];
               this.needTips = false;
            }
            else
            {
               this.gridArray[3].filters = Util.disabled;
               this.blueDiamondBitmap.filters = Util.disabled;
               this.needTips = true;
            }
         }
         var dayStr:String = day.toString();
         var dayStrLen:int = dayStr.length;
         switch(dayStrLen)
         {
            case 1:
               this.dayBm[0].visible = true;
               this.dayBm[1].visible = false;
               this.dayBm[0].x = 385;
               (this.dayBm[0] as Bitmap).bitmapData = this.dayBmdt[day];
               break;
            case 2:
               this.dayBm[0].visible = true;
               this.dayBm[1].visible = true;
               this.dayBm[0].x = 375;
               this.dayBm[1].x = 395;
               (this.dayBm[0] as Bitmap).bitmapData = this.dayBmdt[int(dayStr.charAt(0))];
               (this.dayBm[1] as Bitmap).bitmapData = this.dayBmdt[int(dayStr.charAt(1))];
         }
         this.getPrizeBtn.enabled = btnStatus == 1 ? true : false;
      }
   }
}

