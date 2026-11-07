package com.yiTian.net.message.gc
{
   import com.yiTian.data.model.ModelChristmas;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.CollectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class ChristmasGCMessage
   {
      
      public function ChristmasGCMessage(index:Array)
      {
         super();
         index[MessageType.gc_christmas_open_or_close] = this.gc_christmas_open_or_close;
         index[MessageType.gc_christmas_open_view] = this.gc_christmas_open_view;
         index[MessageType.gc_christmas_one_key_snowman] = this.gc_christmas_one_key_snowman;
         index[MessageType.gc_christmas_request_collect] = this.gc_christmas_request_collect;
         index[MessageType.gc_christmas_get_gift] = this.gc_christmas_get_gift;
         index[MessageType.gc_christmas_can_get_goods] = this.gc_christmas_can_get_goods;
         index[MessageType.gc_christmas_collect_sure] = this.gc_christmas_collect_sure;
         index[MessageType.gc_christmas_update_score] = this.gc_christmas_update_score;
      }
      
      private function gc_christmas_update_score(patch:IDataInput) : void
      {
         var value:uint = uint(patch.readInt());
         GameUnitManager.hero.christmasScore = value;
         if(ModelChristmas.isLoadCom)
         {
            UIManager.christmasView.updateScore();
         }
      }
      
      private function gc_christmas_collect_sure(patch:IDataInput) : void
      {
         var npcid:int = patch.readInt();
         var goodsid:uint = uint(patch.readInt());
         var point:Point = GameUnitManager.hero.parent.localToGlobal(new Point(GameUnitManager.hero.x,GameUnitManager.hero.y));
         var vo:Vo_item = new Vo_item();
         vo.id = goodsid;
         vo.Init_lib();
         Tween.gridToBagBezierFuncDef(vo,-1,point.x,point.y);
      }
      
      private function gc_christmas_can_get_goods(patch:IDataInput) : void
      {
         var pos:uint = 0;
         if(!UIManager.christmasView)
         {
            return;
         }
         ModelChristmas.instance.giftList = new Vector.<uint>();
         var len:uint = uint(patch.readShort());
         var i:uint = 0;
         while(i < len)
         {
            pos = uint(patch.readByte());
            ModelChristmas.instance.giftList.push(pos);
            i++;
         }
         UIManager.christmasView.updateGift();
      }
      
      private function gc_christmas_get_gift(patch:IDataInput) : void
      {
         var pos:uint = 0;
         var index:uint = 0;
         var grid:View_Grid = null;
         var point:Point = null;
         var value:uint = uint(patch.readByte());
         if(value == 1)
         {
            pos = uint(patch.readByte());
            index = ModelChristmas.instance.giftList.indexOf(pos);
            if(index >= 0)
            {
               ModelChristmas.instance.giftList.splice(index,1);
            }
            grid = UIManager.christmasView.getGiftGrid(pos);
            point = UIManager.christmasView.localToGlobal(new Point(grid.x,grid.y));
            Tween.gridToBagBezierFuncDef(grid.vo,-1,point.x,point.y);
            UIManager.christmasView.updateGift();
         }
      }
      
      public function gc_christmas_request_collect(patch:IDataInput) : void
      {
         var id:Number = NaN;
         var npc:Npc = null;
         var value:uint = uint(patch.readByte());
         if(value == 1)
         {
            id = patch.readInt();
            npc = GameUnitManager.findUnit(id,UnitType.NPC) as Npc;
            if(Boolean(npc))
            {
               CollectManager.begin(npc as Npc,10000);
            }
         }
         else if(value == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1",10));
         }
         else if(value == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("2",10));
         }
         else if(value == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("3",10));
         }
      }
      
      private function onCollectCom(obj:Object) : void
      {
      }
      
      private function gc_christmas_one_key_snowman(patch:IDataInput) : void
      {
         var value:uint = uint(patch.readByte());
         if(value == 1)
         {
            GameUnitManager.hero.christmasScore = patch.readInt();
            ModelChristmas.instance.goodsList = new Vector.<Vo_item>();
            ModelChristmas.instance.phase = patch.readByte();
            ModelChristmas.instance.growupValue = patch.readInt();
            UIManager.christmasView.update();
            UIManager.christmasView.flyEffect();
         }
         else if(value == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("4",10));
         }
         else if(value == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("5",10));
         }
      }
      
      private function gc_christmas_open_or_close(patch:IDataInput) : void
      {
         var value:uint = uint(patch.readByte());
         if(value != 1)
         {
            if(value == 2)
            {
               if(Boolean(UIManager.christmasView))
               {
                  UIManager.christmasView.visible = false;
               }
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("6",10));
            }
            else if(value == 3)
            {
               if(Boolean(UIManager.christmasView))
               {
                  UIManager.christmasView.visible = false;
               }
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("17",10));
            }
            else if(value == 4)
            {
               if(Boolean(UIManager.christmasView))
               {
                  UIManager.christmasView.visible = false;
               }
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("7",10));
            }
            else if(value == 5)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("8",10));
            }
         }
      }
      
      private function gc_christmas_open_view(patch:IDataInput) : void
      {
         var vo:Vo_item = null;
         GameUnitManager.hero.christmasScore = patch.readInt();
         ModelChristmas.instance.phase = patch.readByte();
         ModelChristmas.instance.growupValue = patch.readInt();
         var len:uint = uint(patch.readShort());
         ModelChristmas.instance.goodsList = new Vector.<Vo_item>();
         var i:uint = 0;
         while(i < len)
         {
            vo = new Vo_item();
            vo.count = patch.readShort();
            vo.id = patch.readInt();
            vo.Init_lib();
            ModelChristmas.instance.goodsList.push(vo);
            i++;
         }
         UIManager.christmasView.update();
      }
   }
}

