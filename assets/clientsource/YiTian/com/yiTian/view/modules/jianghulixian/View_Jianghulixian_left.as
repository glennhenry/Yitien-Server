package com.yiTian.view.modules.jianghulixian
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.TipManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.utils.Timer;
   
   public class View_Jianghulixian_left extends Sprite
   {
      
      private var id:int;
      
      private var prizeNameTxt:MyTextField;
      
      private var yueliTxt:MyTextField;
      
      private var moneyTxt:MyTextField;
      
      private var bangyinIcon:Sprite;
      
      private var yueliIcon:Sprite;
      
      private var SelectBitmap:Bitmap;
      
      private var timer:Timer;
      
      public function View_Jianghulixian_left(_id:int)
      {
         super();
         ComponentUtil.getBitmap("JLList_Back",this,{
            "x":0,
            "y":0
         },Global.LiXian_Imgsdm);
         this.prizeNameTxt = ComponentUtil.getTextField("",this,{
            "x":68,
            "y":3,
            "color":16696880,
            "size":12,
            "leading":0
         });
         this.prizeNameTxt.filters = [new GlowFilter(16777215,1,2,2,0.5)];
         this.bangyinIcon = new Sprite();
         this.bangyinIcon.addChild(ComponentUtil.getBitmap("Bangyin",this,{
            "x":11,
            "y":21
         },Global.LiXian_Imgsdm));
         this.addChild(this.bangyinIcon);
         this.yueliIcon = new Sprite();
         this.yueliIcon.addChild(ComponentUtil.getBitmap("Yueli",this,{
            "x":103,
            "y":22
         },Global.LiXian_Imgsdm));
         this.addChild(this.yueliIcon);
         this.yueliTxt = ComponentUtil.getTextField("0",this,{
            "x":132,
            "y":20,
            "color":11363483,
            "size":12,
            "leading":0
         });
         this.moneyTxt = ComponentUtil.getTextField("0",this,{
            "x":40,
            "y":20,
            "color":52224,
            "size":12,
            "leading":0
         });
         this.SelectBitmap = ComponentUtil.getBitmap("List_Select",this,{
            "x":-3,
            "y":-3
         },Global.LiXian_Imgsdm);
         this.id = _id;
         this.timer = new Timer(150);
         this.timer.addEventListener(TimerEvent.TIMER,this.onLightUp);
         this.Init();
      }
      
      private function Init() : void
      {
         var arr:Array = String(Data_lib.paixingbiao[this.id + 1][1]).split("_");
         this.prizeNameTxt.text = Data_lib.paixingbiao[this.id + 1][0];
         this.yueliTxt.text = arr[1];
         this.moneyTxt.text = arr[0];
         this.SelectBitmap.visible = false;
         TipManager.bind(this.bangyinIcon,"绑银");
         TipManager.bind(this.yueliIcon,"阅历");
      }
      
      private function onLightUp(e:TimerEvent) : void
      {
         this.SelectBitmap.alpha = this.SelectBitmap.alpha == 1 ? 0.5 : 1;
      }
      
      public function setSelect(_bool:Boolean) : void
      {
         if(_bool)
         {
            this.timer.start();
         }
         else
         {
            this.timer.reset();
         }
         this.SelectBitmap.visible = _bool;
      }
   }
}

