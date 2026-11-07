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
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.AwardOnlineCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_GetAwardPanel extends Panel
   {
      
      private static var instance:View_GetAwardPanel;
      
      private var back:DisplayObject;
      
      private var btn_getAward:Button;
      
      private var bm_icon:Bitmap;
      
      private var tf_mainMsg:MyTextField;
      
      private var tf_msg:MyTextField;
      
      private var gridArr:Array;
      
      private var loadFlag:Boolean = false;
      
      private var bmTitle:Bitmap = new Bitmap();
      
      public function View_GetAwardPanel()
      {
         super();
         this.initGraphics();
      }
      
      public static function getInstance() : View_GetAwardPanel
      {
         if(!instance)
         {
            instance = new View_GetAwardPanel();
         }
         return instance;
      }
      
      private function btn_getAwardClickHandle(evt:MouseEvent) : void
      {
         if(CommandManager.get_bag_canUse() < 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29055",2));
            return;
         }
         AwardOnlineCGMessage.CG_GET_AWARD(AwardItemData.getInstance().id);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
      
      public function update() : void
      {
         var vo:Vo_item = null;
         var arr:Array = AwardItemData.getInstance().dataArr;
         this.nextInfoTime = AwardItemData.getInstance().nextTimeCount;
         var index:uint = 0;
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
         this.bm_icon = Utils.getLoadBitmap("resource/image/myPath/" + "box3" + ".png",this.bm_icon);
         this.bm_icon.x = 45;
         this.bm_icon.y = 45;
         addChild(this.bm_icon);
         this.tf_msg = ComponentUtil.getTextField("",this,{
            "x":40,
            "y":130,
            "color":11904647,
            "size":14,
            "leading":0,
            "realWidth":220
         });
         this.tf_msg.wordWrap = true;
         var msgStr:String = LangConfig.getWord("29158",2);
         this.tf_msg.text = msgStr;
         this.tf_msg.mouseEnabled = false;
         this.tf_mainMsg = ComponentUtil.getTextField("",this,{
            "x":125,
            "y":70,
            "color":11904647,
            "size":12,
            "leading":0,
            "realWidth":130
         });
         this.tf_mainMsg.wordWrap = true;
         this.tf_mainMsg.mouseEnabled = false;
         addChild(this.tf_msg);
         addChild(this.tf_mainMsg);
         move = new Rectangle(0,0,this.back.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":266,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.addEventListener(MouseEvent.CLICK,this.closeButtonClickHandle);
         this.btn_getAward = ComponentUtil.getButton(LangConfig.getWord("29159",2),"Button_Four",this,{
            "x":112,
            "y":245,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_getAward.addEventListener(MouseEvent.CLICK,this.btn_getAwardClickHandle);
         this.gridArr = new Array();
         var index:int = 0;
         while(index < 3)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_bmp_bg();
            grid.isAutoLoad = false;
            grid.set_bmp_over(true,null);
            grid.set_tf_count(true,true,true);
            grid.x = 60 + (30 + Const_png.SIZE_GRID) * index;
            grid.y = 185;
            addChild(grid);
            this.gridArr.push(grid);
            index++;
         }
         this.resetPosition();
      }
      
      private function closeButtonClickHandle(evt:MouseEvent) : void
      {
         this.visible = false;
      }
      
      public function set nextInfoTime(value:int) : void
      {
         var str:String = null;
         var i:int = AwardItemData.getInstance().id;
         if(i < 5)
         {
            str = LangConfig.getWord("29160",2,int(value / 60).toString());
            this.tf_mainMsg.htmlText = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
         }
         else
         {
            this.tf_mainMsg.htmlText = HtmlUtil.fontNoSize(LangConfig.getWord("29161",2),ColorConstant.getColorStr(ColorConstant.RED));
         }
      }
      
      public function showBenz() : void
      {
         var index:int = 0;
         while(index < this.gridArr.length)
         {
            ComboTweenStep.toBag(this.gridArr[index],-1);
            index++;
         }
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
   }
}

