package com.yiTian.net.message.gc
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.JinDan.JinDanVO;
   import flash.utils.IDataInput;
   
   public class JinDanGCMessage
   {
      
      public function JinDanGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_GOLD_EGG] = this.GC_GOLD_EGG;
         index[MessageType.GC_EGG_VALUE] = this.GC_EGG_VALUE;
         index[MessageType.GC_HIT_EGG] = this.GC_HIT_EGG;
         index[MessageType.GC_HIT_NUM] = this.GC_HIT_NUM;
      }
      
      public function GC_GOLD_EGG(patch:IDataInput) : void
      {
         JinDanVO.see = patch.readByte();
         UIManager.jindanBtn.show();
         if(JinDanVO.see == 0)
         {
            UIManager.JinDan.visible = false;
         }
      }
      
      public function GC_EGG_VALUE(patch:IDataInput) : void
      {
         JinDanVO.num = patch.readByte();
         JinDanVO.jcexp = patch.readInt();
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(UIManager.JinDan,function():void
         {
            if(!UIManager.JinDan.visible)
            {
               UIManager.JinDan.visible = true;
            }
            UIManager.JinDan.getnum();
            UIManager.JinDan.eggsX();
         });
      }
      
      public function GC_HIT_EGG(patch:IDataInput) : void
      {
         JinDanVO.doubleexp = patch.readByte();
         JinDanVO.exp = patch.readInt();
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(UIManager.JinDan,function():void
         {
            UIManager.JinDan.getexp();
         });
      }
      
      public function GC_HIT_NUM(patch:IDataInput) : void
      {
         JinDanVO.num = patch.readByte();
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(UIManager.JinDan,function():void
         {
            if(!UIManager.JinDan.visible)
            {
               UIManager.JinDan.visible = true;
            }
            UIManager.JinDan.getnum();
         });
      }
   }
}

