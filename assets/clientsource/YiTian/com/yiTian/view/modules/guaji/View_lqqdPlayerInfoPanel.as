package com.yiTian.view.modules.guaji
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_GuaJi;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class View_lqqdPlayerInfoPanel extends Panel
   {
      
      private var titleBg:Bitmap;
      
      private var tf_lingqiName:MyTextField;
      
      private var btn_nextPage:Button;
      
      private var btn_fontPage:Button;
      
      private var tf_pageIndex:TextField;
      
      private var lqqdListItemVec:Vector.<Child_lqqdListItem>;
      
      private var tb1:TabButton;
      
      private var tb2:TabButton;
      
      private var tb3:TabButton;
      
      public var currentType:int = 1;
      
      public var currentIndex:int = 1;
      
      private var maxPage:int = 0;
      
      public function View_lqqdPlayerInfoPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var index:int = 0;
         var lqqdListItem:Child_lqqdListItem = null;
         var back:ScaleBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":338,
            "height":277
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":23,
            "y":67,
            "width":292,
            "height":202
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":27,
            "y":71,
            "width":284,
            "height":172
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":139,
            "y":245,
            "width":60,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":29,
            "y":73,
            "width":280,
            "height":20
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,42);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":304,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("223",9),this,{
            "x":32,
            "y":72,
            "color":16764206
         });
         ComponentUtil.getTextField(LangConfig.getWord("224",9),this,{
            "x":104,
            "y":72,
            "color":16764206
         });
         ComponentUtil.getTextField(LangConfig.getWord("10577",1),this,{
            "x":190,
            "y":72,
            "color":16764206
         });
         ComponentUtil.getTextField(LangConfig.getWord("29229",2),this,{
            "x":264,
            "y":71,
            "color":16764206
         });
         this.tf_lingqiName = ComponentUtil.getTextField(LangConfig.getWord("21129",2),this,{
            "x":123,
            "y":41,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.btn_fontPage = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":118,
            "y":245,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_nextPage = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":200,
            "y":245,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_fontPage.callBack = this.fontPageClickHandle;
         this.btn_nextPage.callBack = this.nextPageClickHandle;
         this.tf_pageIndex = ComponentUtil.getTextField("0/0",this,{
            "x":170,
            "y":245,
            "color":16764206,
            "realWidth":0
         });
         this.tf_pageIndex.autoSize = TextFieldAutoSize.CENTER;
         this.lqqdListItemVec = new Vector.<Child_lqqdListItem>();
         index = 0;
         while(index < 5)
         {
            lqqdListItem = new Child_lqqdListItem();
            lqqdListItem.x = 28;
            lqqdListItem.y = 92 + index * 30;
            addChild(lqqdListItem);
            this.lqqdListItemVec.push(lqqdListItem);
            index++;
         }
         addChild(Child_lqqdRefreshTip.getInstance());
         Child_lqqdRefreshTip.getInstance().x = 0;
         Child_lqqdRefreshTip.getInstance().y = 64;
      }
      
      public function refreshTipShow() : void
      {
         Child_lqqdRefreshTip.getInstance().show(1);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2 + 250;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         var _x:Number = NaN;
         var __x:Number = NaN;
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
            this.tb1.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         if(value && UIManager.guajiPanel.visible && !this.visible)
         {
            this.resetPosition();
            _x = (Global.stage.stageWidth - width) / 2 + 250;
            Tween.to(this,300,{"x":[x,_x]});
            UIManager.guajiPanel.resetPosition();
            Tween.to(UIManager.guajiPanel,300,{"x":[UIManager.guajiPanel.x,UIManager.guajiPanel.x + 200]},null,null,Tween.EASYINOUT);
         }
         if(!value && UIManager.guajiPanel.visible && this.visible)
         {
            __x = (Global.stage.stageWidth - width) / 2 + 250;
            Tween.to(UIManager.guajiPanel,300,{"x":[UIManager.guajiPanel.x,__x]},null,null,Tween.EASYINOUT);
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
         this.titleBg = ComponentUtil.getBitmap("BT_txt",this,{
            "x":89,
            "y":5
         },Global.GuaJi_Imgsdm);
         this.tb1 = ComponentUtil.getTabButton("","BT_ZS",this,{
            "x":27,
            "y":37,
            "textColor":16184781,
            "tabIndex":1
         },Global.GuaJi_Imgsdm);
         this.tb1.addEventListener(MouseEvent.CLICK,this.tabBtnClickHd);
         this.tb2 = ComponentUtil.getTabButton("","BT_LS",this,{
            "x":122,
            "y":37,
            "textColor":16184781,
            "tabIndex":2
         },Global.GuaJi_Imgsdm);
         this.tb2.addEventListener(MouseEvent.CLICK,this.tabBtnClickHd);
         this.tb3 = ComponentUtil.getTabButton("","BT_LuS",this,{
            "x":217,
            "y":37,
            "textColor":16184781,
            "tabIndex":3
         },Global.GuaJi_Imgsdm);
         this.tb3.addEventListener(MouseEvent.CLICK,this.tabBtnClickHd);
         this.tb1.choose = true;
      }
      
      private function tabBtnClickHd(e:MouseEvent) : void
      {
         var target:TabButton = e.target as TabButton;
         this.tb3.choose = this.tb2.choose = this.tb1.choose = false;
         target.choose = true;
         this.updateView(1,target.tabIndex);
      }
      
      public function updateView(pageIndex:int, lqType:int) : void
      {
         var iadd:int = 0;
         this.currentType = lqType;
         this.maxPage = int(Enum_GuaJi.LINGQIPOS[this.currentType] / 5);
         if(pageIndex < 1 || pageIndex > this.maxPage)
         {
            return;
         }
         this.tf_pageIndex.text = pageIndex + "/" + this.maxPage.toString();
         this.tf_lingqiName.htmlText = Enum_GuaJi.LINGQIHTMLNAME[lqType];
         var lqTypeIndex:int = this.currentType - 1;
         this.currentIndex = pageIndex;
         var s:Array = Model_guajiInfo.getInstance().lqRoomInfoArr;
         var roomInfo:Array = Model_guajiInfo.getInstance().lqRoomInfoArr;
         var i:int = 0;
         while(i < 5)
         {
            iadd = i + 1;
            this.lqqdListItemVec[i].setInfo(roomInfo[lqTypeIndex][(this.currentIndex - 1) * 5 + iadd],iadd);
            i += 1;
         }
      }
      
      override public function get visible() : Boolean
      {
         return super.visible;
      }
      
      public function set lingqiName(value:String) : void
      {
         this.tf_lingqiName.text = value;
      }
      
      private function fontPageClickHandle(evt:MouseEvent) : void
      {
         this.updateView(this.currentIndex - 1,this.currentType);
      }
      
      private function nextPageClickHandle(evt:MouseEvent) : void
      {
         this.updateView(this.currentIndex + 1,this.currentType);
      }
   }
}

