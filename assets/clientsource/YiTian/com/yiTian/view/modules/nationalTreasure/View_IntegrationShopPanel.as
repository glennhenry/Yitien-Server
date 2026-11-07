package com.yiTian.view.modules.nationalTreasure
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.NationalTreasureCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   
   public class View_IntegrationShopPanel extends Panel123
   {
      
      private var bg:DisplayObject;
      
      private var shopVec:Vector.<Child_IntegrationShopItem> = new Vector.<Child_IntegrationShopItem>(10,true);
      
      private var textJifen:MyTextField;
      
      public var Button_Page_Back:Button;
      
      public var Button_Page_Next:Button;
      
      public var Total_text:MyTextField;
      
      public var Page_text:MyTextField;
      
      public var _totalPage:int;
      
      public var _curPage:int = 1;
      
      public function View_IntegrationShopPanel()
      {
         super();
         regResource("lang/ch/JFDH_Imgs.swf","JFDHdm");
      }
      
      public static function get instance() : View_IntegrationShopPanel
      {
         return Singleton.getInstance(View_IntegrationShopPanel);
      }
      
      override protected function initUI2() : void
      {
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":395,
            "height":422
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":26,
            "y":40,
            "width":344,
            "height":370
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":42,
            "width":338,
            "height":364
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_HW",[20,20,1,1],this,{
            "x":31,
            "y":43,
            "width":337,
            "height":362
         },Global.JFDHdm);
         ComponentUtil.getBitmap("Title_JFDH",this,{
            "x":117,
            "y":6
         },Global.JFDHdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":141,
            "y":382,
            "width":88,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Text_WDJF",this,{
            "x":111,
            "y":50
         },Global.WaBaodm);
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":201,
            "y":53,
            "width":74,
            "height":18
         },Global.Img_Cdm);
         this.textJifen = ComponentUtil.getTextField("222222",this,{
            "x":214,
            "y":53,
            "color":13816530,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,this.bg.width,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":358,
            "y":5,
            "textColor":16771436,
            "callBack":this.hide
         },Global.Img_Cdm);
         this.Button_Page_Back = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":121,
            "y":382,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Page_Next = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":226,
            "y":382,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Page_text = ComponentUtil.getTextField("000/000",this,{
            "x":160,
            "y":383,
            "color":14662240,
            "size":12,
            "leading":0,
            "realWidth":45
         });
         this.Page_text.align = TextFormatAlign.CENTER;
         this.Button_Page_Next.name = "next";
         this.Button_Page_Back.name = "back";
         this.Button_Page_Next.callBack = this.Button_Page_Back.callBack = this.nextHandle;
         Model_NationalTreasure.setIntegrationShopData();
         this.createShopList();
      }
      
      private function createShopList() : void
      {
         var item:Child_IntegrationShopItem = null;
         var i:int = 0;
         i = 0;
         while(i < 10)
         {
            item = new Child_IntegrationShopItem();
            addChild(item);
            this.shopVec[i] = item;
            item.x = 37 + i % 2 * 164;
            item.y = 77 + int(i / 2) * 61;
            item.visible = false;
            i++;
         }
      }
      
      public function showShopList(curPage:int) : void
      {
         var currentIndex:int = 0;
         var i:int = 0;
         currentIndex = Enum_NationalTreasure.SHOP_MAX_NUM * curPage;
         var totalLen:int = int(Model_NationalTreasure.integrationShopData.length);
         var showNum:int = totalLen - currentIndex > Enum_NationalTreasure.SHOP_MAX_NUM ? Enum_NationalTreasure.SHOP_MAX_NUM : int(totalLen - currentIndex);
         this._totalPage = totalLen % Enum_NationalTreasure.SHOP_MAX_NUM == 0 ? int(totalLen / Enum_NationalTreasure.SHOP_MAX_NUM) : int(int(totalLen / Enum_NationalTreasure.SHOP_MAX_NUM) + 1);
         i = 0;
         while(i < Enum_NationalTreasure.SHOP_MAX_NUM)
         {
            if(i < showNum)
            {
               this.shopVec[i].visible = true;
               this.shopVec[i].setVo(Model_NationalTreasure.integrationShopData[currentIndex][0],Model_NationalTreasure.integrationShopData[currentIndex][1],Model_NationalTreasure.integrationShopData[currentIndex][2]);
            }
            else
            {
               this.shopVec[i].visible = false;
            }
            currentIndex++;
            i++;
         }
      }
      
      private function nextHandle(e:MouseEvent) : void
      {
         if(e.target.name == "next")
         {
            if(this._curPage < this._totalPage)
            {
               if(this._curPage == this._totalPage)
               {
                  return;
               }
               ++this._curPage;
               this.Page_text.text = String(this._curPage) + "/" + String(this._totalPage);
            }
         }
         else if(e.target.name == "back")
         {
            if(this._curPage == 1)
            {
               return;
            }
            if(this._curPage > 1)
            {
               --this._curPage;
               this.Page_text.text = String(this._curPage) + "/" + String(this._totalPage);
            }
         }
         this.showShopList(this._curPage - 1);
      }
      
      public function setJifen(jifen:int) : void
      {
         if(!this.textJifen)
         {
            return;
         }
         this.textJifen.text = jifen + "";
      }
      
      public function show(prm:* = null) : void
      {
         visible = true;
         NationalTreasureCGMessage.CG_GOODS_QUERY();
         this.showShopList(0);
         this.Page_text.text = String(this._curPage) + "/" + String(this._totalPage);
      }
      
      public function hide(prm:* = null) : void
      {
         visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

