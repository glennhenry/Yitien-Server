package com.yiTian.view.modules.crossClanBattle
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   
   public class view_AllSiegeTimePanel extends Panel123
   {
      
      private var bg:DisplayObject;
      
      private var itemVec:Vector.<Child_SiegeTimeItem> = new Vector.<Child_SiegeTimeItem>();
      
      public var Button_Page_Back:Button;
      
      public var Button_Page_Next:Button;
      
      public var Total_text:MyTextField;
      
      public var Page_text:MyTextField;
      
      public var _totalPage:int = 1;
      
      public var _curPage:int = 1;
      
      public function view_AllSiegeTimePanel()
      {
         super();
         regResource("lang/ch/KFBang_CC.swf","KFBang_CCdm");
      }
      
      public static function get instance() : view_AllSiegeTimePanel
      {
         return Singleton.getInstance(view_AllSiegeTimePanel);
      }
      
      override protected function initUI2() : void
      {
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":683,
            "height":392
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":635,
            "height":342
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":34,
            "y":50,
            "width":615,
            "height":292
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width,38);
         this.Button_Page_Back = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":272,
            "y":351,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Page_Next = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":371,
            "y":351,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":298,
            "y":350,
            "width":68,
            "height":24
         },Global.Img_Cdm);
         this.Page_text = ComponentUtil.getTextField("00/00",this,{
            "x":314,
            "y":353,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Title_GCShiJian",this,{
            "x":261,
            "y":5
         },Global.KFBang_CCdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":649,
            "y":6,
            "textColor":16184781,
            "callBack":this.hide
         },Global.Img_Cdm);
         this.Page_text.align = TextFormatAlign.CENTER;
         this.Button_Page_Next.name = "next";
         this.Button_Page_Back.name = "back";
         this.Button_Page_Next.callBack = this.Button_Page_Back.callBack = this.nextHandle;
         this.createItem();
      }
      
      private function createItem() : void
      {
         var i:int = 0;
         var item:Child_SiegeTimeItem = null;
         i = 0;
         while(i < Enum_CrossClanBattle.MAX_CITY_PAGENUM)
         {
            item = new Child_SiegeTimeItem();
            addChild(item);
            this.itemVec.push(item);
            item.x = 44;
            item.y = 60 + i * 46;
            i++;
         }
      }
      
      public function showItem(curPage:int) : void
      {
         var currentIndex:int = 0;
         var i:int = 0;
         if(!this.itemVec || !this.itemVec.length)
         {
            return;
         }
         currentIndex = Enum_CrossClanBattle.MAX_CITY_PAGENUM * curPage;
         var totalLen:int = int(Model_CrossClanBattle.allCityTimeData.length);
         var showNum:int = totalLen - currentIndex > Enum_CrossClanBattle.MAX_CITY_PAGENUM ? Enum_CrossClanBattle.MAX_CITY_PAGENUM : int(totalLen - currentIndex);
         this._totalPage = totalLen % Enum_CrossClanBattle.MAX_CITY_PAGENUM == 0 ? int(totalLen / Enum_CrossClanBattle.MAX_CITY_PAGENUM) : int(int(totalLen / Enum_CrossClanBattle.MAX_CITY_PAGENUM) + 1);
         i = 0;
         while(i < Enum_CrossClanBattle.MAX_CITY_PAGENUM)
         {
            if(i < showNum)
            {
               this.itemVec[i].visible = true;
               this.itemVec[i].update(Model_CrossClanBattle.allCityTimeData[currentIndex][0],Model_CrossClanBattle.allCityTimeData[currentIndex][1],Model_CrossClanBattle.allCityTimeData[currentIndex][2],Model_CrossClanBattle.allCityTimeData[currentIndex][3],Model_CrossClanBattle.allCityTimeData[currentIndex][4]);
            }
            else
            {
               this.itemVec[i].visible = false;
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
         this.showItem(this._curPage - 1);
      }
      
      public function show() : void
      {
         if(Model_CrossClanBattle.refreshTimeCount < 2 && Model_CrossClanBattle.refreshTimeCount != 0)
         {
            return;
         }
         visible = true;
         this.updateData();
      }
      
      public function updateData() : void
      {
         if(!this.Page_text)
         {
            return;
         }
         this._curPage = 1;
         this.showItem(this._curPage - 1);
         this.Page_text.text = String(this._curPage) + "/" + String(this._totalPage < 1 ? 1 : this._totalPage);
      }
      
      public function hide(prm:* = null) : void
      {
         visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
      
      override public function get height() : Number
      {
         if(!this.bg)
         {
            return super.height;
         }
         return this.bg.height;
      }
      
      override public function get width() : Number
      {
         if(!this.bg)
         {
            return super.width;
         }
         return this.bg.width;
      }
   }
}

