package com.yiTian.view.modules.vip
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_Vip;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.Shopping.shoppingMall.ShoppingMallPan;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   
   public class OpenVipPanel extends Panel
   {
      
      private var titleBg:Bitmap;
      
      private var vecOVI:Vector.<OpenVipItem>;
      
      public var vecId:Vector.<int> = new <int>[46340,46341,46342];
      
      private var txtShop:MyTextField;
      
      private var isFirstOpen:Boolean = true;
      
      public function OpenVipPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var ovi:OpenVipItem = null;
         var i:int = 0;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":508,
            "height":280
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":460,
            "height":230
         },Global.Img_Cdm);
         move = new Rectangle(0,0,480,40);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":474,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         i = 3;
         var vecName:Vector.<String> = new <String>[LangConfig.getWord("10420",1),LangConfig.getWord("10419",1),LangConfig.getWord("10418",1)];
         var vecPrice:Vector.<int> = new <int>[68,288,1688];
         this.vecOVI = new Vector.<OpenVipItem>(i,true);
         while(Boolean(i--))
         {
            ovi = new OpenVipItem(vecName[i],vecPrice[i],this.vecId[i]);
            ovi.x = 35 + 149 * i;
            ovi.y = 50;
            ovi.type = i + 1;
            addChild(ovi);
            this.vecOVI[i] = ovi;
         }
         this.txtShop = ComponentUtil.getTextField("",this,{
            "x":42,
            "y":245,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.txtShop.type = TextFieldType.INPUT;
         this.txtShop.selectable = false;
         this.txtShop.restrict = "";
         this.txtShop.htmlText = LangConfig.getWord("10421",1) + " <u><font color=\'#F4CD31\'><a href=\"event:" + LangConfig.getWord("10422",1) + "\">" + LangConfig.getWord("10422",1) + "</a></font></u> " + LangConfig.getWord("10423",1);
         this.txtShop.addEventListener(TextEvent.LINK,this.linkEvent);
      }
      
      protected function linkEvent(e:TextEvent) : void
      {
         var pan:ShoppingMallPan = Singleton.getInstance(ShoppingMallPan) as ShoppingMallPan;
         pan.visible = !pan.visible;
         this.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:int = 0;
         super.visible = value;
         if(value)
         {
            if(!Global.VIP_Imgsdm)
            {
               this.load();
            }
            else if(!this.titleBg)
            {
               this.sourceComplete();
            }
         }
         if(value && this.isFirstOpen)
         {
            i = 3;
            while(Boolean(i--))
            {
               this.vecOVI[i].init();
            }
            this.isFirstOpen = false;
         }
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push([Enum_Vip.VIPSOURCE,this.sourceComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function sourceComplete(info:Object = null) : void
      {
         if(Boolean(info))
         {
            Global.VIP_Imgsdm = info.applicationDomain;
         }
         this.titleBg = ComponentUtil.getBitmap("Title_WuHun",this,{
            "x":174,
            "y":5
         },Global.VIP_Imgsdm);
      }
   }
}

