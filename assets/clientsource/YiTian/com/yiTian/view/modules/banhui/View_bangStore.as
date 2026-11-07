package com.yiTian.view.modules.banhui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_bangStore extends Panel
   {
      
      private static var isFirstOpen:Boolean = true;
      
      private var Button_PageUp:Button;
      
      private var Button_PageDown:Button;
      
      private var GRGongXian_text:MyTextField;
      
      private var Page_text:MyTextField;
      
      private var _currentPageIndex:int = 1;
      
      private var itemVec:Vector.<View_bangStoreItems>;
      
      public function View_bangStore()
      {
         super();
      }
      
      public function get currentPageIndex() : int
      {
         return this._currentPageIndex;
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var storeItem:View_bangStoreItems = null;
         var back1:ScaleBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":604,
            "height":333
         },Global.Img_Cdm);
         var back2:ScaleBitmap = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":556,
            "height":283
         },Global.Img_Cdm);
         var back3:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":483,
            "y":295,
            "width":60,
            "height":20
         },Global.Img_Cdm);
         move = new Rectangle(0,0,557,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":570,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_PageUp = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":463,
            "y":295,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_PageDown = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":543,
            "y":295,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_PageUp.name = "minus";
         this.Button_PageDown.name = "add";
         ComponentUtil.getTextField(LangConfig.getWord("60031",6),this,{
            "x":37,
            "y":295,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.GRGongXian_text = ComponentUtil.getTextField("0",this,{
            "x":331,
            "y":295,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.Page_text = ComponentUtil.getTextField("1/1",this,{
            "x":502,
            "y":295,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.itemVec = new Vector.<View_bangStoreItems>();
         i = 0;
         while(i < 9)
         {
            storeItem = new View_bangStoreItems();
            storeItem.x = 34 + 183 * int(i % 3);
            storeItem.y = 49 + 83 * int(i / 3);
            addChild(storeItem);
            this.itemVec.push(storeItem);
            i++;
         }
         this.Button_PageUp.callBack = this.pageUpClickHandleHandle;
         this.Button_PageDown.callBack = this.pageDownClickHandle;
         this.update(1);
      }
      
      public function updateByModel(pageIndex:int) : void
      {
         if(pageIndex == -1)
         {
            this.update(this._currentPageIndex);
         }
         else
         {
            this.update(pageIndex);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         this.GRGongXian_text.text = Model_bang.partyInfo.party_self_gong.toString();
         super.visible = value;
         if(value)
         {
            if(isFirstOpen)
            {
               isFirstOpen = false;
               ComponentUtil.getBitmap("Title_BangStore",this,{
                  "x":222,
                  "y":5
               },Global.Bang_Imgsdm);
            }
         }
      }
      
      public function updateGong() : void
      {
         this.GRGongXian_text.text = Model_bang.partyInfo.party_self_gong.toString();
      }
      
      private function pageUpClickHandleHandle(evt:MouseEvent) : void
      {
         this.update(this._currentPageIndex - 1);
      }
      
      private function pageDownClickHandle(evt:MouseEvent) : void
      {
         this.update(this._currentPageIndex + 1);
      }
      
      private function update(pageIndex:int) : void
      {
         if(pageIndex < 1)
         {
            return;
         }
         var dataArr:Array = Model_bang.bangShopSellItemArr;
         if(dataArr.length == 0)
         {
            return;
         }
         var pageCount:int = int(dataArr.length / 9) + 1;
         if(dataArr.length % 9 == 0)
         {
            pageCount -= 1;
         }
         if(pageIndex > pageCount)
         {
            return;
         }
         this.Page_text.text = pageIndex.toString() + "/" + pageCount;
         this._currentPageIndex = pageIndex;
         var dataIndex:int = pageIndex - 1;
         var index:int = 0;
         while(index < 9)
         {
            this.itemVec[index].vo = dataArr[dataIndex * 9 + index];
            index++;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

