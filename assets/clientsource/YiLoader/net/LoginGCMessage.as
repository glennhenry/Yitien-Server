package net
{
   import com.utils.LongUtil;
   import flash.utils.IDataInput;
   
   public class LoginGCMessage
   {
      
      private static var i_index:int = 0;
      
      private static var ii_index:int = 0;
      
      public function LoginGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ASK_LOGIN] = this.GC_ASK_LOGIN;
         index[MessageType.GC_ASK_CHARLIST] = this.GC_ASK_CHARLIST;
         index[MessageType.GC_CREATE_ROLE] = this.GC_CREATE_ROLE;
         index[MessageType.GC_OFF_LINE] = this.GC_OFF_LINE;
         index[MessageType.GC_ASK_CHARLIST_NOROLE] = this.GC_ASK_CHARLIST_NOROLE;
      }
      
      public function GC_ASK_LOGIN(patch:IDataInput) : void
      {
         var result:int = patch.readShort();
         LoginHandler.GC_ASK_LOGIN(result);
      }
      
      public function GC_ASK_CHARLIST(patch:IDataInput) : void
      {
         var array_Hero:Array = null;
         var result:int = patch.readShort();
         var heros_len:int = patch.readShort();
         var heros:Array = [];
         i_index = 0;
         while(i_index < heros_len)
         {
            array_Hero = [];
            array_Hero.push(LongUtil.readLong(patch));
            array_Hero.push(patch.readUTF());
            array_Hero.push(patch.readShort());
            array_Hero.push(patch.readShort());
            array_Hero.push(patch.readShort());
            heros.push(array_Hero);
            ++i_index;
         }
         LoginHandler.GC_ASK_CHARLIST(result,heros);
      }
      
      public function GC_ASK_CHARLIST_NOROLE(patch:IDataInput) : void
      {
         var randJob:int = patch.readByte();
         LoginHandler.GC_ASK_CHARLIST_NOROLE(randJob);
      }
      
      public function GC_CREATE_ROLE(patch:IDataInput) : void
      {
         var array_Hero:Array = null;
         var result:int = patch.readShort();
         var heros_len:int = patch.readShort();
         var heros:Array = [];
         i_index = 0;
         while(i_index < heros_len)
         {
            array_Hero = [];
            array_Hero.push(LongUtil.readLong(patch));
            array_Hero.push(patch.readUTF());
            array_Hero.push(patch.readShort());
            array_Hero.push(patch.readShort());
            array_Hero.push(patch.readShort());
            heros.push(array_Hero);
            ++i_index;
         }
         LoginHandler.GC_CREATE_ROLE(result,heros);
      }
      
      public function GC_OFF_LINE(patch:IDataInput) : void
      {
         var offLineType:int = patch.readByte();
         LoginHandler.GC_OFF_LINE(offLineType);
      }
   }
}

