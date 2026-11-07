package com.yiTian.view.modules.marriage
{
   import com.event.TextField_h;
   import com.ui.controls.*;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.vo.*;
   import com.yiTian.manager.*;
   import com.yiTian.net.handler.MarriageHandler;
   import com.yiTian.utils.*;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.*;
   import com.yiTian.view.modules.Shopping.shoppingMall.ShoppingMallPan;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   
   public class View_MarriagePlane extends Panel123
   {
      
      private var btn_send:Button;
      
      private var tf_title:MyTextField;
      
      private var bg_back:DisplayObjectContainer;
      
      private const WIDTH:int = 605;
      
      private const HEIGHT:int = 468;
      
      public var selectItem:View_Grid;
      
      public var itemList:Array = new Array();
      
      private var ringList:Array = MarriageConfig.ring_idList;
      
      private var num:int = 0;
      
      private var bbb:Boolean = false;
      
      public function View_MarriagePlane()
      {
         super();
         regResource("lang/ch/Marry_Imgs.swf","Marry_Imgsdm");
      }
      
      override protected function initStaticView() : void
      {
         this.bg_back = new Sprite();
         this.bg_back.mouseEnabled = false;
         this.addChild(this.bg_back);
         move = new Rectangle(0,0,this.WIDTH,this.HEIGHT);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":494,
            "y":64
         },Global.Img_Cdm);
         this.tf_title = ComponentUtil.getTextField(LangConfig.getWord("1033",0),this,{
            "x":180,
            "y":178,
            "realWidth":256.2,
            "align":TextFormatAlign.CENTER
         });
         this.getRingGroup();
         this.resetPosition();
      }
      
      private function onSelectItem(evt:MouseEvent) : void
      {
         var i:int = 0;
         while(i < this.itemList.length)
         {
            this.itemList[i].bSelect = false;
            i++;
         }
         this.selectItem = evt.target as View_Grid;
         this.selectItem.bSelect = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.askSceneOKHd);
         }
         super.visible = value;
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getBitmap("Back_Marry",this.bg_back,{
            "x":0,
            "y":0
         },Global.Marry_Imgsdm);
         this.btn_send = ComponentUtil.getButton(LangConfig.getWord("1034",0),"Button_Marry",this,{
            "x":258,
            "y":322,
            "textColor":16184781
         },Global.Marry_Imgsdm);
         this.btn_send.callBack = this.onClick;
      }
      
      private function askSceneOKHd() : void
      {
         this.visible = false;
         Global.control.removeCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.askSceneOKHd);
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         if(GameUnitManager.hero.sex == 2)
         {
            Model_Marriage.showAlert(5);
            return;
         }
         var vec:Vector.<Vo_valuable> = CommandManager.get_bag_vec(Enum_filter.ALL);
         var hasRing:Boolean = false;
         var i:int = 0;
         while(i < vec.length)
         {
            if(vec[i] != null && vec[i].id == this.selectItem.vo.id)
            {
               hasRing = true;
               break;
            }
            i++;
         }
         if(hasRing)
         {
            MarriageHandler.CG_MARRIAGE_INITIATE(this.selectItem.vo.id);
            this.visible = false;
         }
         else
         {
            View_Alert.show(LangConfig.getWord("1035",0),View_Alert.OK_CANCAL,this.showShop);
         }
      }
      
      private function showShop() : void
      {
         var pan:ShoppingMallPan = Singleton.getInstance(ShoppingMallPan) as ShoppingMallPan;
         pan.openView(0,2);
      }
      
      private function getRingGroup() : void
      {
         var strList:Array = null;
         var i:int = 0;
         var tempGrid:View_Grid = null;
         var vo:Vo_item = null;
         var color:String = null;
         var tips:String = null;
         var tempTextField:TextField_h = null;
         strList = new Array(LangConfig.getWord("1063",0),LangConfig.getWord("1064",0),LangConfig.getWord("1065",0));
         i = 0;
         while(i < 3)
         {
            tempGrid = new View_Grid(true);
            tempGrid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
            tempGrid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
            tempGrid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
            vo = new Vo_item();
            vo.id = this.ringList[i];
            vo.Init_lib();
            tempGrid.vo = vo;
            this.addChild(tempGrid);
            tempGrid.x = 160 + i * 110;
            tempGrid.y = 212;
            tempGrid.addEventListener(MouseEvent.CLICK,this.onSelectItem);
            this.itemList.push(tempGrid);
            color = Model_Marriage.getColorStrByVoColor(vo.color);
            tips = LangConfig.getWord("1043",0,color,vo.str_name);
            TipManager.bind(tempGrid,tips);
            tempTextField = ComponentUtil.getTextField_h(strList[i],this,{
               "x":166.4 + i * 110,
               "y":285
            });
            i++;
         }
         this.selectItem = this.itemList[2];
         this.selectItem.bSelect = true;
      }
      
      override public function resetPosition() : void
      {
         this.x = Global.stage.stageWidth / 2 - this.WIDTH / 2;
         this.y = Global.stage.stageHeight / 2 - this.HEIGHT / 2;
      }
   }
}

