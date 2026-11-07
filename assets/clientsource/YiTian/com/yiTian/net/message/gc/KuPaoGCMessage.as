package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.net.handler.KuPaoHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class KuPaoGCMessage
   {
      
      public function KuPaoGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_KP_REQUESTBASICINFO] = this.GC_KP_REQUESTBASICINFO;
         index[MessageType.GC_KP_FRIENDSRANK] = this.GC_KP_FRIENDSRANK;
         index[MessageType.GC_KP_REQUESTHP] = this.GC_KP_REQUESTHP;
         index[MessageType.GC_KP_USEITEM] = this.GC_KP_USEITEM;
         index[MessageType.GC_KP_RANK] = this.GC_KP_RANK;
         index[MessageType.GC_KP_STARTGAME1] = this.GC_KP_STARTGAME1;
         index[MessageType.GC_KP_SCOREREST] = this.GC_KP_SCOREREST;
         index[MessageType.GC_KP_SHOWOFF] = this.GC_KP_SHOWOFF;
         index[MessageType.GC_KP_GETITEMBUYTIMES] = this.GC_KP_GETITEMBUYTIMES;
      }
      
      public function GC_KP_REQUESTBASICINFO(patch:IDataInput) : void
      {
         var hp:int = patch.readInt();
         var remainTime:int = patch.readInt();
         var itemInfo:String = patch.readUTF();
         KuPaoHandler.GC_KP_REQUESTBASICINFO(hp,remainTime,itemInfo);
      }
      
      public function GC_KP_FRIENDSRANK(patch:IDataInput) : void
      {
         var rank:String = null;
         var roleName:String = null;
         var score:String = null;
         var roleID:Number = NaN;
         var meter:int = 0;
         var length:int = int(patch.readUTF());
         var friendRanks:Array = [];
         var i:int = 0;
         while(i < length)
         {
            rank = patch.readUTF();
            roleName = patch.readUTF();
            score = patch.readUTF();
            roleID = LongUtil.readLong(patch);
            meter = patch.readInt();
            if(roleID != GameUnitManager.hero.id)
            {
               friendRanks.push([int(rank),roleName,int(score),roleID,meter]);
            }
            i++;
         }
         KuPaoHandler.GC_KP_FRIENDSRANK(friendRanks);
      }
      
      public function GC_KP_REQUESTHP(patch:IDataInput) : void
      {
         var hp:int = patch.readInt();
         var remainTime:int = patch.readInt();
         KuPaoHandler.GC_KP_REQUESTHP(hp,remainTime);
      }
      
      public function GC_KP_USEITEM(patch:IDataInput) : void
      {
         var rest:int = patch.readByte();
         var type:int = patch.readByte();
         KuPaoHandler.GC_KP_USEITEM(rest,type);
      }
      
      public function GC_KP_RANK(patch:IDataInput) : void
      {
         var rank:int = 0;
         var roleName:String = null;
         var score:int = 0;
         var length:int = patch.readInt();
         var ranks:Array = [];
         var i:int = 0;
         while(i < length)
         {
            rank = patch.readInt();
            roleName = patch.readUTF();
            score = patch.readInt();
            ranks.push([rank,roleName,score]);
            i++;
         }
         var myRank:int = patch.readInt();
         var myName:String = patch.readUTF();
         var myScore:int = patch.readInt();
         KuPaoHandler.GC_KP_RANK(ranks,myRank,myScore);
      }
      
      public function GC_KP_STARTGAME1(patch:IDataInput) : void
      {
         var itemInfo:String = null;
         var hp:int = 0;
         var vaildateNum:int = 0;
         var rest:int = patch.readByte();
         if(rest == 1)
         {
            itemInfo = patch.readUTF();
            hp = patch.readInt();
            vaildateNum = patch.readInt();
         }
         KuPaoHandler.GC_KP_STARTGAME1(rest,itemInfo,vaildateNum,hp);
      }
      
      public function GC_KP_SCOREREST(patch:IDataInput) : void
      {
         var myScore:int = 0;
         var record:int = 0;
         var rest:int = patch.readByte();
         var hp:int = patch.readInt();
         if(rest == 1)
         {
            myScore = patch.readInt();
            record = patch.readInt();
         }
         KuPaoHandler.GC_KP_SCOREREST(rest,hp,myScore,record);
      }
      
      public function GC_KP_SHOWOFF(patch:IDataInput) : void
      {
         var roleId:Number = LongUtil.readLong(patch);
         var roleName:String = patch.readUTF();
         var score:int = patch.readInt();
         KuPaoHandler.GC_KP_SHOWOFF(roleId,roleName,score);
      }
      
      public function GC_KP_GETITEMBUYTIMES(patch:IDataInput) : void
      {
         var times:Array = [];
         var i:int = 0;
         while(i < 4)
         {
            times.push(patch.readInt());
            i++;
         }
         KuPaoHandler.GC_KP_GETITEMBUYTIMES(times);
      }
   }
}

