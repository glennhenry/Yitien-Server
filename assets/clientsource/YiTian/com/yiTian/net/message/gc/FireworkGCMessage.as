package com.yiTian.net.message.gc
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.HtmlUtil;
   import flash.utils.IDataInput;
   
   public class FireworkGCMessage
   {
      
      public static var index:int = 0;
      
      public function FireworkGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_FIREWORK_MSG] = GC_FIREWORK_MSG;
      }
      
      public static function GC_FIREWORK_MSG(patch:IDataInput) : void
      {
         var name:String = Model_heFu.repNameByHero(patch.readUTF());
         var index:int = patch.readByte();
         var str:String = HtmlUtil.font(" 系统  ","#ff0000") + HtmlUtil.font(name,"#33CCFF") + "<font color = \'#ffff00\'>" + Data_lib.yanhua[index][0] + "</font>";
         UIManager.chatPanel.add(str,0,1);
      }
   }
}

