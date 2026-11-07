package com.yiTian.view.modules.keJu
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_KeJu;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   
   public class View_DS_Introduce extends Panel
   {
      
      private static var _instance:View_DS_Introduce;
      
      private var titleBg:Bitmap;
      
      public function View_DS_Introduce()
      {
         super();
         init();
      }
      
      public static function get instance() : View_DS_Introduce
      {
         if(!_instance)
         {
            _instance = new View_DS_Introduce();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":460,
            "height":260
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":412,
            "height":210
         },Global.Img_Cdm);
         move = new Rectangle(0,0,460,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":424,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         var content:MyTextField = ComponentUtil.getTextField("",this,{
            "x":39,
            "y":50,
            "color":16184781,
            "size":12,
            "leading":5
         });
         content.multiline = true;
         content.htmlText = LangConfig.getWord("1115",0);
         ComponentUtil.getTextField("30",this,{
            "x":146,
            "y":69,
            "color":2149919,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("80028",8),this,{
            "x":231,
            "y":88,
            "color":2149919,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("80029",8),this,{
            "x":290,
            "y":88,
            "color":16764206,
            "size":12,
            "leading":0
         });
         var tf2:MyTextField = ComponentUtil.getTextField("",this,{
            "x":39,
            "y":88,
            "color":2149919,
            "size":12,
            "leading":5
         });
         tf2.multiline = true;
         tf2.htmlText = LangConfig.getWord("1116",0);
         ComponentUtil.getTextField("20",this,{
            "x":266,
            "y":127,
            "color":2149919,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("80030",8),this,{
            "x":290,
            "y":146,
            "color":2149919,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("80031",8),this,{
            "x":195,
            "y":202,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("1117",0),this,{
            "x":39 + 35,
            "y":183,
            "color":16764206,
            "size":12,
            "leading":5
         });
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.KeJu_Imgsdm)
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
         arr.push([Enum_KeJu.KEJUSOURCE,this.sourceComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function sourceComplete(info:Object = null) : void
      {
         if(Boolean(info))
         {
            Global.KeJu_Imgsdm = info.applicationDomain;
         }
         this.titleBg = ComponentUtil.getBitmap("KeJu_DS_txt",this,{
            "x":140,
            "y":5
         },Global.KeJu_Imgsdm);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

