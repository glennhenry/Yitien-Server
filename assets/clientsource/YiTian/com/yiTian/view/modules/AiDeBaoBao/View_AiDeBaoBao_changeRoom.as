package com.yiTian.view.modules.AiDeBaoBao
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.AiDeBaoBaoCGMessage;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_AiDeBaoBao_changeRoom extends Panel123
   {
      
      private static var _instance:View_AiDeBaoBao_changeRoom;
      
      private var roomModel:Array;
      
      private var roomArr:Array;
      
      private var closeBtn:Button;
      
      private var prevBtn:Button;
      
      private var nextBtn:Button;
      
      private var pageTxt:MyTextField;
      
      private var curPage:int;
      
      private var totalPage:int;
      
      public function View_AiDeBaoBao_changeRoom()
      {
         super();
         if(!_instance)
         {
            regResource("lang/ch/ADBB_Imgs.swf","ADBB_Imgsdm");
         }
      }
      
      public static function get instance() : View_AiDeBaoBao_changeRoom
      {
         if(!_instance)
         {
            _instance = new View_AiDeBaoBao_changeRoom();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         var room:RoomItem = null;
         move = new Rectangle(44,40,484,30);
         ComponentUtil.getBitmap("Back_Room",this,{
            "x":0,
            "y":0
         },Global.ADBB_Imgsdm);
         ComponentUtil.getTextField("提示：参加活动的人数决定开放房间的数量",this,{
            "x":103,
            "y":349,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Back_Page",this,{
            "x":467,
            "y":350
         },Global.ADBB_Imgsdm);
         this.roomArr = [];
         i = 0;
         while(i < 10)
         {
            room = new RoomItem();
            room.x = 87 + i % 5 * 96;
            room.y = 244 + int(i / 5) * 49;
            room.visible = false;
            addChild(room);
            this.roomArr.push(room);
            i++;
         }
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":552,
            "y":49,
            "textColor":16184781
         },Global.ADBB_Imgsdm);
         this.closeBtn.callBack = function():void
         {
            visible = false;
         };
         this.prevBtn = ComponentUtil.getButton("","Button_PageBack",this,{
            "x":435,
            "y":348,
            "textColor":16184781
         },Global.ADBB_Imgsdm);
         this.nextBtn = ComponentUtil.getButton("","Button_PageNext",this,{
            "x":532,
            "y":348,
            "textColor":16184781
         },Global.ADBB_Imgsdm);
         this.pageTxt = ComponentUtil.getTextField("00/00",this,{
            "x":495,
            "y":351,
            "color":16383744,
            "size":12,
            "leading":0
         },"center");
         this.curPage = 1;
         this.totalPage = 1;
         this.prevBtn.enabled = false;
         this.nextBtn.enabled = false;
         this.prevBtn.callBack = this.changePage;
         this.nextBtn.callBack = this.changePage;
      }
      
      private function changePage(e:MouseEvent) : void
      {
         if(e.currentTarget == this.prevBtn)
         {
            --this.curPage;
         }
         else if(e.currentTarget == this.nextBtn)
         {
            ++this.curPage;
         }
         this.updateCurrentPage();
         this.updatePageTxt();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.curPage = 1;
            AiDeBaoBaoCGMessage.CG_AiDeBaoBao_ROOM_MENU();
         }
      }
      
      public function Update(arr:Array) : void
      {
         this.roomModel = arr;
         this.roomModel.sortOn("0",16);
         this.totalPage = Math.ceil(this.roomModel.length / 10);
         this.updateCurrentPage();
         this.updatePageTxt();
      }
      
      private function updateCurrentPage() : void
      {
         var i:* = undefined;
         for(i in this.roomArr)
         {
            if(Boolean(this.roomModel[(this.curPage - 1) * 10 + i]))
            {
               this.roomArr[i].visible = true;
               this.roomArr[i].id = this.roomModel[(this.curPage - 1) * 10 + i][0];
               this.roomArr[i].number = this.roomModel[(this.curPage - 1) * 10 + i][1];
            }
            else
            {
               this.roomArr[i].visible = false;
            }
         }
      }
      
      private function updatePageTxt() : void
      {
         this.pageTxt.text = this.curPage + "/" + this.totalPage;
         if(this.curPage > 1)
         {
            this.prevBtn.enabled = true;
         }
         else
         {
            this.prevBtn.enabled = false;
         }
         if(this.curPage < this.totalPage)
         {
            this.nextBtn.enabled = true;
         }
         else
         {
            this.nextBtn.enabled = false;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.net.message.cg.AiDeBaoBaoCGMessage;
import flash.display.Sprite;
import flash.events.MouseEvent;

class RoomItem extends Sprite
{
   
   private var _id:int;
   
   private var _number:int;
   
   private var roomTxt:MyTextField;
   
   private var numTxt:MyTextField;
   
   public function RoomItem()
   {
      super();
      ComponentUtil.getBitmap("Back_RoomItem",this,{
         "x":0,
         "y":0
      },Global.ADBB_Imgsdm);
      this.roomTxt = ComponentUtil.getTextField("房间 00",this,{
         "x":54,
         "y":6,
         "color":16777215,
         "size":12,
         "leading":0
      },"center");
      this.numTxt = ComponentUtil.getTextField("（00/00）",this,{
         "x":54,
         "y":23,
         "color":16777215,
         "size":12,
         "leading":0
      },"center");
      this.buttonMode = true;
      this.addEventListener(MouseEvent.CLICK,this.onClick);
   }
   
   private function onClick(e:MouseEvent) : void
   {
      AiDeBaoBaoCGMessage.CG_AiDeBaoBao_CHANGE_ROOM(this._id);
   }
   
   public function get id() : int
   {
      return this._id;
   }
   
   public function set id(value:int) : void
   {
      this._id = value;
      this.roomTxt.text = "房间 " + this._id;
   }
   
   public function get number() : int
   {
      return this._number;
   }
   
   public function set number(value:int) : void
   {
      this._number = value;
      this.numTxt.text = "（" + this._number + "/100）";
   }
}
