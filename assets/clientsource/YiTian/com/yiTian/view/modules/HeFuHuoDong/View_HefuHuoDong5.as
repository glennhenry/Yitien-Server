package com.yiTian.view.modules.HeFuHuoDong
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_HeFuHuoDong;
   import com.yiTian.data.model.Model_HeFuHuoDong;
   import com.yiTian.net.message.cg.HeFuHuoDongCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import flash.display.Sprite;
   
   public class View_HefuHuoDong5 extends Sprite
   {
      
      private static var _instance:View_HefuHuoDong5;
      
      private var haveOnlineTime:MyTextField;
      
      private var keepOnlineTime:MyTextField;
      
      private var YaoJiangBtn:Button;
      
      private var YaoJiangGetBtn:Button;
      
      private var YaoJiangGrid:Array;
      
      private var remainingTimes:MyTextField;
      
      private var nowDay:MyTextField;
      
      private var LiQuanGetBtn:Button;
      
      private var todayLeiJiZaiXianTime:MyTextField;
      
      private var nowLiQuan:MyTextField;
      
      private var haveGet:MyTextField;
      
      private var gridRunCompleteFlag:Array;
      
      public function View_HefuHuoDong5()
      {
         super();
         this.Init();
      }
      
      public static function get instance() : View_HefuHuoDong5
      {
         if(!_instance)
         {
            _instance = new View_HefuHuoDong5();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         var itemArray:Array;
         var key:* = undefined;
         var i:int = 0;
         var grid:Grid_run = null;
         ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
            "x":0,
            "y":230,
            "width":744,
            "height":210
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":72,
            "y":315,
            "width":544,
            "height":80
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
            "x":0,
            "y":10,
            "width":744,
            "height":210
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Text_Back",this,{
            "x":2,
            "y":10
         },Global.HeFu_Imgsdm);
         ComponentUtil.getTextField("今日已保持在线：",this,{
            "x":20,
            "y":70,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("活动时间：",this,{
            "x":20,
            "y":290,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(DateUtil.getYMDHM(Model_HeFuHuoDong.startTime) + " 至 " + DateUtil.getYMDHM(Model_HeFuHuoDong.endTime),this,{
            "x":80,
            "y":290,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("注：活动期间，每小时在线可累计获得          ，每天最多可以累计兑换4小时。",this,{
            "x":327,
            "y":405,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Text_Back",this,{
            "x":2,
            "y":230
         },Global.HeFu_Imgsdm);
         ComponentUtil.getBitmap("Text_ZaiXian",this,{
            "x":89,
            "y":20
         },Global.HeFu_Imgsdm);
         ComponentUtil.getBitmap("Text_ZaiXian_LiQuan",this,{
            "x":89,
            "y":240
         },Global.HeFu_Imgsdm);
         ComponentUtil.getTextField("继续保持在线           ，可以获得一次抽取机会，每天最多5次。",this,{
            "x":255,
            "y":70,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Back_YaoJiang",this,{
            "x":125,
            "y":100
         },Global.HeFu_Imgsdm);
         ComponentUtil.getTextField("剩余抽取次数",this,{
            "x":495,
            "y":117,
            "color":13424242,
            "size":18,
            "leading":0
         });
         ComponentUtil.getTextField("活动时间：",this,{
            "x":444,
            "y":189,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(DateUtil.getYMDHM(Model_HeFuHuoDong.startTime) + " 至 " + DateUtil.getYMDHM(Model_HeFuHuoDong.endTime),this,{
            "x":504,
            "y":189,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("今日累计在线时间：",this,{
            "x":122,
            "y":330,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("当前可领取礼券：",this,{
            "x":122,
            "y":360,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("已领取礼券：",this,{
            "x":452,
            "y":360,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("20礼券",this,{
            "x":532,
            "y":405,
            "color":327424,
            "size":12,
            "leading":0
         });
         this.haveOnlineTime = ComponentUtil.getTextField("00小时00分钟",this,{
            "x":118,
            "y":70,
            "color":327424,
            "size":12,
            "leading":0
         });
         this.keepOnlineTime = ComponentUtil.getTextField("000分钟",this,{
            "x":327,
            "y":70,
            "color":327424,
            "size":12,
            "leading":0
         });
         this.remainingTimes = ComponentUtil.getTextField("00",this,{
            "x":609,
            "y":117,
            "color":16383744,
            "size":18,
            "leading":0
         });
         this.nowDay = ComponentUtil.getTextField("（当前活动第0天）",this,{
            "x":301,
            "y":291,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.todayLeiJiZaiXianTime = ComponentUtil.getTextField("00小时00分",this,{
            "x":230,
            "y":330,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.nowLiQuan = ComponentUtil.getTextField("000",this,{
            "x":218,
            "y":360,
            "color":16383744,
            "size":12,
            "leading":0
         });
         this.haveGet = ComponentUtil.getTextField("0000",this,{
            "x":524,
            "y":360,
            "color":16383744,
            "size":12,
            "leading":0
         });
         this.LiQuanGetBtn = ComponentUtil.getButton("领取奖励","Button_TwoBule91",this,{
            "x":230,
            "y":400,
            "textColor":16184781
         },Global.Img_Cdm);
         this.LiQuanGetBtn.callBack = function():void
         {
            HeFuHuoDongCGMessage.CG_ZaiXian_GET(2);
         };
         this.YaoJiangGetBtn = ComponentUtil.getButton("领取奖励","Button_TwoBule91",this,{
            "x":230,
            "y":184,
            "textColor":16184781
         },Global.Img_Cdm);
         this.YaoJiangGetBtn.enabled = false;
         this.YaoJiangGetBtn.callBack = function():void
         {
            HeFuHuoDongCGMessage.CG_ZaiXian_GET(1);
         };
         this.YaoJiangBtn = ComponentUtil.getButton("","Button_YaoJiang",this,{
            "x":416,
            "y":111,
            "textColor":16184781
         },Global.HeFu_Imgsdm);
         this.YaoJiangBtn.callBack = function():void
         {
            HeFuHuoDongCGMessage.CG_ZaiXian_YaoJiang();
         };
         itemArray = [];
         for(key in Data_lib.zaixianchoujiang)
         {
            itemArray.push(Data_lib.zaixianchoujiang[key][6]);
         }
         this.YaoJiangGrid = [];
         i = 0;
         while(i < 5)
         {
            grid = new Grid_run(i,itemArray);
            grid.x = 158 + i * 49;
            grid.y = 124;
            addChild(grid);
            this.YaoJiangGrid.push(grid);
            i++;
         }
         this.gridRunCompleteFlag = [0,0,0,0,0];
         Global.control.registerCallBack(Enum_HeFuHuoDong.GRID_RUN_COMPLETE,this.onGridRunComplete);
      }
      
      public function updateMenu() : void
      {
         trace("Model_HeFuHuoDong.arr5[0]>>",Model_HeFuHuoDong.arr5[0]);
         this.haveOnlineTime.text = int(Model_HeFuHuoDong.arr5[0] / 3600) + "小时" + int(Model_HeFuHuoDong.arr5[0] / 60 % 60) + "分钟";
         this.keepOnlineTime.text = int(Model_HeFuHuoDong.arr5[1] / 60) + "分钟";
         this.remainingTimes.text = String(Model_HeFuHuoDong.arr5[5]);
         this.nowDay.text = "（当前活动第" + Model_HeFuHuoDong.arr5[6] + "天）";
         if(Model_HeFuHuoDong.arr5[0] <= 14400)
         {
            this.todayLeiJiZaiXianTime.text = this.haveOnlineTime.text;
         }
         else
         {
            this.todayLeiJiZaiXianTime.text = "4小时00分钟";
         }
         this.nowLiQuan.text = String(Model_HeFuHuoDong.arr5[2]);
         this.haveGet.text = String(Model_HeFuHuoDong.arr5[3]);
         if(Boolean(Model_HeFuHuoDong.arr5[7]))
         {
            this.YaoJiangGetBtn.enabled = true;
            this.YaoJiangBtn.enabled = false;
         }
         else
         {
            this.YaoJiangGetBtn.enabled = false;
            if(Boolean(Model_HeFuHuoDong.arr5[5]))
            {
               this.YaoJiangBtn.enabled = true;
            }
            else
            {
               this.YaoJiangBtn.enabled = false;
            }
         }
         if(Boolean(Model_HeFuHuoDong.arr5[2]))
         {
            this.LiQuanGetBtn.enabled = true;
         }
         else
         {
            this.LiQuanGetBtn.enabled = false;
         }
         this.updateYaoJiang();
      }
      
      private function updateYaoJiang() : void
      {
         var i:* = undefined;
         for(i in this.YaoJiangGrid)
         {
            if(Boolean(Model_HeFuHuoDong.arr5[7]))
            {
               this.YaoJiangGrid[i].setItem(Data_lib.zaixianchoujiang[Model_HeFuHuoDong.arr5[8][i]][6]);
            }
            else if(Boolean(Model_HeFuHuoDong.arr5[5]))
            {
               this.YaoJiangGrid[i].setYaoJiang(1);
            }
            else
            {
               this.YaoJiangGrid[i].setYaoJiang(0);
            }
         }
      }
      
      private function onGridRunComplete(e:int) : void
      {
         var i:* = undefined;
         this.gridRunCompleteFlag[e] = 1;
         for(i in this.gridRunCompleteFlag)
         {
            if(this.gridRunCompleteFlag[i] != 1)
            {
               return;
            }
         }
         this.gridRunCompleteFlag = [0,0,0,0,0];
         this.runEnd();
      }
      
      private function runEnd() : void
      {
         this.YaoJiangGetBtn.enabled = true;
      }
      
      public function StartRun() : void
      {
         var i:* = undefined;
         if(!this.YaoJiangBtn.enabled)
         {
            return;
         }
         this.YaoJiangBtn.enabled = false;
         this.remainingTimes.text = String(Model_HeFuHuoDong.arr5[5]);
         for(i in this.YaoJiangGrid)
         {
            this.YaoJiangGrid[i].Run(Data_lib.zaixianchoujiang[Model_HeFuHuoDong.arr5[8][i]][6]);
         }
      }
      
      public function YaoJiangGetComplete() : void
      {
         var i:* = undefined;
         this.YaoJiangGetBtn.enabled = false;
         for(i in this.YaoJiangGrid)
         {
            if(Model_HeFuHuoDong.arr5[5] > 0)
            {
               this.YaoJiangGrid[i].setYaoJiang(1);
            }
            else
            {
               this.YaoJiangGrid[i].setYaoJiang(0);
            }
         }
         if(Model_HeFuHuoDong.arr5[5] > 0)
         {
            this.YaoJiangBtn.enabled = true;
         }
      }
      
      public function LiQuanGetComplete() : void
      {
         this.LiQuanGetBtn.enabled = false;
         this.nowLiQuan.text = "0";
         this.haveGet.text = String(Model_HeFuHuoDong.arr5[3]);
      }
      
      public function FlyToBag() : void
      {
         var i:* = undefined;
         for(i in this.YaoJiangGrid)
         {
            if(Boolean(this.YaoJiangGrid[i].curGrid))
            {
               trace("***",this.YaoJiangGrid[i].curGrid.vo.str_name);
               ComboTweenStep.toBag(this.YaoJiangGrid[i].curGrid);
            }
         }
      }
   }
}

