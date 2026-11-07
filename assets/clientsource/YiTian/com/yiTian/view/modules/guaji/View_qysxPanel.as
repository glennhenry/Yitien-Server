package com.yiTian.view.modules.guaji
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_GuaJi;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.net.message.cg.GuaJiCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.Shopping.shoppingMall.ShoppingMallPan;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class View_qysxPanel extends Panel
   {
      
      private var btn_wwsx:Button;
      
      private var btn_refrest:Button;
      
      private var titleBg:Bitmap;
      
      private var bm_wwpic:Bitmap;
      
      private var btn_next:Button;
      
      private var btn_front:Button;
      
      public var cb_useWaWa:CheckBox;
      
      private var tf_pageInfo:MyTextField;
      
      public var qysxItemVec:Vector.<Child_qysxListItem>;
      
      private var _page:int;
      
      private var refresh:int = -4000;
      
      private var _lastTime:int;
      
      public var currentPageIndex:int = 1;
      
      public function View_qysxPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var index:int = 0;
         var qysxItem:Child_qysxListItem = null;
         var back:ScaleBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":378,
            "height":307
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":330,
            "height":257
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":45,
            "width":145,
            "height":247
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":176,
            "y":45,
            "width":173,
            "height":247
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":177,
            "y":46,
            "width":171,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60141",6),this,{
            "x":236,
            "y":46,
            "color":14662240,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,back.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":344,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.cb_useWaWa = ComponentUtil.getCheckBox("","CheckBox01",this,{
            "x":47,
            "y":235,
            "color":16777215
         },Global.Img_Cdm);
         ComponentUtil.getTextField("自动使用娃娃",this,{
            "x":77,
            "y":235,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.qysxItemVec = new Vector.<Child_qysxListItem>();
         index = 0;
         while(index < 7)
         {
            qysxItem = new Child_qysxListItem();
            this.qysxItemVec.push(qysxItem);
            qysxItem.x = 181;
            qysxItem.y = 66 + 28 * index;
            qysxItem.data = null;
            addChild(qysxItem);
            index++;
         }
         this.btn_wwsx = ComponentUtil.getButton(LangConfig.getWord("21127",2),"Button_Four",this,{
            "x":67,
            "y":259,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_refrest = ComponentUtil.getButton(LangConfig.getWord("21128",2),"Button_TiliteFive",this,{
            "x":182,
            "y":265,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_front = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":259,
            "y":265,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_next = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":324,
            "y":265,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":279,
            "y":265,
            "width":46,
            "height":20
         },Global.Img_Cdm);
         this.tf_pageInfo = ComponentUtil.getTextField("1/1",this,{
            "x":this.btn_front.x + this.btn_front.width,
            "y":266,
            "realWidth":this.btn_next.x - (this.btn_front.x + this.btn_front.width),
            "color":16777215
         });
         this.tf_pageInfo.autoSize = TextFieldAutoSize.CENTER;
         this.cb_useWaWa.clickFun = this.useWaWaClickFun;
      }
      
      private function useWaWaClickFun(cb:CheckBox) : void
      {
         var flag:int = this.cb_useWaWa.selected ? 1 : 0;
         GuaJiCGMessage.CG_AUTOWAWASHUANGXIU(flag);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.btn_wwsx.callBack = this.wwsxClickHandle;
         this.btn_refrest.callBack = this.refrestClickHandle;
         this.btn_front.callBack = this.frontClickHandle;
         this.btn_next.callBack = this.nextClickHandle;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(!Global.GuaJi_Imgsdm)
            {
               this.load();
            }
            else if(!this.titleBg)
            {
               this.sourceComplete();
            }
         }
         super.visible = value;
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push([Enum_GuaJi.GUAJISOURCE,this.sourceComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function sourceComplete(info:Object = null) : void
      {
         if(Boolean(info))
         {
            Global.GuaJi_Imgsdm = info.applicationDomain;
         }
         this.bm_wwpic = ComponentUtil.getBitmap("WaWa",this,{
            "x":33,
            "y":48
         },Global.GuaJi_Imgsdm);
         this.titleBg = ComponentUtil.getBitmap("Title_ShuangXiu",this,{
            "x":109,
            "y":5
         },Global.GuaJi_Imgsdm);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2 + 300;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      private function wwsxClickHandle(evt:MouseEvent) : void
      {
         if(Model_guajiInfo.getInstance().wawaTime <= 5)
         {
            ModalUIManager.fxqPromty.show(LangConfig.getWord("29194",2),1,function(evt:MouseEvent):void
            {
               var pan:ShoppingMallPan = Singleton.getInstance(ShoppingMallPan) as ShoppingMallPan;
               pan.openView(0,2);
            });
         }
         else
         {
            GuaJiCGMessage.CG_CHANGEWAWASHUANGXIU(1);
            Model_guajiInfo.getInstance().isClickedWaWaShuangXiu = true;
         }
      }
      
      private function refrestClickHandle(evt:MouseEvent) : void
      {
         var now:int = getTimer();
         if(now - this.refresh < 4000)
         {
            return;
         }
         this.refresh = now;
         GuaJiCGMessage.CG_GUAJI_OTHERROLE_INFO(2);
      }
      
      public function set lastTime(value:int) : void
      {
         this._lastTime = value;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
      }
      
      private function onFrame(interval:int) : void
      {
         var str:String = null;
         var item:Child_qysxListItem = null;
         var cur:int = getTimer();
         if(cur - this._lastTime <= 10000)
         {
            str = Math.ceil((10000 - cur + this._lastTime) / 1000).toString();
         }
         else
         {
            str = LangConfig.getWord("21126",2);
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
         }
         for each(item in this.qysxItemVec)
         {
            item.label = str;
         }
      }
      
      private function frontClickHandle(evt:MouseEvent) : void
      {
         this.show(this.currentPageIndex - 1);
      }
      
      private function nextClickHandle(evt:MouseEvent) : void
      {
         this.show(this.currentPageIndex + 1);
      }
      
      public function show(pageIndex:int) : void
      {
         var maxIndex:int = Math.ceil(Model_guajiInfo.getInstance().qysxData.length / 7);
         if(maxIndex < 1)
         {
            maxIndex = 1;
         }
         if(pageIndex < 1 || pageIndex > maxIndex)
         {
            return;
         }
         this.currentPageIndex = pageIndex;
         var index:int = 0;
         while(index < 7)
         {
            if(Boolean(Model_guajiInfo.getInstance().qysxData[(this.currentPageIndex - 1) * 7 + index]))
            {
               this.qysxItemVec[index].data = Model_guajiInfo.getInstance().qysxData[(this.currentPageIndex - 1) * 7 + index];
            }
            else
            {
               this.qysxItemVec[index].data = null;
            }
            index++;
         }
         this.tf_pageInfo.text = this.currentPageIndex + "/" + maxIndex;
      }
   }
}

