package com.yiTian.view.modules.KFHomeland
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class VisiteFriendHome extends Panel123
   {
      
      private static const LENPAGE:int = 12;
      
      private var back:ScaleBitmap;
      
      private var lacalFriBtn:TabButton;
      
      private var otherServeFriBtn:TabButton;
      
      private var _friVec:Vector.<visiteFirHomeItem>;
      
      private var _friData:Array;
      
      private var _totalPage:int;
      
      private var _numPage:int;
      
      private var _pageTxt:MyTextField;
      
      private var _prePageBtn:Button;
      
      private var _nextPageBtn:Button;
      
      public var _curSelIndex:int;
      
      private var _allSeverData:Array;
      
      private var _curSelSeverData:Array;
      
      private var _getSeverIndex:int;
      
      private var nowBtn:TabButton;
      
      private var curShowMax:int;
      
      private var tempfirInfObj:Object;
      
      private var tempIndex:int;
      
      private var curIndex:int;
      
      private var isfirstEnter:Boolean = false;
      
      public function VisiteFriendHome()
      {
         super();
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":620,
            "height":464
         },Global.Img_Cdm);
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":23,
            "y":66,
            "width":574,
            "height":390
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":this.back.width - 37,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back4",[3,3,1,1],this,{
            "x":29,
            "y":73,
            "width":562,
            "height":350
         },Global.Img_Cdm);
         if(!Global.KFJYdm)
         {
            SingleLoader.add("lang/ch/KFJY.swf",function(info:Object):void
            {
               Global.KFJYdm = info.applicationDomain;
               initFir();
            });
         }
         else
         {
            this.initFir();
         }
         this.lacalFriBtn = ComponentUtil.getTabButton(LangConfig.getWord("30226",3),"TabButton_Four",this,{
            "x":36,
            "y":46,
            "textColor":16772813,
            "chooseColor":16771436,
            "index":1
         },Global.Img_Cdm);
         this.otherServeFriBtn = ComponentUtil.getTabButton(LangConfig.getWord("30227",3),"TabButton_Four",this,{
            "x":114,
            "y":46,
            "textColor":16772813,
            "chooseColor":16771436,
            "index":2
         },Global.Img_Cdm);
         this.lacalFriBtn.addEventListener(MouseEvent.CLICK,this.friClkHandle);
         this.otherServeFriBtn.addEventListener(MouseEvent.CLICK,this.friClkHandle);
         this._prePageBtn = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":256,
            "y":430,
            "textColor":16771436
         },Global.Img_Cdm);
         this._nextPageBtn = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":344,
            "y":430,
            "textColor":16771436
         },Global.Img_Cdm);
         this._pageTxt = ComponentUtil.getTextField("1/5",this,{
            "x":297,
            "y":431,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this._prePageBtn.callBack = this.preHandle;
         this._nextPageBtn.callBack = this.nextHandle;
      }
      
      private function preHandle(evt:MouseEvent) : void
      {
         if(this._numPage <= 1)
         {
            return;
         }
         --this._numPage;
         this.showPage();
      }
      
      private function nextHandle(evt:MouseEvent) : void
      {
         if(this._numPage >= this._totalPage)
         {
            return;
         }
         ++this._numPage;
         this.showPage();
      }
      
      private function initFir() : void
      {
         var i:int = 0;
         var item:visiteFirHomeItem = null;
         ComponentUtil.getBitmap("Title_HaoYou",this,{
            "x":230,
            "y":5
         },Global.KFJYdm);
         ComponentUtil.getTextField("亲，跨服好友的数据有些延迟,同时没有家园的好友也不会显示哦。",this,{
            "x":200,
            "y":48,
            "color":16184781,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":280,
            "y":429,
            "width":60,
            "height":22
         },Global.Img_Cdm);
         this._friVec = new Vector.<visiteFirHomeItem>(LENPAGE,true);
         i = 0;
         while(i < LENPAGE)
         {
            item = new visiteFirHomeItem();
            addChild(item);
            item.x = 36 + int(i % 3) * 184;
            item.y = 78 + int(i / 3) * 85;
            this._friVec[i] = item;
            i++;
         }
         this._curSelIndex = 1;
      }
      
      private function friClkHandle(evt:MouseEvent) : void
      {
         var curBtn:TabButton = evt.target as TabButton;
         if(this.nowBtn == curBtn)
         {
            return;
         }
         curBtn.choose = true;
         if(Boolean(this.nowBtn))
         {
            this.nowBtn.choose = false;
         }
         this.nowBtn = curBtn;
         this._curSelIndex = this.nowBtn.index;
         HomeLandCGMessage.CG_FIRENDLIST_HOMELAND(this._curSelIndex);
      }
      
      private function showPage() : void
      {
         var i:int = 0;
         this._pageTxt.text = this._numPage.toString() + "/" + this._totalPage;
         if(this._curSelSeverData.length < LENPAGE * this._numPage)
         {
            this.curShowMax = this._curSelSeverData.length - LENPAGE * (this._numPage - 1);
         }
         else
         {
            this.curShowMax = LENPAGE;
         }
         this.tempIndex = 0;
         i = 0;
         while(i < LENPAGE)
         {
            this._friVec[i].visible = false;
            if(this.tempIndex < this.curShowMax)
            {
               this.curIndex = int(this._numPage - 1) * LENPAGE + this.tempIndex;
               this.tempfirInfObj = this._curSelSeverData[this.curIndex] as Object;
               this._friVec[i].visible = true;
               this._friVec[i].update(this.tempfirInfObj);
            }
            ++this.tempIndex;
            i++;
         }
      }
      
      public function update(type:int, arr:Array) : void
      {
         this._getSeverIndex = type;
         if(this._curSelIndex != type)
         {
            if(!this._allSeverData[this._curSelIndex])
            {
               this._allSeverData[this._curSelIndex] = new Array();
            }
            this._allSeverData[this._curSelIndex] = arr;
         }
         this._curSelSeverData = arr;
         this.delNoHome();
         this._totalPage = int(Math.ceil(arr.length / LENPAGE));
         this._numPage = 1;
         this.showPage();
      }
      
      private function delNoHome() : void
      {
         var obj:Object = null;
         var i:int = 0;
         while(i < this._curSelSeverData.length)
         {
            obj = this._curSelSeverData[i] as Object;
            if(obj.hasHome == 0)
            {
               this._curSelSeverData.splice(i,1);
               i--;
            }
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.isfirstEnter)
            {
               super.init();
               this.isfirstEnter = true;
            }
            HomeLandCGMessage.CG_FIRENDLIST_HOMELAND(this._curSelIndex);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
   }
}

