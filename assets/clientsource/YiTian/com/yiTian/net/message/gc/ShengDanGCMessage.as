package com.yiTian.net.message.gc
{
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.ShengDan.ShengDanVO;
   import flash.utils.IDataInput;
   
   public class ShengDanGCMessage
   {
      
      public function ShengDanGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_SHENGDAN_OPEN] = this.GC_SHENGDAN_OPEN;
         index[MessageType.GC_SHENGDAN_VALUE] = this.GC_SHENGDAN_VALUE;
      }
      
      public function GC_SHENGDAN_OPEN(patch:IDataInput) : void
      {
         ShengDanVO.see = patch.readByte();
         if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            UIManager.shengdanBtn.show();
         }
      }
      
      public function GC_SHENGDAN_VALUE(patch:IDataInput) : void
      {
         var pnl:Panel123;
         ShengDanVO.isyellow = patch.readByte();
         ShengDanVO.yellowIndex = patch.readByte();
         ShengDanVO.btn1 = patch.readByte();
         ShengDanVO.btn2 = patch.readByte();
         ShengDanVO.btn3 = patch.readByte();
         ShengDanVO.btn4 = patch.readByte();
         ShengDanVO.btn5 = patch.readByte();
         ShengDanVO.btn6 = patch.readByte();
         ShengDanVO.starTime = patch.readInt();
         ShengDanVO.endTime = patch.readInt();
         ShengDanVO.istime = patch.readByte();
         pnl = UIManager.ShengDan;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
         {
            UIManager.ShengDan.visible = true;
            UIManager.ShengDan.Open();
         });
      }
   }
}

