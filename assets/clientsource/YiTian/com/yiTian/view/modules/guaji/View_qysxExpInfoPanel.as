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
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.GuaJiCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_qysxExpInfoPanel extends Panel
   {
      
      private var titleBg:Bitmap;
      
      private var tf_info:MyTextField;
      
      private var btn_stopSX:Button;
      
      public function View_qysxExpInfoPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":398,
            "height":180
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":350,
            "height":130
         },Global.Img_Cdm);
         move = new Rectangle(0,0,398,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":364,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.tf_info = ComponentUtil.getTextField("",this,{
            "y":64,
            "color":14662240,
            "size":12,
            "leading":6,
            "realWidth":398
         });
         this.tf_info.align = "center";
         this.tf_info.wordWrap = true;
         this.btn_stopSX = ComponentUtil.getButton(LangConfig.getWord("21121",2),"Button_Four",this,{
            "x":166,
            "y":123,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.btn_stopSX.callBack = this.stopSXClickHandle;
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
         this.titleBg = ComponentUtil.getBitmap("Title_ShuangXiu",this,{
            "x":119,
            "y":5
         },Global.GuaJi_Imgsdm);
      }
      
      public function updateView(wawaTime:int, isGJ:int) : void
      {
         var type:int = Model_guajiInfo.getInstance().sxType;
         var strArr:Array = Enum_GuaJi.SHUANGXIUADDPERCENT;
         switch(type)
         {
            case 1:
               this.tf_info.text = "";
               this.visible = false;
               break;
            case 2:
               this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("21122",2),ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12) + HtmlUtil.font(strArr[type] + "%",ColorConstant.getColorStr(ColorConstant.GREEN),12);
               UIManager.qysxPanel.visible = false;
               if(isGJ == 1)
               {
                  this.visible = false;
               }
               break;
            case 3:
               this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("21123",2),ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12) + HtmlUtil.font(strArr[type] + "%",ColorConstant.getColorStr(ColorConstant.GREEN),12);
               UIManager.qysxPanel.visible = false;
               UIManager.heroHead.removeBuff(View_wwsxMoveButton.getInstance());
               break;
            case 4:
               this.tf_info.htmlText = HtmlUtil.font(LangConfig.getWord("21124",2),ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12) + HtmlUtil.font(strArr[type] + "%",ColorConstant.getColorStr(ColorConstant.GREEN),12);
               UIManager.qysxPanel.visible = false;
               break;
            default:
               this.tf_info.text = "";
               this.visible = false;
         }
         this.resetPosition();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2 + 300;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      private function stopSXClickHandle(evt:MouseEvent) : void
      {
         if(Model_guajiInfo.getInstance().sxType == 2)
         {
            GuaJiCGMessage.CG_CHANGEWAWASHUANGXIU(2);
         }
         else
         {
            GuaJiCGMessage.CG_CANCEL_SHUANGXIU(Model_guajiInfo.getInstance().currentSXName);
         }
      }
   }
}

