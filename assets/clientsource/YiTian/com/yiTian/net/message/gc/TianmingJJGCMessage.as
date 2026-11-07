package com.yiTian.net.message.gc
{
   import com.yiTian.data.model.Model_TianmingJJ;
   import com.yiTian.net.handler.TianmingJJHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.tianmingjj.Vo_TianmingJJ;
   import flash.utils.IDataInput;
   
   public class TianmingJJGCMessage
   {
      
      public function TianmingJJGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_TMJJ_OPENWIN] = this.GC_TMJJ_OPENWIN;
         index[MessageType.GC_TMJJ_TZ] = this.GC_TMJJ_TZ;
         index[MessageType.GC_TMJJ_LQ] = this.GC_TMJJ_LQ;
         index[MessageType.GC_TMJJ_GY] = this.GC_TMJJ_GY;
         index[MessageType.GC_TMJJ_JJ] = this.GC_TMJJ_JJ;
         index[MessageType.GC_TMJJ_JJ_START] = this.GC_TMJJ_JJ_START;
      }
      
      private function GC_TMJJ_OPENWIN(patch:IDataInput) : void
      {
         var tmd:int = patch.readInt();
         TianmingJJHandler.GC_TMJJ_OPENWIN(tmd);
      }
      
      private function GC_TMJJ_TZ(patch:IDataInput) : void
      {
         var vo:Vo_TianmingJJ = null;
         var flag:int = patch.readByte();
         Model_TianmingJJ.startPlay = false;
         if(flag == 0)
         {
            return;
         }
         var vec:Vector.<Vo_TianmingJJ> = new Vector.<Vo_TianmingJJ>();
         var i:int = 0;
         while(i < 6)
         {
            vo = new Vo_TianmingJJ();
            vo.value = patch.readByte();
            vo.index = patch.readByte();
            vec.push(vo);
            i++;
         }
         var result:String = patch.readUTF();
         var num:int = patch.readInt();
         TianmingJJHandler.GC_TMJJ_TZ(vec,result,num);
      }
      
      private function GC_TMJJ_GY(patch:IDataInput) : void
      {
         var vo:Vo_TianmingJJ = null;
         var vec:Vector.<Vo_TianmingJJ> = new Vector.<Vo_TianmingJJ>();
         var i:int = 0;
         while(i < 6)
         {
            vo = new Vo_TianmingJJ();
            vo.value = patch.readByte();
            vo.index = patch.readByte();
            vec.push(vo);
            i++;
         }
         var result:String = patch.readUTF();
         var num:int = patch.readInt();
         TianmingJJHandler.GC_TMJJ_GY(vec,result,num);
      }
      
      private function GC_TMJJ_LQ(patch:IDataInput) : void
      {
         TianmingJJHandler.GC_TMJJ_LQ();
      }
      
      private function GC_TMJJ_JJ(patch:IDataInput) : void
      {
         var arr:Array = null;
         var sysId:int = 0;
         var id:int = 0;
         var level:int = 0;
         var exp:int = 0;
         var value:int = 0;
         var eat_lock:int = 0;
         var voVec:Vector.<Array> = new Vector.<Array>();
         var len:int = patch.readInt();
         var i:int = 0;
         while(i < len)
         {
            arr = [];
            sysId = 11;
            id = patch.readInt();
            level = patch.readInt();
            exp = patch.readInt();
            value = patch.readInt();
            eat_lock = patch.readByte();
            arr.push(sysId,id,level,exp,value,eat_lock);
            voVec.push(arr);
            i++;
         }
         var tmd:int = patch.readInt();
         TianmingJJHandler.GC_TMJJ_JJ(voVec,tmd);
      }
      
      private function GC_TMJJ_JJ_START(patch:IDataInput) : void
      {
         var reslut:int = patch.readByte();
         TianmingJJHandler.GC_TMJJ_JJ_START(reslut);
      }
   }
}

