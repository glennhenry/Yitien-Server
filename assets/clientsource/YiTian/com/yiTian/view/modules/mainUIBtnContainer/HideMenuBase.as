package com.yiTian.view.modules.mainUIBtnContainer
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.net.message.cg.FruitShopCGMessage;
   import com.yiTian.view.Panel;
   import flash.geom.Rectangle;
   
   public class HideMenuBase extends Panel
   {
      
      private var type:int;
      
      private var can:Canvas;
      
      protected var itemArray:Array = [];
      
      protected var notEnoughLV_IconArr:Array = [];
      
      private var needUpdateStatus:Boolean = true;
      
      protected var nowTime:Number = 0;
      
      public function HideMenuBase(type:int)
      {
         super();
         this.type = type;
      }
      
      override protected function initStaticView() : void
      {
         var i:* = undefined;
         var item:hideMenuListItem = null;
         var iconId:int = 0;
         move = new Rectangle(0,0,528,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":528,
            "height":501
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":478,
            "height":451
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":454,
            "height":427
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":493,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         this.can = new Canvas(435,416);
         this.can.scrollAutoType = ScrollAutoType.TO_TOP;
         this.can.x = 45;
         this.can.y = 58;
         addChild(this.can);
         for(i in Data_lib.iconHide)
         {
            if(Data_lib.iconHide[i][0] == this.type)
            {
               item = new hideMenuListItem();
               iconId = int(Data_lib.iconHide[i][5]);
               item.setType(i,iconId,Enum_mainUIBtn_hide.iconPathDictionary[iconId],Data_lib.iconHide[i][2],Data_lib.iconHide[i][3]);
               if(GameUnitManager.hero.level < Data_lib.iconHide[i][4])
               {
                  this.notEnoughLV_IconArr.push(item);
               }
               else
               {
                  this.addAtCanvas(item);
               }
            }
         }
         if(this.notEnoughLV_IconArr.length > 0)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,this.onLevelUp);
         }
         Global.control.registerCallBack(Enum_mainUIBtn_hide.CLICK_ENTER,this.onClickEnter);
         Global.control.registerCallBack(Enum_mainUIBtn_hide.HIDE_MENU,this.onHide);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.onHide);
         Global.control.registerCallBack(Enum_mainUIBtn_hide.CHANGE_STATUS,this.setItemStatus);
         Global.control.registerCallBack(Enum_mainUIBtn_hide.SET_COUNT,this.setCount);
         Global.control.registerCallBack(Enum_mainUIBtn_hide.NOW_TIME,this.setNowTime);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value && this.needUpdateStatus)
         {
            this.getNowDate();
         }
      }
      
      protected function getNowDate() : void
      {
         FruitShopCGMessage.CG_FRUIT_SHOP_SER_TIME();
      }
      
      private function setNowTime(value:int) : void
      {
         var i:* = undefined;
         this.nowTime = value * 1000;
         this.needUpdateStatus = false;
         for(i in this.itemArray)
         {
            if(this.itemArray[i].status == -1)
            {
               this.setStartEndByDate(i);
            }
         }
         this.sort();
      }
      
      protected function setStartEndByDate(itemId:int) : void
      {
      }
      
      protected function onClickEnter(id:int) : void
      {
      }
      
      protected function setItemStatus(arr:Array) : void
      {
         var i:* = undefined;
         for(i in this.itemArray)
         {
            if(this.itemArray[i].id == arr[0])
            {
               (this.itemArray[i] as hideMenuListItem).setStatus(arr[1]);
               break;
            }
         }
         this.sort();
      }
      
      private function setCount(arr:Array) : void
      {
         var i:* = undefined;
         for(i in this.itemArray)
         {
            if(this.itemArray[i].id == arr[0])
            {
               (this.itemArray[i] as hideMenuListItem).setCount(arr[1]);
               break;
            }
         }
      }
      
      private function onLevelUp() : void
      {
         var i:int = 0;
         while(i < this.notEnoughLV_IconArr.length)
         {
            if(GameUnitManager.hero.level >= Data_lib.iconHide[this.notEnoughLV_IconArr[i].id][4])
            {
               this.addAtCanvas(this.notEnoughLV_IconArr[i]);
               this.notEnoughLV_IconArr.splice(i,1);
               i--;
            }
            i++;
         }
         if(this.notEnoughLV_IconArr.length == 0)
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,this.onLevelUp);
         }
      }
      
      protected function addAtCanvas(item:hideMenuListItem) : void
      {
         if(this.itemArray.indexOf(item) > -1)
         {
            return;
         }
         this.itemArray.push(item);
         this.can.addChild(item);
         this.sort();
         this.can.align();
      }
      
      protected function sort() : void
      {
         var j:* = undefined;
         this.itemArray.sortOn(["status","sortId"],[Array.NUMERIC,Array.NUMERIC]);
         var t_arr:Array = [];
         var len:int = int(this.itemArray.length);
         var i:int = 0;
         while(i < len)
         {
            if(this.itemArray[i].status == 1)
            {
               t_arr.push(this.itemArray[i]);
               this.itemArray.splice(i,1);
               i--;
               len--;
            }
            i++;
         }
         this.itemArray = t_arr.concat(this.itemArray);
         for(j in this.itemArray)
         {
            this.itemArray[j].y = j * 70;
         }
      }
      
      private function onHide() : void
      {
         this.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 528) / 2;
         y = (Global.stage.stageHeight - 501) / 2;
      }
   }
}

