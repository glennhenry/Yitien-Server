package com.yiTian.view.modules.zaiZhanJiangHu
{
   import com.yiTian.data.Data_lib;
   import flash.display.Sprite;
   
   public class JH_PanelItem extends Sprite
   {
      
      private var _iconItem:JH_IconItem;
      
      private var _getAwardBtnItem:JH_GetAwardBtnItem;
      
      public function JH_PanelItem(len:int)
      {
         super();
         this._iconItem = new JH_IconItem(len);
         this._getAwardBtnItem = new JH_GetAwardBtnItem(len);
         addChild(this._iconItem);
         addChild(this._getAwardBtnItem);
      }
      
      public function dispose() : void
      {
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
      }
      
      public function getAwards() : void
      {
         this._iconItem.getAwards();
         this._getAwardBtnItem.setBtnState("已领取",false);
      }
      
      public function update(days:int, status:int, leftDay:int) : void
      {
         var ss:String = null;
         var _a:Array = null;
         var str:String = Data_lib.zaizhanjianghu[days][0];
         var _arr:Array = str.split(",");
         var daysA:Array = [];
         var i:int = 0;
         while(i < _arr.length)
         {
            ss = _arr[i];
            _a = ss.split("_");
            daysA.push(_a);
            i++;
         }
         this._iconItem.update(daysA);
         this._getAwardBtnItem.update(days,status,leftDay);
      }
   }
}

