package com.yiTian.net.message.gc
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.HuangzhuanZPHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.huangzhuanZP.Vo_HuangzhuanZP;
   import flash.utils.IDataInput;
   
   public class HuangzhuanZPGCMessage
   {
      
      public function HuangzhuanZPGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_HZZP_OPENWIN] = this.GC_HZZP_OPENWIN;
         index[MessageType.GC_HZZP_CJ] = this.GC_HZZP_CJ;
         index[MessageType.CG_HZZP_ICON] = this.CG_HZZP_ICON;
      }
      
      private function GC_HZZP_OPENWIN(patch:IDataInput) : void
      {
         var vo:Vo_HuangzhuanZP = null;
         var shengYu:int = patch.readByte();
         if(shengYu == -1)
         {
            UIManager.centerBroadcast.addMsg("不在活动时间内！");
            return;
         }
         var len:int = patch.readByte();
         var award_data:String = "";
         var i:int = 0;
         while(i < len)
         {
            award_data += patch.readByte();
            if(i < len - 1)
            {
               award_data += ",";
            }
            i++;
         }
         len = patch.readByte();
         var vecPlayVo:Vector.<Vo_HuangzhuanZP> = new Vector.<Vo_HuangzhuanZP>();
         i = 0;
         while(i < len)
         {
            vo = new Vo_HuangzhuanZP();
            vo.name = patch.readUTF();
            vo.job = patch.readByte();
            vo.goodsID = patch.readInt();
            vo.goodsCount = patch.readShort();
            vecPlayVo.push(vo);
            i++;
         }
         HuangzhuanZPHandler.GC_HZZP_OPENWIN(shengYu,award_data,vecPlayVo);
      }
      
      private function GC_HZZP_CJ(patch:IDataInput) : void
      {
         var currentIndex:int = patch.readByte();
         var shengYu:int = patch.readByte();
         HuangzhuanZPHandler.GC_HZZP_CJ(currentIndex,shengYu);
      }
      
      private function CG_HZZP_ICON(patch:IDataInput) : void
      {
         var reslut:int = patch.readByte();
         HuangzhuanZPHandler.CG_HZZP_ICON(reslut);
      }
   }
}

