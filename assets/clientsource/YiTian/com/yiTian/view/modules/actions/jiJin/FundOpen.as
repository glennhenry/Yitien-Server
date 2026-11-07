package com.yiTian.view.modules.actions.jiJin
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.Panel123;
   import flash.geom.Rectangle;
   
   public class FundOpen extends Panel123
   {
      
      private var bItem:BuyItem;
      
      private var buttomI:ButtomText;
      
      private var sItem:StoreItem;
      
      private var fanliI:Fanli;
      
      public function FundOpen()
      {
         super();
         regResource("lang/ch/JiJin_Imgs.swf","JiJin_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":578,
            "height":396
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":530,
            "height":347
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":34,
            "y":115,
            "width":510,
            "height":262
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":34,
            "y":50,
            "width":510,
            "height":60
         },Global.Img_Cdm);
         move = new Rectangle(0,0,575,38);
         this.bItem = new BuyItem();
         this.bItem.x = 43;
         this.bItem.y = 115;
         addChild(this.bItem);
         this.buttomI = new ButtomText();
         this.buttomI.x = 34;
         this.buttomI.y = 351;
         addChild(this.buttomI);
         this.sItem = new StoreItem();
         this.sItem.x = 34;
         this.sItem.y = 47;
         addChild(this.sItem);
         this.fanliI = new Fanli();
         this.fanliI.x = 44;
         this.fanliI.y = 187;
         addChild(this.fanliI);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":544,
            "y":6,
            "textColor":16184781,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_JiJin",this,{
            "x":209,
            "y":5
         },Global.JiJin_Imgsdm);
      }
      
      public function update(type:int, lvl:int, days:int, dataArr:Array) : void
      {
         if(FundMter.isOpenPan)
         {
            if(!visible)
            {
               this.visible = true;
            }
            FundMter.isOpenPan = false;
         }
         this.fanliI.update(type,lvl,dataArr,days);
         this.buttomI.update(type,lvl);
         this.bItem.update(type,lvl);
         this.sItem.update(type);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            pop();
         }
      }
      
      public function getAward(_index:int) : void
      {
         this.fanliI.getAward(_index);
      }
   }
}

