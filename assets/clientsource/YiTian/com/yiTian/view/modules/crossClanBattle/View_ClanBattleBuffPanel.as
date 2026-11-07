package com.yiTian.view.modules.crossClanBattle
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_Buffer;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   
   public class View_ClanBattleBuffPanel extends Panel
   {
      
      private var bg:DisplayObject;
      
      private var itemVec:Vector.<Child_ClanBattleBuffItem> = new Vector.<Child_ClanBattleBuffItem>();
      
      public function View_ClanBattleBuffPanel()
      {
         super();
         init();
      }
      
      public static function get instance() : View_ClanBattleBuffPanel
      {
         return Singleton.getInstance(View_ClanBattleBuffPanel);
      }
      
      override protected function initStaticView() : void
      {
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.bg = Utils.getLoadBitmap("resource/image/kuafubangzhan/Back_SHZC.png",new Bitmap(),null,function():void
         {
            resetPosition();
         });
         this.bg.x = 5;
         this.bg.y = 39;
         addChild(this.bg);
         this.bg.visible = false;
         this.createItem();
         this.updateItem();
      }
      
      private function createItem() : void
      {
         var i:int = 0;
         var item:Child_ClanBattleBuffItem = null;
         i = 0;
         while(i < Enum_CrossClanBattle.MAX_BUFF_NUM)
         {
            item = Child_ClanBattleBuffItem.getItem();
            addChild(item);
            this.itemVec.push(item);
            item.x = 30 + i % Enum_CrossClanBattle.MAX_BUFF_COL * 80;
            item.y = 50 + int(i / Enum_CrossClanBattle.MAX_BUFF_COL) * 50;
            i++;
         }
      }
      
      public function updateItem() : void
      {
         var i:int = 0;
         var buff:Vo_Buffer = null;
         if(!this.itemVec || !this.itemVec.length)
         {
            return;
         }
         i = 0;
         while(i < Enum_CrossClanBattle.MAX_BUFF_NUM)
         {
            buff = new Vo_Buffer(Model_CrossClanBattle.bufferIdArr[i]);
            this.itemVec[i].data = buff;
            this.itemVec[i].enable = true;
            i++;
         }
      }
      
      public function refreshItem(data:Array, serverTime:int) : void
      {
         var i:int = 0;
         var remainTime:int = 0;
         var j:int = 0;
         if(!this.itemVec || !this.itemVec.length)
         {
            return;
         }
         i = 0;
         while(i < 2)
         {
            this.itemVec[i].vo.remainValue = 0;
            i++;
         }
         i = 0;
         while(i < data.length)
         {
            j = 0;
            while(j < this.itemVec.length)
            {
               if(this.itemVec[j].vo.id == data[i][0])
               {
                  remainTime = Data_lib.buffer[data[i][0]][Vo_Buffer.LAST_TIME] - (serverTime - data[i][1]);
                  this.itemVec[j].vo.remainValue = remainTime;
                  this.itemVec[j].start();
                  if(this.itemVec[j].vo.remainValue > 0)
                  {
                     this.itemVec[j].enable = false;
                  }
                  break;
               }
               j++;
            }
            i++;
         }
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - this.width - 30;
         y = (Global.stage.stageHeight - 160) / 2 - 30;
      }
      
      override public function get width() : Number
      {
         if(!this.bg)
         {
            return super.width;
         }
         return this.bg.width;
      }
   }
}

