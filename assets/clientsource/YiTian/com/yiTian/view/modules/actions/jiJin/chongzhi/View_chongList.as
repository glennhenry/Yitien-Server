package com.yiTian.view.modules.actions.jiJin.chongzhi
{
   import com.utils.ComponentUtil;
   import flash.display.Sprite;
   
   public class View_chongList extends Sprite
   {
      
      private var chontItemVec:Vector.<Child_chongItem> = new Vector.<Child_chongItem>(4);
      
      public function View_chongList()
      {
         var item:Child_chongItem = null;
         super();
         var i:int = 0;
         while(i < this.chontItemVec.length)
         {
            item = new Child_chongItem();
            item.update(i + 1);
            this.chontItemVec[i] = item;
            addChild(item);
            ComponentUtil.setPropertie(item,{
               "x":15 + 138 * i,
               "y":13
            });
            i++;
         }
      }
      
      public function buyItem(_index:int) : void
      {
         this.chontItemVec[_index].buyHandle();
      }
   }
}

