package com.yiTian.view.modules.guangMingDing
{
   import Layout.GridGroup;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   
   public class View_guangMingDingHallPanel extends Panel123
   {
      
      private var _bg:DisplayObject;
      
      private var _itemsLay:GridGroup;
      
      private var _items:Array = [];
      
      private var _bgLay:GridGroup;
      
      private var _btnPrePage:Button;
      
      private var _btnNxtPage:Button;
      
      private var _tfPage:MyTextField;
      
      public var _listCZItem:Child_ListCZItem;
      
      private var _curPage:int = 1;
      
      private var _maxPage:int = 1;
      
      private var _questDataTimer:Timer;
      
      public function View_guangMingDingHallPanel()
      {
         super();
         regResource("lang/ch/GuangMingDing_Img.swf","GuangMingDing_Imgdm");
         this.visible = false;
      }
      
      public static function getInstance() : View_guangMingDingHallPanel
      {
         return Singleton.getInstance(View_guangMingDingHallPanel);
      }
      
      override protected function initUI2() : void
      {
         var smallBg:Bitmap = null;
         var it:Child_RoomItem = null;
         var vo:Vo_item = null;
         this._bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":908,
            "height":470
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_YCGMD",this,{
            "x":374,
            "y":5
         },Global.GuangMingDing_Imgdm);
         ComponentUtil.getScaleBitmap("Back_01",[22,22,1,1],this,{
            "x":24,
            "y":40,
            "width":860,
            "height":420
         },Global.GuangMingDing_Imgdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":279,
            "y":425,
            "width":60,
            "height":25
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":34,
            "y":50,
            "width":550,
            "height":370
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this._bg.width,35);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":874,
            "y":6,
            "callBack":this.hide
         },Global.Img_Cdm);
         this._bgLay = new GridGroup(42,58,0,0,0,180,0,180,3);
         this._itemsLay = new GridGroup(42,58,0,0,0,180,0,180,3);
         var i:int = 0;
         while(i < 6)
         {
            smallBg = ComponentUtil.getBitmap("Back_RoomNone",this,null,Global.GuangMingDing_Imgdm);
            this._bgLay.appendItem(smallBg);
            it = new Child_RoomItem();
            this._items.push(it);
            this._itemsLay.appendItem(it);
            addChild(it);
            i += 1;
         }
         this._bgLay.align();
         this._itemsLay.align();
         this._tfPage = ComponentUtil.getTextField("",this,{
            "x":309,
            "y":428,
            "color":14662240,
            "realWidth":0
         });
         this._tfPage.autoSize = TextFieldAutoSize.CENTER;
         this._btnPrePage = ComponentUtil.getButton("上一页","Button_Four",this,{
            "x":202,
            "y":426,
            "textColor":16184781,
            "callBack":this.prePageClickHd
         },Global.Img_Cdm);
         this._btnNxtPage = ComponentUtil.getButton("下一页","Button_Four",this,{
            "x":344,
            "y":425,
            "textColor":16184781,
            "callBack":this.nxtPageClickHd
         },Global.Img_Cdm);
         var gridInfos:Array = [];
         var ii:int = 0;
         while(ii < 3)
         {
            vo = new Vo_item();
            vo.id = 44601;
            vo.Init_lib();
            gridInfos.push(vo);
            ii += 1;
         }
         this._listCZItem = new Child_ListCZItem();
         this._listCZItem.x = 592;
         this._listCZItem.y = 48;
         addChild(this._listCZItem);
      }
      
      private function prePageClickHd(e:MouseEvent) : void
      {
         if(this._curPage > 1)
         {
            GuangMingDingCGMessage.CG_GMD_ROOM_INFO(this._curPage - 1);
         }
         this._questDataTimer.reset();
         this._questDataTimer.start();
      }
      
      private function nxtPageClickHd(e:MouseEvent) : void
      {
         if(this._curPage < this._maxPage)
         {
            GuangMingDingCGMessage.CG_GMD_ROOM_INFO(this._curPage + 1);
         }
         this._questDataTimer.reset();
         this._questDataTimer.start();
      }
      
      public function updatePage(curPage:int, maxPage:int) : void
      {
         this._curPage = curPage;
         this._maxPage = maxPage;
         this._tfPage.text = curPage.toString() + "/" + maxPage.toString();
      }
      
      public function updateRooms(infos:Array) : void
      {
         var o:Object = null;
         var item:Child_RoomItem = null;
         var i:int = 0;
         while(i < 6)
         {
            o = infos[i];
            item = this._items[i];
            item.update(o);
            i += 1;
         }
      }
      
      public function show(param:* = null) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.GMD)
         {
            this.hide();
            return;
         }
         this.visible = true;
         this._listCZItem._cbPassWord.selected = false;
      }
      
      public function hide(param:* = null) : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(!this._questDataTimer)
         {
            this._questDataTimer = new Timer(GuangMingDingConfig.HALL_INFO_QUEST_INTERVAL);
            this._questDataTimer.addEventListener(TimerEvent.TIMER,this.onTimer);
         }
         super.visible = value;
         Model_guangMingDing.isHallShow = value;
         if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.hide);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.hide);
            this._questDataTimer.reset();
            this._questDataTimer.start();
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.hide);
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.hide);
            Global.control.sendNotification(Msg_guangMingDing.HALLPANEL_HIDE,this);
            this._questDataTimer.stop();
         }
      }
      
      private function onTimer(e:TimerEvent) : void
      {
         GuangMingDingCGMessage.CG_GMD_ROOM_INFO(Model_guangMingDing.curPage);
      }
      
      override public function get width() : Number
      {
         return this._bg.width;
      }
      
      override public function get height() : Number
      {
         return this._bg.height;
      }
   }
}

