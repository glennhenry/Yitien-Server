package com.yiTian.view.modules.XiaoFeiPaiHang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_XiaoFeiPaiHang;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.ChongZhiPaiHang.ItemList;
   import com.yiTian.view.modules.activityGuide.Enum_ActivityGuide;
   import com.yiTian.view.modules.activityGuide.Model_ActivityGuide;
   import flash.geom.Rectangle;
   
   public class View_XiaoFeiPaiHang_menu extends Panel123
   {
      
      private static var _instance:View_XiaoFeiPaiHang_menu;
      
      private var startTime:int;
      
      private var endTime:int;
      
      private var timeTxt:MyTextField;
      
      private var grid0_array:Array;
      
      private var grid1_array:Array;
      
      private var grid2_array:Array;
      
      private var grid3_array:Array;
      
      private var itemLisi_0:ItemList;
      
      private var itemLisi_1:ItemList;
      
      private var itemLisi_2:ItemList;
      
      private var itemLisi_3:ItemList;
      
      private var itemLisi_4:ItemList;
      
      private var itemLisi_5:ItemList;
      
      private var itemLisi_6:ItemList;
      
      private var itemLisi_7:ItemList;
      
      private var itemLisi_8:ItemList;
      
      private var itemLisi_9:ItemList;
      
      private var curPage:int;
      
      private var pageTxt:MyTextField;
      
      private var nextBtn:Button;
      
      private var prevBtn:Button;
      
      private var closeBtn:Button;
      
      public function View_XiaoFeiPaiHang_menu()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/ChongZhiRank.swf","ChongZhiRankdm");
         this.curPage = 0;
      }
      
      public static function get instance() : View_XiaoFeiPaiHang_menu
      {
         if(!_instance)
         {
            _instance = new View_XiaoFeiPaiHang_menu();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var arrayId:int;
         var i:int;
         var row:int = 0;
         var grid:View_Grid = null;
         var ef:Effect = null;
         var grid2:View_Grid = null;
         var vo:Vo_equip = null;
         var numItem:int = 0;
         var id:int = 0;
         var grid3:View_Grid = null;
         var ids:int = 0;
         var vo2:Vo_item = null;
         var vo3:Vo_equip = null;
         var j:* = undefined;
         move = new Rectangle(0,0,839,430);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":839,
            "height":430
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":791,
            "height":380
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
            "x":34,
            "y":88,
            "width":520,
            "height":90
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("ListBack",this,{
            "x":34,
            "y":222
         },Global.ChongZhiRankdm);
         ComponentUtil.getBitmap("ListBack",this,{
            "x":34,
            "y":270
         },Global.ChongZhiRankdm);
         ComponentUtil.getBitmap("ListBack",this,{
            "x":34,
            "y":318
         },Global.ChongZhiRankdm);
         ComponentUtil.getBitmap("ListBack",this,{
            "x":34,
            "y":366
         },Global.ChongZhiRankdm);
         ComponentUtil.getBitmap("Text_01",this,{
            "x":44,
            "y":234
         },Global.ChongZhiRankdm);
         ComponentUtil.getBitmap("Text_02",this,{
            "x":44,
            "y":282
         },Global.ChongZhiRankdm);
         ComponentUtil.getBitmap("Text_02",this,{
            "x":44,
            "y":330
         },Global.ChongZhiRankdm);
         ComponentUtil.getBitmap("Text_03",this,{
            "x":44,
            "y":378
         },Global.ChongZhiRankdm);
         ComponentUtil.getBitmap("Title_JiangLi",this,{
            "x":24,
            "y":184
         },Global.ChongZhiRankdm);
         ComponentUtil.getBitmap("Title_MiaoShu",this,{
            "x":24,
            "y":50
         },Global.ChongZhiRankdm);
         ComponentUtil.getScaleBitmap("Back_XFRank",[226,52,2,6],this,{
            "x":569,
            "y":50,
            "width":236,
            "height":362
         },Global.ChongZhiRankdm);
         ComponentUtil.getTextField("整点刷新排行榜",this,{
            "x":685,
            "y":101,
            "color":16764206,
            "size":12,
            "leading":0,
            "autoSize":"center"
         });
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":659,
            "y":383,
            "width":56,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getTextField("活动详情：\n活动时间：\n领奖时间：",this,{
            "x":49,
            "y":98,
            "color":11523767,
            "size":12,
            "leading":5
         });
         this.timeTxt = ComponentUtil.getTextField("",this,{
            "x":114,
            "y":98,
            "color":15397533,
            "size":12,
            "leading":5,
            "multiline":true
         });
         ComponentUtil.getBitmap("Title_XFRank",this,{
            "x":339,
            "y":5
         },Global.ChongZhiRankdm);
         ComponentUtil.getTextField(String(Data_lib.XiaoFeiPaiHang[1][0]),this,{
            "x":125,
            "y":230,
            "color":16710164,
            "size":18,
            "leading":0,
            "autoSize":"center"
         });
         ComponentUtil.getTextField(String(Data_lib.XiaoFeiPaiHang[2][0]).split("_")[0],this,{
            "x":125,
            "y":278,
            "color":16710164,
            "size":18,
            "leading":0,
            "autoSize":"center"
         });
         ComponentUtil.getTextField(String(Data_lib.XiaoFeiPaiHang[2][0]).split("_")[1],this,{
            "x":161,
            "y":278,
            "color":16710164,
            "size":18,
            "leading":0,
            "autoSize":"center"
         });
         ComponentUtil.getTextField(String(Data_lib.XiaoFeiPaiHang[3][0]).split("_")[0],this,{
            "x":125,
            "y":326,
            "color":16710164,
            "size":18,
            "leading":0,
            "autoSize":"center"
         });
         ComponentUtil.getTextField(String(Data_lib.XiaoFeiPaiHang[3][0]).split("_")[1],this,{
            "x":161,
            "y":326,
            "color":16710164,
            "size":18,
            "leading":0,
            "autoSize":"center"
         });
         ComponentUtil.getTextField(String(Data_lib.XiaoFeiPaiHang[4][0]).split("_")[0],this,{
            "x":130,
            "y":374,
            "color":16710164,
            "size":18,
            "leading":0,
            "autoSize":"center"
         });
         ComponentUtil.getTextField(String(Data_lib.XiaoFeiPaiHang[4][0]).split("_")[1],this,{
            "x":174,
            "y":374,
            "color":16710164,
            "size":18,
            "leading":0,
            "autoSize":"center"
         });
         row = 0;
         while(row < 4)
         {
            this["grid" + row + "_array"] = [];
            if(Data_lib.XiaoFeiPaiHang[row + 1][1] != 0)
            {
               grid = this.creatGrid();
               ComponentUtil.getBitmap("YuanBao",grid,null,Global.ChongZhiRankdm);
               this["grid" + row + "_array"].push(grid);
               TipManager.bind(grid,"返利消费元宝的" + Data_lib.XiaoFeiPaiHang[row + 1][1] * 100 + "%");
               if(Data_lib.XiaoFeiPaiHang[row + 1][1] * 100 == 5)
               {
                  ef = EffectManager.addEffect("35180",grid,1000,43,43,true);
                  ef.scaleX = 0.5;
                  ef.scaleY = 0.5;
               }
            }
            if(Data_lib.XiaoFeiPaiHang[row + 1][2] != 0)
            {
               grid2 = this.creatGrid();
               vo = new Vo_equip();
               if(GameUnitManager.hero.sex == 1)
               {
                  vo.id = Data_lib.XiaoFeiPaiHang[row + 1][2].split(",")[0].split("_")[1];
               }
               else
               {
                  vo.id = Data_lib.XiaoFeiPaiHang[row + 1][2].split(",")[1].split("_")[1];
               }
               vo.Init_lib();
               grid2.vo = vo;
               grid2.type = Enum_type_grid.STORE;
               this["grid" + row + "_array"].push(grid2);
               if(row != 3)
               {
                  ef = EffectManager.addEffect("35180",grid2,1000,43,43,true);
                  ef.scaleX = 0.5;
                  ef.scaleY = 0.5;
               }
            }
            if(Data_lib.XiaoFeiPaiHang[row + 1][3] != 0)
            {
               numItem = int(Data_lib.XiaoFeiPaiHang[row + 1][3].split(",").length);
               id = 0;
               while(id < numItem)
               {
                  grid3 = this.creatGrid();
                  ids = int(Data_lib.XiaoFeiPaiHang[row + 1][3].split(",")[id].split("_")[1]);
                  if(Data_lib.XiaoFeiPaiHang[row + 1][3].split(",")[id].split("_")[0] == 1)
                  {
                     vo2 = new Vo_item();
                     vo2.id = ids;
                     vo2.Init_lib();
                     grid3.vo = vo2;
                  }
                  else
                  {
                     vo3 = new Vo_equip();
                     vo3.id = ids;
                     vo3.Init_lib();
                     grid3.vo = vo3;
                  }
                  if([41006,41016,41086,41026].indexOf(ids) != -1)
                  {
                     ef = EffectManager.addEffect("35180",grid3,1000,43,43,true);
                     ef.scaleX = 0.5;
                     ef.scaleY = 0.5;
                  }
                  grid3.count = Data_lib.XiaoFeiPaiHang[row + 1][3].split(",")[id].split("_")[2];
                  this["grid" + row + "_array"].push(grid3);
                  id++;
               }
            }
            row++;
         }
         arrayId = 0;
         while(arrayId < 4)
         {
            this["grid" + arrayId + "_array"].reverse();
            for(j in this["grid" + arrayId + "_array"])
            {
               this["grid" + arrayId + "_array"][j].x = 468 - 45 * j;
               this["grid" + arrayId + "_array"][j].y = 228 + 48 * arrayId;
               this.addChild(this["grid" + arrayId + "_array"][j]);
            }
            arrayId++;
         }
         i = 0;
         while(i < 10)
         {
            this["itemLisi_" + i] = new ItemList();
            this["itemLisi_" + i].x = 575;
            this["itemLisi_" + i].y = 123 + 26 * i;
            addChild(this["itemLisi_" + i]);
            i++;
         }
         this.prevBtn = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":636,
            "y":384,
            "textColor":16184781
         },Global.Img_Cdm);
         this.prevBtn.callBack = this.prevPage;
         this.prevBtn.enabled = false;
         this.nextBtn = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":718,
            "y":384,
            "textColor":16184781
         },Global.Img_Cdm);
         this.nextBtn.callBack = this.nextPage;
         this.pageTxt = ComponentUtil.getTextField("00/00",this,{
            "x":669,
            "y":385,
            "color":15397533,
            "size":12,
            "leading":0
         });
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":805,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.closeBtn.callBack = function():void
         {
            _instance.visible = false;
         };
      }
      
      private function prevPage(e:*) : void
      {
         --this.curPage;
         this.UpdateCurrentPage();
      }
      
      private function nextPage(e:*) : void
      {
         ++this.curPage;
         this.UpdateCurrentPage();
      }
      
      private function updateCurrentPageTxt() : void
      {
         this.pageTxt.text = String(this.curPage + 1) + "/" + Model_XiaoFeiPaiHang.totalPege;
      }
      
      private function updateButton() : void
      {
         if(Model_XiaoFeiPaiHang.totalPege < 2)
         {
            this.nextBtn.enabled = false;
            this.prevBtn.enabled = false;
         }
         else if(this.curPage == 0)
         {
            this.prevBtn.enabled = false;
            this.nextBtn.enabled = true;
         }
         else
         {
            this.prevBtn.enabled = true;
            if(this.curPage == Model_XiaoFeiPaiHang.totalPege - 1)
            {
               this.nextBtn.enabled = false;
            }
            else
            {
               this.nextBtn.enabled = true;
            }
         }
      }
      
      public function UpdateCurrentPage() : void
      {
         var i:int = 0;
         while(i < 10)
         {
            if(Boolean(Model_XiaoFeiPaiHang.array[i + this.curPage * 10]))
            {
               this["itemLisi_" + i].setItemList(i + 1 + this.curPage * 10,Model_XiaoFeiPaiHang.array[i * 3 + this.curPage * 30],Model_XiaoFeiPaiHang.array[i * 3 + 1 + this.curPage * 30],Model_XiaoFeiPaiHang.array[i * 3 + 2 + this.curPage * 30]);
            }
            else
            {
               this["itemLisi_" + i].setItemList();
            }
            i++;
         }
         this.updateCurrentPageTxt();
         this.updateButton();
         this.updateTimer();
      }
      
      private function updateTimer() : void
      {
         var temp:Array = Model_ActivityGuide.getStartTimeById(Enum_ActivityGuide.XIAOFEIPAIHANG);
         var timeStr:String = "<font color=\'#00ff00\'>" + temp[0] + "-" + temp[1] + "</font>";
         this.timeTxt.htmlText = "活动时间，玩家在本服消费后会列入消费排行榜，前100名均可获得奖励<br/>" + timeStr + "<br/>" + "活动结束30分钟后通过<font color=\'#00ff00\'>邮件</font>发送";
      }
      
      private function creatGrid() : View_Grid
      {
         var grid:View_Grid = new View_Grid();
         grid.isAutoLoad = true;
         grid.set_bmp_bg();
         grid.set_bmp_over();
         grid.set_tf_count();
         return grid;
      }
   }
}

