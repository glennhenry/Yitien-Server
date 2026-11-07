package com.yiTian.view.modules.activityGuide
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_store;
   import flash.display.Sprite;
   
   public class Child_shopMenu extends Sprite
   {
      
      private static var isFirstOpen:Boolean = true;
      
      private var twoTitleIcon:ScaleBitmap;
      
      private var txt:MyTextField;
      
      private var itemArr:Array = [];
      
      private var itemMoreArr:Array = [];
      
      public function Child_shopMenu()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.twoTitleIcon = ComponentUtil.getScaleBitmap("Back_TitleBule",[5,5,2,2],this,{
            "x":5,
            "y":5,
            "width":440,
            "height":30
         },Global.Img_Cdm);
         this.txt = ComponentUtil.getTextField("活动名称",this,{
            "x":189,
            "y":9,
            "color":16764206,
            "size":12,
            "leading":0
         });
      }
      
      private function createItem() : void
      {
         var item:Child_BuyItem = null;
         var i:int = 0;
         while(i < 2)
         {
            item = new Child_BuyItem();
            item.x = 15 + i * 218;
            item.y = 42;
            addChild(item);
            this.itemArr.push(item);
            i++;
         }
      }
      
      public function update(name:String, data:Array, type:int) : void
      {
         this.txt.htmlText = name;
         this.clear();
         if(type == Enum_ActivityGuide.ACTIVITY_SHOP)
         {
            this.setShopItem(data);
         }
         else if(type == Enum_ActivityGuide.ACTIVITY_MORE_SHOP)
         {
            this.setMoreShopItem(data);
         }
      }
      
      private function clear() : void
      {
         var item:Sprite = null;
         var i:int = 0;
         while(i < this.itemArr.length)
         {
            item = this.itemArr[i];
            if(Boolean(item.parent))
            {
               item.parent.removeChild(item);
            }
            i++;
         }
         i = 0;
         while(i < this.itemMoreArr.length)
         {
            item = this.itemMoreArr[i];
            if(Boolean(item.parent))
            {
               item.parent.removeChild(item);
            }
            i++;
         }
      }
      
      private function setShopItem(data:Array) : void
      {
         var item:Child_BuyItem = null;
         var voStore:Vo_store = null;
         var i:int = 0;
         i = 0;
         while(i < data.length)
         {
            voStore = data[i];
            if(!this.itemArr[i])
            {
               item = new Child_BuyItem();
               if(data.length == 1)
               {
                  item.x = 110 + i * 218;
               }
               else
               {
                  item.x = 15 + i * 218;
               }
               item.y = 42;
               item.update(voStore,0);
               addChild(item);
               this.itemArr[i] = item;
            }
            else
            {
               this.itemArr[i].update(voStore,0);
               addChild(this.itemArr[i]);
            }
            i++;
         }
      }
      
      private function setMoreShopItem(data:Array) : void
      {
         var item:Child_MoreBuyItem = null;
         var voStore:Vo_store = null;
         var i:int = 0;
         i = 0;
         while(i < data.length)
         {
            voStore = data[i];
            if(!this.itemMoreArr[i])
            {
               item = new Child_MoreBuyItem();
               if(data.length == 1)
               {
                  item.x = 99 + i * 111;
               }
               else
               {
                  item.x = 4 + i * 111;
               }
               item.y = 31;
               item.update(voStore,0);
               addChild(item);
               this.itemMoreArr[i] = item;
            }
            else
            {
               this.itemMoreArr[i].update(voStore,0);
               addChild(this.itemMoreArr[i]);
            }
            i++;
         }
      }
   }
}

