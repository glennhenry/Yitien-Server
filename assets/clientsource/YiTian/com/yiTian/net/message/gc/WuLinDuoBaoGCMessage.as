package com.yiTian.net.message.gc
{
   import com.yiTian.Global;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.net.handler.WuLinDuoBaoHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.treeDownCL.Model_treeCL;
   import flash.utils.IDataInput;
   
   public class WuLinDuoBaoGCMessage
   {
      
      public function WuLinDuoBaoGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_SHOW_BAOXIANG] = GC_SHOW_BAOXIANG;
         index[MessageType.GC_HIDE_BAOXIANG] = GC_HIDE_BAOXIANG;
         index[MessageType.GC_DUOBAO] = GC_DUOBAO;
         index[MessageType.GC_GET_BAOXIANG] = GC_GET_BAOXIANG;
         index[MessageType.GC_CANCEL_GET_BAOXIANG] = GC_CANCEL_GET_BAOXIANG;
         index[MessageType.GC_EXP_UPGRADE] = GC_EXP_UPGRADE;
         index[MessageType.GC_SNATCH_BX_TIP] = GC_SNATCH_BX_TIP;
      }
      
      public static function GC_SHOW_BAOXIANG(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var arr:Array = [];
         arr.push(patch.readByte());
         arr.push(patch.readByte());
         arr.push(patch.readByte());
         WuLinDuoBaoHandler.GC_SHOW_BAOXIANG(result,arr);
      }
      
      public static function GC_HIDE_BAOXIANG(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WuLinDuoBaoHandler.GC_HIDE_BAOXIANG(result);
      }
      
      public static function GC_DUOBAO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WuLinDuoBaoHandler.GC_DUOBAO(result);
      }
      
      public static function GC_GET_BAOXIANG(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WuLinDuoBaoHandler.GC_GET_BAOXIANG(result);
      }
      
      public static function GC_CANCEL_GET_BAOXIANG(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WuLinDuoBaoHandler.GC_CANCEL_GET_BAOXIANG(result);
      }
      
      public static function GC_SNATCH_BX_TIP(patch:IDataInput) : void
      {
         WuLinDuoBaoHandler.GC_SNATCH_BX_TIP();
      }
      
      public static function GC_EXP_UPGRADE(patch:IDataInput) : void
      {
         var exp:int = patch.readInt();
         Global.control.sendNotification(Model_treeCL.ADD_EXPERIANCE,exp);
         EffectManager.flyEffGlobal(exp);
      }
   }
}

