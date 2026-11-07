package com.yiTian.net.message.gc
{
   import com.yiTian.data.model.Model_WeiLie;
   import com.yiTian.data.vo.Vo_WeiLie;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.WeiLieHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class WeiLieGCMessage
   {
      
      public function WeiLieGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_WEILIE_OPEN] = this.GC_WEILIE_OPEN;
         index[MessageType.GC_WEILIE_SHOT] = this.GC_WEILIE_SHOT;
         index[MessageType.GC_PPTREE_OPEN] = this.GC_PPTREE_OPEN;
         index[MessageType.GC_PPTREE_SHOT] = this.GC_PPTREE_SHOT;
      }
      
      private function GC_WEILIE_OPEN(patch:IDataInput) : void
      {
         var time:int = 0;
         var currentXF:int = 0;
         var index:String = null;
         var len:int = 0;
         var arr:Vector.<Vo_WeiLie> = null;
         var vo:Vo_WeiLie = null;
         var i:int = 0;
         var result:int = patch.readByte();
         if(result == 1)
         {
            time = patch.readByte();
            currentXF = patch.readInt();
            index = patch.readUTF();
            len = patch.readByte();
            arr = new Vector.<Vo_WeiLie>();
            i = 0;
            while(i < len)
            {
               vo = new Vo_WeiLie();
               vo.job = patch.readByte();
               vo.roleName = patch.readUTF();
               vo.index = patch.readByte();
               arr.push(vo);
               i++;
            }
            WeiLieHandler.GC_WEILIE_OPEN(time,currentXF,arr,index);
         }
         else
         {
            UIManager.centerBroadcast.addGirdMsg("不在活动时间内");
         }
      }
      
      private function GC_WEILIE_SHOT(patch:IDataInput) : void
      {
         var sb:int = 0;
         var index:int = 0;
         var time:int = 0;
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               sb = patch.readInt();
               index = patch.readByte();
               time = patch.readByte();
               WeiLieHandler.GC_WEILIE_SHOT(sb,index,time);
               break;
            case 2:
               Model_WeiLie.ins(Model_WeiLie.QZYG).isRunning = false;
               UIManager.centerBroadcast.addGirdMsg("射猎次数不足");
               break;
            case 3:
               Model_WeiLie.ins(Model_WeiLie.QZYG).isRunning = false;
               UIManager.centerBroadcast.addGirdMsg("等级不足");
         }
      }
      
      private function GC_PPTREE_OPEN(patch:IDataInput) : void
      {
         var time:int = 0;
         var currentXF:int = 0;
         var index:String = null;
         var len:int = 0;
         var arr:Vector.<Vo_WeiLie> = null;
         var vo:Vo_WeiLie = null;
         var i:int = 0;
         var result:int = patch.readByte();
         if(result == 1)
         {
            time = patch.readByte();
            currentXF = patch.readInt();
            index = patch.readUTF();
            len = patch.readByte();
            arr = new Vector.<Vo_WeiLie>();
            i = 0;
            while(i < len)
            {
               vo = new Vo_WeiLie();
               vo.job = patch.readByte();
               vo.roleName = patch.readUTF();
               vo.index = patch.readByte();
               arr.push(vo);
               i++;
            }
            WeiLieHandler.GC_PPTREE_OPEN(time,currentXF,arr,index);
         }
         else
         {
            UIManager.centerBroadcast.addGirdMsg("不在活动时间内");
         }
      }
      
      private function GC_PPTREE_SHOT(patch:IDataInput) : void
      {
         var sb:int = 0;
         var index:int = 0;
         var time:int = 0;
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               sb = patch.readInt();
               index = patch.readByte();
               time = patch.readByte();
               WeiLieHandler.GC_PPTREE_SHOT(sb,index,time);
               break;
            case 2:
               Model_WeiLie.ins(Model_WeiLie.QZGS).isRunning = false;
               UIManager.centerBroadcast.addGirdMsg("射猎次数不足");
               break;
            case 3:
               Model_WeiLie.ins(Model_WeiLie.QZGS).isRunning = false;
               UIManager.centerBroadcast.addGirdMsg("等级不足");
         }
      }
   }
}

