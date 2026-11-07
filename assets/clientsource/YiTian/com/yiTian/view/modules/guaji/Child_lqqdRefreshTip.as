package com.yiTian.view.modules.guaji
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_GuaJi;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class Child_lqqdRefreshTip extends Sprite
   {
      
      private static var instance:Child_lqqdRefreshTip;
      
      private var titleBg:Bitmap;
      
      private var tf_info:MyTextField;
      
      private var btn_refreshok:Button;
      
      private var btn_continue:Button;
      
      private var btn_cancel:Button;
      
      private var _cbFun:Function;
      
      public function Child_lqqdRefreshTip()
      {
         super();
         if(Boolean(instance))
         {
            throw new Error("singlon error");
         }
         this.init();
         instance = this;
      }
      
      public static function getInstance() : Child_lqqdRefreshTip
      {
         if(instance)
         {
         }
         return instance;
      }
      
      private function init() : void
      {
         this.visible = false;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":338,
            "height":180
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":290,
            "height":130
         },Global.Img_Cdm);
         this.tf_info = ComponentUtil.getTextField("",this,{
            "y":68,
            "realWidth":width
         });
         this.tf_info.autoSize = TextFieldAutoSize.CENTER;
         this.btn_continue = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Four",this,{
            "x":65,
            "y":120
         },Global.Img_Cdm);
         this.btn_cancel = ComponentUtil.getButton(LangConfig.getWord("29035",2),"Button_Four",this,{
            "x":185,
            "y":120
         },Global.Img_Cdm);
         this.btn_refreshok = ComponentUtil.getButton(LangConfig.getWord("29039",2),"Button_Four",this,{
            "x":125.5,
            "y":120
         },Global.Img_Cdm);
         this.btn_continue.callBack = this.continueClickHandle;
         this.btn_cancel.callBack = this.cancelClickHandle;
         this.btn_refreshok.callBack = this.okClickHandle;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
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
         this.titleBg = ComponentUtil.getBitmap("Title_LQQiangDuo",this,{
            "x":89,
            "y":5
         },Global.GuaJi_Imgsdm);
      }
      
      private function continueClickHandle(evt:MouseEvent) : void
      {
         this._cbFun();
         this.visible = false;
      }
      
      private function cancelClickHandle(evt:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function okClickHandle(evt:MouseEvent) : void
      {
         this.visible = false;
      }
      
      public function show(type:int, callback:Function = null) : void
      {
         this.visible = true;
         if(type == 1)
         {
            this.btn_refreshok.visible = true;
            this.btn_continue.visible = false;
            this.btn_cancel.visible = false;
            this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("21177",2),ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
         }
         else if(type == 2)
         {
            this._cbFun = callback;
            this.btn_refreshok.visible = false;
            this.btn_continue.visible = true;
            this.btn_cancel.visible = true;
            this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("21178",2),ColorConstant.getColorStr(ColorConstant.RED),12);
         }
         else if(type == 3)
         {
            this._cbFun = callback;
            this.btn_refreshok.visible = false;
            this.btn_continue.visible = true;
            this.btn_cancel.visible = true;
            this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("21179",2),ColorConstant.getColorStr(ColorConstant.RED),12);
         }
      }
   }
}

