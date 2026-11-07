package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.net.handler.FeiXingQiHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import flash.utils.IDataInput;
   
   public class FeiXingQiGCMessage
   {
      
      public function FeiXingQiGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_FXQ] = this.GC_FXQ;
         index[MessageType.GC_FXQINFO] = this.GC_FXQINFO;
         index[MessageType.GC_FXQROLL] = this.GC_FXQROLL;
         index[MessageType.GC_FXQTODIS] = this.GC_FXQTODIS;
         index[MessageType.GC_FXQACCELERATE] = this.GC_FXQACCELERATE;
         index[MessageType.GC_TOUREMAIN] = this.GC_TOUREMAIN;
         index[MessageType.GC_FXQEVENT] = this.GC_FXQEVENT;
         index[MessageType.GC_GUESSING] = this.GC_GUESSING;
         index[MessageType.GC_FXQISJOIN] = this.GC_FXQISJOIN;
         index[MessageType.GC_DELPLAYER] = this.GC_DELPLAYER;
         index[MessageType.GC_FXQPLAYERJOIN] = this.GC_FXQPLAYERJOIN;
         index[MessageType.GC_FXQZBINFO] = this.GC_FXQZBINFO;
         index[MessageType.GC_RESTART] = this.GC_RESTART;
         index[MessageType.GC_ROLLREWARD] = this.GC_ROLLREWARD;
         index[MessageType.GC_FXQGETITEM] = this.GC_FXQGETITEM;
         index[MessageType.GC_TIMEON] = this.GC_TIMEON;
         index[MessageType.GC_FXQACCINFO] = this.GC_FXQACCINFO;
      }
      
      public function GC_FXQ(patch:IDataInput) : void
      {
         var version:int = patch.readInt();
         var type:int = patch.readByte();
         FeiXingQiHandle.GC_FXQ(version,type);
      }
      
      public function GC_FXQINFO(patch:IDataInput) : void
      {
         var tmp:int = 0;
         var id:Number = NaN;
         var name:String = null;
         var sex:int = 0;
         var job:int = 0;
         var index:int = 0;
         var result:int = 0;
         var rId1:Number = NaN;
         var rname1:String = null;
         var rId2:Number = NaN;
         var rname2:String = null;
         var version:int = patch.readInt();
         var isRefreshIm:int = patch.readByte();
         var unitLen:int = patch.readByte();
         var unitArr:Array = [];
         tmp = 0;
         while(tmp < unitLen)
         {
            id = LongUtil.readLong(patch);
            name = patch.readUTF();
            name = Model_heFu.repNameByHero(name);
            sex = patch.readByte();
            job = patch.readByte();
            index = patch.readByte();
            unitArr.push([id,name,sex,job,index]);
            tmp += 1;
         }
         var replayLen:int = patch.readByte();
         var repArr:Array = [];
         tmp = 0;
         while(tmp < replayLen)
         {
            result = patch.readByte();
            rId1 = LongUtil.readLong(patch);
            rname1 = Model_heFu.repNameByHero(patch.readUTF());
            rId2 = LongUtil.readLong(patch);
            rname2 = Model_heFu.repNameByHero(patch.readUTF());
            repArr.push([result,rId1,rname1,rId2,rname2]);
            tmp += 1;
         }
         var rollCDRemain:int = patch.readInt();
         var roomId:int = patch.readInt();
         FeiXingQiHandle.GC_FXQINFO(version,isRefreshIm,unitArr,repArr,rollCDRemain,roomId);
      }
      
      public function GC_FXQROLL(patch:IDataInput) : void
      {
         var version:int = patch.readInt();
         var resultPoint:int = patch.readByte();
         var rollCDRemain:int = patch.readInt();
         FeiXingQiHandle.GC_FXQROLL(version,resultPoint,rollCDRemain);
      }
      
      public function GC_FXQTODIS(patch:IDataInput) : void
      {
         var version:int = patch.readInt();
         var id:Number = LongUtil.readLong(patch);
         var curIndex:int = patch.readByte();
         var numStep:int = patch.readByte();
         var endIndex:int = patch.readByte();
         FeiXingQiHandle.GC_FXQTODIS(version,id,curIndex,numStep,endIndex);
      }
      
      public function GC_FXQACCELERATE(patch:IDataInput) : void
      {
         var version:int = patch.readInt();
         var result:int = patch.readByte();
         FeiXingQiHandle.GC_FXQACCELERATE(version,result);
      }
      
      public function GC_TOUREMAIN(patch:IDataInput) : void
      {
         var remain:int = patch.readInt();
         FeiXingQiHandle.GC_TOUREMAIN(remain);
      }
      
      public function GC_FXQEVENT(patch:IDataInput) : void
      {
         var version:int = patch.readInt();
         var type:int = patch.readByte();
         var bId:int = patch.readInt();
         FeiXingQiHandle.GC_FXQEVENT(version,type,bId,patch);
      }
      
      public function GC_GUESSING(patch:IDataInput) : void
      {
         var version:int = patch.readInt();
         var npcPoint:int = patch.readByte();
         var myPoint:int = patch.readByte();
         var isWin:int = patch.readByte();
         FeiXingQiHandle.GC_GUESSING(version,npcPoint,myPoint,isWin);
      }
      
      public function GC_FXQISJOIN(patch:IDataInput) : void
      {
         var version:int = patch.readInt();
         var remainTimes:int = patch.readByte();
         FeiXingQiHandle.GC_FXQISJOIN(version,remainTimes);
      }
      
      public function GC_FXQPLAYERJOIN(patch:IDataInput) : void
      {
         var version:int = patch.readInt();
         var id:Number = LongUtil.readLong(patch);
         var name:String = patch.readUTF();
         name = Model_heFu.repNameByHero(name);
         var sex:int = patch.readByte();
         var job:int = patch.readByte();
         var index:int = patch.readByte();
         var pInfos:Array = [id,name,sex,job,index];
         FeiXingQiHandle.GC_FXQPLAYERJOIN(version,pInfos);
      }
      
      public function GC_DELPLAYER(patch:IDataInput) : void
      {
         var version:int = patch.readInt();
         var id:Number = LongUtil.readLong(patch);
         var reason:int = patch.readByte();
         FeiXingQiHandle.GC_DELPLAYER(version,id,reason);
      }
      
      public function GC_FXQZBINFO(patch:IDataInput) : void
      {
         var version:int = patch.readInt();
         var result:int = patch.readByte();
         var id1:Number = LongUtil.readLong(patch);
         var name1:String = patch.readUTF();
         name1 = Model_heFu.repNameByHero(name1);
         var id2:Number = LongUtil.readLong(patch);
         var name2:String = patch.readUTF();
         name2 = Model_heFu.repNameByHero(name2);
         FeiXingQiHandle.GC_FXQZBINFO(version,[result,id1,name1,id2,name2]);
      }
      
      public function GC_RESTART(patch:IDataInput) : void
      {
         var version:int = patch.readInt();
         var roleId:Number = LongUtil.readLong(patch);
         var reason:int = patch.readByte();
         FeiXingQiHandle.GC_RESTART(version,roleId,reason);
      }
      
      public function GC_ROLLREWARD(patch:IDataInput) : void
      {
         var version:int = patch.readInt();
         var num:int = patch.readByte();
         var itemId:int = patch.readInt();
         FeiXingQiHandle.GC_ROLLREWARD(version,num,itemId);
      }
      
      public function GC_FXQGETITEM(patch:IDataInput) : void
      {
         var type:int = 0;
         var id:int = 0;
         var num:int = 0;
         var reason:int = patch.readByte();
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            type = patch.readByte();
            id = patch.readInt();
            num = patch.readInt();
            arr.push(type,id,num);
            i += 1;
         }
         FeiXingQiHandle.GC_FXQGETITEM(reason,arr);
      }
      
      public function GC_TIMEON(patch:IDataInput) : void
      {
         var id:* = undefined;
         FeiXingQiHandle.GC_TIMEON();
         for(id in Data_lib.iconHide)
         {
            if(Data_lib.iconHide[id][0] == Enum_mainUIBtn_hide.XianShiHuoDong)
            {
               Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Data_lib.iconHide[id][5],0,0]);
            }
         }
      }
      
      public function GC_FXQACCINFO(patch:IDataInput) : void
      {
         var version:int = patch.readInt();
         var cost:int = patch.readInt();
         FeiXingQiHandle.GC_FXQACCINFO(cost);
      }
   }
}

