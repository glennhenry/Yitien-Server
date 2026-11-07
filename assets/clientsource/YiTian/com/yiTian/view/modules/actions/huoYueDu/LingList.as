package com.yiTian.view.modules.actions.huoYueDu
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.Sprite;
   
   public class LingList extends Sprite
   {
      
      private var LListIVec:Vector.<LingListItem> = new Vector.<LingListItem>(5);
      
      public function LingList()
      {
         var LItem:LingListItem = null;
         super();
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":0,
            "y":0,
            "width":311,
            "height":320
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TitleBule",[5,5,2,2],this,{
            "x":3,
            "y":4,
            "width":305,
            "height":28
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Text_Ling",this,{
            "x":24,
            "y":6
         },Global.HuoYue_Imgsdm);
         var i:int = 0;
         while(i < this.LListIVec.length)
         {
            LItem = new LingListItem();
            ComponentUtil.setPropertie(LItem,{
               "x":6,
               "y":32.3 + 57.5 * i
            });
            addChild(LItem);
            this.LListIVec[i] = LItem;
            i++;
         }
      }
      
      public function update(dataArrM:Array) : void
      {
         var status:int = 0;
         var LIM:LingListItem = null;
         var len:int = int(dataArrM.length);
         var i:int = 0;
         while(i < len)
         {
            status = int(dataArrM[i]);
            LIM = this.LListIVec[i];
            LIM.update(i,status);
            i++;
         }
      }
      
      public function getAward(_type:int) : void
      {
         this.LListIVec[_type - 1].getAward();
      }
   }
}

