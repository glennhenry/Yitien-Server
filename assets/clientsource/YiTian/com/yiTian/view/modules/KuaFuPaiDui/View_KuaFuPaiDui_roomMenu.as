package com.yiTian.view.modules.KuaFuPaiDui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_KuaFuPaiDui;
   import com.yiTian.net.message.cg.KuaFuPaiDuiCGMessage;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_KuaFuPaiDui_roomMenu extends Panel
   {
      
      private static var _instance:View_KuaFuPaiDui_roomMenu;
      
      private var prevBtn:Button;
      
      private var nextBtn:Button;
      
      private var pageTxt:MyTextField;
      
      private var curPage:int;
      
      private var totalPage:int;
      
      private var roomArr:Array;
      
      public function View_KuaFuPaiDui_roomMenu()
      {
         super();
         init();
      }
      
      public static function get instance() : View_KuaFuPaiDui_roomMenu
      {
         if(!_instance)
         {
            _instance = new View_KuaFuPaiDui_roomMenu();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var room:FangJian = null;
         move = new Rectangle(0,0,610,35);
         ComponentUtil.getBitmap("Back_GHFJ",this,{
            "x":0,
            "y":0
         },Global.KFPDdm);
         ComponentUtil.getBitmap("Title_GHFJ",this,{
            "x":297,
            "y":9
         },Global.KFPDdm);
         ComponentUtil.getBitmap("Back_YSD",this,{
            "x":499,
            "y":409
         },Global.KFPDdm);
         ComponentUtil.getTextField("提示：参加活动的人数决定开放房间的数量",this,{
            "x":23,
            "y":410,
            "color":15714352,
            "size":12,
            "leading":0
         });
         CloseButton = ComponentUtil.getButton("","Button_GuanBi",this,{
            "x":614,
            "y":10,
            "textColor":16771436
         },Global.KFPDdm);
         this.curPage = 1;
         this.totalPage = 1;
         this.prevBtn = ComponentUtil.getButton("","Button_SYY",this,{
            "x":470,
            "y":407,
            "textColor":16771436
         },Global.KFPDdm);
         this.nextBtn = ComponentUtil.getButton("","Button_XYY",this,{
            "x":562,
            "y":407,
            "textColor":16771436
         },Global.KFPDdm);
         this.pageTxt = ComponentUtil.getTextField("1/1",this,{
            "x":528,
            "y":409,
            "color":16777215,
            "size":12,
            "leading":0,
            "autoSize":"center"
         });
         this.prevBtn.enabled = false;
         this.prevBtn.callBack = this.changePage;
         this.nextBtn.enabled = false;
         this.nextBtn.callBack = this.changePage;
         this.roomArr = [];
         i = 0;
         while(i < 35)
         {
            room = new FangJian();
            room.x = 23 + i % 5 * 121;
            room.y = 40 + int(i / 5) * 50;
            room.visible = false;
            addChild(room);
            this.roomArr.push(room);
            i++;
         }
      }
      
      private function changePage(e:MouseEvent) : void
      {
         if(e.currentTarget == this.prevBtn)
         {
            --this.curPage;
         }
         else
         {
            ++this.curPage;
         }
         this.setCurPage();
      }
      
      private function setCurPage() : void
      {
         if(this.curPage == 1)
         {
            this.prevBtn.enabled = false;
         }
         else
         {
            this.prevBtn.enabled = true;
         }
         if(this.curPage == this.totalPage)
         {
            this.nextBtn.enabled = false;
         }
         else
         {
            this.nextBtn.enabled = true;
         }
         this.pageTxt.text = this.curPage + "/" + this.totalPage;
         var i:int = (this.curPage - 1) * 35;
         while(i < (this.curPage - 1) * 35 + 35)
         {
            if(Boolean(Model_KuaFuPaiDui.roomList[i]))
            {
               this.roomArr[i % 35].visible = true;
               this.roomArr[i % 35].setRoom(Model_KuaFuPaiDui.roomList[i]);
            }
            else
            {
               this.roomArr[i % 35].visible = false;
            }
            i++;
         }
      }
      
      public function freshRoom() : void
      {
         this.curPage = 1;
         this.totalPage = Math.max(Math.ceil(Model_KuaFuPaiDui.roomList.length / 35),1);
         this.setCurPage();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_FRESH_ROOM();
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
import com.yiTian.net.message.cg.KuaFuPaiDuiCGMessage;
import com.yiTian.view.comp.View_Alert;
import flash.display.Sprite;
import flash.events.MouseEvent;

class FangJian extends Sprite
{
   
   private var roomId:MyTextField;
   
   private var count:MyTextField;
   
   private var realRoomId:int;
   
   public function FangJian()
   {
      super();
      ComponentUtil.getBitmap("Back_FangJian",this,{
         "x":0,
         "y":0
      },Global.KFPDdm);
      ComponentUtil.getBitmap("Icon_FangJian",this,{
         "x":6,
         "y":6
      },Global.KFPDdm);
      this.roomId = ComponentUtil.getTextField("跨服派对",this,{
         "x":53,
         "y":5,
         "color":16775128,
         "size":12,
         "leading":0
      });
      this.count = ComponentUtil.getTextField("0/100",this,{
         "x":52,
         "y":23,
         "color":10092288,
         "size":12,
         "leading":0
      });
      this.buttonMode = true;
      this.addEventListener(MouseEvent.CLICK,this.changeRoom);
   }
   
   public function setRoom(arr:Array) : void
   {
      this.roomId.text = "跨服派对" + arr[1];
      this.realRoomId = arr[1];
      this.count.text = arr[2] + "/100";
   }
   
   private function changeRoom(e:MouseEvent) : void
   {
      View_Alert.show("切换房间后，会<font color=\'#ff0000\'>解除舞伴</font>关系，" + "默契度将会<font color=\'#ff0000\'>清零</font>，是否继续？",2,function():void
      {
         KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_CHANGE_ROOM(realRoomId);
      },null,null,null,310,null,null,"center",false,2);
   }
}
