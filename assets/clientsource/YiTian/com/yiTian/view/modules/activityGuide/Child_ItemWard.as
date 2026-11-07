package com.yiTian.view.modules.activityGuide
{
   import com.ui.containers.Canvas;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Child_ItemWard extends Panel123
   {
      
      private static var _instance:Child_ItemWard;
      
      public static var itemsIdArr:Array = [];
      
      public static var LISTNUM:int = 11;
      
      public static var CUR_INDEX:int = 0;
      
      private var txtThemeOne:MyTextField;
      
      private var txtThemeTwo:MyTextField;
      
      private var txtThemeThree:MyTextField;
      
      private var container:Canvas;
      
      private var bgs:ScaleBitmap;
      
      private var _awardItemVec:Vector.<AwardItem> = new Vector.<AwardItem>();
      
      private var _isLoaded:Boolean = false;
      
      private var _maxPage:int = 0;
      
      private var _curPage:int = 0;
      
      private var len:int = 0;
      
      private var _leftButton:Button;
      
      private var _rightButton:Button;
      
      private var itemDic:Dictionary = new Dictionary();
      
      private var itemLen:int = 16;
      
      private var dictionary:DictionaryTabel;
      
      private var _statusArr:Array = [];
      
      private var _initt:Boolean = false;
      
      private var pageTF:MyTextField;
      
      public function Child_ItemWard()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/XFHKdm.swf","XFHKdm");
      }
      
      public static function get instance() : Child_ItemWard
      {
         if(!_instance)
         {
            _instance = new Child_ItemWard();
         }
         return _instance;
      }
      
      public function get awardItemVec() : Vector.<AwardItem>
      {
         return this._awardItemVec;
      }
      
      override protected function initUI2() : void
      {
         var awardItem:AwardItem = null;
         move = new Rectangle(0,0,897,40);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":897,
            "height":537
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":847,
            "height":487
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":862,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_CZDH",this,{
            "x":368,
            "y":5
         },Global.XFHKdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":823,
            "height":443
         },Global.XFHKdm);
         this._rightButton = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":483,
            "y":500,
            "textColor":16771436,
            "name":"right"
         },Global.Img_Cdm);
         this._leftButton = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":395,
            "y":500,
            "textColor":16771436,
            "name":"left"
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":418,
            "y":500,
            "width":62,
            "height":20
         },Global.Img_Cdm);
         this.pageTF = ComponentUtil.getTextField("0/0",this,{
            "x":437,
            "y":501,
            "color":13741658,
            "size":12,
            "leading":0
         });
         this._rightButton.callBack = this._leftButton.callBack = this.updateListButton;
         super.initDynamicView();
         this.dictionary = Data_lib.daojuduihuan;
         this.len = this.dictionary.getLength();
         LISTNUM = this.len;
         var i:int = 0;
         while(i < this.len)
         {
            awardItem = new AwardItem();
            awardItem.getAwardTimes = Data_lib.daojuduihuan[i + 1][9];
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
         x = (Global.stage.stageWidth - 897) / 2;
         y = (Global.stage.stageHeight - 537) / 2;
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
         var curIndex:int = 0;
         var awardItem:AwardItem = null;
         var singleItemArr:Array = null;
         var j:int = 0;
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
         while(count < 16)
         {
            if(this.itemDic[idIndex] == null)
            {
               count = 16;
               break;
            }
            addChild(this.itemDic[idIndex]);
            this._awardItemVec.push(this.itemDic[idIndex]);
            idIndex++;
            count++;
         }
         var tempLen:int = int(this._awardItemVec.length);
         idIndex = this._curPage * this.itemLen;
         i = 0;
         while(i < tempLen)
         {
            curIndex = i + idIndex;
            awardItem = this._awardItemVec[i];
            awardItem.x = 44 + i % 2 * 406;
            awardItem.y = 59 + int(i / 2) * 54;
            singleItemArr = [];
            j = 0;
            while(j < 9)
            {
               singleItemArr.push(this.dictionary[curIndex + 1][j]);
               j++;
            }
            this.updateAwardItem(singleItemArr,i);
            i++;
         }
         this._initt = true;
         if(Boolean(this._statusArr.length))
         {
            this.updateData(this._statusArr);
         }
      }
      
      public function updateAwardItem(arr:Array, index:int) : void
      {
         var singleItemArr:Array = null;
         var item:AwardItem = null;
         var i:int = 0;
         var a:Array = null;
         if(Boolean(this._awardItemVec.length))
         {
            singleItemArr = [];
            i = 0;
            while(i < arr.length)
            {
               a = [];
               a.push(arr[i],arr[i + 1],arr[i + 2]);
               singleItemArr.push(a);
               i += 3;
            }
            item = this._awardItemVec[index];
            item.updateGrids(singleItemArr);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            DailyActCGMessage.CG_DAOJUDUIHUAN();
         }
      }
      
      public function updateData(status:Array) : void
      {
         var curIndex:int = 0;
         this._statusArr = status;
         if(!this._initt)
         {
            this._initt = false;
         }
         var len:int = int(status.length);
         len = int(this._awardItemVec.length);
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
            len = this._awardItemVec[i].grid3.count;
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
import com.yiTian.manager.ModelManager;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.DailyActCGMessage;
import com.yiTian.utils.ComboTweenStep;
import com.yiTian.view.comp.View_Alert;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.activityGuide.Child_ItemWard;
import com.yiTian.view.modules.activityGuide.Model_ActivityGuide;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFormatAlign;
import flash.utils.getTimer;

class AwardItem extends Sprite
{
   
   public var grid1:View_Grid;
   
   public var grid2:View_Grid;
   
   public var grid3:View_Grid;
   
   public var getAwardBtn:Button;
   
   public var getAwardText:MyTextField;
   
   public var getAwardTimes:int = 20;
   
   private var index:int;
   
   private var btnLabelTextArr:Array = ["未达成","兑换奖励","已达上限"];
   
   private var gridPosXArr:Array = [13,133,253];
   
   private var _gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
   
   private var lastClickTime:uint;
   
   private var isShowCheckBoxTips:Boolean = false;
   
   public function AwardItem()
   {
      super();
      this.init();
   }
   
   private function init() : void
   {
      ComponentUtil.getBitmap("Back_DHWPK",this,{
         "x":0,
         "y":0
      },Global.XFHKdm);
      var i:int = 1;
      while(i < 4)
      {
         this["grid" + i] = new View_Grid();
         this["grid" + i].set_bmp_bg();
         this["grid" + i].set_bmp_over(true,null);
         this["grid" + i].set_tf_count(true,false,true);
         addChild(this["grid" + i]);
         this._gridVec.push(this["grid" + i]);
         ComponentUtil.setPropertie(this["grid" + i],{
            "x":this.gridPosXArr[i - 1],
            "y":7
         });
         i++;
      }
      this.getAwardBtn = ComponentUtil.getButton("条件不符","Button_Four",this,{
         "x":312,
         "y":8,
         "textColor":16771436,
         "callBack":this.gain
      },Global.Img_Cdm);
      ComponentUtil.getBitmap("Icon_DYH",this,{
         "x":186,
         "y":0
      },Global.XFHKdm);
      ComponentUtil.getBitmap("Icon_JiaHao",this,{
         "x":66,
         "y":2
      },Global.XFHKdm);
      ComponentUtil.getBitmap("Text_YiLingQu",this,{
         "x":315,
         "y":34
      },Global.XFHKdm);
      this.getAwardText = ComponentUtil.getTextField("0/20",this,{
         "x":347,
         "y":31,
         "color":13424242,
         "size":11,
         "leading":0
      });
      this.getAwardText.text = "0/" + this.getAwardTimes;
      this.getAwardText.realWidth = 60;
   }
   
   private function reset() : void
   {
      var i:int = 1;
      while(i < 4)
      {
         this["grid" + i].vo = null;
         i++;
      }
   }
   
   private function instensifyCheckCall(box:CheckBox) : void
   {
      this.isShowCheckBoxTips = box.selected;
   }
   
   private function gain(e:MouseEvent) : void
   {
      var okFunc:Function = null;
      var str:String = null;
      okFunc = function():void
      {
         var countSum:int = 0;
         var gridStr:String = null;
         if(grid1.vo.id == grid2.vo.id)
         {
            countSum = grid1.vo.count + grid2.vo.count;
            gridStr = ModelManager.bag.getGridId(grid1.vo.id,countSum);
            if(gridStr == "0")
            {
               UIManager.centerBroadcast.addMsg("条件不满足");
               return;
            }
         }
         Child_ItemWard.CUR_INDEX = index;
         DailyActCGMessage.CG_DAOJUDUIHUAN_GETAWARD(index + 1);
         Model_ActivityGuide.rewardIndex = index;
      };
      if(getTimer() - this.lastClickTime < 500)
      {
         return;
      }
      this.lastClickTime = getTimer();
      if(!this.isShowCheckBoxTips)
      {
         str = "<font color=\'#ffffff\'>确定使用<font color=\'#ffff00\'>" + this.grid1.vo.str_name + "</font>+<font color=\'#ffff00\'>" + this.grid2.vo.str_name + "</font>兑换<font color=\'#ffff00\'>" + this.grid3.vo.str_name + "</font></font>?";
         View_Alert.show(str,View_Alert.OK_CANCAL,okFunc,null,null,null,310,"","",TextFormatAlign.LEFT,true);
         View_Alert.instance.showCheckBox = this.instensifyCheckCall;
      }
      else
      {
         okFunc();
      }
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
            this["grid" + (i + 1)].vo = voI;
         }
         else if(type == 2)
         {
            voE = new Vo_equip();
            voE.id = id;
            voE.count = count;
            voE.Init_lib();
            this["grid" + (i + 1)].vo = voE;
         }
         if(i == 2)
         {
            this["grid" + (i + 1)].vo.bBind = true;
         }
         i++;
      }
   }
   
   public function flyIcon() : void
   {
      ComboTweenStep.toBag(this.grid3);
   }
}
