package com.yiTian.net.message.gc
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.XiaoZhaoHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.xiaozhao.XiaoZhao_CardVO;
   import com.yiTian.view.modules.xiaozhao.XiaoZhao_PropVO;
   import flash.utils.IDataInput;
   
   public class XiaoZhaoGCMessage
   {
      
      public function XiaoZhaoGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_XIAOZHAO_GET_WARD] = GC_XIAOZHAO_GET_WARD;
         index[MessageType.GC_XIAOZHAO_OPEN_WIN] = GC_XIAOZHAO_OPEN_WIN;
         index[MessageType.GC_XIAOZHAO_REFRESH] = GC_XIAOZHAO_REFRESH;
         index[MessageType.GC_XIAOZHAO_SHOWICON] = GC_XIAOZHAO_SHOWICON;
      }
      
      public static function GC_XIAOZHAO_OPEN_WIN(patch:IDataInput) : void
      {
         var vo:XiaoZhao_PropVO = null;
         var _vo:XiaoZhao_CardVO = null;
         var propLen:int = patch.readByte();
         var pArr:Array = [];
         var i:int = 0;
         while(i < propLen)
         {
            vo = new XiaoZhao_PropVO();
            vo.propId = patch.readInt();
            vo.count = patch.readByte();
            vo.propIndex = patch.readByte();
            pArr.push(vo);
            i++;
         }
         var cardLen:int = patch.readByte();
         var c:Array = [];
         i = 0;
         while(i < cardLen)
         {
            _vo = new XiaoZhao_CardVO();
            _vo.state = patch.readByte();
            _vo.propIndex = patch.readByte();
            _vo.cardIndex = i + 1;
            c.push(_vo);
            i++;
         }
         var state:int = patch.readByte();
         XiaoZhaoHandle.CG_XIAOZHAO_OPEN_WIN(pArr,c,state);
      }
      
      public static function GC_XIAOZHAO_REFRESH(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("洗牌失败！");
         }
         else
         {
            XiaoZhaoHandle.GC_XIAOZHAO_REFRESH();
         }
      }
      
      public static function GC_XIAOZHAO_GET_WARD(patch:IDataInput) : void
      {
         var index:int = 0;
         var result:int = patch.readByte();
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("翻牌失败！");
         }
         else
         {
            index = patch.readByte();
            XiaoZhaoHandle.GC_XIAOZHAO_GET_WARD(index);
         }
      }
      
      public static function GC_XIAOZHAO_SHOWICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
      }
   }
}

