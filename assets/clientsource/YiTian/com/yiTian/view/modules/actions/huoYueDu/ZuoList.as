package com.yiTian.view.modules.actions.huoYueDu
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.view.modules.chatM.TestScroll;
   import flash.display.Sprite;
   
   public class ZuoList extends Sprite
   {
      
      private var canvasM:TestScroll;
      
      private var ZLItemVec:Vector.<ZuolistItem> = new Vector.<ZuolistItem>(20);
      
      private var conSp:Sprite;
      
      private var canvasCon:Canvas;
      
      private var hasArr:Array = [];
      
      public function ZuoList()
      {
         var ZLItem:ZuolistItem = null;
         super();
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":0,
            "y":0,
            "width":287 + 50,
            "height":320
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TitleBule",[5,5,2,2],this,{
            "x":3,
            "y":4,
            "width":281 + 50,
            "height":28
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Text_Zuo",this,{
            "x":12,
            "y":6
         },Global.HuoYue_Imgsdm);
         this.canvasCon = new Canvas(277 + 50,280);
         this.canvasCon.x = 5;
         this.canvasCon.y = 34;
         this.canvasCon.scrollAutoType = ScrollAutoType.TO_TOP;
         addChild(this.canvasCon);
         var i:int = 0;
         while(i < this.ZLItemVec.length)
         {
            ZLItem = new ZuolistItem();
            this.ZLItemVec[i] = ZLItem;
            i++;
         }
      }
      
      private function reset() : void
      {
         this.hasArr = [];
         while(Boolean(this.canvasCon.numChildren))
         {
            this.canvasCon.removeChildAt(0);
         }
      }
      
      public function update(dataArrL:Array) : void
      {
         var leftTimes:int = 0;
         var isBegin:int = 0;
         var maxTimes:int = 0;
         var actionsName:String = null;
         var huoYueDu:int = 0;
         var showLvl:int = 0;
         var pinLvl:int = 0;
         var zlI:ZuolistItem = null;
         this.reset();
         var len:int = int(dataArrL.length);
         var lvl:int = GameUnitManager.hero.level;
         var i:int = 0;
         while(i < len)
         {
            leftTimes = int(dataArrL[i]);
            isBegin = int(dataArrL[i]);
            if(leftTimes < 0)
            {
               leftTimes = 0;
            }
            maxTimes = int(Data_lib.huoYueDu[i + 1][2]);
            actionsName = Data_lib.huoYueDu[i + 1][1];
            huoYueDu = int(Data_lib.huoYueDu[i + 1][3]);
            showLvl = int(Data_lib.huoYueDu[i + 1][5]);
            pinLvl = int(Data_lib.huoYueDu[i + 1][6]);
            zlI = this.ZLItemVec[i];
            zlI.update(actionsName,leftTimes,maxTimes,leftTimes == 0,huoYueDu,i + 1,isBegin);
            if(lvl >= showLvl && lvl <= pinLvl)
            {
               this.canvasCon.addChild(zlI);
               this.hasArr.push(zlI);
            }
            i++;
         }
         this.resize();
      }
      
      private function resize() : void
      {
         var zlI:ZuolistItem = null;
         var i:int = 0;
         while(i < this.hasArr.length)
         {
            zlI = this.hasArr[i];
            ComponentUtil.setPropertie(zlI,{
               "x":2,
               "y":40 * i
            });
            i++;
         }
         this.canvasCon.reset();
         this.canvasCon.align();
      }
      
      public function joinHd(__type:int) : void
      {
         this.ZLItemVec[__type - 1].joinHd(__type);
      }
   }
}

