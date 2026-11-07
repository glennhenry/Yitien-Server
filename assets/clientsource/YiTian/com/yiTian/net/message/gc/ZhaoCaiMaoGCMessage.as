package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_ZhaoCaiMao;
   import com.yiTian.data.vo.Vo_ZhaoCaiMao;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.ZhaoCaiMaoHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class ZhaoCaiMaoGCMessage
   {
      
      public function ZhaoCaiMaoGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ZHAOCAIMAO_ZHAOMU] = this.GC_ZHAOCAIMAO_ZHAOMU;
         index[MessageType.GC_ZHAOCAIMAO_LY] = this.GC_ZHAOCAIMAO_LY;
         index[MessageType.GC_ZHAOCAIMAO_WEIYANG] = this.GC_ZHAOCAIMAO_WEIYANG;
         index[MessageType.GC_ZHAOCAIMAO_OPENWIN] = this.GC_ZHAOCAIMAO_OPENWIN;
         index[MessageType.GC_ZHAOCAIMAO_GB] = this.GC_ZHAOCAIMAO_GB;
         index[MessageType.GC_ZHAOCAIMAO_SEARCH] = this.GC_ZHAOCAIMAO_SEARCH;
         index[MessageType.GC_ZHAOCAIMAO_PAGE] = this.GC_ZHAOCAIMAO_PAGE;
      }
      
      private function GC_ZHAOCAIMAO_OPENWIN(patch:IDataInput) : void
      {
         var vo:Vo_ZhaoCaiMao = null;
         var reslut:int = patch.readByte();
         if(reslut != 1)
         {
            UIManager.centerBroadcast.addMsg("不在活动时间内！");
            return;
         }
         var time:int = patch.readInt();
         var mIndex:String = patch.readUTF();
         var page:int = patch.readInt();
         var page1:int = patch.readInt();
         var len:int = patch.readByte();
         var voVec:Vector.<Vo_ZhaoCaiMao> = new Vector.<Vo_ZhaoCaiMao>();
         var i:int = 0;
         while(i < len)
         {
            vo = new Vo_ZhaoCaiMao();
            vo.roleID = LongUtil.readLong(patch);
            vo.currentWY = patch.readInt();
            vo.maxWY = patch.readInt();
            vo.index = patch.readUTF();
            vo.roleName = patch.readUTF();
            voVec.push(vo);
            i++;
         }
         ZhaoCaiMaoHandler.GC_ZHAOCAIMAO_OPENWIN(time,mIndex,page,page1,voVec);
      }
      
      private function GC_ZHAOCAIMAO_WEIYANG(patch:IDataInput) : void
      {
         var reslut:int = patch.readByte();
         var roleID:Number = LongUtil.readLong(patch);
         ZhaoCaiMaoHandler.GC_ZHAOCAIMAO_WEIYANG(reslut,roleID);
      }
      
      private function GC_ZHAOCAIMAO_LY(patch:IDataInput) : void
      {
         var reslut:int = patch.readByte();
         ZhaoCaiMaoHandler.GC_ZHAOCAIMAO_LY(reslut);
      }
      
      private function GC_ZHAOCAIMAO_SEARCH(patch:IDataInput) : void
      {
         var reslut:int = patch.readByte();
         ZhaoCaiMaoHandler.GC_ZHAOCAIMAO_SEARCH(reslut);
      }
      
      private function GC_ZHAOCAIMAO_ZHAOMU(patch:IDataInput) : void
      {
         var reslut:int = patch.readByte();
         var time:int = patch.readInt();
         ZhaoCaiMaoHandler.GC_ZHAOCAIMAO_ZHAOMU(reslut,time);
      }
      
      private function GC_ZHAOCAIMAO_PAGE(patch:IDataInput) : void
      {
         var vo:Vo_ZhaoCaiMao = null;
         var reslut:int = patch.readByte();
         if(reslut != 1)
         {
            UIManager.centerBroadcast.addMsg("活动尚未开始，敬请期待！");
            return;
         }
         var time:int = patch.readInt();
         var mIndex:String = patch.readUTF();
         var page:int = patch.readInt();
         var page1:int = patch.readInt();
         var len:int = patch.readByte();
         var voVec:Vector.<Vo_ZhaoCaiMao> = new Vector.<Vo_ZhaoCaiMao>();
         var i:int = 0;
         while(i < len)
         {
            vo = new Vo_ZhaoCaiMao();
            vo.roleID = LongUtil.readLong(patch);
            vo.currentWY = patch.readInt();
            vo.maxWY = patch.readInt();
            vo.index = patch.readUTF();
            vo.roleName = patch.readUTF();
            voVec.push(vo);
            i++;
         }
         ZhaoCaiMaoHandler.GC_ZHAOCAIMAO_PAGE(time,mIndex,page,page1,voVec);
      }
      
      private function GC_ZHAOCAIMAO_GB(patch:IDataInput) : void
      {
         var roleID:Number = LongUtil.readLong(patch);
         var roleName:String = patch.readUTF();
         ZhaoCaiMaoHandler.GC_ZHAOCAIMAO_GB(roleName,roleID);
      }
      
      private function GC_CHUNJIEHUODONG_OPENWIN(patch:IDataInput) : void
      {
         var key:int = 0;
         var value:int = 0;
         var len:int = patch.readByte();
         var i:int = 0;
         while(i < len)
         {
            key = patch.readByte();
            value = patch.readByte();
            Model_ZhaoCaiMao.instance.activityStatus[key] = value;
            i++;
         }
      }
   }
}

