package com.yiTian.view.modules.YueBingShangCheng
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_YueBingShangCheng extends Panel123
   {
      
      private static var _instance:View_YueBingShangCheng;
      
      private const systemString:String = "月饼";
      
      private var countTxt:MyTextField;
      
      private var itemArray:Array;
      
      private var totalPage:int;
      
      private var curPage:int;
      
      private var prevBtn:Button;
      
      private var nextBtn:Button;
      
      private var pageTxt:MyTextField;
      
      public function View_YueBingShangCheng()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/ChunJie_Imgs.swf","ChunJie_Imgsdm");
         regResource("lang/ch/MiJingCangZong_Imgs.swf","MiJingCangZong_Imgs");
      }
      
      public static function get instance() : View_YueBingShangCheng
      {
         if(!_instance)
         {
            _instance = new View_YueBingShangCheng();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         var item:Item = null;
         move = new Rectangle(0,0,710,30);
         ComponentUtil.getScaleBitmap("Store_Back1",[229,44,2,3],this,{
            "x":0,
            "y":3,
            "width":710,
            "height":578
         },Global.ChunJie_Imgsdm);
         ComponentUtil.getBitmap("Store_Title_YueBing",this,{
            "x":229,
            "y":0
         },Global.MiJingCangZong_Imgs);
         ComponentUtil.getScaleBitmap("Store_Back4",[2,2,4,4],this,{
            "x":28,
            "y":47,
            "width":654,
            "height":524
         },Global.ChunJie_Imgsdm);
         ComponentUtil.getBitmap("Store_Img_YueBing",this,{
            "x":38,
            "y":57
         },Global.MiJingCangZong_Imgs);
         ComponentUtil.getTextField(this.systemString + "：",this,{
            "x":48,
            "y":542,
            "color":327424,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Store_Back3",[3,3,4,4],this,{
            "x":327,
            "y":539,
            "width":57,
            "height":23
         },Global.ChunJie_Imgsdm);
         this.totalPage = Math.max(1,Math.ceil(Data_lib.ybsc.getLength() / 9));
         this.curPage = 0;
         this.itemArray = [];
         i = 0;
         while(i < 9)
         {
            item = new Item();
            item.id = i;
            item.x = 38 + i % 3 * 213;
            item.y = 191 + int(i / 3) * 116;
            addChild(item);
            this.itemArray.push(item);
            i++;
         }
         this.setCurPageGrid();
         this.countTxt = ComponentUtil.getTextField("0",this,{
            "x":89,
            "y":542,
            "color":16383744,
            "size":12,
            "leading":0
         });
         this.prevBtn = ComponentUtil.getButton("","Button_PageL",this,{
            "x":299,
            "y":539,
            "textColor":16184781
         },Global.ChunJie_Imgsdm);
         this.prevBtn.callBack = this.changePage;
         this.prevBtn.enabled = false;
         this.nextBtn = ComponentUtil.getButton("","Button_PageR",this,{
            "x":388,
            "y":539,
            "textColor":16184781
         },Global.ChunJie_Imgsdm);
         this.nextBtn.callBack = this.changePage;
         if(this.totalPage < 2)
         {
            this.nextBtn.enabled = false;
         }
         this.pageTxt = ComponentUtil.getTextField("1/1",this,{
            "x":355,
            "y":541,
            "color":16777215,
            "size":12,
            "leading":0
         },"center");
         CloseButton = ComponentUtil.getButton("","Button_SClose",this,{
            "x":658,
            "y":14,
            "textColor":16184781
         },Global.ChunJie_Imgsdm);
         CloseButton.callBack = function():void
         {
            visible = false;
         };
      }
      
      private function setCurPageGrid() : void
      {
         var i:* = undefined;
         for(i in this.itemArray)
         {
            if(i + 9 * this.curPage < Data_lib.ybsc.getLength())
            {
               this.itemArray[i].setItem(Data_lib.ybsc[i + 9 * this.curPage + 1][0],Data_lib.ybsc[i + 9 * this.curPage + 1][1]);
               this.itemArray[i].visible = true;
            }
            else
            {
               this.itemArray[i].visible = false;
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.UpdateZongZiCount();
         }
      }
      
      public function UpdateZongZiCount() : void
      {
         this.countTxt.text = CommandManager.get_bag_count(45006).toString();
      }
      
      private function changePage(e:MouseEvent) : void
      {
         if(e.currentTarget == this.prevBtn)
         {
            this.nextBtn.enabled = true;
            --this.curPage;
            if(this.curPage == 0)
            {
               this.prevBtn.enabled = false;
            }
         }
         else
         {
            this.prevBtn.enabled = true;
            ++this.curPage;
            if(this.curPage == this.totalPage - 1)
            {
               this.nextBtn.enabled = false;
            }
         }
         this.pageTxt.text = this.curPage + 1 + "/" + this.totalPage;
      }
      
      public function Buy(id:int, count:int) : void
      {
         DailyActCGMessage.CG_YueBingShangCheng_BUY(this.curPage * 9 + id + 1,count);
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Data_lib;
import com.yiTian.data.config.Enum_YueBingShangCheng;
import com.yiTian.data.config.valuable.Enum_lib_item;
import com.yiTian.data.vo.Vo_equip;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.manager.CommandManager;
import com.yiTian.manager.UIManager;
import com.yiTian.utils.ComboTweenStep;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.YueBingShangCheng.View_YueBingShangCheng;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextFieldType;

class Item extends Sprite
{
   
   private const systemString:String = "月饼";
   
   public var id:int;
   
   private var itemID:int;
   
   private var itemCount:int;
   
   private var prizeTxt:MyTextField;
   
   private var itemName:MyTextField;
   
   private var buyNum:MyTextField;
   
   private var buyBtn:Button;
   
   private var upBtn:Button;
   
   private var downBtn:Button;
   
   private var grid:View_Grid;
   
   private var prize:int;
   
   public function Item()
   {
      super();
      this.Init();
   }
   
   private function Init() : void
   {
      ComponentUtil.getScaleBitmap("Store_Back2",[50,30,4,1],this,{
         "x":0,
         "y":0,
         "width":208,
         "height":111
      },Global.ChunJie_Imgsdm);
      ComponentUtil.getScaleBitmap("Store_Back3",[3,3,4,4],this,{
         "x":83,
         "y":73,
         "width":62,
         "height":24
      },Global.ChunJie_Imgsdm);
      ComponentUtil.getTextField("售价：",this,{
         "x":88,
         "y":46,
         "color":5757360,
         "size":12,
         "leading":0
      });
      this.itemName = ComponentUtil.getTextField("",this,{
         "x":66,
         "y":3,
         "color":3394815,
         "size":12,
         "leading":0
      });
      this.grid = new View_Grid(true);
      this.grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
      this.grid.set_bmp_over(true,null);
      this.grid.set_tf_count();
      this.grid.x = 9;
      this.grid.y = 32;
      addChild(this.grid);
      this.prizeTxt = ComponentUtil.getTextField("0" + this.systemString,this,{
         "x":129,
         "y":46,
         "color":16776960,
         "size":12,
         "leading":0
      });
      this.buyNum = ComponentUtil.getTextField("1",this,{
         "x":100,
         "y":76,
         "color":16777215,
         "size":12,
         "leading":0,
         "realWidth":40,
         "restrict":"0-9",
         "maxChars":3
      },"center",TextFieldType.INPUT);
      this.buyNum.addEventListener(Event.CHANGE,this.updateBuyNum);
      this.buyBtn = ComponentUtil.getButton("购买","Button_Buy",this,{
         "x":149,
         "y":72,
         "textColor":16184781
      },Global.ChunJie_Imgsdm);
      this.buyBtn.callBack = function():void
      {
         if(CommandManager.get_bag_count(45006) < Number(buyNum.text) * prize)
         {
            UIManager.centerBroadcast.addMsg(systemString + "不足");
            return;
         }
         Global.control.registerCallBack(Enum_YueBingShangCheng.FLY_TO_BAG,onFlyToBag);
         View_YueBingShangCheng.instance.Buy(id,int(buyNum.text));
      };
      this.upBtn = ComponentUtil.getButton("","Button_Nup",this,{
         "x":124,
         "y":74,
         "textColor":16184781
      },Global.ChunJie_Imgsdm);
      this.upBtn.callBack = function():void
      {
         buyNum.text = String(Number(buyNum.text) + 1);
         updateBuyNum(null);
      };
      this.downBtn = ComponentUtil.getButton("","Button_Ndown",this,{
         "x":124,
         "y":84,
         "textColor":16184781
      },Global.ChunJie_Imgsdm);
      this.downBtn.callBack = function():void
      {
         buyNum.text = String(Number(buyNum.text) - 1);
         updateBuyNum(null);
      };
   }
   
   public function setItem(itemStr:String, cost:int) : void
   {
      var vo:Vo_item = null;
      var vo2:Vo_equip = null;
      var itemArr:Array = itemStr.split("_");
      this.itemID = itemArr[1];
      if(itemArr[0] == 1)
      {
         this.itemName.text = Data_lib.item[this.itemID][Enum_lib_item.STR_NAME];
         vo = new Vo_item();
         vo.id = this.itemID;
         vo.count = itemArr[2];
         vo.Init_lib();
         this.grid.vo = vo;
      }
      else if(itemArr[0] == 2)
      {
         this.itemName.text = Data_lib.equip[this.itemID][Enum_lib_item.STR_NAME];
         vo2 = new Vo_equip();
         vo2.id = this.itemID;
         vo2.count = itemArr[2];
         vo2.Init_lib();
         this.grid.vo = vo2;
      }
      this.itemCount = itemArr[2];
      this.prize = cost;
      this.prizeTxt.text = cost + this.systemString;
   }
   
   private function updateBuyNum(e:Event) : void
   {
      if(int(this.buyNum.text) > 99)
      {
         this.buyNum.text = "99";
      }
      else if(int(this.buyNum.text) < 1 || this.buyNum.text == "")
      {
         this.buyNum.text = "1";
      }
   }
   
   private function onFlyToBag(e:*) : void
   {
      Global.control.removeCallBack(Enum_YueBingShangCheng.FLY_TO_BAG,this.onFlyToBag);
      ComboTweenStep.toBag(this.grid,15,15);
   }
}
