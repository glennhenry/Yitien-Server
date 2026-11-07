package com.yiTian.net.message.gc
{
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.net.message.cg.LiuShiBackCGMessage;
   import com.yiTian.view.modules.actions.liushiBack.LiushiBackBtn;
   import com.yiTian.view.modules.actions.liushiBack.LiushiBackPan;
   import flash.utils.IDataInput;
   
   public class LiuShiBackGCMessage
   {
      
      public static var _arr:Array;
      
      public static var _day:int;
      
      public function LiuShiBackGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_LIUSHIBACK_ICON] = this.GC_LIUSHIBACK_ICON;
         index[MessageType.GC_LIUSHIBACK_OPEN] = this.GC_LIUSHIBACK_OPEN;
         index[MessageType.GC_LIUSHIBACK_AWARD] = this.GC_LIUSHIBACK_AWARD;
      }
      
      public function GC_LIUSHIBACK_ICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            LiushiBackBtn.showIcon();
         }
         else if(result == 2)
         {
            LiuShiBackCGMessage.CG_LIUSHIBACK_OPEN();
            LiushiBackBtn.showIcon();
            Global.delegate.dosomething(LiushiBackPan.instance,function():void
            {
               LiushiBackPan.instance.visible = true;
            });
         }
         else if(result == 0)
         {
            LiushiBackBtn.remove();
         }
      }
      
      public function GC_LIUSHIBACK_OPEN(patch:IDataInput) : void
      {
         var day:int;
         var value:int = 0;
         var arr:Array = [];
         var i:int = 0;
         while(i < 7)
         {
            value = patch.readByte();
            arr.push(value);
            i++;
         }
         day = patch.readByte();
         _arr = arr;
         _day = day;
         Global.delegate.dosomething(LiushiBackPan.instance,function():void
         {
            LiushiBackPan.instance.update(_arr,_day);
         });
      }
      
      public function GC_LIUSHIBACK_AWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("领取失败");
         }
         else if(result == 1)
         {
            if(_arr[0] == 1)
            {
               _arr[0] = 2;
            }
            else if(_arr[1] == 1)
            {
               _arr[1] = 2;
            }
            else if(_arr[2] == 1)
            {
               _arr[2] = 2;
            }
            else if(_arr[3] == 1)
            {
               _arr[3] = 2;
            }
            else if(_arr[4] == 1)
            {
               _arr[4] = 2;
            }
            else if(_arr[5] == 1)
            {
               _arr[5] = 2;
            }
            else if(_arr[6] == 1)
            {
               _arr[6] = 2;
            }
            UIManager.centerBroadcast.addMsg("领取成功");
            Global.delegate.dosomething(LiushiBackPan.instance,function():void
            {
               LiushiBackPan.instance.update(_arr,_day);
               LiushiBackPan.instance.giftFly();
            });
         }
      }
   }
}

