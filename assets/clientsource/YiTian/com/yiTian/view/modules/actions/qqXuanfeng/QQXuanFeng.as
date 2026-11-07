package com.yiTian.view.modules.actions.qqXuanfeng
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.ActionsCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class QQXuanFeng extends Panel123
   {
      
      private var grid:View_Grid;
      
      private var icon:Bitmap;
      
      private var getBtn:Button;
      
      private var isFirstOpen:Boolean = true;
      
      private var _status:int;
      
      public function QQXuanFeng()
      {
         super();
         regResource("lang/ch/QQXuanFeng.swf","QQXuanFengdm");
      }
      
      override protected function initUI2() : void
      {
         var biZhiBtn:Button;
         var shiPinBtn:Button;
         var voI:Vo_item;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":428,
            "height":250
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back4",[3,3,1,1],this,{
            "x":24,
            "y":40,
            "width":380,
            "height":200
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("ListBack_Bule02",[12,12,1,1],this,{
            "x":34,
            "y":50,
            "width":360,
            "height":100
         },Global.Img_Cdm);
         move = new Rectangle(0,0,428,36);
         this.icon = ComponentUtil.getBitmap("Icon_QQXF",this,{
            "x":57,
            "y":63
         },Global.QQXuanFengdm);
         biZhiBtn = ComponentUtil.getButton("","Button_BiZhi",this,{
            "x":71,
            "y":169,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               navigateToURL(new URLRequest("http://urlxf.qq.com/?eayauiB"),"_blank");
            }
         },Global.QQXuanFengdm);
         shiPinBtn = ComponentUtil.getButton("","Button_ShiPin",this,{
            "x":235,
            "y":167,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               navigateToURL(new URLRequest("http://urlxf.qq.com/?7Zfy6zy"),"_blank");
            }
         },Global.QQXuanFengdm);
         ComponentUtil.getTextField("玩家每天可以领取QQ旋风礼品一个",this,{
            "x":170,
            "y":65,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over(true,null);
         this.grid.set_tf_count(true,false,true);
         ComponentUtil.setPropertie(this.grid,{
            "x":175,
            "y":93
         });
         addChild(this.grid);
         voI = new Vo_item();
         voI.id = 46061;
         voI.count = 1;
         voI.Init_lib();
         this.grid.vo = voI;
         this.getBtn = ComponentUtil.getButton("领取","Button_RedFive",this,{
            "x":250,
            "y":100,
            "textColor":16184781,
            "callBack":function():void
            {
               getAward();
            }
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":394,
            "y":6,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_QQXuanFeng",this,{
            "x":134,
            "y":5
         },Global.QQXuanFengdm);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               TipManager.bind(this.icon,"QQ旋风");
            }
            this.setBtnEnable(this._status == 1);
         }
      }
      
      public function set status(value:int) : void
      {
         this._status = value;
         if(visible)
         {
            this.setBtnEnable(this._status == 1);
         }
      }
      
      private function setBtnEnable(value:Boolean) : void
      {
         this.getBtn.enabled = value;
         if(value)
         {
            this.getBtn.label = "领取";
         }
         else
         {
            this.getBtn.label = "已领取";
         }
      }
      
      public function open() : void
      {
         if(!visible)
         {
            this.visible = true;
         }
      }
      
      public function getAward() : void
      {
         ActionsCGMessage.CG_QQXUANFENG_GETAWARD();
      }
      
      public function getEff() : void
      {
         ComboTweenStep.toBag(this.grid,this.grid.x,this.grid.y);
      }
      
      public function close() : void
      {
         this.visible = false;
      }
   }
}

