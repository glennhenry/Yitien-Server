package com.yiTian.view.modules.retrieExp
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.specialBtnDill.Model_specialD;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_retrieExp extends Panel123
   {
      
      private var bg:ScaleBitmap;
      
      private var titleBg:Bitmap;
      
      private var itemVec:Vector.<Child_retrieExp>;
      
      private var btn_prePage:Button;
      
      private var btn_nextPage:Button;
      
      private var tf_pageInfo:MyTextField;
      
      private var dataArr:Array;
      
      private const itemCount:int = 9;
      
      private const rol:int = 3;
      
      private var isFirstOpen:Boolean = true;
      
      private var _curPage:int = 0;
      
      private var _maxPage:int = 1;
      
      public function View_retrieExp()
      {
         super();
         regResource(Enum_retrieExp.RETRIESOURCE,"JYZH_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":768,
            "height":475
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":720,
            "height":400
         },Global.Img_Cdm);
         var objArr:Array = [{
            "x":34,
            "y":50
         },{
            "x":504,
            "y":50
         },{
            "x":34,
            "y":177
         },{
            "x":269,
            "y":50
         },{
            "x":34,
            "y":304
         },{
            "x":269,
            "y":177
         },{
            "x":269,
            "y":304
         },{
            "x":504,
            "y":304
         },{
            "x":504,
            "y":177
         }];
         var len:int = int(objArr.length);
         var i:int = 0;
         while(i < len)
         {
            ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
               "x":objArr[i].x,
               "y":objArr[i].y,
               "width":230,
               "height":122
            },Global.Img_Cdm).bitmapData;
            i += 1;
         }
         move = new Rectangle(0,0,768,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":734,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":340,
            "y":445,
            "width":87,
            "height":20
         },Global.Img_Cdm);
         this.btn_prePage = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":318,
            "y":445,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_nextPage = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":429,
            "y":445,
            "textColor":16184781
         },Global.Img_Cdm);
         this.tf_pageInfo = ComponentUtil.getTextField("",this,{
            "x":353.5,
            "y":446,
            "width":61,
            "realWidth":61
         });
         this.tf_pageInfo.autoSize = TextFieldAutoSize.CENTER;
         super.initDynamicView();
         this.createItem(9);
         this.btn_prePage.callBack = this.preClickHandle;
         this.btn_nextPage.callBack = this.nextClickHande;
         this.titleBg = ComponentUtil.getBitmap("Title_JYZH",this,{
            "x":304,
            "y":5
         },Global.JYZH_Imgsdm);
      }
      
      private function createItem(num:int) : void
      {
         var posY1:Number = NaN;
         var offsetY:Number = NaN;
         var index:int = 0;
         var item:Child_retrieExp = null;
         this.itemVec = new Vector.<Child_retrieExp>();
         posY1 = 50;
         offsetY = 127;
         index = 0;
         while(index < this.itemCount)
         {
            item = new Child_retrieExp();
            item.x = 34 + index % this.rol * 235;
            item.y = posY1 + int(index / this.rol) * offsetY;
            this.itemVec.push(item);
            addChild(item);
            index++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            super.visible = value;
         }
         else
         {
            Model_specialD.visFalseComp(this,UIManager.smallMap.Button_Gu,this.superHide,1);
         }
      }
      
      private function superHide() : void
      {
         super.visible = false;
      }
      
      private function preClickHandle(evt:MouseEvent) : void
      {
         this.setPage(this._curPage - 1);
      }
      
      private function nextClickHande(evt:MouseEvent) : void
      {
         this.setPage(this._curPage + 1);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2 - 140;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      private function setPage(index:int) : void
      {
         var i:int = 0;
         var item:Child_retrieExp = null;
         this._maxPage = int(this.dataArr.length / 9);
         if(this.dataArr.length > 0 && this.dataArr.length % 9 == 0)
         {
            this._maxPage -= 1;
         }
         if(index < 0)
         {
            this.setPage(0);
            return;
         }
         if(index > this._maxPage)
         {
            this.setPage(this._maxPage);
            return;
         }
         this.tf_pageInfo.text = (index + 1).toString() + "/" + (this._maxPage + 1).toString();
         this._curPage = index;
         if(this.dataArr == null || this.dataArr.length == 0)
         {
            for each(item in this.itemVec)
            {
               item.vo = null;
            }
            return;
         }
         var length:int = int(this.itemVec.length);
         while(i < length)
         {
            this.itemVec[i].vo = this.dataArr[index * length + i];
            i++;
         }
      }
      
      public function update() : void
      {
         this.dataArr = Model_actDaily.getInstance().retExpArr;
         this.setPage(this._curPage);
      }
   }
}

