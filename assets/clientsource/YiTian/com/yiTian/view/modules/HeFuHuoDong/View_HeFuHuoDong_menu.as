package com.yiTian.view.modules.HeFuHuoDong
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.HeFuHuoDongCGMessage;
   import com.yiTian.view.Panel123;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_HeFuHuoDong_menu extends Panel123
   {
      
      private static var _instance:View_HeFuHuoDong_menu;
      
      private var closeBtn:Button;
      
      private var tabBtnArray:Array;
      
      private var pageArray:Array;
      
      public function View_HeFuHuoDong_menu()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         this.tabBtnArray = [];
         this.pageArray = [];
         regResource("lang/ch/HeFu_Imgs.swf","HeFu_Imgsdm");
      }
      
      public static function get instance() : View_HeFuHuoDong_menu
      {
         if(!_instance)
         {
            _instance = new View_HeFuHuoDong_menu();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var i:* = undefined;
         move = new Rectangle(0,0,932,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":932,
            "height":510
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":884,
            "height":460
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
            "x":34,
            "y":50,
            "width":110,
            "height":440
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_HeFu",this,{
            "x":386,
            "y":5
         },Global.HeFu_Imgsdm);
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":898,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.closeBtn.callBack = function():void
         {
            visible = false;
         };
         this.tabBtnArray.push(ComponentUtil.getTabButton("合服登陆","ClassButton",this,{
            "x":43,
            "y":59,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm));
         this.tabBtnArray.push(ComponentUtil.getTabButton("回归礼包","ClassButton",this,{
            "x":43,
            "y":95,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm));
         this.tabBtnArray.push(ComponentUtil.getTabButton("充值回馈","ClassButton",this,{
            "x":43,
            "y":131,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm));
         this.tabBtnArray.push(ComponentUtil.getTabButton("竞技决战","ClassButton",this,{
            "x":43,
            "y":167,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm));
         this.tabBtnArray.push(ComponentUtil.getTabButton("帮派争霸","ClassButton",this,{
            "x":43,
            "y":203,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm));
         this.tabBtnArray.push(ComponentUtil.getTabButton("在线豪礼","ClassButton",this,{
            "x":43,
            "y":239,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm));
         this.tabBtnArray.push(ComponentUtil.getTabButton("战力争夺","ClassButton",this,{
            "x":43,
            "y":275,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm));
         this.tabBtnArray.push(ComponentUtil.getTabButton("宠物比拼","ClassButton",this,{
            "x":43,
            "y":311,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm));
         this.pageArray.push(View_HefuHuoDong0.instance);
         this.pageArray.push(View_HefuHuoDong1.instance);
         this.pageArray.push(View_HefuHuoDong2.instance);
         this.pageArray.push(View_HefuHuoDong3.instance);
         this.pageArray.push(View_HefuHuoDong4.instance);
         this.pageArray.push(View_HefuHuoDong5.instance);
         this.pageArray.push(View_HefuHuoDong6.instance);
         this.pageArray.push(View_HefuHuoDong7.instance);
         for(i in this.tabBtnArray)
         {
            this.pageArray[i].x = 154;
            this.pageArray[i].y = 40;
            this.pageArray[i].visible = false;
            addChild(this.pageArray[i]);
            this.tabBtnArray[i].y = 59 + i * 36;
            this.tabBtnArray[i].binding = this.pageArray[i];
            this.tabBtnArray[i].addEventListener(MouseEvent.CLICK,this.onClickTabBtn);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.onClickTabBtn(0);
         }
      }
      
      private function onClickTabBtn(e:*) : void
      {
         if(e is Number)
         {
            HeFuHuoDongCGMessage.CG_OPEN_MENU(e + 1);
         }
         else if(e is MouseEvent)
         {
            switch(e.currentTarget.binding)
            {
               case View_HefuHuoDong0.instance:
                  HeFuHuoDongCGMessage.CG_OPEN_MENU(1);
                  break;
               case View_HefuHuoDong1.instance:
                  HeFuHuoDongCGMessage.CG_OPEN_MENU(2);
                  break;
               case View_HefuHuoDong2.instance:
                  HeFuHuoDongCGMessage.CG_OPEN_MENU(3);
                  break;
               case View_HefuHuoDong3.instance:
                  this.setTabBtn(View_HefuHuoDong3.instance);
                  break;
               case View_HefuHuoDong4.instance:
                  this.setTabBtn(View_HefuHuoDong4.instance);
                  break;
               case View_HefuHuoDong5.instance:
                  HeFuHuoDongCGMessage.CG_OPEN_MENU(4);
                  break;
               case View_HefuHuoDong6.instance:
                  this.setTabBtn(View_HefuHuoDong6.instance);
                  break;
               case View_HefuHuoDong7.instance:
                  this.setTabBtn(View_HefuHuoDong7.instance);
            }
         }
      }
      
      public function setTabBtn(menu:Sprite) : void
      {
         var i:* = undefined;
         for(i in this.tabBtnArray)
         {
            if(menu == this.tabBtnArray[i].binding)
            {
               this.tabBtnArray[i].choose = true;
               if(Boolean(this.pageArray.length))
               {
                  this.tabBtnArray[i].binding.updateMenu();
               }
            }
            else
            {
               this.tabBtnArray[i].choose = false;
            }
         }
      }
   }
}

