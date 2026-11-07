package com.yiTian.view.modules.farm
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_farm;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FarmCGMessage;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_arrestList extends Panel
   {
      
      private static var isLoad:Boolean = false;
      
      private var TabButton_defeated:TabButton;
      
      private var TabButton_robFarmer:TabButton;
      
      private var TabButton_master:TabButton;
      
      private var Button_now:TabButton;
      
      private var pageRight_Button:Button;
      
      private var pageLeft_Button:Button;
      
      private var right_Button:Button;
      
      private var left_Button:Button;
      
      private var page_text:MyTextField;
      
      public var jingJiChang:Button;
      
      public var introduce:MyTextField;
      
      private var arrestItemArr:Array = [];
      
      private var _curPage:int = 1;
      
      private var _totalPage:int;
      
      public function View_arrestList()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var arrestItem:Child_arrest_item = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":392,
            "height":527
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":344,
            "height":477
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":162,
            "y":490,
            "width":68,
            "height":21
         },Global.Img_Cdm);
         move = new Rectangle(0,0,350,36);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":358,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.jingJiChang = ComponentUtil.getButton(LangConfig.getWord("184",9),"Button_Five",this,{
            "x":148,
            "y":321
         },Global.Img_Cdm);
         this.jingJiChang.addEventListener(MouseEvent.CLICK,this.jingJIClickHandle);
         this.jingJiChang.visible = false;
         this.introduce = ComponentUtil.getTextField("",this,{
            "x":83,
            "y":134,
            "color":16184781
         });
         this.introduce.visible = false;
         this.introduce.multiline = true;
         this.introduce.htmlText = LangConfig.getWord("190",9);
         this.page_text = ComponentUtil.getTextField("00/00",this,{
            "x":178,
            "y":491,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.pageRight_Button = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":236,
            "y":490,
            "textColor":16184781,
            "name":"add"
         },Global.Img_Cdm);
         this.pageLeft_Button = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":135,
            "y":490,
            "textColor":16184781
         },Global.Img_Cdm);
         this.right_Button = ComponentUtil.getButton("","Button_NumMax",this,{
            "x":263,
            "y":490,
            "textColor":16184781,
            "name":"last"
         },Global.Img_Cdm);
         this.left_Button = ComponentUtil.getButton("","Button_NumMin",this,{
            "x":108,
            "y":490,
            "textColor":16184781,
            "name":"first"
         },Global.Img_Cdm);
         i = 0;
         while(i < 5)
         {
            arrestItem = new Child_arrest_item();
            arrestItem.x = 30;
            arrestItem.y = 46 + 89 * i;
            addChild(arrestItem);
            arrestItem.visible = false;
            this.arrestItemArr.push(arrestItem);
            i++;
         }
         this.pageRight_Button.callBack = this.pageChangeHandle;
         this.pageLeft_Button.callBack = this.pageChangeHandle;
         this.right_Button.callBack = this.pageChangeHandle;
         this.left_Button.callBack = this.pageChangeHandle;
      }
      
      public function pageChangeHandle(e:MouseEvent) : void
      {
         var temBtn:Button = e.target as Button;
         if(temBtn.name == "first")
         {
            if(this._curPage == 1)
            {
               return;
            }
            this._curPage = 1;
         }
         else if(temBtn.name == "last")
         {
            if(this._curPage == this._totalPage)
            {
               return;
            }
            this._curPage = this._totalPage;
         }
         else if(temBtn.name == "add")
         {
            if(this._curPage == this._totalPage)
            {
               return;
            }
            ++this._curPage;
         }
         else
         {
            if(this._curPage == 1)
            {
               return;
            }
            --this._curPage;
         }
         this.update(this._curPage);
      }
      
      public function update(curP:uint) : void
      {
         var temN:int = 0;
         var i:int = 0;
         while(i < this.arrestItemArr.length)
         {
            this.arrestItemArr[i].visible = false;
            this.arrestItemArr[i].dispose();
            i++;
         }
         if(!Model_farm.instace.farm_defeated_list.length)
         {
            this.jingJiChang.visible = true;
            this.introduce.visible = true;
            this.page_text.text = "1/1";
            return;
         }
         this.jingJiChang.visible = false;
         this.introduce.visible = false;
         if(Model_farm.instace.farm_defeated_list.length % 5 == 0)
         {
            this._totalPage = Model_farm.instace.farm_defeated_list.length / 5;
         }
         else
         {
            this._totalPage = Model_farm.instace.farm_defeated_list.length / 5 + 1;
         }
         this._curPage = curP;
         Model_farm.defeatedPage = curP;
         this.page_text.text = String(this._curPage) + "/" + String(this._totalPage);
         this.jingJiChang.visible = false;
         this.introduce.visible = false;
         if(this._curPage != this._totalPage)
         {
            i = 0;
            while(i < this.arrestItemArr.length)
            {
               this.arrestItemArr[i].visible = true;
               this.arrestItemArr[i].update(Model_farm.instace.farm_defeated_list[(this._curPage - 1) * 5 + i]);
               i++;
            }
         }
         else
         {
            temN = Model_farm.instace.farm_defeated_list.length % 5 + 5 * int(Model_farm.instace.farm_defeated_list.length % 5 == 0);
            i = 0;
            while(i < temN)
            {
               this.arrestItemArr[i].visible = true;
               this.arrestItemArr[i].update(Model_farm.instace.farm_defeated_list[(this._curPage - 1) * 5 + i]);
               i++;
            }
         }
      }
      
      private function jingJIClickHandle(evt:MouseEvent) : void
      {
         UIManager.jjc_panel.visible = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            UIManager.jjc_panel.visible = false;
            FarmCGMessage.cg_friends_list(2,GameUnitManager.hero.id);
            if(!isLoad)
            {
               this.showTl();
               isLoad = true;
            }
            else
            {
               this.update(1);
            }
         }
      }
      
      private function showTl() : void
      {
         ComponentUtil.getBitmap("Title_ZhuaBuList",this,{
            "x":116,
            "y":5
         },Global.ShanZhuang_Imgsdm);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
   }
}

