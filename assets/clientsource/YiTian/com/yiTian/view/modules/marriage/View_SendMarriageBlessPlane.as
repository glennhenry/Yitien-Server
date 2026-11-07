package com.yiTian.view.modules.marriage
{
   import com.event.TextField_h;
   import com.ui.controls.*;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.*;
   import com.yiTian.net.handler.MarriageHandler;
   import com.yiTian.utils.*;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   
   public class View_SendMarriageBlessPlane extends Panel
   {
      
      private var _data:Object = null;
      
      private var bg_board:DisplayObject;
      
      private var btn_send:Button;
      
      private var tf_title:TextField_h;
      
      private var bg_back:DisplayObject = new Bitmap();
      
      private const WIDTH:int = 605;
      
      private const HEIGHT:int = 468;
      
      public var selectItem:int = 0;
      
      public var itemList:Array = new Array();
      
      public var cashGift_idList:Array;
      
      public var cashGift_costList:Array;
      
      public function View_SendMarriageBlessPlane()
      {
         this.cashGift_idList = MarriageConfig.cashGift_idList;
         this.cashGift_costList = MarriageConfig.cashGift_costList;
         Utils.loadTitle("lang/ch/Marry_Imgs.swf","Back_Marry",this.bg_back as Bitmap,null);
         addChild(this.bg_back);
         super();
         Model_SendMarriageBless.countList.push(this);
         this.initStaticView();
         bindParent.addChild(this);
      }
      
      override protected function initStaticView() : void
      {
         move = new Rectangle(0,0,this.WIDTH,this.HEIGHT);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":494,
            "y":64
         });
         CloseButton.name = "close";
         CloseButton.callBack = this.onClick;
         this.tf_title = ComponentUtil.getTextField_h("",this,{
            "x":this.WIDTH / 2,
            "y":165
         });
         this.tf_title.autoSize = TextFormatAlign.CENTER;
         this.getRingGroup();
         this.btn_send = ComponentUtil.getButton(LangConfig.getWord("1009",0),"Button_Marry",this,{
            "x":265,
            "y":345
         });
         this.btn_send.name = "0";
         this.btn_send.addEventListener(MouseEvent.CLICK,this.onClick);
         this.resetPosition();
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         if(evt.target.name == "close")
         {
            this.dispose();
            return;
         }
         if(!this.data)
         {
            return;
         }
         this.selectItem = int(evt.target.name);
         if(this.selectItem == 0)
         {
            MarriageHandler.CG_MARRIAGE_BLESS_SEND(this.data.maleID,this.data.femaleID,0);
            this.dispose();
            return;
         }
         var color:String = Model_Marriage.getColorStrByVoColor(this.itemList[this.selectItem - 1].vo.color);
         var item:String = HtmlUtil.font(this.itemList[this.selectItem - 1].vo.str_name,color);
         var str:String = LangConfig.getWord("1007",0,this.cashGift_costList[this.selectItem - 1].toString(),this.data.maleName,this.data.femaleName,item);
         View_Alert.show(str,View_Alert.OK_CANCAL,this.moneyCheck);
      }
      
      private function moneyCheck() : void
      {
         if(GameUnitManager.hero.money < this.cashGift_costList[this.selectItem - 1])
         {
            Model_Marriage.showAlert(106);
         }
         else
         {
            this.send();
         }
      }
      
      private function send() : void
      {
         MarriageHandler.CG_MARRIAGE_BLESS_SEND(this.data.maleID,this.data.femaleID,this.selectItem);
         GameUnitManager.hero.autoMoveLocation(12304);
         this.dispose();
      }
      
      private function getRingGroup() : void
      {
         var expArr:Array = null;
         var i:int = 0;
         var tempGrid:View_Grid = null;
         var vo:Vo_item = null;
         var color:String = null;
         var str:String = null;
         var tf:MyTextField = null;
         var btn:Button = null;
         expArr = [20000,50000,100000];
         i = 0;
         while(i < 3)
         {
            tempGrid = new View_Grid(true);
            tempGrid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
            tempGrid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
            tempGrid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
            vo = new Vo_item();
            vo.id = this.cashGift_idList[i];
            vo.Init_lib();
            tempGrid.vo = vo;
            this.addChild(tempGrid);
            tempGrid.x = 160 + i * 115;
            tempGrid.y = 200;
            this.itemList.push(tempGrid);
            color = Model_Marriage.getColorStrByVoColor(vo.color);
            str = LangConfig.getWord("29275",2,expArr[i].toString());
            tf = ComponentUtil.getTextField("",this,{
               "y":tempGrid.y + 75,
               "x":tempGrid.x,
               "realWidth":70
            });
            tf.autoSize = TextFieldAutoSize.CENTER;
            tf.htmlText = Enum_BroadCastTool.instance.getColorStr(str,i + 2);
            btn = ComponentUtil.getButton(LangConfig.getWord("1008",0),"Button_Orange",this,{
               "x":tempGrid.x - 2,
               "y":295
            },Global.Img_Cdm);
            btn.name = (i + 1).toString();
            btn.addEventListener(MouseEvent.CLICK,this.onClick);
            i++;
         }
      }
      
      override public function resetPosition() : void
      {
         this.x = Global.stage.stageWidth / 2 - this.WIDTH / 2;
         this.y = Global.stage.stageHeight / 2 - this.HEIGHT / 2;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(value:Object) : void
      {
         this._data = value;
         var msg:String = LangConfig.getWord("29448",2,this.data.maleName,this.data.femaleName);
         this.tf_title.htmlText = msg;
         visible = true;
      }
      
      public function restart() : void
      {
         visible = true;
         Model_SendMarriageBless.countList.push(this);
         this.resetPosition();
         this.btn_send.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      public function dispose() : void
      {
         this.tf_title.htmlText = "";
         visible = false;
         this.btn_send.removeEventListener(MouseEvent.CLICK,this.onClick);
         Model_SendMarriageBless.pool.push(this);
         Model_SendMarriageBless.countList.splice(Model_SendMarriageBless.countList.indexOf(this),1);
      }
   }
}

