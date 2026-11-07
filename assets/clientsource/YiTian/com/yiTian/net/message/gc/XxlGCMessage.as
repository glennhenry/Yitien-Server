package com.yiTian.net.message.gc
{
   import com.yiTian.data.model.Model_xiaoxiaole;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.XxlHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Utils;
   import flash.utils.IDataInput;
   
   public class XxlGCMessage
   {
      
      public function XxlGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_XXL_OPENWIN] = this.GC_XXL_OPENWIN;
         index[MessageType.GC_XXL_CHANGEPOS] = this.GC_XXL_CHANGEPOS;
         index[MessageType.GC_XXL_GREATEMAP] = this.GC_XXL_GREATEMAP;
         index[MessageType.GC_XXL_KILL_GIRD] = this.GC_XXL_KILL_GIRD;
         index[MessageType.GC_XXL_USE_TOOL_CLEAR] = this.GC_XXL_USE_TOOL_CLEAR;
         index[MessageType.GC_XXL_USE_TOOL_PP] = this.GC_XXL_USE_TOOL_PP;
         index[MessageType.GC_XXL_USE_TOOL_ADDSTEP] = this.GC_XXL_USE_TOOL_ADDSTEP;
         index[MessageType.GC_XXL_USE_TOOL_BW] = this.GC_XXL_USE_TOOL_BW;
         index[MessageType.GC_XXL_DATA] = this.GC_XXL_DATA;
         index[MessageType.GC_XXL_CLOSE] = this.GC_XXL_CLOSE;
         index[MessageType.GC_XXL_TIP] = this.GC_XXL_TIP;
         index[MessageType.GC_XXL_SHOW_TIP] = this.GC_XXL_SHOW_TIP;
      }
      
      private function GC_XXL_OPENWIN(patch:IDataInput) : void
      {
         var b:int = patch.readByte();
         var s:String = patch.readUTF();
         var d:int = patch.readByte();
         var a:int = patch.readInt();
         var addJP:int = patch.readInt();
         XxlHandler.GC_XXL_OPENWIN(b,s,d,a,addJP);
      }
      
      private function GC_XXL_CHANGEPOS(patch:IDataInput) : void
      {
         var b:int = patch.readByte();
         var u:String = patch.readUTF();
         var s:String = patch.readUTF();
         XxlHandler.GC_XXL_CHANGEPOS(b,u,s);
      }
      
      private function GC_XXL_GREATEMAP(patch:IDataInput) : void
      {
         var arr1:Array = null;
         var a:String = null;
         var count:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < count)
         {
            arr1 = patch.readUTF().split(",");
            a = arr1.shift();
            arr1.unshift(a.charAt(1));
            a = arr1.pop();
            arr1.push(a.charAt(0));
            arr.push(arr1);
            i++;
         }
         XxlHandler.GC_XXL_GREATEMAP(arr);
      }
      
      private function GC_XXL_KILL_GIRD(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         if(flag != 1)
         {
            return;
         }
         var u:String = patch.readUTF();
         var add:String = patch.readUTF();
         Utils.print("返回数据step:",Model_xiaoxiaole.getInstance().remaindStep,"下落牌",u,"消除pai",add);
         XxlHandler.GC_XXL_KILL_GIRD(flag,u,add);
      }
      
      private function GC_XXL_DATA(patch:IDataInput) : void
      {
         var b:int = patch.readByte();
         var s:int = patch.readInt();
         XxlHandler.GC_XXL_DATA(b,s);
      }
      
      private function GC_XXL_CLOSE(patch:IDataInput) : void
      {
         XxlHandler.GC_XXL_CLOSE();
      }
      
      private function GC_XXL_TIP(patch:IDataInput) : void
      {
         var jp:int = patch.readInt();
         var ym:int = patch.readInt();
         XxlHandler.GC_XXL_TIP(jp,ym);
      }
      
      private function GC_XXL_SHOW_TIP(patch:IDataInput) : void
      {
         XxlHandler.GC_XXL_SHOW_TIP();
      }
      
      private function GC_XXL_USE_TOOL_CLEAR(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         if(this.result(flag))
         {
            return;
         }
         var color:int = patch.readByte();
         var down:String = patch.readUTF();
         var add:String = patch.readUTF();
         XxlHandler.GC_XXL_USE_TOOL_CLEAR(color,down,add);
      }
      
      private function GC_XXL_USE_TOOL_PP(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         if(this.result(flag))
         {
            return;
         }
         var u:String = patch.readUTF();
         var down:String = patch.readUTF();
         var add:String = patch.readUTF();
         XxlHandler.GC_XXL_USE_TOOL_PP(u,down,add);
         Model_xiaoxiaole.getInstance().testMap("炸弹");
      }
      
      private function GC_XXL_USE_TOOL_ADDSTEP(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         if(this.result(flag))
         {
            return;
         }
      }
      
      private function GC_XXL_USE_TOOL_BW(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         if(this.result(flag))
         {
            return;
         }
         var color:int = patch.readByte();
         var newcolor:int = patch.readByte();
         XxlHandler.GC_XXL_USE_TOOL_BW(color,newcolor);
         Model_xiaoxiaole.getInstance().testMap("黑白不分");
      }
      
      private function result(flag:int) : Boolean
      {
         var str:String = null;
         switch(flag)
         {
            case 1:
               return false;
            case 2:
               str = "元宝不足！";
               UIManager.centerBroadcast.addMsg(str);
               return true;
            case 3:
               str = "剩余次数为0！";
               UIManager.centerBroadcast.addMsg(str);
               return true;
            case 4:
               str = "步数用完啦";
               UIManager.centerBroadcast.addMsg(str);
               return true;
            case 5:
               str = "银子不足!";
               UIManager.centerBroadcast.addMsg(str);
               return true;
            default:
               return false;
         }
      }
   }
}

