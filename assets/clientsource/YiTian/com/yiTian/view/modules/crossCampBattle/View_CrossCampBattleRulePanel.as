package com.yiTian.view.modules.crossCampBattle
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class View_CrossCampBattleRulePanel extends Panel
   {
      
      private var bg:DisplayObjectContainer;
      
      private var tf:MyTextField;
      
      private var back1:ScaleBitmap;
      
      private var back2:ScaleBitmap;
      
      private var isUIComplete:Boolean = false;
      
      public function View_CrossCampBattleRulePanel()
      {
         super();
         init();
      }
      
      public static function get instance() : View_CrossCampBattleRulePanel
      {
         return Singleton.getInstance(View_CrossCampBattleRulePanel);
      }
      
      override protected function initStaticView() : void
      {
         this.bg = new Sprite();
         this.bg.mouseEnabled = false;
         addChild(this.bg);
         this.back1 = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.bg,{
            "x":0,
            "y":0,
            "width":620,
            "height":195
         },Global.Img_Cdm);
         this.back2 = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.bg,{
            "x":24,
            "y":40,
            "width":565,
            "height":148
         },Global.Img_Cdm);
         move = new Rectangle(0,0,633,38);
         this.tf = ComponentUtil.getTextField("",this,{
            "x":38,
            "y":50,
            "realWidth":550,
            "color":16777215,
            "multiline":true,
            "wordWrap":true,
            "leading":5,
            "size":12
         });
         this.tf.htmlText = LangConfig.getWord("228",9);
         this.back1.height = this.tf.textHeight + 69;
         this.back2.height = this.tf.textHeight + 22;
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":586,
            "y":6
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      override public function set visible(value:Boolean) : void
      {
         var arr:Array = null;
         if(value)
         {
            if(!this.isUIComplete)
            {
               if(!Global.crossCampBattle_Imgdm)
               {
                  arr = [];
                  arr.push(["lang/ch/JCYB.swf",function(info:Object):void
                  {
                     Global.crossCampBattle_Imgdm = info.applicationDomain;
                  },LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
                  View_loading.instance.load(arr,function():void
                  {
                     initT();
                     visible = true;
                     View_loading.instance.visible = false;
                  });
                  return;
               }
               this.initT();
            }
            bind_target = Enum_explor.bind(Enum_explor.BTN_CROSS_CAMP_HELP);
         }
         super.visible = value;
      }
      
      private function initT() : void
      {
         this.isUIComplete = true;
         ComponentUtil.getBitmap("Title_WFJS",this,{
            "x":222,
            "y":5
         },Global.crossCampBattle_Imgdm);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

