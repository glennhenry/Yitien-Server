package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.treeDownCL.Model_treeCL;
   import flash.utils.ByteArray;
   
   public class TreeDownCLCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function TreeDownCLCGMessage()
      {
         super();
      }
      
      public static function CG_ENTER_TREEMAP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ENTER_TREEMAP,bytebuff);
      }
      
      public static function CG_SENDANSWER_TREECL(answerKey:int, answer:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(answerKey);
         bytebuff.writeUTF(answer);
         Model_treeCL.delayAnswer = Model_treeCL.answerArr;
         Model_treeCL.delayRightAnswerKey = Model_treeCL.answerKey;
         SocketManager.send(MessageType.CG_SENDANSWER_TREECL,bytebuff);
      }
      
      public static function CG_QUIT_TREEMAP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_QUIT_TREEMAP,bytebuff);
      }
      
      public static function CG_ASK_FORDATA_TREE(status:int) : void
      {
      }
   }
}

