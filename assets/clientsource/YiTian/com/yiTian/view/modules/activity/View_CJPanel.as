package com.yiTian.view.modules.activity
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.AwardOnlineCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class View_CJPanel extends Panel
   {
      
      private static var isLoad:Boolean = false;
      
      private var bg:Sprite;
      
      public var cjBroad:Child_cjBoard;
      
      private var isFirstOpen:Boolean = true;
      
      private var _loadFlag:Boolean = false;
      
      public function View_CJPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.bg = new Sprite();
         this.bg.graphics.beginFill(0,0);
         this.bg.graphics.drawRect(0,0,560,427);
         this.bg.graphics.endFill();
         addChild(this.bg);
         this.bg.visible = false;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":536,
            "height":420
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":488,
            "height":370
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":31,
            "y":48,
            "width":472,
            "height":29
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":31,
            "y":81,
            "width":350,
            "height":140
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":385,
            "y":81,
            "width":118,
            "height":140
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":31,
            "y":230,
            "width":472,
            "height":26
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":31,
            "y":260,
            "width":350,
            "height":140
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":385,
            "y":260,
            "width":118,
            "height":140
         },Global.Img_Cdm);
         move = new Rectangle(0,0,558,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":504,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.cjBroad = new Child_cjBoard();
         addChild(this.cjBroad);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               bind_target = Enum_explor.bind(Enum_explor.BTN_FU);
               if(!Global.Award_Imgsdm)
               {
                  SingleLoader.add("lang/ch/Award_Imgs.swf",function(info:Object):void
                  {
                     Global.Award_Imgsdm = info.applicationDomain;
                     showB();
                  });
               }
               else if(!isLoad)
               {
                  this.showB();
               }
            }
            this.loadd();
            AwardOnlineCGMessage.CG_GET_CJ_INFO_BOARD();
         }
         super.visible = value;
      }
      
      private function showB() : void
      {
         isLoad = true;
         ComponentUtil.getBitmap("Title_AwardOnLine",this,{
            "x":188,
            "y":5
         },Global.Award_Imgsdm);
      }
      
      private function loadd() : void
      {
         if(!this._loadFlag)
         {
            this._loadFlag = true;
            this.cjBroad.enableGridLoad();
         }
      }
      
      public function get loadFlag() : Boolean
      {
         return this._loadFlag;
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.bg.width) / 2;
         y = (Global.stage.stageHeight - this.bg.height) / 2;
      }
   }
}

