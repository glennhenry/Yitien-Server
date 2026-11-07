package com.yiTian.view.modules.marriage
{
   import com.ui.controls.*;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.handler.MarriageHandler;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_HongBao extends Panel
   {
      
      private var tf_title:MyTextField;
      
      private var bg_back:DisplayObjectContainer;
      
      private const WIDTH:int = 479;
      
      private const HEIGHT:int = 240;
      
      private var selectItem:Child_HongBao;
      
      public var costList:Array = MarriageConfig.hongBao_costList;
      
      private var isUIComplete:Boolean = false;
      
      public function View_HongBao()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.bg_back = new Sprite();
         this.bg_back.mouseEnabled = false;
         addChild(this.bg_back);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.bg_back,{
            "x":0,
            "y":0,
            "width":507,
            "height":240
         },Global.Img_Cdm);
         move = new Rectangle(0,0,479,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":473,
            "y":6
         },Global.Img_Cdm);
      }
      
      override public function set visible(value:Boolean) : void
      {
         var arr:Array = null;
         if(value)
         {
            if(!this.isUIComplete)
            {
               if(!Global.Marry_Imgsdm)
               {
                  arr = [];
                  arr.push(["lang/ch/Marry_Imgs.swf",function(info:Object):void
                  {
                     Global.Marry_Imgsdm = info.applicationDomain;
                  },LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
                  View_loading.instance.load(arr,function():void
                  {
                     initT();
                     View_loading.instance.visible = false;
                     visible = true;
                  });
                  return;
               }
               this.initT();
            }
         }
         super.visible = value;
      }
      
      private function initT() : void
      {
         var temp:Child_HongBao = null;
         this.isUIComplete = true;
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.bg_back,{
            "x":24,
            "y":40,
            "width":459,
            "height":190
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_MarryBag",this,{
            "x":174,
            "y":5
         },Global.Marry_Imgsdm);
         var i:int = 0;
         while(i < 3)
         {
            temp = new Child_HongBao(i);
            this.addChild(temp);
            temp.x = 33 + i * 150;
            temp.y = 50;
            temp.btn.addEventListener(MouseEvent.CLICK,this.onClick);
            i++;
         }
      }
      
      public function onClick(evt:MouseEvent) : void
      {
         if(GameUnitManager.hero.money < this.costList[int(evt.target.name)])
         {
            Model_Marriage.showAlert(106);
            return;
         }
         var type:int = int(evt.target.name) + 1;
         MarriageHandler.CG_MARRIAGE_ADDCASHGIFT(type);
      }
      
      override public function resetPosition() : void
      {
         this.x = Global.stage.stageWidth / 2 - this.WIDTH / 2;
         this.y = Global.stage.stageHeight / 2 - this.HEIGHT / 2;
      }
   }
}

