package com.yiTian.view.modules.kuafujingjichang
{
   import com.ui.containers.Canvas;
   import com.ui.controls.ComboBox;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_KuaFuJingJiChang;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.net.message.cg.KuaFuJingJiChangCGMessage;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class DRKFRank extends Panel123
   {
      
      private static var _instance:DRKFRank;
      
      private var back:ScaleBitmap;
      
      private var PL1:PingLunItem;
      
      private var PL2:PingLunItem;
      
      private var PL3:PingLunItem;
      
      private var PLVector:Array;
      
      private var canvas:Canvas;
      
      public var isXuanZe:Boolean = false;
      
      private var tfy:Number = 0;
      
      private var arr:Array = [["40级-49级榜单",1],["50级-59级榜单",2],["60级-69级榜单",3],["70级-79级榜单",4],["80级-89级榜单",5],["90级-99级榜单",6],["100级-109级榜单",7],["110级-119级榜单",8],["120级-129级榜单",9],["130级-159级榜单",10]];
      
      public var combobox:ComboBox;
      
      public function DRKFRank()
      {
         this.PLVector = [this.PL1,this.PL2,this.PL3];
         super();
         regResource("lang/ch/DRKF_Imgs.swf","DRKF_Imgsdm");
      }
      
      public static function get instance() : DRKFRank
      {
         if(!_instance)
         {
            _instance = new DRKFRank();
         }
         return _instance;
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      override protected function initUI2() : void
      {
         var lvl:int;
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":886,
            "height":534
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Img",[26,26,2,2],this,{
            "x":24,
            "y":40,
            "width":838,
            "height":485
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Title_DRKFJingJi",this,{
            "x":363,
            "y":5
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Back_Rank",this,{
            "x":26,
            "y":42
         },Global.DRKF_Imgsdm);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":852,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.addEventListener(MouseEvent.CLICK,this.CloseClick);
         this.PLVector.length = 3;
         this.PLVector[0] = new PingLunItem();
         this.PLVector[0].x = 342;
         this.PLVector[0].y = 435;
         this.PLVector[0].teamIndex = 1;
         addChild(this.PLVector[0]);
         this.PLVector[1] = new PingLunItem();
         this.PLVector[1].x = 37;
         this.PLVector[1].y = 303;
         this.PLVector[1].teamIndex = 2;
         addChild(this.PLVector[1]);
         this.PLVector[2] = new PingLunItem();
         this.PLVector[2].x = 630;
         this.PLVector[2].y = 303;
         this.PLVector[2].teamIndex = 3;
         addChild(this.PLVector[2]);
         this.combobox = new ComboBox(this.arr,function(value:Object):void
         {
            var j:* = 0;
            while(j < PLVector.length)
            {
               isXuanZe = true;
               (PLVector[j] as PingLunItem).remove();
               j++;
            }
            isXuanZe = true;
            Model_KuaFuJingJiChang.PJVo.length = 0;
            KuaFuJingJiChangCGMessage.CG_STAR_PAIHANG(int(value));
         },130,"Button_PageDown","ComboBox_background","xuanze_over",130);
         lvl = GameUnitManager.hero.level / 10 - 3;
         this.combobox.select(lvl);
         this.combobox.x = 30;
         this.combobox.y = 60;
         addChild(this.combobox);
         this.initDynamicView();
      }
      
      private function CloseClick(e:MouseEvent) : void
      {
         var j:int = 0;
         while(j < this.PLVector.length)
         {
            this.isXuanZe = true;
            (this.PLVector[j] as PingLunItem).remove();
            j++;
         }
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      public function updata() : void
      {
         var i:int = 0;
         while(i < Model_KuaFuJingJiChang.PJVo.length)
         {
            (this.PLVector[i] as PingLunItem).updata(Model_KuaFuJingJiChang.PJVo[i]);
            i++;
         }
         if(!visible)
         {
            this.show();
         }
      }
      
      private function herobitmap(a:Array) : void
      {
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
   }
}

