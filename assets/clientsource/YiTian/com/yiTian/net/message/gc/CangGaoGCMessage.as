package com.yiTian.net.message.gc
{
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.canggao.CangGaoBtn;
   import com.yiTian.view.modules.canggao.CangGaoVO;
   import flash.utils.IDataInput;
   
   public class CangGaoGCMessage
   {
      
      public function CangGaoGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_CANGGAO_SEE] = this.GC_CANGGAO_SEE;
      }
      
      public function GC_CANGGAO_SEE(patch:IDataInput) : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            return;
         }
         CangGaoBtn.instance.show();
         UIManager.canggao.show();
         CangGaoVO.time = patch.readUTF();
      }
   }
}

