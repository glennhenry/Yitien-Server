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
   
   public class View_KuaFuPaiDui_partnerMenu extends Panel
   {
      
      private static var _instance:View_KuaFuPaiDui_partnerMenu;
      
      private var freshBtn:Button;
      
      private var prevBtn:Button;
      
      private var nextBtn:Button;
      
      private var pageTxt:MyTextField;
      
      private var curPage:int;
      
      private var totalPage:int;
      
      private var partnerArr:Array;
      
      public function View_KuaFuPaiDui_partnerMenu()
      {
         super();
         init();
      }
      
      public static function get instance() : View_KuaFuPaiDui_partnerMenu
      {
         if(!_instance)
         {
            _instance = new View_KuaFuPaiDui_partnerMenu();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var list:DDWJ = null;
         move = new Rectangle(0,0,610,32);
         ComponentUtil.getBitmap("Back_XZDD",this,{
            "x":0,
            "y":0
         },Global.KFPDdm);
         ComponentUtil.getBitmap("Title_XZDD",this,{
            "x":278,
            "y":9
         },Global.KFPDdm);
         ComponentUtil.getBitmap("Back_HBQC",this,{
            "x":19,
            "y":36
         },Global.KFPDdm);
         CloseButton = ComponentUtil.getButton("","Button_GuanBi",this,{
            "x":614,
            "y":10,
            "textColor":16771436
         },Global.KFPDdm);
         this.freshBtn = ComponentUtil.getButton("","Button_ShuaXin",this,{
            "x":313,
            "y":397,
            "textColor":16771436
         },Global.KFPDdm);
         this.freshBtn.callBack = function():void
         {
            KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_FRESH_PARTNER();
         };
         this.curPage = 1;
         this.totalPage = 1;
         this.prevBtn = ComponentUtil.getButton("","Button_SYY",this,{
            "x":486,
            "y":401,
            "textColor":16771436
         },Global.KFPDdm);
         this.nextBtn = ComponentUtil.getButton("","Button_XYY",this,{
            "x":578,
            "y":401,
            "textColor":16771436
         },Global.KFPDdm);
         this.pageTxt = ComponentUtil.getTextField("1/1",this,{
            "x":544,
            "y":403,
            "color":16777215,
            "size":12,
            "leading":0,
            "autoSize":"center"
         });
         this.prevBtn.enabled = false;
         this.prevBtn.callBack = this.changePage;
         this.nextBtn.enabled = false;
         this.nextBtn.callBack = this.changePage;
         this.partnerArr = [];
         i = 0;
         while(i < 9)
         {
            list = new DDWJ();
            list.x = 314;
            list.y = 45 + i * 39;
            addChild(list);
            list.visible = false;
            this.partnerArr.push(list);
            i++;
         }
         Global.control.registerCallBack(Enum_KuaFuPaiDui.INVITE_SUCCEED,this.inviteSucceed);
      }
      
      private function inviteSucceed(e:*) : void
      {
         this.visible = false;
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
         var i:int = (this.curPage - 1) * 9;
         while(i < (this.curPage - 1) * 9 + 9)
         {
            if(Boolean(Model_KuaFuPaiDui.partnerList[i]))
            {
               this.partnerArr[i % 9].visible = true;
               this.partnerArr[i % 9].setInfo(Model_KuaFuPaiDui.partnerList[i]);
            }
            else
            {
               this.partnerArr[i % 9].visible = false;
            }
            i++;
         }
      }
      
      public function freshRoom() : void
      {
         this.curPage = 1;
         this.totalPage = Math.max(Math.ceil(Model_KuaFuPaiDui.partnerList.length / 9),1);
         this.setCurPage();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_FRESH_PARTNER();
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.net.message.cg.KuaFuPaiDuiCGMessage;
import flash.display.Sprite;

class DDWJ extends Sprite
{
   
   private var getBtn:Button;
   
   private var id:Number;
   
   private var zoneId:int;
   
   private var nameTxt:MyTextField;
   
   private var sexTxt:MyTextField;
   
   public function DDWJ()
   {
      super();
      this.nameTxt = ComponentUtil.getTextField("玩家中文名字.R119.S",this,{
         "x":0,
         "y":6,
         "color":16514386,
         "size":12,
         "leading":0
      });
      this.sexTxt = ComponentUtil.getTextField("女",this,{
         "x":157,
         "y":6,
         "color":16775128,
         "size":12,
         "leading":0
      });
      this.getBtn = ComponentUtil.getButton("","Button_TiaoWu",this,{
         "x":212,
         "y":0,
         "textColor":16771436
      },Global.KFPDdm);
      this.getBtn.callBack = function():void
      {
         KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_INVITE(id,zoneId);
      };
   }
   
   public function setInfo(arr:Array) : void
   {
      this.id = arr[0];
      this.zoneId = arr[1];
      this.nameTxt.text = arr[2];
      if(arr[3] == 1)
      {
         this.sexTxt.text = "男";
      }
      else
      {
         this.sexTxt.text = "女";
      }
   }
}
