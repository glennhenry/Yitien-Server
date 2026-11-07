package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.net.handler.CardHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.Card.Vo_card;
   import flash.utils.IDataInput;
   
   public class CardGCMessage
   {
      
      public function CardGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_CARD_OPEN_PANEL] = this.GC_CARD_OPEN_PANEL;
         index[MessageType.GC_CARD_RETURN] = this.GC_CARD_RETURN;
         index[MessageType.GC_CARD_COUNT_DOWN_TIME] = this.GC_CARD_COUNT_DOWN_TIME;
         index[MessageType.GC_CARD_JiangHuGuangBo] = this.GC_CARD_JiangHuGuangBo;
         index[MessageType.GC_CARD_ZhanBu] = this.GC_CARD_ZhanBu;
         index[MessageType.GC_CARD_UPDATE_CARD_PIECE] = this.GC_CARD_UPDATE_CARD_PIECE;
         index[MessageType.GC_CARD_BUY] = this.GC_CARD_BUY;
         index[MessageType.GC_CARD_BAG] = this.GC_CARD_BAG;
         index[MessageType.GC_CARD_EQUIP_CARD] = this.GC_CARD_EQUIP_CARD;
         index[MessageType.GC_CARD_TunShi] = this.GC_CARD_TunShi;
         index[MessageType.GC_CARD_ShengXing] = this.GC_CARD_ShengXing;
         index[MessageType.GC_CARD_FIRST_ICON] = this.GC_CARD_FIRST_ICON;
         index[MessageType.GC_CARD_FenJie] = this.GC_CARD_FenJie;
         index[MessageType.GC_CARD_TOTAL_ATTIBUTE] = this.GC_CARD_TOTAL_ATTIBUTE;
         index[MessageType.GC_CARD_LOCK] = this.GC_CARD_LOCK;
      }
      
      public function GC_CARD_OPEN_PANEL(patch:IDataInput) : void
      {
         var cardId:int = 0;
         var JingYan:int = patch.readInt();
         var SuiPian:int = patch.readInt();
         var leftTimes:int = patch.readByte();
         var haveUseTimes:int = patch.readByte();
         var haveUseMoneyZhanBuTimes:int = patch.readInt();
         var curXingZuo:int = patch.readByte();
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            cardId = patch.readInt();
            arr.push(cardId);
            i++;
         }
         CardHandle.GC_CARD_OPEN_PANEL(JingYan,SuiPian,leftTimes,haveUseTimes,haveUseMoneyZhanBuTimes,curXingZuo,arr);
      }
      
      public function GC_CARD_RETURN(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         CardHandle.GC_CARD_RETURN(flag);
      }
      
      public function GC_CARD_COUNT_DOWN_TIME(patch:IDataInput) : void
      {
         var time:int = patch.readInt();
         CardHandle.GC_CARD_COUNT_DOWN_TIME(time);
      }
      
      public function GC_CARD_JiangHuGuangBo(patch:IDataInput) : void
      {
         var name:String = patch.readUTF();
         var roleId:Number = LongUtil.readLong(patch);
         var card:int = patch.readInt();
         CardHandle.GC_CARD_JiangHuGuangBo(name,roleId,card);
      }
      
      public function GC_CARD_ZhanBu(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var prize:int = patch.readByte();
         var useType:int = patch.readByte();
         var item:int = patch.readInt();
         CardHandle.GC_CARD_ZhanBu(result,prize,useType,item);
      }
      
      public function GC_CARD_UPDATE_CARD_PIECE(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         var num:int = patch.readInt();
         CardHandle.GC_CARD_UPDATE_CARD_PIECE(flag,num);
      }
      
      public function GC_CARD_BUY(patch:IDataInput) : void
      {
         var id:int = patch.readInt();
         CardHandle.GC_CARD_BUY(id);
      }
      
      public function GC_CARD_BAG(patch:IDataInput) : void
      {
         var vo:Vo_card = null;
         var len:int = patch.readInt();
         var voArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            vo = new Vo_card();
            vo.id = patch.readInt();
            vo.level = patch.readShort();
            vo.exp = patch.readInt();
            vo.star = patch.readByte();
            vo.lock = patch.readByte();
            voArr.push(vo);
            i++;
         }
         CardHandle.GC_CARD_BAG(voArr);
      }
      
      public function GC_CARD_EQUIP_CARD(patch:IDataInput) : void
      {
         var vo:Vo_card = null;
         var openedNum:int = patch.readByte();
         var len:int = patch.readByte();
         var voArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            vo = new Vo_card();
            vo.id = patch.readInt();
            vo.level = patch.readShort();
            vo.exp = patch.readInt();
            vo.star = patch.readByte();
            vo.lock = patch.readByte();
            voArr.push(vo);
            i++;
         }
         CardHandle.GC_CARD_EQUIP_CARD(openedNum,voArr);
      }
      
      public function GC_CARD_TunShi(patch:IDataInput) : void
      {
         var cardID:int = patch.readInt();
         var level:int = patch.readShort();
         var exp:int = patch.readInt();
         var BaoJiCount:int = patch.readShort();
         var totalExp:int = patch.readInt();
         CardHandle.GC_CARD_TunShi(cardID,level,exp,BaoJiCount,totalExp);
      }
      
      public function GC_CARD_ShengXing(patch:IDataInput) : void
      {
         var cardID:int = patch.readInt();
         var star:int = patch.readShort();
         CardHandle.GC_CARD_ShengXing(cardID,star);
      }
      
      public function GC_CARD_FIRST_ICON(patch:IDataInput) : void
      {
         CardHandle.GC_CARD_FIRST_ICON(patch.readByte());
      }
      
      public function GC_CARD_FenJie(patch:IDataInput) : void
      {
         var exp:int = patch.readInt();
         var pieces:int = patch.readInt();
         CardHandle.GC_CARD_FenJie(exp,pieces);
      }
      
      public function GC_CARD_TOTAL_ATTIBUTE(patch:IDataInput) : void
      {
         var type:int = 0;
         var percent:Number = NaN;
         var num:int = 0;
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            type = patch.readShort();
            percent = patch.readInt() / 10;
            num = patch.readInt();
            arr.push([type,percent,num]);
            i++;
         }
         CardHandle.GC_CARD_TOTAL_ATTIBUTE(arr);
      }
      
      public function GC_CARD_LOCK(patch:IDataInput) : void
      {
         var bagID:int = patch.readShort();
         var lock:int = patch.readByte();
         var type:int = patch.readByte();
         CardHandle.GC_CARD_LOCK(bagID,lock,type);
      }
   }
}

