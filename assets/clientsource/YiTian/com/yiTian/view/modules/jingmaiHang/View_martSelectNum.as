package com.yiTian.view.modules.jingmaiHang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_mart;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.MartCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   
   public class View_martSelectNum extends Panel
   {
      
      private static var SOLDWP:int = 0;
      
      private static var SOLDPRICE:int = 1;
      
      private static var SOLDNUM:int = 2;
      
      private static var OK:int = 0;
      
      private static var CANCEL:int = 1;
      
      private static var stype:int = 1;
      
      private static var isFirstOpen:Boolean = true;
      
      private var back:ScaleBitmap;
      
      private var tf_vec:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var btn_vec:Vector.<Button> = new Vector.<Button>();
      
      private var label_arr:Array = new Array();
      
      private var i:int;
      
      private var grid:View_Grid;
      
      private var priceTF:MyTextField;
      
      private var numsTF:MyTextField;
      
      private var priceTypeBmp:Bitmap;
      
      private var shape:Shape;
      
      private var spr:Sprite;
      
      private var isGetGood:Boolean = false;
      
      private var gridId:int;
      
      private var utl:Array = ["resource/image/priceTypes/silver.png","resource/image/priceTypes/gold.png"];
      
      private var max:int;
      
      private var priceType:int;
      
      private var price:int;
      
      private var _martId:Number = 0;
      
      private var titleStr:Array = new Array();
      
      public function View_martSelectNum()
      {
         super();
      }
      
      public static function setType(valueType:int) : void
      {
         stype = valueType;
      }
      
      private function initStr() : void
      {
         this.label_arr = [LangConfig.getWord("6",0),LangConfig.getWord("5",0)];
         this.titleStr = [[LangConfig.getWord("393",0),LangConfig.getWord("394",0),LangConfig.getWord("395",0)],[LangConfig.getWord("386",0),LangConfig.getWord("396",0),LangConfig.getWord("387",0)]];
      }
      
      override protected function initStaticView() : void
      {
         var tf:MyTextField = null;
         var btn:Button = null;
         this.shape = ComponentUtil.getShape(Global.stage.stageWidth,Global.stage.stageHeight,0,0.2);
         addChildAt(this.shape,0);
         this.spr = new Sprite();
         addChild(this.spr);
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.spr,{
            "x":0,
            "y":0,
            "width":300,
            "height":197
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.spr,{
            "x":24,
            "y":40,
            "width":256,
            "height":120
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.spr,{
            "x":125,
            "y":120,
            "width":60,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WXPrompt",this.spr,{
            "x":73,
            "y":5
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this.spr,{
            "x":266,
            "y":6,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         this.i = 0;
         while(this.i < 3)
         {
            tf = ComponentUtil.getTextField("",this,{
               "y":65,
               "color":11904647
            });
            this.tf_vec[this.i] = tf;
            ++this.i;
         }
         this.tf_vec[SOLDWP].y = 60;
         this.tf_vec[SOLDPRICE].y = 98;
         this.tf_vec[SOLDNUM].y = 125;
         this.initStr();
         this.i = 0;
         while(this.i < 2)
         {
            btn = ComponentUtil.getButton(this.label_arr[this.i],"Button_Four",this,null,Global.Img_Cdm);
            this.btn_vec[this.i] = btn;
            btn.addEventListener(MouseEvent.CLICK,this.cliHandle);
            ++this.i;
         }
         this.btn_vec[OK].x = 80;
         this.btn_vec[OK].y = 175;
         this.btn_vec[CANCEL].x = 180;
         this.btn_vec[CANCEL].y = 175;
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over(true,null);
         this.grid.x = 148;
         this.grid.y = 54;
         this.grid.type = Enum_type_grid.MART;
         addChild(this.grid);
         this.priceTF = ComponentUtil.getTextField("",this,{
            "x":114.8,
            "y":95,
            "color":16383744,
            "realWidth":54
         });
         this.numsTF = ComponentUtil.getTextField("",this,{
            "x":123.2,
            "y":120,
            "color":14013822,
            "realWidth":60,
            "realHeight":19
         });
         this.priceTF.align = TextFormatAlign.CENTER;
         this.numsTF.align = TextFormatAlign.CENTER;
         this.numsTF.type = TextFieldType.INPUT;
         this.priceTypeBmp = new Bitmap();
         addChild(this.priceTypeBmp);
         this.priceTypeBmp.x = 166.55;
         this.priceTypeBmp.y = 95.35;
         bindParent = GameScene.popupLayer;
         this.numsTF.addEventListener(Event.CHANGE,this.changeHandle);
         addEventListener(MouseEvent.MOUSE_UP,this.onUpHandle);
      }
      
      public function cliHandle(e:MouseEvent) : void
      {
         var label:String = (e.target as Button).label;
         switch(label)
         {
            case this.label_arr[0]:
               if(stype == 1)
               {
                  this.buyHandle();
                  break;
               }
               if(stype == 2)
               {
                  this.soldHandle();
               }
               break;
            case this.label_arr[1]:
               this.visible = false;
         }
      }
      
      private function soldHandle() : void
      {
         if(this.isGetGood)
         {
            MartCGMessage.CG_SOLD(this._martId,int(this.numsTF.text),this.gridId,UIManager.JMH_panel._mart_sold_buy._curPage);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("391",0));
         }
      }
      
      private function buyHandle() : void
      {
         var tem_num:int = int(this.numsTF.text);
         if(this.priceType == 1)
         {
            if(GameUnitManager.hero.silver < tem_num * this.price)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("8",0));
               return;
            }
         }
         else if(this.priceType == 2)
         {
            if(GameUnitManager.hero.money < tem_num * this.price)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
               return;
            }
         }
         MartCGMessage.CG_BUY(this._martId,tem_num,UIManager.JMH_panel._mart_sold_buy._curPage);
      }
      
      private function onUpHandle(e:MouseEvent) : void
      {
         var dragGrid:View_Grid = null;
         var upGrid:View_Grid = e.target as View_Grid;
         if(UIManager.isDrag)
         {
            dragGrid = UIManager.dragObj.grid;
            if(dragGrid.type == Enum_type_grid.BAG)
            {
               this.add_mart_goods(dragGrid);
            }
         }
      }
      
      public function add_mart_goods(_grid:View_Grid) : void
      {
         var temp:Vo_valuable = null;
         if(_grid.vo is Vo_valuable)
         {
            temp = _grid.vo as Vo_valuable;
         }
         if(Boolean(_grid) && Boolean(_grid.vo))
         {
            if(_grid.vo is Vo_equip && (_grid.vo as Vo_equip).type == 12)
            {
               UIManager.centerBroadcast.addMsg("勋章不能交易");
               return;
            }
         }
         if(temp.bBind || temp.id != this.grid.vo.id)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("392",0));
            return;
         }
         this.grid.vo = temp;
         this.numsTF.text = temp.count > this.max ? String(this.max) : String(temp.count);
         this.max = temp.count;
         if(int(this.numsTF.text) < 1)
         {
            this.numsTF.text = "1";
            this.max = 1;
         }
         this.setGridGrey(this.grid,false);
         this.gridId = this.grid.vo.gridId;
      }
      
      private function changeHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         var temNum:int = int(tf.text);
         if(temNum < 1)
         {
            temNum = 1;
         }
         if(temNum > this.max)
         {
            temNum = this.max;
         }
         if(stype == 2)
         {
            if(temNum > Model_mart.max)
            {
               temNum = Model_mart.max;
            }
         }
         tf.text = String(temNum);
         if(stype == 1)
         {
            this.priceTF.text = String(temNum * this.price);
         }
      }
      
      public function setGridGrey(_grid:View_Grid, value:Boolean) : void
      {
         _grid.set_grey(value);
         if(stype == 2)
         {
            if(value)
            {
               this.isGetGood = false;
            }
            else
            {
               this.isGetGood = true;
            }
         }
      }
      
      public function updata(tem_num:int, martId:Number, good_price:int, _costType:int, vo:Vo_grid) : void
      {
         this.grid.vo = vo;
         this.priceTF.text = String(good_price);
         this.priceTypeBmp = Utils.getLoadBitmap(this.utl[_costType - 1],this.priceTypeBmp);
         this.max = tem_num;
         this.priceType = _costType;
         this.price = good_price;
         this._martId = martId;
         if(stype == 2)
         {
            if(Model_mart.max < this.max)
            {
               this.max = Model_mart.max;
            }
            this.setGridGrey(this.grid,true);
         }
         else
         {
            this.setGridGrey(this.grid,false);
         }
         this.numsTF.text = String(1);
      }
      
      private function check(stype:int) : void
      {
         if(stype == 1)
         {
            this.shape.visible = true;
         }
         else if(stype == 2)
         {
            this.shape.visible = false;
            UIManager.bagPanel.visible = true;
         }
         this.setTXT(this.tf_vec,this.titleStr[stype - 1]);
      }
      
      private function setTXT(vec:Vector.<MyTextField>, arr:Array) : void
      {
         var i:int = 0;
         while(i < vec.length)
         {
            vec[i].text = arr[i];
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.check(stype);
            if(isFirstOpen)
            {
               isFirstOpen = false;
            }
         }
      }
      
      override public function resetPosition() : void
      {
         var temNum:int = 0;
         var temX:int = 0;
         var temY:int = 0;
         this.shape.width = Global.stage.stageWidth;
         this.shape.height = Global.stage.stageHeight;
         temNum = stype == 2 ? -130 : 0;
         this.spr.x = (Global.stage.stageWidth - this.back.width) / 2 + temNum;
         this.spr.y = (Global.stage.stageHeight - this.back.height) / 2;
         temX = (Global.stage.stageWidth - this.back.width) / 2 + temNum;
         temY = (Global.stage.stageHeight - this.back.height) / 2;
         this.i = 0;
         while(this.i < this.tf_vec.length)
         {
            this.tf_vec[this.i].x = temX + 65;
            ++this.i;
         }
         this.tf_vec[SOLDWP].y = 65 + temY;
         this.tf_vec[SOLDPRICE].y = 98 + temY;
         this.tf_vec[SOLDNUM].y = 122 + temY;
         this.btn_vec[OK].x = 70 + temX;
         this.btn_vec[OK].y = 165 + temY;
         this.btn_vec[CANCEL].x = 170 + temX;
         this.btn_vec[CANCEL].y = 165 + temY;
         this.priceTypeBmp.x = 180.55 + temX;
         this.priceTypeBmp.y = 97.35 + temY;
         this.grid.x = 135.8 + temX;
         this.grid.y = 54 + temY;
         this.priceTF.x = 126.8 + temX;
         this.priceTF.y = 97 + temY;
         this.numsTF.x = 124.2 + temX;
         this.numsTF.y = 122 + temY;
      }
   }
}

