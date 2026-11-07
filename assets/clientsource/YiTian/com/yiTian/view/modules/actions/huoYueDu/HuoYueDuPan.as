package com.yiTian.view.modules.actions.huoYueDu
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.Panel123;
   import flash.geom.Rectangle;
   
   public class HuoYueDuPan extends Panel123
   {
      
      private var LList:LingList;
      
      private var ZList:ZuoList;
      
      private var PItem:ProgressItem;
      
      public function HuoYueDuPan()
      {
         super();
         regResource("lang/ch/HuoYue_Imgs.swf","HuoYue_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":671 + 50,
            "height":425
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":623 + 50,
            "height":375
         },Global.Img_Cdm);
         move = new Rectangle(0,0,670,38);
         this.LList = new LingList();
         this.LList.x = 326 + 50;
         this.LList.y = 50;
         addChild(this.LList);
         this.ZList = new ZuoList();
         this.ZList.x = 34;
         this.ZList.y = 50;
         addChild(this.ZList);
         this.PItem = new ProgressItem();
         this.PItem.x = 34;
         this.PItem.y = 370;
         addChild(this.PItem);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":637 + 50,
            "y":6,
            "textColor":16184781,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_HuoYue",this,{
            "x":256 + 30,
            "y":5
         },Global.HuoYue_Imgsdm);
      }
      
      public function update(dataArrL:Array, curHuoYueDu:int, dataArrM:Array) : void
      {
         if(!visible)
         {
            this.visible = true;
         }
         this.LList.update(dataArrM);
         this.PItem.updateCurHuoYueDu(curHuoYueDu);
         this.ZList.update(dataArrL);
      }
      
      public function getAward(_type:int) : void
      {
         this.LList.getAward(_type);
      }
      
      public function applyJoin(__type:int) : void
      {
         this.ZList.joinHd(__type);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 718) / 2;
         y = (Global.stage.stageHeight - 424) / 2;
      }
   }
}

