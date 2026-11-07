package com.yiTian.view.modules.gongcehuodong
{
   import com.ui.containers.Canvas;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.net.message.cg.GongCeJiShiCGMessage;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_GongCejishi extends Panel123
   {
      
      private static var _instance:View_GongCejishi;
      
      public static var itemsIdArr:Array = [];
      
      public static var LISTNUM:int = 11;
      
      public static var CURINDEX:int = 0;
      
      private var txtThemeOne:MyTextField;
      
      private var txtThemeTwo:MyTextField;
      
      private var txtThemeThree:MyTextField;
      
      private var container:Canvas;
      
      private var bgs:ScaleBitmap;
      
      private var _awardItemVec:Vector.<VAwardItem> = new Vector.<VAwardItem>();
      
      private var _isLoaded:Boolean = false;
      
      private var _maxPage:int = 0;
      
      private var _curPage:int = 0;
      
      private var len:int = 0;
      
      private var _leftButton:Button;
      
      private var _rightButton:Button;
      
      private var itemDic:Dictionary = new Dictionary();
      
      private var itemLen:int = 5;
      
      private var dictionary:DictionaryTabel;
      
      private var _statusArr:Array = [];
      
      private var _initt:Boolean = false;
      
      private var pageTF:MyTextField;
      
      public function View_GongCejishi()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/gongcejishi.swf","GCJSdm");
      }
      
      public static function get instance() : View_GongCejishi
      {
         if(!_instance)
         {
            _instance = new View_GongCejishi();
         }
         return _instance;
      }
      
      public function get awardItemVec() : Vector.<VAwardItem>
      {
         return this._awardItemVec;
      }
      
      override protected function initUI2() : void
      {
         var awardItem:VAwardItem = null;
         var i:int = 0;
         move = new Rectangle(0,0,787,450);
         ComponentUtil.getBitmap("Back_GCJS",this,{
            "x":0,
            "y":0
         },Global.GCJSdm);
         ComponentUtil.getBitmap("Back_FHLT",this,{
            "x":75,
            "y":73
         },Global.GCJSdm);
         ComponentUtil.getBitmap("Back_QXZL",this,{
            "x":638,
            "y":73
         },Global.GCJSdm);
         ComponentUtil.getBitmap("Back_WUJC",this,{
            "x":151,
            "y":75
         },Global.GCJSdm);
         ComponentUtil.getBitmap("Text_CaoZuo",this,{
            "x":561,
            "y":84
         },Global.GCJSdm);
         ComponentUtil.getBitmap("Text_DHTJ",this,{
            "x":273,
            "y":83
         },Global.GCJSdm);
         ComponentUtil.getBitmap("Text_GCJS",this,{
            "x":336,
            "y":2
         },Global.GCJSdm);
         ComponentUtil.getBitmap("Text_JiangLi",this,{
            "x":477,
            "y":83
         },Global.GCJSdm);
         CloseButton = ComponentUtil.getButton("","Button_GCGB",this,{
            "x":718,
            "y":5,
            "textColor":16771436
         },Global.GCJSdm);
         this._rightButton = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":426,
            "y":366,
            "textColor":16771436,
            "name":"right"
         },Global.Img_Cdm);
         this._leftButton = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":338,
            "y":366,
            "textColor":16771436,
            "name":"left"
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":363,
            "y":367,
            "width":58,
            "height":18
         },Global.Img_Cdm);
         this.pageTF = ComponentUtil.getTextField("0/0",this,{
            "x":380,
            "y":365,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this._rightButton.callBack = this._leftButton.callBack = this.updateListButton;
         super.initDynamicView();
         this.dictionary = Data_lib.jishi;
         this.len = this.dictionary.getLength();
         LISTNUM = this.len;
         i = 0;
         while(i < this.len)
         {
            awardItem = new VAwardItem();
            awardItem.getAwardTimes = Data_lib.jishi[i + 1][2];
            awardItem.x = 162;
            awardItem.y = 111 + i * 50;
            addChild(awardItem);
            this._awardItemVec[i] = awardItem;
            this.itemDic[i] = awardItem;
            i++;
         }
         this._initt = true;
         if(Boolean(this._statusArr))
         {
            this.setCurrentPage(0);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      private function updateListButton(e:MouseEvent) : void
      {
         switch(e.target.name)
         {
            case "left":
               --this._curPage;
               if(this._curPage <= 0)
               {
                  this._curPage = 0;
               }
               break;
            case "right":
               ++this._curPage;
               if(this._curPage >= this._maxPage)
               {
                  this._curPage = this._maxPage;
               }
         }
         this.setCurrentPage(this._curPage);
      }
      
      private function computeMaxPage() : void
      {
         var temp:int = int(this.len / this.itemLen);
         if(temp >= 1 && this.len % this.itemLen == 0)
         {
            temp -= 1;
         }
         this._maxPage = temp;
         this.pageTF.text = this._curPage + 1 + "/" + (this._maxPage + 1);
      }
      
      public function setCurrentPage(pageIndex:int) : void
      {
         this.computeMaxPage();
         this._curPage = Math.max(0,Math.min(pageIndex,this._maxPage));
         this.showPage();
      }
      
      private function showPage() : void
      {
         var i:int = 0;
         var allItemArr:Array = null;
         var curIndex:int = 0;
         var awardItem:VAwardItem = null;
         var singleItemArr:Array = null;
         var awardItemStr:String = null;
         var len2:int = this._awardItemVec.length - 1;
         i = len2;
         while(i >= 0)
         {
            if(Boolean(this._awardItemVec[i]))
            {
               removeChild(this._awardItemVec[i]);
               this._awardItemVec.pop();
            }
            i--;
         }
         var count:int = 0;
         var idIndex:int = this._curPage * this.itemLen;
         while(count < 5)
         {
            if(this.itemDic[idIndex] == null)
            {
               count = 5;
               break;
            }
            addChild(this.itemDic[idIndex]);
            this._awardItemVec.push(this.itemDic[idIndex]);
            idIndex++;
            count++;
         }
         var tempLen:int = int(this._awardItemVec.length);
         allItemArr = [];
         idIndex = this._curPage * this.itemLen;
         i = 0;
         while(i < tempLen)
         {
            curIndex = i + idIndex;
            awardItem = this._awardItemVec[i];
            awardItem.x = 162;
            awardItem.y = 111 + i * 50;
            singleItemArr = [];
            singleItemArr = this.dictionary[curIndex + 1][0].split(",");
            awardItemStr = this.dictionary[curIndex + 1][1];
            allItemArr.push(singleItemArr);
            this.updateAwardItem(singleItemArr,i,awardItemStr);
            i++;
         }
         this._initt = true;
         if(Boolean(this._statusArr.length))
         {
            this.updateData(this._statusArr);
         }
      }
      
      public function updateAwardItem(arr:Array, index:int, awardItemStr:String) : void
      {
         var tempItem:String = null;
         var singleItemArr:Array = null;
         var item:VAwardItem = null;
         var i:int = 0;
         var awardArr:Array = null;
         var a:Array = null;
         if(Boolean(this._awardItemVec.length))
         {
            singleItemArr = [];
            i = 0;
            while(i < arr.length)
            {
               tempItem = arr[i];
               a = tempItem.split("_");
               singleItemArr.push(a);
               i++;
            }
            item = this._awardItemVec[index];
            item.updateGrids(singleItemArr);
            awardArr = awardItemStr.split("_");
            item.updateAwardGrid(awardArr);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            GongCeJiShiCGMessage.GC_GCJS_SHOWPANEL();
         }
      }
      
      public function updateData(status:Array) : void
      {
         var curIndex:int = 0;
         this._statusArr = status;
         if(!this._initt)
         {
            return;
         }
         var i:int = 0;
         while(i < this._awardItemVec.length)
         {
            curIndex = i + this._curPage * this.itemLen;
            this._awardItemVec[i].update(curIndex,status[curIndex]);
            i++;
         }
      }
      
      public function getAward(idx:int, time:int) : void
      {
         var realIdx:int = idx - this._curPage * this.itemLen;
         this._awardItemVec[realIdx].update(idx,time);
         this._statusArr[idx] = time;
         this.flyIcon(idx);
      }
      
      public function flyIcon(idx:int) : void
      {
         var i:int = 0;
         var len:int = 0;
         var clearIdArr:Array = null;
         var j:int = 0;
         var clearId:int = 0;
         i = idx - this._curPage * this.itemLen;
         if(Boolean(this._awardItemVec[i]))
         {
            len = this._awardItemVec[i].awardGrid.count;
            if(len > 10)
            {
               len = 10;
            }
            clearIdArr = [];
            j = 0;
            while(j < len)
            {
               clearId = int(setTimeout(function():void
               {
                  var k:* = undefined;
                  _awardItemVec[i].flyIcon();
                  clearIdArr.push(clearId);
                  if(j == len - 1)
                  {
                     k = 0;
                     while(k < clearIdArr.length)
                     {
                        clearTimeout(clearIdArr[k]);
                        k++;
                     }
                  }
               },j * 100));
               j++;
            }
         }
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.CheckBox;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.vo.Vo_equip;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.net.message.cg.GongCeJiShiCGMessage;
import com.yiTian.utils.ComboTweenStep;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.gongcehuodong.View_GongCejishi;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.utils.getTimer;

class VAwardItem extends Sprite
{
   
   public var getAwardBtn:Button;
   
   public var getAwardText:MyTextField;
   
   public var getAwardTimes:int = 20;
   
   private var index:int;
   
   private var btnLabelTextArr:Array = ["未达成","兑换奖励","已达上限"];
   
   private var _gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
   
   private var _exchangeArr:Array = [];
   
   private var _awardGrid:View_Grid;
   
   private var lastClickTime:uint;
   
   private var isShowCheckBoxTips:Boolean = false;
   
   public function VAwardItem()
   {
      super();
      this.init();
   }
   
   public function get awardGrid() : View_Grid
   {
      return this._awardGrid;
   }
   
   private function init() : void
   {
      var i:int = 0;
      var grid:View_Grid = null;
      i = 0;
      while(i < 7)
      {
         grid = new View_Grid();
         grid.set_bmp_bg();
         grid.set_bmp_over(true);
         grid.set_tf_count(true,false,true);
         addChild(grid);
         this._exchangeArr.push(grid);
         grid.visible = false;
         ComponentUtil.setPropertie(grid,{
            "x":i * 41,
            "y":1
         });
         i++;
      }
      this._awardGrid = new View_Grid();
      this._awardGrid.set_bmp_bg();
      this._awardGrid.set_bmp_over(true);
      this._awardGrid.set_tf_count(true,false,true);
      addChild(this._awardGrid);
      ComponentUtil.setPropertie(this._awardGrid,{
         "x":317,
         "y":1
      });
      ComponentUtil.getBitmap("Icon_GCJT",this,{
         "x":284,
         "y":7
      },Global.GCJSdm);
      this.getAwardBtn = ComponentUtil.getButton("条件不符","Button_Five",this,{
         "x":369,
         "y":0,
         "textColor":16771436,
         "callBack":this.gain
      },Global.Img_Cdm);
      ComponentUtil.getTextField("兑换次数:",this,{
         "x":368,
         "y":23,
         "color":13424242,
         "size":11,
         "leading":0
      });
      this.getAwardText = ComponentUtil.getTextField("",this,{
         "x":429,
         "y":23,
         "color":13424242,
         "size":11,
         "leading":0
      });
      this.getAwardText.realWidth = 60;
   }
   
   private function instensifyCheckCall(box:CheckBox) : void
   {
      this.isShowCheckBoxTips = box.selected;
   }
   
   private function gain(e:MouseEvent) : void
   {
      if(getTimer() - this.lastClickTime < 300)
      {
         return;
      }
      this.lastClickTime = getTimer();
      GongCeJiShiCGMessage.GC_GCJS_AWARD(this.index + 1);
      View_GongCejishi.CURINDEX = this.index;
   }
   
   public function update(index:int, repeatNum:int) : void
   {
      this.index = index;
      this.getAwardText.text = repeatNum + "/" + this.getAwardTimes;
      if(repeatNum == this.getAwardTimes)
      {
         this.getAwardBtn.enabled = false;
         this.getAwardBtn.label = this.btnLabelTextArr[2];
      }
      else
      {
         this.getAwardBtn.enabled = true;
         this.getAwardBtn.label = this.btnLabelTextArr[1];
      }
   }
   
   public function updateGrids(arr:Array) : void
   {
      var type:int = 0;
      var id:int = 0;
      var count:int = 0;
      var voI:Vo_item = null;
      var voE:Vo_equip = null;
      var i:int = 0;
      while(i < arr.length)
      {
         type = int(arr[i][0]);
         id = int(arr[i][1]);
         count = int(arr[i][2]);
         if(type == 1)
         {
            voI = new Vo_item();
            voI.id = id;
            voI.count = count;
            voI.Init_lib();
            this._exchangeArr[i].vo = voI;
         }
         else if(type == 2)
         {
            voE = new Vo_equip();
            voE.id = id;
            voE.count = count;
            voE.Init_lib();
            this._exchangeArr[i].vo = voE;
         }
         this._exchangeArr[i].visible = true;
         i++;
      }
   }
   
   public function updateAwardGrid(arr:Array) : void
   {
      var voI:Vo_item = null;
      var voE:Vo_equip = null;
      var type:int = int(arr[0]);
      var id:int = int(arr[1]);
      var count:int = int(arr[2]);
      if(type == 1)
      {
         voI = new Vo_item();
         voI.id = id;
         voI.count = count;
         voI.Init_lib();
         voI.bBind = true;
         this._awardGrid.vo = voI;
      }
      else if(type == 2)
      {
         voE = new Vo_equip();
         voE.id = id;
         voE.count = count;
         voE.Init_lib();
         voE.bBind = true;
         this._awardGrid.vo = voE;
      }
   }
   
   public function flyIcon() : void
   {
      ComboTweenStep.toBag(this._awardGrid);
   }
}
