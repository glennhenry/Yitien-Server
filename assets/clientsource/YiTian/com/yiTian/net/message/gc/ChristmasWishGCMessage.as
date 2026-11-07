package com.yiTian.net.message.gc
{
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.newYear.View_nianShouPnl;
   import com.yiTian.view.modules.shengDanXuYuan.ChristmasWish_Btn;
   import com.yiTian.view.modules.shengDanXuYuan.View_ChristmasWish;
   import flash.utils.IDataInput;
   
   public class ChristmasWishGCMessage
   {
      
      public function ChristmasWishGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_OPEN_WISH] = this.GC_SHOW_WISH;
         index[MessageType.GC_GET_WISH] = this.GC_GET_WISH;
         index[MessageType.GC_SHOW_WISH_ICON] = this.GC_SHOW_WISH_ICON;
         index[MessageType.GC_ATTACK_SNOWMAN] = this.GC_ATTACK_SNOWMAN;
         index[MessageType.GC_WISHACTION_STATE] = this.GC_WISHACTION_STATE;
      }
      
      public function GC_ATTACK_SNOWMAN(patch:IDataInput) : void
      {
         var time:int = 0;
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80196",8));
               break;
            case 2:
               time = patch.readShort();
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80197",8,time));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80198",8));
         }
      }
      
      public function GC_SHOW_WISH_ICON(patch:IDataInput) : void
      {
         var type:uint = uint(patch.readByte());
         if(type == 1)
         {
            ChristmasWish_Btn.instance.show();
         }
         else
         {
            ChristmasWish_Btn.instance.hide();
         }
      }
      
      public function GC_GET_WISH(patch:IDataInput) : void
      {
         var time:uint = 0;
         var value:uint = 0;
         var type:uint = 0;
         var typeValue:uint = 0;
         var typeShow:uint = 0;
         var data:String = null;
         var targetPnl:View_nianShouPnl = null;
         var result:int = patch.readByte();
         if(result == 1)
         {
            time = uint(patch.readByte());
            value = uint(patch.readInt());
            type = uint(patch.readByte());
            typeValue = uint(patch.readInt());
            typeShow = uint(patch.readByte());
            View_ChristmasWish.instance.upBtn(type,typeShow,typeValue);
            data = patch.readUTF();
            View_ChristmasWish.instance.upData(time,value,data);
            targetPnl = Singleton.getInstance(View_nianShouPnl);
            Global.delegate.dosomething(targetPnl,function():void
            {
               targetPnl.flyToBag();
            });
         }
         else
         {
            switch(result)
            {
               case 0:
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("80192",8));
                  break;
               case 2:
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("80185",8));
                  break;
               case 3:
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("80193",8));
                  break;
               case 4:
                  UIManager.centerBroadcast.addMsg("活动1月30日开启，敬请期待!");
                  break;
               case 5:
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("80195",8));
            }
         }
      }
      
      public function GC_SHOW_WISH(patch:IDataInput) : void
      {
         var time:uint = 0;
         var value:uint = 0;
         var data:String = null;
         var reslut:int = patch.readByte();
         if(reslut == 0)
         {
            UIManager.centerBroadcast.addMsg("活动1月30日开启，敬请期待!");
            return;
         }
         time = uint(patch.readByte());
         value = uint(patch.readInt());
         data = patch.readUTF();
         Global.delegate.dosomething(View_ChristmasWish.instance,function():void
         {
            View_ChristmasWish.instance.visible = !View_ChristmasWish.instance.visible;
            View_ChristmasWish.instance.upData(time,value,data);
         });
      }
      
      public function GC_WISHACTION_STATE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("活动1月30日开启，敬请期待!");
         }
      }
   }
}

