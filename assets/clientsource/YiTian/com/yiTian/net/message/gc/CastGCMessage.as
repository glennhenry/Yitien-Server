package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_cast;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.CastHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.cast.baishiZengyi.View_baoshiZY;
   import com.yiTian.view.modules.cast.baishiZengyi.Vo_baoshiZY;
   import com.yiTian.view.modules.cast.newUnit.View_equip_jinJi;
   import com.yiTian.view.modules.newRolePan.View_rolePan;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.utils.IDataInput;
   import flashx.textLayout.formats.TextAlign;
   
   public class CastGCMessage
   {
      
      private static var arr:Array = ["失败","晋级成功","不是紫装或者橙装装备","晋级的装备必须是强化10星未晋级的装备","所需材料不足","所需银两不足","50级以上玩家才能晋级"];
      
      private var len:int;
      
      private var i:int;
      
      private var tipsArr:Array = ["点化成功","要紫装以上的装备才能点化哦亲","装备还没满50级","材料不够","银两不够","该装备不可点化"];
      
      public function CastGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ADD_HOLE] = this.GC_ADD_HOLE;
         index[MessageType.GC_INLAY] = this.GC_INLAY;
         index[MessageType.GC_UNLOAD] = this.GC_UNLOAD;
         index[MessageType.GC_INTENSIFY] = this.GC_INTENSIFY;
         index[MessageType.GC_POLISH] = this.GC_POLISH;
         index[MessageType.GC_GEM_COMPOSE] = this.GC_GEM_COMPOSE;
         index[MessageType.GC_DECOMPOSE] = this.GC_DECOMPOSE;
         index[MessageType.GC_RIDE_COMPOSE] = this.GC_RIDE_COMPOSE;
         index[MessageType.GC_POLISH_OK] = this.GC_POLISH_OK;
         index[MessageType.GC_INSTEN_CHANGED] = this.GC_INSTEN_CHANGED;
         index[MessageType.GC_RIDE_UP] = this.GC_RIDE_UP;
         index[MessageType.GC_CZ_REFINE] = this.GC_CZ_REFINE;
         index[MessageType.GC_CZ_XILIAN] = this.GC_CZ_XILIAN;
         index[MessageType.GC_GET_STONE_DATA] = this.GC_GET_STONE_DATA;
         index[MessageType.GC_CLICK_UP_LEVEL] = GC_CLICK_UP_LEVEL;
         index[MessageType.GC_FIRST_OPEN_PAN_JINJI] = this.GC_FIRST_OPEN_PAN_JINJI;
         index[MessageType.GC_CLICK_UP_LEVEL_DIANHUA] = this.GC_CLICK_UP_LEVEL_DIANHUA;
         index[MessageType.GC_FIRST_OPEN_PAN_JINJI_DIANHUA] = this.GC_FIRST_OPEN_PAN_JINJI_DIANHUA;
         index[MessageType.GC_GETSILVER_NOTICE] = this.GC_GETSILVER_NOTICE;
      }
      
      public static function GC_CLICK_UP_LEVEL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         UIManager.castPanel.jinJiHandle(result);
         UIManager.centerBroadcast.addMsg(arr[result]);
         if(result == 1 && View_equip_jinJi.nowChooseUpLvl == 21)
         {
            View_Alert.show(HtmlUtil.font("帝级装备可以继续强化，来提升附加属性百分比。","#f9ff00"),View_Alert.OK,function():void
            {
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(0);
               }
               else
               {
                  UIManager.castPanel.openView(0);
               }
            },null,null,null,310,null,null,TextAlign.CENTER);
            View_Alert.setOkBtnLabel(HtmlUtil.font("强化装备","#f9ff00"));
         }
      }
      
      public function GC_FIRST_OPEN_PAN_JINJI(patch:IDataInput) : void
      {
         Model_cast.isFirOpen_jinJiPan = true;
         UIManager.castPanel.lvUp();
      }
      
      public function GC_ADD_HOLE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CastHandler.GC_ADD_HOLE(result);
      }
      
      public function GC_INLAY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CastHandler.GC_INLAY(result);
      }
      
      public function GC_UNLOAD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CastHandler.GC_UNLOAD(result);
      }
      
      public function GC_DECOMPOSE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         this.len = patch.readByte();
         var vec:Vector.<int> = new Vector.<int>();
         this.i = 0;
         while(this.i < this.len)
         {
            vec.push(patch.readShort());
            ++this.i;
         }
         CastHandler.GC_DECOMPOSE(result,vec);
      }
      
      public function GC_INTENSIFY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CastHandler.GC_INTENSIFY(result);
      }
      
      public function GC_POLISH(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         this.len = patch.readByte();
         var vec:Vector.<int> = new Vector.<int>();
         this.i = 0;
         while(this.i < this.len)
         {
            vec.push(patch.readByte());
            vec.push(patch.readInt());
            vec.push(patch.readByte());
            vec.push(0);
            ++this.i;
         }
         CastHandler.GC_POLISH(result,vec);
      }
      
      public function GC_GEM_COMPOSE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CastHandler.GC_GEM_COMPOSE(result);
      }
      
      public function GC_RIDE_COMPOSE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CastHandler.GC_RIDE_COMPOSE(result);
      }
      
      public function GC_RIDE_UP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CastHandler.GC_RIDE_UP(result);
      }
      
      public function GC_POLISH_OK(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CastHandler.GC_POLISH_OK(result);
      }
      
      public function GC_INSTEN_CHANGED(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CastHandler.GC_INSTEN_CHANGED(result);
      }
      
      public function GC_CLICK_UP_LEVEL_DIANHUA(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         UIManager.centerBroadcast.addMsg(this.tipsArr[result - 1]);
         UIManager.castPanel.dianHuaHandle(result);
      }
      
      public function GC_FIRST_OPEN_PAN_JINJI_DIANHUA(patch:IDataInput) : void
      {
         Model_cast.isFirOpen_dianHua = true;
      }
      
      public function GC_CZ_REFINE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CastHandler.GC_CZ_REFINE(result);
      }
      
      public function GC_CZ_XILIAN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CastHandler.GC_CZ_XILIAN(result);
      }
      
      public function GC_GET_STONE_DATA(patch:IDataInput) : void
      {
         var pan:View_baoshiZY = null;
         var _pan:View_baoshiZY = null;
         var sLvl:int = patch.readByte();
         if(YelloDiaGCMessage.isTrue)
         {
            if(sLvl > Vo_baoshiZY.StoneLvl)
            {
               if(sLvl == View_baoshiZY.MAXLEVEL)
               {
                  UIManager.centerBroadcast.addMsg("宝石增益已到最高级");
               }
               else
               {
                  UIManager.centerBroadcast.addMsg("宝石增益升至到" + sLvl + "级");
                  _pan = Singleton.getInstance(View_baoshiZY) as View_baoshiZY;
                  _pan.wordsEff(sLvl);
               }
            }
            else
            {
               UIManager.centerBroadcast.addMsg("恭喜宝石镶刻成功");
            }
            YelloDiaGCMessage.isTrue = false;
         }
         Vo_baoshiZY.StoneLvl = sLvl;
         Vo_baoshiZY.curLvl = patch.readInt();
         Vo_baoshiZY.maxLvl = patch.readInt();
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            pan.updataStoneLvl(Vo_baoshiZY.StoneLvl);
         });
         pan = Singleton.getInstance(View_baoshiZY) as View_baoshiZY;
         if(pan.visible)
         {
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
            {
               pan.updata(Vo_baoshiZY.StoneLvl);
            });
         }
      }
      
      public function GC_GETSILVER_NOTICE(patch:IDataInput) : void
      {
         var silver:Number = LongUtil.readLong(patch);
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("30130",3) + " x" + silver.toString());
      }
   }
}

