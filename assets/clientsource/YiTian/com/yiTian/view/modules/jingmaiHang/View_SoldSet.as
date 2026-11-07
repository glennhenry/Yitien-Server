package com.yiTian.view.modules.jingmaiHang
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.RadioButton;
   import com.ui.controls.RadioButtonGroup;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_mart;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.MartCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   
   public class View_SoldSet extends Panel
   {
      
      public static var MAX_NUM:int;
      
      public static var getBagData:Array = [];
      
      private var Button_OK:DisplayObject;
      
      public var Number_text:MyTextField;
      
      private var Price_YinLiang_text:MyTextField;
      
      private var Price_YuanBao_text:MyTextField;
      
      public var Fee_text:MyTextField;
      
      private var YL_btn:DisplayObject;
      
      private var YB_btn:DisplayObject;
      
      public var grid:View_Grid;
      
      private var titleTf:MyTextField;
      
      private var disTitle:Bitmap;
      
      public var _price:int;
      
      public var _num:int;
      
      public var _priceType:int;
      
      public var maxNum:int;
      
      private var rbg:RadioButtonGroup;
      
      private var rb_yl:RadioButton;
      
      private var rb_yb:RadioButton;
      
      public var _gridId:int;
      
      public var soldNum:View_SoldNum;
      
      public function View_SoldSet()
      {
         super();
         addEventListener(MouseEvent.MOUSE_UP,this.upHandle);
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":300,
            "height":350
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":252,
            "height":270
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":34,
            "y":260,
            "width":230,
            "height":2
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":34,
            "y":170,
            "width":230,
            "height":2
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":166,
            "y":185,
            "width":80,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":166,
            "y":210,
            "width":80,
            "height":20
         },Global.Img_Cdm);
         move = new Rectangle(0,0,246,38);
         ComponentUtil.getTextField(LangConfig.getWord("60176",6),this,{
            "x":51,
            "y":185,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60177",6),this,{
            "x":51,
            "y":235,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60178",6),this,{
            "x":51,
            "y":275,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.titleTf = ComponentUtil.getTextField("",this,{
            "x":91,
            "y":70,
            "color":11904647
         });
         this.Button_OK = ComponentUtil.getButton(LangConfig.getWord("6",0),"Button_Four",this,{
            "x":116,
            "y":315,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":266,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Number_text = ComponentUtil.getTextField("1",this,{
            "x":136,
            "y":235,
            "color":16184781,
            "realWidth":72
         });
         this.Number_text.align = TextFormatAlign.CENTER;
         this.Price_YinLiang_text = ComponentUtil.getTextField("",this,{
            "x":174,
            "y":185,
            "color":16184781,
            "realWidth":85
         });
         this.Price_YuanBao_text = ComponentUtil.getTextField("",this,{
            "x":174,
            "y":210,
            "color":16184781,
            "realWidth":85
         });
         this.Fee_text = ComponentUtil.getTextField("1",this,{
            "x":121,
            "y":275,
            "realWidth":79
         });
         this.Fee_text.align = TextFormatAlign.CENTER;
         this.Price_YinLiang_text.name = LangConfig.getWord("124",0);
         this.Price_YuanBao_text.name = LangConfig.getWord("21",0);
         this.Price_YinLiang_text.maxChars = 10;
         this.Price_YuanBao_text.maxChars = 10;
         this.Price_YinLiang_text.restrict = "0-9";
         this.Price_YuanBao_text.restrict = "0-9";
         this.Price_YinLiang_text.addEventListener(Event.CHANGE,this.changedHandle);
         this.Price_YuanBao_text.addEventListener(Event.CHANGE,this.changedHandle);
         Global.focus = this.Price_YinLiang_text;
         this.addRadioButton();
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over();
         this.grid.set_bmp_select();
         this.grid.x = 131;
         this.grid.y = 105;
         this.grid.type = Enum_type_grid.MART;
         addChild(this.grid);
         this.grid.doubleClickEnabled = true;
         this.grid.addEventListener(MouseEvent.DOUBLE_CLICK,this.backBagHandle);
         super.CloseButton.addEventListener(MouseEvent.CLICK,this.cloHandle);
         this.Button_OK.addEventListener(MouseEvent.CLICK,this.sendHandle);
      }
      
      public function YLFocusOuthandle(e:FocusEvent) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(tf.text == "")
         {
            tf.text = LangConfig.getWord("348",0);
         }
      }
      
      public function setTitle(str:String, ty:int) : void
      {
         this.titleTf.text = str;
         Model_mart.martType = ty;
         if(Boolean(this.disTitle))
         {
            this.disTitle.visible = false;
            removeChild(this.disTitle);
         }
         if(this.Number_text.hasEventListener(Event.CHANGE))
         {
            this.Number_text.removeEventListener(Event.CHANGE,this.chaHandle);
         }
         if(!Global.Mart_Imgsdm)
         {
            SingleLoader.add("lang/ch/Mart_Imgs.swf",function(info:Object):void
            {
               Global.Mart_Imgsdm = info.applicationDomain;
               showB(ty);
            });
         }
         else
         {
            this.showB(ty);
         }
      }
      
      private function showB(_type:int) : void
      {
         if(_type == 1)
         {
            this.disTitle = ComponentUtil.getBitmap("Title_SoldSet",this,{
               "x":70,
               "y":5
            },Global.Mart_Imgsdm);
         }
         else if(_type == 2)
         {
            this.disTitle = ComponentUtil.getBitmap("Title_BuySet",this,{
               "x":70,
               "y":5
            },Global.Mart_Imgsdm);
         }
      }
      
      private function chaHandle(e:Event) : void
      {
         var temNum:int = 0;
         var ys:String = null;
         var bs:String = null;
         var tf:MyTextField = e.target as MyTextField;
         var tempStr:String = tf.text.replace(/,/gi,"");
         tf.text = Utils.getGapNum(tempStr);
         tf.setSelection(tf.length,tf.length);
         var temStr:String = tf.text.replace(/,/gi,"");
         if(this.rbg.selectedItem == this.rb_yl)
         {
            ys = this.Price_YinLiang_text.text.replace(/,/gi,"");
            trace(ys);
            temNum = int(ys);
            this.Fee_text.text = Utils.getGapNum(String(Math.ceil(int(temStr) * temNum * 0.05)));
         }
         else
         {
            bs = this.Price_YuanBao_text.text.replace(/,/gi,"");
            trace(bs);
            temNum = int(bs);
            this.Fee_text.text = Utils.getGapNum(String(int(temStr) * temNum * 5));
         }
         var str:String = this.Fee_text.text.replace(/,/gi,"");
         var s:String = tf.text.replace(/,/gi,"");
         if(int(s) == 0)
         {
            tf.text = "1";
         }
         if(int(str) == 0)
         {
            this.Fee_text.text = "1";
         }
      }
      
      public function YBFocusOuthandle(e:FocusEvent) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(tf.text == "")
         {
            tf.text = LangConfig.getWord("350",0);
         }
      }
      
      private function sendHandle(e:MouseEvent) : void
      {
         var temJY_text:String = this.Price_YinLiang_text.text;
         var temYY_text:String = this.Price_YuanBao_text.text;
         temJY_text = temJY_text.replace(/,/gi,"");
         temYY_text = temYY_text.replace(/,/gi,"");
         if(this._priceType == 1)
         {
            this._price = int(temJY_text);
         }
         else
         {
            this._price = int(temYY_text);
         }
         if(this._price == 0)
         {
            UIManager.centerBroadcast.addMsg("请输入收购价钱");
            return;
         }
         this._num = int(this.Number_text.text);
         var fee_str:String = this.Fee_text.text.replace(/,/gi,"");
         if(int(fee_str) > GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("402",0));
            return;
         }
         if(this._priceType == 1 && (this.Price_YinLiang_text.text == LangConfig.getWord("348",0) || this.Price_YinLiang_text.text == "") || this._priceType == 2 && (this.Price_YuanBao_text.text == LangConfig.getWord("350",0) || this.Price_YuanBao_text.text == "") || this._priceType == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("403",0));
            return;
         }
         if(!this.grid.vo)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("404",0));
            return;
         }
         if(Model_mart.martType == 2)
         {
            if(this._priceType == 1)
            {
               if(GameUnitManager.hero.silver < this._price * this._num || GameUnitManager.hero.bingSilver + GameUnitManager.hero.silver - this._price * this._num < int(fee_str))
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("402",0));
                  return;
               }
            }
            if(this._priceType == 2)
            {
               if(GameUnitManager.hero.money < this._price * this._num || GameUnitManager.hero.bingSilver + GameUnitManager.hero.silver < int(fee_str))
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("405",0));
                  return;
               }
            }
         }
         if(Model_mart.martType == 1)
         {
            MartCGMessage.CG_MYSOLD(this.grid.vo.gridId,this._num,this._price,this._priceType);
         }
         else if(Model_mart.martType == 2)
         {
            MartCGMessage.CG_MYBUY(this.grid.vo.id,this._price,this._priceType,this._num);
         }
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      private function changedHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         var tempStr:String = tf.text.replace(/,/gi,"");
         tf.text = Utils.getGapNum(tempStr);
         tf.setSelection(tf.length,tf.length);
         var temStr:String = tf.text.replace(/,/gi,"");
         var temNum:int = int(this.Number_text.text);
         if(tf.name == LangConfig.getWord("124",0))
         {
            this.Fee_text.text = Utils.getGapNum(String(Math.ceil(int(temStr) * temNum * 0.05)));
         }
         else
         {
            this.Fee_text.text = Utils.getGapNum(String(int(temStr) * temNum * 5));
         }
         var str:String = this.Fee_text.text.replace(/,/gi,"");
         if(int(str) == 0)
         {
            this.Fee_text.text = "1";
         }
      }
      
      private function addRadioButton() : void
      {
         this.rbg = new RadioButtonGroup();
         this.rbg.direction = RadioButtonGroup.VERTICAL;
         this.rbg.space = 40;
         this.rbg.x = 111;
         this.rbg.y = 185;
         addChild(this.rbg);
         this.rb_yl = ComponentUtil.getRadioButton(LangConfig.getWord("124",0),"CheckBox01",this.rbg,{"value":LangConfig.getWord("124",0)},Global.Img_Cdm);
         this.rb_yb = ComponentUtil.getRadioButton(LangConfig.getWord("21",0),"CheckBox01",this.rbg,{"value":LangConfig.getWord("21",0)},Global.Img_Cdm);
         this.rbg.selectedItem = this.rb_yb;
         this.YBHandle();
         this.rbg.addEventListener(RadioButtonGroup.SELECTED_CHANGE,function():void
         {
            var value:Object = null;
            if(Boolean(rbg.selectedItem))
            {
               value = rbg.selectedItem.value;
               if(value == LangConfig.getWord("124",0))
               {
                  Fee_text.text = "1";
                  YLHandle();
               }
               else
               {
                  Fee_text.text = "1";
                  YBHandle();
               }
            }
         });
      }
      
      private function YLHandle() : void
      {
         this._priceType = 1;
         this.Price_YuanBao_text.type = TextFieldType.DYNAMIC;
         this.Price_YuanBao_text.text = "";
         this.Price_YinLiang_text.type = TextFieldType.INPUT;
         this.Price_YinLiang_text.text = LangConfig.getWord("348",0);
         this.Price_YinLiang_text.addEventListener(FocusEvent.FOCUS_IN,this.down1Handle);
         this.Price_YinLiang_text.addEventListener(FocusEvent.FOCUS_OUT,this.YLFocusOuthandle);
      }
      
      private function down1Handle(e:FocusEvent) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(tf.text == LangConfig.getWord("348",0))
         {
            tf.text = "";
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            if(Boolean(this.grid.vo))
            {
               UIManager.bagPanel.set_mask(this.grid.vo.gridId,false);
               this.grid.vo = null;
            }
            if(UIManager.mart_sold_num.visible)
            {
               UIManager.mart_sold_num.visible = false;
            }
            this.Number_text.text = "1";
            this.Fee_text.text = "1";
         }
         else
         {
            this._num = 0;
            this._price = 0;
            this._priceType = 2;
            this.rbg.selectedItem = this.rb_yb;
            this.YBHandle();
         }
      }
      
      private function YBHandle() : void
      {
         this._priceType = 2;
         this.Price_YinLiang_text.text = "";
         this.Price_YuanBao_text.type = TextFieldType.INPUT;
         this.Price_YinLiang_text.type = TextFieldType.DYNAMIC;
         this.Price_YuanBao_text.text = LangConfig.getWord("350",0);
         this.Price_YuanBao_text.addEventListener(FocusEvent.FOCUS_IN,this.down2Handle);
         this.Price_YuanBao_text.addEventListener(FocusEvent.FOCUS_OUT,this.YBFocusOuthandle);
      }
      
      private function down2Handle(e:FocusEvent) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(tf.text == LangConfig.getWord("350",0))
         {
            tf.text = "";
         }
      }
      
      public function add_mart_goods(_grid:View_Grid) : void
      {
         var temp:Vo_valuable = null;
         this.reset_soldSet();
         if(_grid.vo is Vo_valuable)
         {
            temp = _grid.vo as Vo_valuable;
         }
         if(Boolean(_grid) && Boolean(_grid.vo))
         {
            if(_grid.vo is Vo_equip && (_grid.vo as Vo_equip).type == 12)
            {
               UIManager.centerBroadcast.addMsg("勋章不能收购和出售");
               return;
            }
         }
         if(Model_mart.martType == 1)
         {
            if(temp.bBind)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("406",0) + "</font></a>");
               return;
            }
            if(temp.count > 1)
            {
               if(!UIManager.mart_sold_num.visible)
               {
                  UIManager.mart_sold_num.visible = true;
               }
               UIManager.mart_sold_num.update_goods(_grid);
               return;
            }
            this.add_grid_Mask(this.grid,_grid);
            this.update_vo(_grid,1);
         }
         else if(Model_mart.martType == 2)
         {
            if(!UIManager.mart_sold_num.visible)
            {
               UIManager.mart_sold_num.visible = true;
            }
            UIManager.mart_sold_num.update_goods(_grid);
         }
      }
      
      private function reset_soldSet() : void
      {
         if(UIManager.mart_sold_num.visible)
         {
            UIManager.mart_sold_num.visible = false;
         }
      }
      
      public function update_vo(_gr_id:View_Grid, _num:int) : void
      {
         this.add_grid_Mask(this.grid,_gr_id);
         this.grid.vo = _gr_id.vo;
         this.Number_text.text = String(_num);
      }
      
      private function backBagHandle(e:MouseEvent = null) : void
      {
         if(Boolean(this.grid.vo))
         {
            UIManager.bagPanel.set_mask(this.grid.vo.gridId,false);
         }
         this.grid.vo = null;
         this.Number_text.text = "1";
         this._num = 1;
      }
      
      public function add_grid_Mask(preGrid:View_Grid, nowGrid:View_Grid) : void
      {
         if(preGrid.vo != null)
         {
            UIManager.bagPanel.set_mask(preGrid.vo.gridId,false);
         }
         UIManager.bagPanel.set_mask(nowGrid.vo.gridId,true);
      }
      
      public function cloHandle(e:MouseEvent = null) : void
      {
         this.visible = false;
      }
      
      private function getGrid(disp:DisplayObject) : View_Grid
      {
         if(disp is View_Grid)
         {
            return disp as View_Grid;
         }
         return this.getGrid(disp.parent);
      }
      
      private function upHandle(e:MouseEvent) : void
      {
         var dragGrid:View_Grid = null;
         if(!UIManager.isDrag)
         {
            return;
         }
         var upGrid:View_Grid = this.getGrid(this.grid as DisplayObject);
         if(UIManager.isDrag)
         {
            dragGrid = UIManager.dragObj.grid;
            trace(UIManager.dragObj.grid.vo);
            if(dragGrid.type == Enum_type_grid.BAG)
            {
               this.add_mart_goods(dragGrid);
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2 - 180;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      public function set sold_Num(_num:int) : void
      {
         this.Number_text.text = String(_num);
      }
      
      public function get sold_num() : String
      {
         return this.Number_text.text;
      }
   }
}

