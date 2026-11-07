package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.WanAnSiHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.wanansi.WanAnSiVO;
   import flash.utils.IDataInput;
   
   public class WanAnSiGCMessage
   {
      
      public function WanAnSiGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_WANANSI_ICON] = GC_WANANSI_ICON;
         index[MessageType.GC_WANANSI_TIMES] = GC_WANANSI_TIMES;
         index[MessageType.GC_WANANSI_ENTER] = GC_WANANSI_ENTER;
         index[MessageType.GC_WANANSI_SKIP_BATTLE] = GC_WANANSI_SKIP_BATTLE;
         index[MessageType.GC_WANANSI_FUHUO] = GC_WANANSI_FUHUO;
         index[MessageType.GC_WANANSI_FUHUOCISHU] = GC_WANANSI_FUHUOCISHU;
      }
      
      public static function GC_WANANSI_ICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WanAnSiHandler.GC_WANANSI_ICON(result);
      }
      
      public static function GC_WANANSI_FUHUOCISHU(patch:IDataInput) : void
      {
         var tiems:int = patch.readByte();
         WanAnSiHandler.GC_WANANSI_FUHUOCISHU(tiems);
      }
      
      public static function GC_WANANSI_TIMES(patch:IDataInput) : void
      {
         var times:int = patch.readByte();
         WanAnSiVO.isType = patch.readByte();
         WanAnSiHandler.GC_WANANSI_TIMES(times);
      }
      
      public static function GC_WANANSI_SKIP_BATTLE(patch:IDataInput) : void
      {
         WanAnSiHandler.GC_WANANSI_SKIP_BATTLE();
      }
      
      public static function GC_WANANSI_FUHUO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WanAnSiHandler.GC_WANANSI_FUHUO(result);
      }
      
      public static function GC_WANANSI_ENTER(patch:IDataInput) : void
      {
         var layers:int = 0;
         var id:Number = NaN;
         var name:String = null;
         var result:int = patch.readByte();
         if(result == -1 || result == -2 || result == -3)
         {
            id = LongUtil.readLong(patch);
            name = patch.readUTF();
         }
         else
         {
            if(result != 1)
            {
               if(result == 2)
               {
                  UIManager.centerBroadcast.addMsg("本场景不能进入万安寺！");
                  return;
               }
               UIManager.centerBroadcast.addMsg("特殊情况不能进入万安寺！" + result);
               Utils.print("特殊情况不能进入万安寺！" + result);
               return;
            }
            layers = patch.readShort();
         }
         WanAnSiHandler.GC_WANANSI_ENTER(layers,result,id,name);
      }
   }
}

