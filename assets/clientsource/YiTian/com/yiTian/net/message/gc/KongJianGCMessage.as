package com.yiTian.net.message.gc
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.KongJianDengLu.KongJianVO;
   import flash.display.Sprite;
   import flash.utils.IDataInput;
   
   public class KongJianGCMessage
   {
      
      private var spr:Sprite;
      
      public function KongJianGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_OPEN_KONGJIANDENGLU] = this.GC_OPEN_KONGJIANDENGLU;
         index[MessageType.GC_GETBT_KONGJIANDENGLU] = this.GC_GETBT_KONGJIANDENGLU;
         index[MessageType.GC_LINGQU_KONGJIAN] = this.GC_LINGQU_KONGJIAN;
         index[MessageType.GC_SHOW_DENGLU_3366] = this.GC_SHOW_DENGLU_3366;
         index[MessageType.GC_LINGQU_DENGLU_3366] = this.GC_LINGQU_DENGLU_3366;
      }
      
      public function GC_LINGQU_DENGLU_3366(patch:IDataInput) : void
      {
         KongJianVO._SafeStr_1 = patch.readByte();
         KongJianVO.see = 2;
         UIManager.kongjianBtn.show();
         UIManager.kongjian.close();
      }
      
      public function GC_SHOW_DENGLU_3366(patch:IDataInput) : void
      {
         KongJianVO.see = 1;
         UIManager.kongjianBtn.show();
         KongJianVO.day = patch.readShort();
         if(KongJianVO.day > 3)
         {
            KongJianVO.day = 3;
         }
         UIManager.kongjian.Open();
      }
      
      public function GC_OPEN_KONGJIANDENGLU(patch:IDataInput) : void
      {
         KongJianVO.see = patch.readByte();
         UIManager.kongjianBtn.show();
      }
      
      public function GC_GETBT_KONGJIANDENGLU(patch:IDataInput) : void
      {
         KongJianVO.day = patch.readInt();
         UIManager.kongjian.visible = true;
         UIManager.kongjian.Open();
      }
      
      public function GC_LINGQU_KONGJIAN(patch:IDataInput) : void
      {
         KongJianVO._SafeStr_1 = patch.readInt();
         UIManager.kongjianBtn.show();
         UIManager.kongjian.close();
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "get"
 */
