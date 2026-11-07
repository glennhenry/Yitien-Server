package com.yiTian.view.modules.QShow
{
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.SmallActivityLink.SmallActManager;
   import flash.utils.IDataInput;
   
   public class QShowSkinGCMessage
   {
      
      public function QShowSkinGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_SHOWSKIN_ICON] = GC_SHOWSKIN_ICON;
         index[MessageType.GC_SHOWSKIN_GIFT] = GC_SHOWSKIN_GIFT;
         index[MessageType.GC_SHOWSKIN_ICO] = GC_SHOWSKIN_ICO;
      }
      
      public static function GC_SHOWSKIN_ICON(patch:IDataInput) : void
      {
         var str:String = patch.readUTF();
         var arr:Array = str.split("_");
         ViewQShowSkin.instance.update(int(arr[0]),int(arr[1]));
      }
      
      public static function GC_SHOWSKIN_GIFT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30141",3));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30142",3));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30143",3));
               ViewQShowSkin.instance.disableGiftBtn();
         }
      }
      
      public static function GC_SHOWSKIN_ICO(patch:IDataInput) : void
      {
         SmallActManager.instance.getShowSkinBtn();
      }
   }
}

