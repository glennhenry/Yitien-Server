package com.yiTian.view.modules.KFHomeland
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.CameraManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class SortBuildings extends Panel123
   {
      
      private static var curClkId:int;
      
      public static var startBuildX:Number;
      
      public static var startBuildY:Number;
      
      private static const BTNLEN:int = 4;
      
      private static const BUILDPAGELEN:int = 10;
      
      private static const SKINPAGELEN:int = 4;
      
      private var back:ScaleBitmap;
      
      private var typeTabBtnVec:Vector.<TabButton>;
      
      private var titleBtnVec:Vector.<String>;
      
      private var buildingsVec:Vector.<buildingsItem>;
      
      private var skinVec:Vector.<SkinItem>;
      
      private var _selTypeBuilds:int;
      
      private var _lenPage:int;
      
      private var _totalPage:int;
      
      private var _numPage:int;
      
      private var _prePageBtn:Button;
      
      private var _nextPageBtn:Button;
      
      private var _pageTxt:MyTextField;
      
      private var itemServerData:Vector.<InfoItemBuildings>;
      
      private var itemLocalData:Vector.<InfoItemBuildings>;
      
      private var AllTypeLocalData:Array = [];
      
      private var receiveSeverDataType:int;
      
      private var curItem:buildingsItem;
      
      private var nowTabBtn:TabButton;
      
      private var i:int;
      
      private var isfirstEnter:Boolean = false;
      
      public function SortBuildings()
      {
         super();
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":670,
            "height":461
         },Global.Img_Cdm);
      }
      
      public static function startBuildHome() : void
      {
         var builds:CreatedBuildings = null;
         Global.isBuildHome = true;
         EnterHomeControl.instance.sortBuild.visible = false;
         EnterHomeControl.instance.addEscTips();
         BuildAction.offsetX = CameraManager.sightX;
         BuildAction.offsetY = CameraManager.sightY;
         builds = new CreatedBuildings();
         builds.id = Number(curClkId);
         builds.orient = 1;
         builds.updateBInfo();
         BuildAction.moveBuild = builds;
         BuildAction.instance.building(SortBuildings.startBuildX,SortBuildings.startBuildY);
      }
      
      override protected function initStaticView() : void
      {
         var i:int;
         var tabBtn:TabButton = null;
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":66,
            "width":622,
            "height":387
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back4",[3,3,1,1],this,{
            "x":34,
            "y":73,
            "width":602,
            "height":344
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":this.back.width - 37,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":305,
            "y":423,
            "width":60,
            "height":22
         },Global.Img_Cdm);
         if(!Global.KFJYdm)
         {
            SingleLoader.add("lang/ch/KFJY.swf",function(info:Object):void
            {
               Global.KFJYdm = info.applicationDomain;
               initBuildings();
            });
         }
         else
         {
            this.initBuildings();
         }
         this.typeTabBtnVec = new Vector.<TabButton>();
         this.titleBtnVec = new <String>[LangConfig.getWord("30218",3),LangConfig.getWord("30219",3),LangConfig.getWord("30220",3),LangConfig.getWord("30222",3),LangConfig.getWord("30223",3)];
         i = 0;
         while(i < BTNLEN)
         {
            tabBtn = ComponentUtil.getTabButton(this.titleBtnVec[i],"TabButton_Four",this,{
               "x":35 + i * 78,
               "y":46,
               "textColor":16773818,
               "chooseColor":16383744,
               "index":i + 1
            },Global.Img_Cdm);
            tabBtn.addEventListener(MouseEvent.CLICK,this.tabBtnHandle);
            this.typeTabBtnVec.push(tabBtn);
            if(this.titleBtnVec[i] == LangConfig.getWord("30222",3))
            {
               tabBtn.index = 0;
            }
            else if(this.titleBtnVec[i] == LangConfig.getWord("30223",3))
            {
               tabBtn.index = 10;
            }
            i++;
         }
         this._prePageBtn = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":281,
            "y":424,
            "textColor":16771436
         },Global.Img_Cdm);
         this._nextPageBtn = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":369,
            "y":424,
            "textColor":16771436
         },Global.Img_Cdm);
         this._pageTxt = ComponentUtil.getTextField("1/5",this,{
            "x":322,
            "y":425,
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
      
      private function initBuildings() : void
      {
         var i:int = 0;
         var item:buildingsItem = null;
         ComponentUtil.getBitmap("Title_JZWP",this,{
            "x":255,
            "y":5
         },Global.KFJYdm);
         this.buildingsVec = new Vector.<buildingsItem>();
         this._lenPage = BUILDPAGELEN;
         i = 0;
         while(i < this._lenPage)
         {
            item = new buildingsItem();
            addChild(item);
            this.buildingsVec.push(item);
            item.x = 41 + int(i % 5) * 118;
            item.y = 80 + int(i / 5) * 168;
            item.buttonMode = true;
            item.addEventListener(MouseEvent.CLICK,this.clkHandle);
            i++;
         }
      }
      
      private function clkHandle(evt:MouseEvent) : void
      {
         this.curItem = evt.target as buildingsItem;
         if(this.curItem._sysLevel == 0)
         {
            return;
         }
         if(this.curItem._canUseNum <= 0)
         {
            return;
         }
         curClkId = this.curItem._bId;
         startBuildX = evt.stageX;
         startBuildY = evt.stageY;
         startBuildHome();
      }
      
      private function tabBtnHandle(evt:MouseEvent) : void
      {
         var curTabBtn:TabButton = evt.target as TabButton;
         if(curTabBtn == this.nowTabBtn)
         {
            return;
         }
         curTabBtn.choose = true;
         if(Boolean(this.nowTabBtn))
         {
            this.nowTabBtn.choose = false;
         }
         this.nowTabBtn = curTabBtn;
         this.showTypeBuilds(this.nowTabBtn.index);
         HomeLandCGMessage.CG_SOREBUILD_HOMELAND(this.nowTabBtn.index);
      }
      
      private function showTypeBuilds(type:int) : void
      {
         var skinItem:SkinItem = null;
         this._selTypeBuilds = type;
         if(type == 0)
         {
            if(this._lenPage != SKINPAGELEN)
            {
               this._lenPage = SKINPAGELEN;
               this.i = 0;
               while(this.i < BUILDPAGELEN)
               {
                  this.buildingsVec[this.i].visible = false;
                  ++this.i;
               }
            }
            if(!this.skinVec)
            {
               this.skinVec = new Vector.<SkinItem>(SKINPAGELEN,true);
               this.i = 0;
               while(this.i < SKINPAGELEN)
               {
                  skinItem = new SkinItem();
                  addChild(skinItem);
                  skinItem.x = 40 + int(this.i % 2) * 297;
                  skinItem.y = 79 + int(this.i / 2) * 169;
                  this.skinVec[this.i] = skinItem;
                  ++this.i;
               }
            }
         }
         else if(this._lenPage != BUILDPAGELEN)
         {
            this._lenPage = BUILDPAGELEN;
            this.i = 0;
            while(this.i < SKINPAGELEN)
            {
               if(Boolean(this.skinVec))
               {
                  this.skinVec[this.i].visible = false;
               }
               ++this.i;
            }
         }
         this._totalPage = int(Math.ceil(this.updateLocalData() / this._lenPage));
         if(this._totalPage == 0)
         {
            this._totalPage = 1;
         }
         this.itemLocalData = this.AllTypeLocalData[this._selTypeBuilds];
         this._numPage = 1;
         this.showPage();
      }
      
      private function showPage() : void
      {
         var curItemServerInfo:InfoItemBuildings = null;
         var curItemInfo:InfoItemBuildings = null;
         this._pageTxt.text = this._numPage.toString() + "/" + this._totalPage;
         this.i = 0;
         while(this.i < this._lenPage)
         {
            if(Boolean(this.itemServerData))
            {
               if(this.itemServerData.length <= this.i + int(this._numPage - 1) * this._lenPage)
               {
                  curItemServerInfo = null;
               }
               else
               {
                  curItemServerInfo = this.itemServerData[this.i + int(this._numPage - 1) * this._lenPage] as InfoItemBuildings;
               }
            }
            curItemInfo = this.reOrderAsSever(curItemServerInfo,this.i + int(this._numPage - 1) * this._lenPage);
            if(this._selTypeBuilds != 0)
            {
               this.buildingsVec[this.i].update(curItemInfo);
               this.buildingsVec[this.i]._sysLevel = this._selTypeBuilds;
            }
            else
            {
               this.skinVec[this.i].update(curItemInfo);
               this.skinVec[this.i]._sysLevel = this._selTypeBuilds;
            }
            ++this.i;
         }
      }
      
      private function reOrderAsSever(itemInfo:InfoItemBuildings, index:int) : InfoItemBuildings
      {
         var temp:InfoItemBuildings = null;
         var i:int = 0;
         if(!this.itemLocalData || index >= this.itemLocalData.length)
         {
            return null;
         }
         if(Boolean(itemInfo))
         {
            i = 0;
            while(i < this.itemLocalData.length)
            {
               if(itemInfo.id == this.itemLocalData[i].id)
               {
                  this.itemLocalData[i].num = itemInfo.num;
                  this.itemLocalData[i].leftTime = itemInfo.leftTime;
                  temp = this.itemLocalData[index];
                  this.itemLocalData[index] = this.itemLocalData[i];
                  this.itemLocalData[i] = temp;
               }
               i++;
            }
         }
         return this.itemLocalData[index];
      }
      
      public function updateServer(type:int, arr:Vector.<InfoItemBuildings>) : void
      {
         this.receiveSeverDataType = type;
         this.itemServerData = arr;
         if(visible && this._selTypeBuilds >= 0)
         {
            this.showTypeBuilds(this._selTypeBuilds);
         }
      }
      
      private function updateLocalData() : int
      {
         var arr:Array = null;
         var key:String = null;
         var itemInfo1:InfoItemBuildings = null;
         var itemInfo2:InfoItemBuildings = null;
         var curTypeLoaclData:Vector.<InfoItemBuildings> = new Vector.<InfoItemBuildings>();
         for(key in Data_lib.kfjyjzflb)
         {
            arr = Data_lib.kfjyjzflb[key];
            if(this._selTypeBuilds == arr[Enum_SortBuildins.SORE_LEVEL])
            {
               if(VoHome.isOut == arr[Enum_SortBuildins.OUT_INNER] && this._selTypeBuilds != 0)
               {
                  itemInfo1 = new InfoItemBuildings();
                  itemInfo1.id = int(key);
                  itemInfo1.localDataArr = arr;
                  curTypeLoaclData.push(itemInfo1);
               }
               if(this._selTypeBuilds == 0)
               {
                  itemInfo2 = new InfoItemBuildings();
                  itemInfo2.id = int(key);
                  itemInfo2.localDataArr = arr;
                  curTypeLoaclData.push(itemInfo2);
               }
            }
         }
         this.AllTypeLocalData[this._selTypeBuilds] = curTypeLoaclData;
         return curTypeLoaclData.length;
      }
      
      public function updateSkin(id:int) : void
      {
         if(this._selTypeBuilds == 0)
         {
            this.i = 0;
            while(this.i < SKINPAGELEN)
            {
               if(this.skinVec[this.i]._sId == id)
               {
                  this.skinVec[this.i].updateBtnLabel();
               }
               ++this.i;
            }
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
            this.typeTabBtnVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            HomeLandCGMessage.CG_BUILD_HOMELAND(VoHome.isOut,VoHome.heroS);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
   }
}

