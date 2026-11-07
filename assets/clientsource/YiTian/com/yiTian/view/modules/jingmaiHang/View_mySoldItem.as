package com.yiTian.view.modules.jingmaiHang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_mart_buy;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.MartCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_mySoldItem extends Sprite
   {
      
      public static var pool:Array = [];
      
      private var Button_Cancel02:Button;
      
      private var Name02_text:MyTextField;
      
      private var Time02_text:MyTextField;
      
      private var Money02_text:MyTextField;
      
      private var MoneyStyle02_text:MyTextField;
      
      private var Total02_text:MyTextField;
      
      private var Already02_text:MyTextField;
      
      public var grid:View_Grid;
      
      private var arrDW:Array = [LangConfig.getWord("124",0),LangConfig.getWord("21",0)];
      
      public var _costType:int;
      
      public var _martId:Number;
      
      public var _leftTime:int;
      
      private var lastTime:int;
      
      public function View_mySoldItem()
      {
         super();
         this.init();
      }
      
      public static function getInstance() : View_mySoldItem
      {
         var temInstance:View_mySoldItem = null;
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         temInstance = new View_mySoldItem();
         pool.push(temInstance);
         return temInstance;
      }
      
      public function init() : void
      {
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":41,
            "width":636,
            "height":2
         },Global.Img_Cdm);
         this.Button_Cancel02 = ComponentUtil.getButton(LangConfig.getWord("5",0),"Button_Four",this,{
            "x":549,
            "y":13,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Name02_text = ComponentUtil.getTextField(LangConfig.getWord("397",0),this,{
            "x":55,
            "y":15,
            "color":6938422,
            "size":12,
            "leading":0
         });
         this.Time02_text = ComponentUtil.getTextField("00:00:00",this,{
            "x":162,
            "y":15,
            "color":16184781,
            "size":12,
            "leading":0,
            "realWidth":80
         });
         this.Money02_text = ComponentUtil.getTextField("00000000",this,{
            "x":257,
            "y":15,
            "color":16184781,
            "size":12,
            "leading":0,
            "realWidth":112
         });
         this.Total02_text = ComponentUtil.getTextField("000",this,{
            "x":387,
            "y":15,
            "color":16184781,
            "size":12,
            "leading":0,
            "realWidth":56
         });
         this.Already02_text = ComponentUtil.getTextField("000",this,{
            "x":478,
            "y":15,
            "color":16184781,
            "size":12,
            "leading":0,
            "realWidth":44
         });
         this.Time02_text.align = TextAlign.CENTER;
         this.Money02_text.align = TextAlign.CENTER;
         this.Total02_text.align = TextAlign.CENTER;
         this.Already02_text.align = TextAlign.CENTER;
         this.Button_Cancel02.addEventListener(MouseEvent.CLICK,this.cancleHandle);
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over();
         this.grid.x = 10;
         this.grid.y = 2;
         this.grid.type = Enum_type_grid.NO_DRAG;
         addChild(this.grid);
      }
      
      public function cancleHandle(e:MouseEvent) : void
      {
         if(UIManager.JMH_panel.now.text == LangConfig.getWord("369",0))
         {
            MartCGMessage.CG_CANCLE_SOLD(this._martId);
         }
         else if(UIManager.JMH_panel.now.text == LangConfig.getWord("370",0))
         {
            MartCGMessage.CG_CANCLE_BUY(this._martId);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            GameScene.instance.addFrameCallBack(this.frameHandle);
         }
         else
         {
            GameScene.instance.removeFrameCallBack(this.frameHandle);
         }
      }
      
      public function set good_name(str:String) : void
      {
         this.Name02_text.text = str;
      }
      
      public function set timeLeft(timeLF:int) : void
      {
         this._leftTime = timeLF;
         this.Time02_text.text = String(DateUtil.getMSBySecond2(timeLF));
      }
      
      private function frameHandle(instanc:int) : void
      {
         var now:int = getTimer();
         if(now - this.lastTime >= 1000)
         {
            --this._leftTime;
            this.Time02_text.text = String(DateUtil.getMSBySecond2(this._leftTime));
            this.lastTime = now;
         }
         if(this._leftTime == 0)
         {
            GameScene.instance.removeFrameCallBack(this.frameHandle);
            this.visible = false;
            if(UIManager.JMH_panel.now.text == LangConfig.getWord("369",0))
            {
               MartCGMessage.CG_CANCLE_SOLD(this._martId);
            }
            else if(UIManager.JMH_panel.now.text == LangConfig.getWord("370",0))
            {
               MartCGMessage.CG_CANCLE_BUY(this._martId);
            }
         }
      }
      
      public function set money(_num:int) : void
      {
         this.Money02_text.text = Utils.getGapNum(String(_num)) + " " + this.arrDW[this._costType - 1];
      }
      
      public function set tatolNum(_num:int) : void
      {
         this.Total02_text.text = String(_num);
      }
      
      public function set soldNum(_num:int) : void
      {
         this.Already02_text.text = String(_num);
      }
      
      public function set_vec_item(items:Array) : void
      {
         var tem_item:Vo_item = null;
         this.Name02_text.text = LangConfig.getWord("398",0);
         this.Name02_text.textColor = 16711680;
         if(!items)
         {
            return;
         }
         if(items[0] < 40000)
         {
            return;
         }
         tem_item = new Vo_item();
         tem_item.id = items[0];
         tem_item.Init_lib();
         (this.grid as View_Grid).vo = tem_item;
         this.Name02_text.text = tem_item.str_name;
         this.Name02_text.textColor = Model_shop.getColorArr[tem_item.color - 1];
      }
      
      public function update(bought_vo:Vo_mart_buy) : void
      {
         var tem_item:Vo_item = null;
         var tem_equip:Vo_equip = null;
         if(bought_vo.wp_type == 1)
         {
            tem_item = new Vo_item();
            tem_item.id = bought_vo.wp_id;
            tem_item.Init_lib();
            this.grid.vo = tem_item;
            this.Name02_text.text = tem_item.str_name;
            this.Name02_text.textColor = Model_shop.getColorArr[tem_item.color - 1];
         }
         else if(bought_vo.wp_type == 2)
         {
            tem_equip = new Vo_equip();
            tem_equip.id = bought_vo.wp_id;
            tem_equip.Init_lib();
            this.grid.vo = tem_equip;
            this.Name02_text.text = tem_equip.str_name;
            this.Name02_text.textColor = Model_shop.getColorArr[tem_equip.color - 1];
         }
         this._martId = bought_vo.mart_id;
         this.timeLeft = bought_vo.left_time;
         this._costType = bought_vo.price_type;
         this.Money02_text.text = Utils.getGapNum(String(bought_vo.price)) + " " + this.arrDW[this._costType - 1];
         this.Total02_text.text = String(bought_vo.good_num);
         this.Already02_text.text = String(bought_vo.sold_bought_num);
      }
      
      public function set_vec_equip(equips:Array) : void
      {
         var tem_equip:Vo_equip = null;
         this.Name02_text.text = LangConfig.getWord("398",0);
         this.Name02_text.textColor = 16711680;
         if(!equips)
         {
            return;
         }
         if(equips[1] > 100000 || equips[1] < 90000)
         {
            return;
         }
         tem_equip = new Vo_equip();
         tem_equip.Init_sever_bag(equips);
         (this.grid as View_Grid).vo = tem_equip;
         this.Name02_text.text = tem_equip.str_name;
         this.Name02_text.textColor = Model_shop.getColorArr[tem_equip.color - 1];
      }
   }
}

