package com.yiTian.view.modules.vipBGift
{
   import com.ui.controls.Button;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_vipBGift;
   import com.yiTian.net.message.cg.VipBGiftCGMessage;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   
   public class View_vipBGift extends Panel123
   {
      
      private static var instance:View_vipBGift;
      
      private var BGVec:Vector.<QiTianLB> = new Vector.<QiTianLB>();
      
      private var JJVec:Vector.<HGJJ> = new Vector.<HGJJ>();
      
      private var instance0:ScaleBitmap;
      
      private var instance1:ScaleBitmap;
      
      private var instance2:Button;
      
      private var instance3:ScaleBitmap;
      
      private var instance4:ScaleBitmap;
      
      private var instance5:Bitmap;
      
      private var instance6:Bitmap;
      
      private var instance7:Bitmap;
      
      private var instance8:Bitmap;
      
      private var instance9:QiTianLB;
      
      private var instance10:QiTianLB;
      
      private var instance11:QiTianLB;
      
      private var instance12:QiTianLB;
      
      private var instance13:QiTianLB;
      
      private var instance14:Bitmap;
      
      private var instance15:Bitmap;
      
      private var instance16:Bitmap;
      
      private var instance17:Bitmap;
      
      private var instance18:Bitmap;
      
      private var instance19:Bitmap;
      
      private var instance20:Bitmap;
      
      private var instance21:HGJJ;
      
      private var instance22:HGJJ;
      
      private var instance23:HGJJ;
      
      public function View_vipBGift()
      {
         super();
         regResource("lang/ch/WHHG.swf","WHHGdm");
      }
      
      public static function getInstance() : View_vipBGift
      {
         if(!instance)
         {
            instance = new View_vipBGift();
         }
         return instance;
      }
      
      override protected function initUI2() : void
      {
         var i:int;
         this.instance0 = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":684,
            "height":522
         },Global.Img_Cdm);
         this.instance1 = ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":634,
            "height":472
         },Global.Img_Cdm);
         this.instance2 = ComponentUtil.getButton("","Button_Close",this,{
            "x":650,
            "y":6,
            "textColor":16771436,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         this.instance3 = ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":191,
            "width":610,
            "height":152
         },Global.WHHGdm);
         this.instance4 = ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":375,
            "width":610,
            "height":125
         },Global.WHHGdm);
         this.instance5 = ComponentUtil.getBitmap("Light_WHHG",this,{
            "x":37,
            "y":343
         },Global.WHHGdm);
         this.instance6 = ComponentUtil.getBitmap("Light_WHHG",this,{
            "x":37,
            "y":159
         },Global.WHHGdm);
         this.instance7 = ComponentUtil.getBitmap("Back_WHHG",this,{
            "x":37,
            "y":51
         },Global.WHHGdm);
         this.instance8 = ComponentUtil.getBitmap("Title_WHHG",this,{
            "x":262,
            "y":5
         },Global.WHHGdm);
         this.instance9 = new QiTianLB();
         this.instance9.x = 44;
         this.instance9.y = 198;
         addChild(this.instance9);
         this.instance10 = new QiTianLB();
         this.instance10.x = 164;
         this.instance10.y = 198;
         addChild(this.instance10);
         this.instance11 = new QiTianLB();
         this.instance11.x = 284;
         this.instance11.y = 198;
         addChild(this.instance11);
         this.instance12 = new QiTianLB();
         this.instance12.x = 404;
         this.instance12.y = 198;
         addChild(this.instance12);
         this.instance13 = new QiTianLB();
         this.instance13.x = 524;
         this.instance13.y = 198;
         addChild(this.instance13);
         this.instance14 = ComponentUtil.getBitmap("Text_HGJJ",this,{
            "x":293,
            "y":350
         },Global.WHHGdm);
         this.instance15 = ComponentUtil.getBitmap("Text_HGLB",this,{
            "x":310,
            "y":167
         },Global.WHHGdm);
         this.instance16 = ComponentUtil.getBitmap("Text_QiTian",this,{
            "x":559,
            "y":202
         },Global.WHHGdm);
         this.instance17 = ComponentUtil.getBitmap("Text_SanTian",this,{
            "x":319,
            "y":202
         },Global.WHHGdm);
         this.instance18 = ComponentUtil.getBitmap("Text_WuTian",this,{
            "x":439,
            "y":202
         },Global.WHHGdm);
         this.instance19 = ComponentUtil.getBitmap("Text_YiTian",this,{
            "x":79,
            "y":202
         },Global.WHHGdm);
         this.instance20 = ComponentUtil.getBitmap("Text_ErTian",this,{
            "x":199,
            "y":202
         },Global.WHHGdm);
         this.instance21 = new HGJJ();
         this.instance21.x = 42;
         this.instance21.y = 381;
         addChild(this.instance21);
         this.instance22 = new HGJJ();
         this.instance22.x = 242;
         this.instance22.y = 381;
         addChild(this.instance22);
         this.instance23 = new HGJJ();
         this.instance23.x = 442;
         this.instance23.y = 381;
         addChild(this.instance23);
         move = new Rectangle(0,0,630,38);
         if(Boolean(this.BGVec.length))
         {
            return;
         }
         this.BGVec.push(this.instance9,this.instance10,this.instance11,this.instance12,this.instance13);
         this.JJVec.push(this.instance21,this.instance22,this.instance23);
         i = 1;
         while(i < 6)
         {
            this.BGVec[i - 1].index = i;
            if(i <= this.JJVec.length)
            {
               this.JJVec[i - 1].index = i;
            }
            i++;
         }
      }
      
      public function toolFly(type:int) : void
      {
         var index:int = Model_vipBGift.curIndex;
         if(type == 1)
         {
            this.BGVec[index - 1].toolFly();
         }
         else
         {
            this.JJVec[index - 1].toolFly();
         }
      }
      
      public function setData() : void
      {
         if(!visible)
         {
            return;
         }
         var i:int = 0;
         i = 0;
         while(i < 5)
         {
            this.BGVec[i].setdata(Model_vipBGift.data_Gift[i]);
            if(i < this.JJVec.length)
            {
               this.JJVec[i].setdata(Model_vipBGift.data_GiftNum[i]);
            }
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(visible)
         {
            VipBGiftCGMessage.CG_VIPBG_OPENWIN();
         }
      }
   }
}

