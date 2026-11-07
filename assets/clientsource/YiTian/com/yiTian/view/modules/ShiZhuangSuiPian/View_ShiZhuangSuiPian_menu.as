package com.yiTian.view.modules.ShiZhuangSuiPian
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_ShiZhuangSuiPian;
   import com.yiTian.data.model.Model_ShiZhuangSuiPian;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_ShiZhuangSuiPian_menu extends Panel123
   {
      
      private static var _instance:View_ShiZhuangSuiPian_menu;
      
      private var closeBtn:Button;
      
      private var prevBtn:Button;
      
      private var nextBtn:Button;
      
      private var pageTxt:MyTextField;
      
      private var totalPage:int;
      
      private var curPage:int;
      
      private var myPiecesTxt:MyTextField;
      
      private var itemListArray:Array;
      
      public function View_ShiZhuangSuiPian_menu()
      {
         super();
         if(!_instance)
         {
            regResource("lang/ch/SuiPian_Imgs.swf","SuiPian_Imgsdm");
         }
      }
      
      public static function get instance() : View_ShiZhuangSuiPian_menu
      {
         if(!_instance)
         {
            _instance = new View_ShiZhuangSuiPian_menu();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var count:int;
         var i:int = 0;
         var j:* = undefined;
         var item:ShiZhuangSuiPian_itemList = null;
         move = new Rectangle(0,0,473,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":473,
            "height":445
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":425,
            "height":395
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":34,
            "y":50,
            "width":405,
            "height":345
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":201,
            "y":403,
            "width":68,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_SZDuiHuan",this,{
            "x":156,
            "y":5
         },Global.SuiPian_Imgsdm);
         ComponentUtil.getTextField("时装碎片：",this,{
            "x":34,
            "y":406,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.myPiecesTxt = ComponentUtil.getTextField("",this,{
            "x":99,
            "y":406,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.curPage = 0;
         this.itemListArray = [];
         i = 0;
         while(i < 10)
         {
            item = new ShiZhuangSuiPian_itemList();
            item.id = i;
            item.x = i % 2 == 0 ? 44 : 240;
            item.y = int(i / 2) * 66 + 60;
            item.setItem(i,this.curPage);
            this.addChild(item);
            this.itemListArray.push(item);
            i++;
         }
         this.prevBtn = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":175,
            "y":405,
            "textColor":16184781
         },Global.Img_Cdm);
         this.prevBtn.enabled = false;
         this.prevBtn.callBack = this.onTurnPage;
         this.nextBtn = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":274,
            "y":405,
            "textColor":16184781
         },Global.Img_Cdm);
         this.nextBtn.callBack = this.onTurnPage;
         count = 0;
         for(j in Data_lib.ShiZhuangSuiPian)
         {
            count++;
         }
         this.totalPage = Math.ceil(count / 10);
         if(this.curPage == this.totalPage - 1)
         {
            this.nextBtn.enabled = false;
         }
         this.pageTxt = ComponentUtil.getTextField("00/00",this,{
            "x":234,
            "y":406,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.pageTxt.autoSize = "center";
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":439,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.closeBtn.callBack = function():void
         {
            visible = false;
         };
         Global.control.registerCallBack(Enum_ShiZhuangSuiPian.CLICK_GRID,this.onCLickGrid);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.format();
         }
      }
      
      private function onCLickGrid(e:int) : void
      {
         var i:* = undefined;
         for(i in this.itemListArray)
         {
            if(this.itemListArray[i].grid)
            {
               if(i == e)
               {
                  this.itemListArray[i].grid.bSelect = true;
               }
               else
               {
                  this.itemListArray[i].grid.bSelect = false;
               }
            }
         }
         View_ShiZhuangSuiPian_buyMenu.instance.Show(this.curPage * 10 + e);
      }
      
      public function UpdatePieces() : void
      {
         this.myPiecesTxt.text = Model_ShiZhuangSuiPian.myPiecesCount.toString();
      }
      
      private function format() : void
      {
         var i:* = undefined;
         this.curPage = 0;
         this.pageTxt.text = this.curPage + 1 + "/" + this.totalPage;
         this.prevBtn.enabled = false;
         if(this.curPage == this.totalPage - 1)
         {
            this.nextBtn.enabled = false;
         }
         else
         {
            this.nextBtn.enabled = true;
         }
         for(i in this.itemListArray)
         {
            this.itemListArray[i].setItem(i,this.curPage);
         }
      }
      
      private function onTurnPage(e:MouseEvent) : void
      {
         if(e.currentTarget == this.prevBtn)
         {
            if(!this.nextBtn.enabled)
            {
               this.nextBtn.enabled = true;
            }
            --this.curPage;
            if(this.curPage == 0)
            {
               this.prevBtn.enabled = false;
            }
         }
         else if(e.currentTarget == this.nextBtn)
         {
            if(!this.prevBtn.enabled)
            {
               this.prevBtn.enabled = true;
            }
            ++this.curPage;
            if(this.curPage == this.totalPage - 1)
            {
               this.nextBtn.enabled = false;
            }
         }
         this.pageTxt.text = this.curPage + 1 + "/" + this.totalPage;
         var i:int = 0;
         while(i < 10)
         {
            this.itemListArray[i].setItem(i,this.curPage);
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

