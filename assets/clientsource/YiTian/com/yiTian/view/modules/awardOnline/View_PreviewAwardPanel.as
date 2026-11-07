package com.yiTian.view.modules.awardOnline
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_png;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_PreviewAwardPanel extends Panel
   {
      
      private static var instance:View_PreviewAwardPanel;
      
      private var back:DisplayObject;
      
      private var tf_timer:MyTextField;
      
      private var btn_cancel:Button;
      
      private var bm_icon:Bitmap;
      
      private var tf_msg:MyTextField;
      
      private var gridArr:Array;
      
      private var loadFlag:Boolean = false;
      
      private var bmTitle:Bitmap = new Bitmap();
      
      public function View_PreviewAwardPanel()
      {
         super();
         this.initGraphics();
      }
      
      public static function getInstance() : View_PreviewAwardPanel
      {
         if(!instance)
         {
            instance = new View_PreviewAwardPanel();
         }
         return instance;
      }
      
      private function btn_cancelClickHandle(evt:MouseEvent) : void
      {
         this.visible = false;
      }
      
      public function update() : void
      {
         var index:uint = 0;
         var vo:Vo_item = null;
         var arr:Array = AwardItemData.getInstance().dataArr;
         index = 0;
         while(index < arr.length)
         {
            vo = new Vo_item();
            vo.id = arr[index][0];
            vo.Init_lib();
            vo.count = arr[index][2];
            this.gridArr[index].vo = vo;
            index++;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
      
      protected function initGraphics() : void
      {
         var grid:View_Grid = null;
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":300,
            "height":285
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":252,
            "height":200
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":31,
            "y":48,
            "width":238,
            "height":75
         },Global.Img_Cdm);
         this.bm_icon = new Bitmap();
         this.bm_icon = Utils.getLoadBitmap("resource/image/myPath/" + "box1" + ".png",this.bm_icon);
         this.bm_icon.x = 45;
         this.bm_icon.y = 45;
         addChild(this.bm_icon);
         this.tf_msg = ComponentUtil.getTextField("",this,{
            "x":40,
            "y":130,
            "color":11904647,
            "size":12,
            "leading":0,
            "realWidth":220
         });
         this.tf_msg.wordWrap = true;
         this.tf_msg.mouseEnabled = false;
         var str:String = LangConfig.getWord("29162",2);
         this.tf_msg.text = str;
         this.btn_cancel = ComponentUtil.getButton(LangConfig.getWord("29035",2),"Button_Four",this,{
            "x":112,
            "y":245,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_cancel.addEventListener(MouseEvent.CLICK,this.btn_cancelClickHandle);
         this.gridArr = new Array();
         var index:int = 0;
         while(index < 3)
         {
            grid = new View_Grid();
            grid.isAutoLoad = false;
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_tf_count(true,true,true);
            grid.x = 60 + (30 + Const_png.SIZE_GRID) * index;
            grid.y = 185;
            addChild(grid);
            this.gridArr.push(grid);
            index++;
         }
         this.tf_timer = ComponentUtil.getTextField("",this,{
            "x":140,
            "y":68,
            "color":16767490,
            "size":24,
            "leading":0
         });
         move = new Rectangle(0,0,236,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":266,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.addEventListener(MouseEvent.CLICK,this.closeButtonClickHandle);
         this.resetPosition();
      }
      
      private function loadd() : void
      {
         var g:View_Grid = null;
         if(!this.loadFlag)
         {
            this.loadFlag = true;
            for each(g in this.gridArr)
            {
               g.beginLoad();
               g.isAutoLoad = true;
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            this.loadd();
            if(!this.bmTitle.bitmapData)
            {
               Utils.loadTitle("lang/ch/Award_Imgs.swf","AwardWait",this.bmTitle,{
                  "x":70,
                  "y":5
               },this);
            }
         }
         super.visible = value;
      }
      
      private function closeButtonClickHandle(evt:MouseEvent) : void
      {
         this.visible = false;
      }
      
      public function set timeString(value:String) : void
      {
         this.tf_timer.htmlText = HtmlUtil.font(value,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),26);
      }
   }
}

