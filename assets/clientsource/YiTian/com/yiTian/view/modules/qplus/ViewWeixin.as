package com.yiTian.view.modules.qplus
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QplusShareCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class ViewWeixin extends Sprite
   {
      
      public static var instance:ViewWeixin;
      
      private var preBtn:Button;
      
      private var nextBtn:Button;
      
      private var descTxt:MyTextField;
      
      private var itemLen:int = 3;
      
      private var itemTextArr:Array = ["一","二","三","四","五","六","七","八","九","十"];
      
      private var arrLen:int;
      
      private var curId:int = 0;
      
      private var thisId:int = 0;
      
      private var itemArr:Array = new Array();
      
      private var stateArr:Array = new Array();
      
      public function ViewWeixin()
      {
         super();
         this.init();
         instance = this;
      }
      
      private function init() : void
      {
         var i:int = 0;
         var item:WeixinItem = null;
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":0,
            "y":0,
            "width":456,
            "height":344
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":2,
            "y":2,
            "width":452,
            "height":185
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":2,
            "y":188,
            "width":452,
            "height":153
         },Global.Img_Cdm);
         this.descTxt = ComponentUtil.getTextField("",this,{
            "x":40,
            "y":34,
            "color":16772287,
            "size":12,
            "leading":14
         });
         this.descTxt.multiline = true;
         this.descTxt.htmlText = LangConfig.getWord("30115",3);
         this.arrLen = this.itemTextArr.length;
         i = 0;
         while(i < this.itemLen)
         {
            item = new WeixinItem();
            this.itemArr.push(item);
            item.x = 40 + i * 131;
            item.y = 213;
            addChild(item);
            i++;
         }
         this.turnGoal(0);
         this.nextBtn = ComponentUtil.getButton("","Button_FishPageDown",this,{
            "x":427,
            "y":221,
            "textColor":16771436
         },Global.FengXiang_Imgsdm);
         this.preBtn = ComponentUtil.getButton("","Button_FishPageUp",this,{
            "x":14,
            "y":221,
            "textColor":16771436
         },Global.FengXiang_Imgsdm);
         this.preBtn.addEventListener(MouseEvent.CLICK,this.preHandle);
         this.nextBtn.addEventListener(MouseEvent.CLICK,this.nextHandle);
      }
      
      private function preHandle(evt:MouseEvent) : void
      {
         if(this.curId <= 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30116",3));
            return;
         }
         --this.curId;
         this.turnGoal(this.curId);
      }
      
      private function nextHandle(evt:MouseEvent) : void
      {
         if(int(this.curId + 3) >= this.arrLen)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30117",3));
            return;
         }
         ++this.curId;
         this.turnGoal(this.curId);
      }
      
      private function turnGoal(t:int) : void
      {
         var i:int = 0;
         var item:WeixinItem = null;
         var microDataArr:Array = null;
         var vo:Vo_item = null;
         i = 0;
         while(i < this.itemLen)
         {
            item = this.itemArr[i] as WeixinItem;
            item.itemId = int(t + i + 1);
            if(item.itemId <= this.thisId)
            {
               item.enabledBtn(true);
            }
            else
            {
               item.enabledBtn(false);
               item.lockGrid();
            }
            microDataArr = Data_lib.micro[item.itemId];
            item.goldText = String(microDataArr[0]);
            if(Boolean(microDataArr[1]))
            {
               item.careNum = String(microDataArr[1]);
               item.gird.mouseEnabled = true;
            }
            else
            {
               item.gird.mouseEnabled = false;
               item.careNum = LangConfig.getWord("30118",3);
            }
            if(Boolean(microDataArr[2]))
            {
               vo = new Vo_item();
               vo.id = int(microDataArr[2]);
               vo.Init_lib();
               item.gird.vo = vo;
            }
            else
            {
               item.gird.vo = null;
            }
            if(this.stateArr.length > 0)
            {
               item.state = this.stateArr[t + i];
            }
            if(item.state == 1)
            {
               item.bitBgShow(true);
            }
            else
            {
               item.bitBgShow(false);
            }
            i++;
         }
      }
      
      public function set curGoal(t:int) : void
      {
         if(t <= 0)
         {
            this.thisId = 0;
            this.curId = 0;
         }
         else
         {
            this.curId = t - 1;
            this.thisId = t;
         }
         this.turnGoal(this.curId);
      }
      
      public function microGoal(t:int, arr:Array) : void
      {
         var i:int = 0;
         var item:WeixinItem = null;
         this.arrLen = t;
         this.stateArr = arr;
         i = 0;
         while(i < this.itemLen)
         {
            item = this.itemArr[i] as WeixinItem;
            if(this.stateArr.length > 0)
            {
               item.state = this.stateArr[this.curId + i];
               if(item.state == 1)
               {
                  item.bitBgShow(true);
               }
               else
               {
                  item.bitBgShow(false);
               }
            }
            i++;
         }
      }
      
      public function flyGrid(id:int) : void
      {
         var item:WeixinItem = null;
         var order:int = int(id - this.curId - 1);
         if(order >= 0 && order < 3)
         {
            item = this.itemArr[id - this.curId - 1];
         }
         var gird:View_Grid = item.gird;
         var p:Point = new Point(item.x + gird.x,item.y + gird.y);
         p = localToGlobal(p);
         Tween.gridToBagBezierFuncDef(gird,-1,p.x,p.y);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.curGoal = 0;
            QplusShareCGMessage.CG_MICRO_XIN();
         }
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Enum_type_grid;
import com.yiTian.manager.LangConfig;
import com.yiTian.net.message.cg.QplusShareCGMessage;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.qplus.ViewWeixin;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

class WeixinItem extends Sprite
{
   
   private var _goalText:MyTextField;
   
   private var _careNumText:MyTextField;
   
   private var _itemGrid:View_Grid;
   
   private var getGiftBtn:Button;
   
   private var _itemId:int;
   
   private var _state:int;
   
   private var _bitBg:Bitmap;
   
   public function WeixinItem()
   {
      super();
      this.initItem();
   }
   
   private function initItem() : void
   {
      ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
         "x":0,
         "y":0,
         "width":115,
         "height":100
      },Global.Img_Cdm);
      ComponentUtil.getTextField(LangConfig.getWord("30119",3),this,{
         "x":15,
         "y":1,
         "color":16764206,
         "size":12,
         "leading":0
      });
      this._careNumText = ComponentUtil.getTextField("",this,{
         "x":62,
         "y":1,
         "color":16764206,
         "size":12,
         "leading":0
      });
      this.getGiftBtn = ComponentUtil.getButton(LangConfig.getWord("30120",3),"Button_Orange",this,{
         "x":27,
         "y":70,
         "textColor":16771436
      },Global.Img_Cdm);
      ComponentUtil.getTextField(LangConfig.getWord("30121",3),this,{
         "x":6,
         "y":19,
         "color":16764206,
         "size":12,
         "leading":0
      });
      this._goalText = ComponentUtil.getTextField("一",this,{
         "x":6,
         "y":34,
         "color":16764206,
         "size":12,
         "leading":0
      });
      ComponentUtil.getTextField(LangConfig.getWord("30122",3),this,{
         "x":6,
         "y":49,
         "color":16764206,
         "size":12,
         "leading":0
      });
      ComponentUtil.getTextField(LangConfig.getWord("30123",3),this,{
         "x":6,
         "y":64,
         "color":16764206,
         "size":12,
         "leading":0
      });
      this._itemGrid = new View_Grid();
      addChild(this._itemGrid);
      this._itemGrid.type = Enum_type_grid.NO_DRAG;
      this._itemGrid.set_bmp_over();
      this._itemGrid.set_tf_count();
      this._itemGrid.set_bmp_bg();
      this._itemGrid.x = 42;
      this._itemGrid.y = 26;
      this.getGiftBtn.enabled = false;
      this.getGiftBtn.mouseEnabled = false;
      this.getGiftBtn.addEventListener(MouseEvent.CLICK,this.getGoadGiftHandle);
   }
   
   public function set careNum(str:String) : void
   {
      this._careNumText.text = String(str);
   }
   
   public function set goldText(desc:String) : void
   {
      this._goalText.text = desc;
   }
   
   public function get goldText() : String
   {
      return this._goalText.text;
   }
   
   public function set itemId(t:int) : void
   {
      this._itemId = t;
   }
   
   public function get itemId() : int
   {
      return this._itemId;
   }
   
   public function set state(t:int) : void
   {
      this._state = t;
      if(t == 1)
      {
         this.enabledBtn(false);
      }
   }
   
   public function get state() : int
   {
      return this._state;
   }
   
   public function get gird() : View_Grid
   {
      return this._itemGrid;
   }
   
   public function enabledBtn(boo:Boolean) : void
   {
      this.getGiftBtn.enabled = boo;
      this.getGiftBtn.mouseChildren = boo;
   }
   
   public function lockGrid() : void
   {
      this._itemGrid.set_bmp_bg(View_Grid.GRID_LOCK);
   }
   
   private function getGoadGiftHandle(evt:MouseEvent) : void
   {
      QplusShareCGMessage.CG_MICRO_GIFT(this._itemId);
      ViewWeixin.instance.flyGrid(this.itemId);
   }
   
   public function bitBgShow(value:Boolean) : void
   {
      if(value)
      {
         if(!this._bitBg)
         {
            this._bitBg = ComponentUtil.getBitmap("FinishImg",this,{
               "x":58,
               "y":-23
            },Global.FengXiang_Imgsdm);
         }
         addChild(this._bitBg);
      }
      else if(Boolean(this._bitBg) && Boolean(this.contains(this._bitBg)))
      {
         removeChild(this._bitBg);
      }
   }
}
