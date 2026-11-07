package com.yiTian.view.modules.meirixg
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_MeiRiXianGou;
   import com.yiTian.data.vo.Vo_MeiRiXianGou;
   import com.yiTian.net.message.cg.MeiRiXianGouCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class View_MeiRiXianGou extends Panel123
   {
      
      public static var tempIndex:int;
      
      public static var dic:Dictionary;
      
      private static var _instance:View_MeiRiXianGou;
      
      private var canv:Canvas;
      
      private var vec:Vector.<Item_MeiRiXianGou>;
      
      private var bm:Bitmap;
      
      private var isFirst:Boolean;
      
      public function View_MeiRiXianGou()
      {
         super();
         regResource("lang/ch/XSFQ.swf","XSFQdm");
      }
      
      public static function get instance() : View_MeiRiXianGou
      {
         if(!_instance)
         {
            _instance = new View_MeiRiXianGou();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         dic = new Dictionary();
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":96,
            "y":0,
            "width":811,
            "height":530
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":121,
            "y":40,
            "width":761,
            "height":480
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":872,
            "y":6,
            "textColor":16771436,
            "callBack":this.onClose
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_XGFQ",this,{
            "x":421,
            "y":5
         },Global.XSFQdm);
         ComponentUtil.getBitmap("Back_MRXG",this,{
            "x":133,
            "y":52
         },Global.XSFQdm);
         this.bm = ComponentUtil.getBitmap("MRMM",this,{
            "x":0,
            "y":10
         },Global.XSFQdm);
         move = new Rectangle(0,0,778,36);
         this.canv = new Canvas(560,420);
         this.canv.x = 293;
         this.canv.y = 70;
         this.addChild(this.canv);
      }
      
      private function onClose(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      public function setdata() : void
      {
         var item:Item_MeiRiXianGou = null;
         var len:int = int(this.vec.length);
         var vecc:Vector.<Vo_MeiRiXianGou> = Model_MeiRiXianGou.data_MRXG;
         var k:int = 0;
         while(k < len)
         {
            item = this.vec[k];
            item.vo = vecc[k];
            k++;
         }
      }
      
      public function iconFly() : void
      {
         var len:int = int(this.vec.length);
         var k:int = 0;
         while(k < len)
         {
            if(this.vec[k].vo.index == tempIndex)
            {
               this.vec[k].iconFLY();
               break;
            }
            k++;
         }
      }
      
      public function show() : void
      {
         MeiRiXianGouCGMessage.CG_MRXG_OPEN();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.isFirst)
            {
               this.drawItem();
            }
            this.isFirst = true;
            Tween.stop(this.bm);
            Tween.to(this.bm,400,{
               "x":[-30,0],
               "alpha":[0.6,1]
            });
         }
      }
      
      private function drawItem() : void
      {
         var vo:Vo_MeiRiXianGou = null;
         var item:Item_MeiRiXianGou = null;
         var k:int = 0;
         var lib:Array = Data_lib.meirixiangou.toArray();
         var len:int = int(lib.length);
         Model_MeiRiXianGou.data_MRXG = new Vector.<Vo_MeiRiXianGou>();
         this.vec = new Vector.<Item_MeiRiXianGou>();
         k = 0;
         while(k < len)
         {
            vo = new Vo_MeiRiXianGou();
            vo.countMAX = lib[k][5];
            vo.index = lib[k][0];
            vo.popId = lib[k][1];
            vo.popType = lib[k][6];
            vo.moneyType = lib[k][2];
            vo.priceXJ = lib[k][4];
            vo.priceYJ = lib[k][3];
            vo.hightLine = lib[k][7];
            vo.hot = lib[k][8];
            Model_MeiRiXianGou.data_MRXG.push(vo);
            item = new Item_MeiRiXianGou();
            item.vo = vo;
            item.x = 268 * (k % 2) + 20;
            item.y = 105 * int(k / 2);
            this.canv.addChild(item);
            this.vec.push(item);
            k++;
         }
         this.canv.scrollAutoType = ScrollAutoType.TO_TOP;
         this.canv.align();
      }
   }
}

