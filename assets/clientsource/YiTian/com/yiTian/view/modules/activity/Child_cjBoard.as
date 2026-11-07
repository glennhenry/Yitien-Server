package com.yiTian.view.modules.activity
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.AwardOnlineCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class Child_cjBoard extends Sprite
   {
      
      private static var isLoad:Boolean = false;
      
      public var tf_info1:MyTextField;
      
      public var tf_info2:MyTextField;
      
      private var btn_getAward1:Button;
      
      private var btn_getAward2:Button;
      
      private var btn_roll1:Button;
      
      private var btn_roll2:Button;
      
      private var itemVec1:Vector.<Child_ChouJiangGroup>;
      
      private var itemVec2:Vector.<Child_ChouJiangGroup>;
      
      private var itemMask1:ItemMask;
      
      private var itemMask2:ItemMask;
      
      private const _itemCount:int = 5;
      
      private var getAward1:Child_GetRCCJItem;
      
      private var getAward2:Child_GetJRCJItem;
      
      public var isRun1:Boolean = false;
      
      public var isRun2:Boolean = false;
      
      private var count1:int = -1;
      
      private var finNum1:int;
      
      private var _status1:int;
      
      private var count2:int = -1;
      
      private var finNum2:int;
      
      private var _status2:int;
      
      public function Child_cjBoard()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.tf_info1 = ComponentUtil.getTextField("",this,{
            "x":393,
            "y":105,
            "color":16759552,
            "realWidth":110,
            "height":100
         });
         this.tf_info2 = ComponentUtil.getTextField("",this,{
            "x":393,
            "y":280,
            "color":16759552,
            "realWidth":110,
            "height":100
         });
         this.tf_info1.wordWrap = true;
         this.tf_info2.wordWrap = true;
         ComponentUtil.getTextField(LangConfig.getWord("50001",5),this,{
            "x":226,
            "y":50,
            "bold":true,
            "size":16,
            "color":16776960
         });
         ComponentUtil.getTextField(LangConfig.getWord("50002",5),this,{
            "x":226,
            "y":230,
            "bold":true,
            "size":16,
            "color":16776960
         });
         this.btn_roll1 = ComponentUtil.getButton("","Button_YaoJiang",this,{
            "x":333,
            "y":105
         },Global.New_Imgsdm);
         this.btn_roll2 = ComponentUtil.getButton("","Button_YaoJiang",this,{
            "x":333,
            "y":284
         },Global.New_Imgsdm);
         this.btn_getAward1 = ComponentUtil.getButton(LangConfig.getWord("50004",5),"Button_Four",this,{
            "x":164,
            "y":186,
            "textColor":16773818
         },Global.Img_Cdm);
         this.btn_getAward2 = ComponentUtil.getButton(LangConfig.getWord("50004",5),"Button_Four",this,{
            "x":164,
            "y":365,
            "textColor":16773818
         },Global.Img_Cdm);
         var array:Array = CJInfo.getInstance().itemList1;
         var index:int = 0;
         while(index < array.length)
         {
            array[index].push(index);
            index++;
         }
         var array2:Array = CJInfo.getInstance().itemList2;
         var index2:int = 0;
         while(index2 < array2.length)
         {
            array2[index2].push(index2);
            index2++;
         }
         this.itemVec1 = new Vector.<Child_ChouJiangGroup>();
         this.createItem(5,new Point(72,119),array,this.itemVec1,1);
         this.itemVec2 = new Vector.<Child_ChouJiangGroup>();
         this.createItem(5,new Point(72,298),array2,this.itemVec2,2);
         this.btn_roll1.callBack = this.roll1ClickHandle;
         this.btn_roll2.callBack = this.roll2ClickHandle;
         this.btn_getAward1.callBack = this.award1ClickHandle;
         this.btn_getAward2.callBack = this.award2ClickHandle;
         this.getAward1 = Child_GetRCCJItem.getInstance();
         this.getAward2 = Child_GetJRCJItem.getInstance();
         this.getAward1.x = 74;
         this.getAward1.y = 120;
         addChild(this.getAward1);
         this.getAward2.x = 74;
         this.getAward2.y = 296;
         addChild(this.getAward2);
         this.itemMask1 = new ItemMask();
         this.itemMask1.x = 74;
         this.itemMask1.y = 120;
         addChild(this.itemMask1);
         this.itemMask2 = new ItemMask();
         this.itemMask2.x = 74;
         this.itemMask2.y = 298;
         addChild(this.itemMask2);
         this.btn_getAward1.enabled = false;
         this.btn_getAward2.enabled = false;
      }
      
      private function award1ClickHandle(evt:MouseEvent) : void
      {
         var freeGrid:int = CommandManager.get_bag_canUse() - CommandManager.get_bag_used();
         if(freeGrid < CJInfo.getInstance().arr1.length)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("50005",5));
         }
         AwardOnlineCGMessage.CG_GET_CJ_AWARD(1);
      }
      
      private function award2ClickHandle(evt:MouseEvent) : void
      {
         var freeGrid:int = CommandManager.get_bag_canUse() - CommandManager.get_bag_used();
         if(freeGrid < 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("50005",5));
            return;
         }
         AwardOnlineCGMessage.CG_GET_CJ_AWARD(2);
      }
      
      private function roll1ClickHandle(evt:MouseEvent) : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("50006",5));
            return;
         }
         this.isRun1 = true;
         AwardOnlineCGMessage.CG_CJ_SEND(1);
      }
      
      private function roll2ClickHandle(evt:MouseEvent) : void
      {
         this.isRun2 = true;
         AwardOnlineCGMessage.CG_CJ_SEND(2);
      }
      
      private function createItem(count:int, point:Point, viewArr:Array, vec:Vector.<Child_ChouJiangGroup>, type:int) : void
      {
         var posY:Number = NaN;
         var cjb:Child_ChouJiangGroup = null;
         var posX1:Number = point.x;
         posY = point.y;
         var index:int = 0;
         while(index < count)
         {
            cjb = new Child_ChouJiangGroup();
            cjb.x = posX1 + index * 49.3;
            cjb.y = posY;
            cjb.setViewArr(viewArr,type);
            addChild(cjb);
            vec.push(cjb);
            index++;
         }
      }
      
      public function start1(arr:Array) : void
      {
         this.itemMask1.numUnvisible = CJInfo.getInstance().comboDay;
         this.numVisible1 = arr.length;
         this.count1 = arr.length;
         this.finNum1 = 0;
         var index:int = 0;
         while(index < arr.length)
         {
            this.itemVec1[index].start(1,arr[index]);
            if(this.itemVec1[index].hasEventListener("endloop") == false)
            {
               this.itemVec1[index].addEventListener("endloop",this.end1Handle);
            }
            index++;
         }
      }
      
      private function set itemVisible1(value:Boolean) : void
      {
         var item:Child_ChouJiangGroup = null;
         for each(item in this.itemVec1)
         {
            item.itemVisible = value;
         }
      }
      
      private function set itemVisible2(value:Boolean) : void
      {
         var item:Child_ChouJiangGroup = null;
         for each(item in this.itemVec2)
         {
            item.itemVisible = value;
         }
      }
      
      private function end1Handle(evt:Event) : void
      {
         this.itemMask1.visible = true;
         this.isRun1 = false;
         this.finNum1 += 1;
         if(this.finNum1 == this.count1)
         {
            this.status1 = 2;
            this.count1 = -1;
         }
      }
      
      public function enableGridLoad() : void
      {
         var g:Child_ChouJiangGroup = null;
         var g1:Child_ChouJiangGroup = null;
         var grid:View_Grid = null;
         var grid2:View_Grid = null;
         for each(g in this.itemVec1)
         {
            for each(grid in g.aactItemVec)
            {
               grid.beginLoad();
               grid.isAutoLoad = true;
            }
         }
         for each(g1 in this.itemVec2)
         {
            for each(grid2 in g1.aactItemVec)
            {
               grid2.beginLoad();
               grid2.isAutoLoad = true;
            }
         }
         this.Vis = true;
      }
      
      public function get status1() : int
      {
         return this._status1;
      }
      
      public function set status1(value:int) : void
      {
         var str:String = null;
         var num:int = 0;
         var info:CJInfo = CJInfo.getInstance();
         if(GameUnitManager.hero.level < 30)
         {
            value = 4;
         }
         this._status1 = value;
         num = info.comboDay > 5 ? 5 : info.comboDay;
         switch(value)
         {
            case -1:
               str = LangConfig.getWord("50008",5);
               this.tf_info1.htmlText = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
               this.itemVisible1 = false;
               this.btn_roll1.enabled = false;
               this.btn_getAward1.enabled = false;
               this.getAward1.visible = false;
               break;
            case 0:
               this.tf_info1.htmlText = LangConfig.getWord("50003",5,HtmlUtil.font(info.comboDay.toString(),ColorConstant.getColorStr(ColorConstant.GREEN),15),HtmlUtil.font(num.toString(),ColorConstant.getColorStr(ColorConstant.GREEN),15));
               this.tf_info1.htmlText += LangConfig.getWord("50007",5);
               this.btn_roll1.enabled = true;
               this.btn_getAward1.enabled = false;
               this.getAward1.visible = false;
               this.itemMask1.numUnvisible = 0;
               this.itemMask1.numEnabled = num;
               this.numVisible1 = 0;
               break;
            case 1:
               str = LangConfig.getWord("50009",5);
               this.tf_info1.htmlText = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
               this.btn_roll1.enabled = false;
               this.btn_getAward1.enabled = true;
               this.getAward1.update(CJInfo.getInstance().arr1);
               this.getAward1.visible = true;
               this.itemMask1.numUnvisible = CJInfo.getInstance().arr1.length;
               this.itemMask1.numEnabled = CJInfo.getInstance().arr1.length;
               this.numVisible1 = CJInfo.getInstance().arr1.length;
            case 2:
               str = LangConfig.getWord("50010",5);
               this.tf_info1.htmlText = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
               this.btn_roll1.enabled = false;
               this.btn_getAward1.enabled = true;
               this.getAward1.update(CJInfo.getInstance().arr1);
               this.getAward1.visible = true;
               this.itemMask1.numUnvisible = CJInfo.getInstance().arr1.length;
               this.itemMask1.numEnabled = CJInfo.getInstance().arr1.length;
               this.numVisible1 = CJInfo.getInstance().arr1.length;
               break;
            case 3:
               str = LangConfig.getWord("50011",5);
               this.tf_info1.htmlText = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
               this.itemVisible1 = false;
               this.btn_roll1.enabled = false;
               this.btn_getAward1.enabled = false;
               this.getAward1.visible = false;
               this.itemMask1.numUnvisible = 0;
               this.itemMask1.numEnabled = 0;
               break;
            case 4:
               str = LangConfig.getWord("50012",5);
               this.tf_info1.htmlText = str;
               this.itemVisible1 = false;
               this.btn_roll1.enabled = false;
               this.btn_getAward1.enabled = false;
               this.getAward1.visible = false;
               this.itemMask1.numUnvisible = 0;
               this.itemMask1.numEnabled = 0;
               break;
            default:
               str = "错误信息";
               this.tf_info1.htmlText = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.RED),12);
               this.itemVisible1 = false;
               this.btn_roll1.enabled = false;
               this.btn_getAward1.enabled = false;
               this.getAward1.visible = false;
         }
         if(GameUnitManager.hero.level < 30)
         {
            return;
         }
         this.al();
      }
      
      public function set Vis(value:Boolean) : void
      {
         if(value)
         {
            if(!Global.Award_Imgsdm)
            {
               SingleLoader.add("lang/ch/Award_Imgs.swf",function(info:Object):void
               {
                  Global.Award_Imgsdm = info.applicationDomain;
                  showBmp();
               });
            }
            else if(!isLoad)
            {
               this.showBmp();
            }
         }
      }
      
      private function showBmp() : void
      {
         var bg1:Bitmap = ComponentUtil.getBitmap("Back_YaoJiang",this,{
            "x":41,
            "y":95
         },Global.Award_Imgsdm);
         var bg2:Bitmap = ComponentUtil.getBitmap("Back_YaoJiang",this,{
            "x":41,
            "y":274
         },Global.Award_Imgsdm);
         setChildIndex(bg1,2);
         setChildIndex(bg2,3);
         isLoad = true;
      }
      
      private function set numVisible1(value:int) : void
      {
         var i:int = 0;
         while(i < 5)
         {
            this.itemVec1[i].itemVisible = value > i;
            i += 1;
         }
         Child_GetRCCJItem.getInstance().numVisible = value;
      }
      
      private function set numVisible2(value:int) : void
      {
         var i:int = 0;
         while(i < 5)
         {
            this.itemVec2[i].itemVisible = value > i;
            i += 1;
         }
         Child_GetJRCJItem.getInstance().numVisible = value;
      }
      
      public function start2(arr:Array) : void
      {
         this.itemMask2.numUnvisible = 5;
         this.numVisible2 = arr.length;
         this.count2 = arr.length;
         this.finNum2 = 0;
         var index:int = 0;
         while(index < arr.length)
         {
            this.itemVec2[index].start(1,arr[index]);
            if(this.itemVec2[index].hasEventListener("endloop") == false)
            {
               this.itemVec2[index].addEventListener("endloop",this.end2Handle);
            }
            index++;
         }
      }
      
      private function end2Handle(evt:Event) : void
      {
         this.itemMask2.visible = false;
         this.isRun2 = false;
         this.finNum2 += 1;
         if(this.finNum2 == this.count2)
         {
            this.status2 = 2;
            this.count2 = -1;
         }
      }
      
      public function get status2() : int
      {
         return this._status2;
      }
      
      public function set status2(value:int) : void
      {
         var str:String = null;
         var freName:String = null;
         this._status2 = value;
         switch(value)
         {
            case -1:
               str = LangConfig.getWord("50014",5);
               this.tf_info2.htmlText = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
               this.btn_roll2.enabled = false;
               this.btn_getAward2.enabled = false;
               this.itemMask2.numUnvisible = 0;
               this.itemMask2.numEnabled = 0;
               this.numVisible2 = 0;
               break;
            case 0:
               str = LangConfig.getWord("50015",5);
               this.tf_info2.htmlText = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
               this.btn_roll2.enabled = true;
               this.btn_getAward2.enabled = false;
               this.getAward2.visible = false;
               this.itemMask2.numUnvisible = 0;
               this.itemMask2.numEnabled = 5;
               this.numVisible2 = 0;
               break;
            case 1:
               str = LangConfig.getWord("50016",5);
               this.tf_info2.htmlText = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
               this.getAward2.update(CJInfo.getInstance().arr2);
               this.btn_roll2.enabled = false;
               this.btn_getAward2.enabled = true;
               this.getAward2.visible = true;
               this.itemMask2.numUnvisible = 5;
               this.numVisible2 = 5;
            case 2:
               str = LangConfig.getWord("50017",5);
               this.tf_info2.htmlText = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
               this.getAward2.update(CJInfo.getInstance().arr2);
               this.btn_roll2.enabled = false;
               this.btn_getAward2.enabled = true;
               this.getAward2.visible = true;
               this.itemMask2.numUnvisible = 5;
               this.numVisible2 = 5;
               break;
            case 3:
               str = LangConfig.getWord("50018",5);
               this.tf_info2.htmlText = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
               this.btn_roll2.enabled = false;
               this.btn_getAward2.enabled = false;
               this.getAward2.visible = false;
               this.itemMask2.visible = true;
               this.itemMask2.numUnvisible = 0;
               this.itemMask2.numEnabled = 0;
               this.numVisible2 = 0;
               break;
            case 4:
               freName = CJInfo.getInstance().nxtFreName;
               str = LangConfig.getWord("50013",5,CJInfo.getInstance().nxtFreName,CJInfo.getInstance().nextFreDay);
               this.tf_info2.htmlText = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
               this.btn_roll2.enabled = false;
               this.btn_getAward2.enabled = false;
               this.getAward2.visible = false;
               this.itemMask2.numUnvisible = 0;
               this.itemMask2.numEnabled = 0;
               this.numVisible2 = 0;
               break;
            default:
               str = "错误信息";
               this.tf_info2.htmlText = HtmlUtil.font(str,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
         }
      }
      
      private function al() : void
      {
         if(this._status1 >= 0 && this._status1 <= 2 || this._status2 >= 0 && this._status2 <= 2)
         {
            UIManager.smallMap.addTip(4);
         }
         else
         {
            UIManager.smallMap.removeTip(4);
         }
      }
   }
}

import com.yiTian.utils.Utils;
import flash.display.Bitmap;
import flash.display.Sprite;

class ItemMask extends Sprite
{
   
   private var _type:int;
   
   private var bmVec:Vector.<Bitmap>;
   
   private var _numEnabled:int;
   
   private var _numVisible:int;
   
   public function ItemMask()
   {
      var bm:Bitmap = null;
      super();
      this.bmVec = new Vector.<Bitmap>();
      var i:int = 0;
      while(i < 5)
      {
         bm = new Bitmap();
         bm.x = i * 49;
         addChild(bm);
         this.bmVec.push(bm);
         i += 1;
      }
   }
   
   public function set type(value:int) : void
   {
   }
   
   public function set numUnvisible(value:int) : void
   {
      var i:int = 0;
      while(i < this.bmVec.length)
      {
         this.bmVec[i].visible = value <= i;
         i += 1;
      }
      this._numVisible = value;
   }
   
   public function set numEnabled(value:int) : void
   {
      var i:int = 0;
      while(i < this.bmVec.length)
      {
         if(i < value)
         {
            this.bmVec[i] = Utils.getLoadBitmap("resource/image/icon/46393.png",this.bmVec[i]);
         }
         else
         {
            this.bmVec[i] = Utils.getLoadBitmap("resource/image/icon/46395.png",this.bmVec[i]);
         }
         i += 1;
      }
      this._numEnabled = value;
   }
}
