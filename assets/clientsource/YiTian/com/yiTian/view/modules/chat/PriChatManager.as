package com.yiTian.view.modules.chat
{
   import com.yiTian.manager.UIManager;
   import flash.utils.Dictionary;
   
   public class PriChatManager
   {
      
      private static var _instance:PriChatManager;
      
      public static const NUM_ROW:int = 5;
      
      private var _dic:Dictionary;
      
      private var _tipArr:Array;
      
      private const OFFSET:Number = 45;
      
      public function PriChatManager()
      {
         super();
         this._dic = new Dictionary();
         this._tipArr = [];
      }
      
      public static function getInstance() : PriChatManager
      {
         if(!_instance)
         {
            _instance = new PriChatManager();
         }
         return _instance;
      }
      
      public function findMed(id:Number) : ChatMediator
      {
         return this._dic[id];
      }
      
      public function addMed(vo:ChatMediator) : void
      {
         if(Boolean(this._dic[vo.roleId]))
         {
            throw new Error("chat error id:" + vo.roleId);
         }
         this._dic[vo.roleId] = vo;
      }
      
      public function delMed(vo:ChatMediator) : void
      {
         delete this._dic[vo.roleId];
      }
      
      public function addTip(tip:View_FriTishi) : void
      {
         if(this._tipArr.indexOf(tip) >= 0)
         {
            return;
         }
         this._tipArr.push(tip);
         UIManager.chatPanel.addChild(tip);
         this.resetTipPos();
      }
      
      public function removeTip(tip:View_FriTishi) : void
      {
         this._tipArr.splice(this._tipArr.indexOf(tip),1);
         tip.parent.removeChild(tip);
         this.resetTipPos();
      }
      
      public function resetTipPos(isSort:Boolean = true) : void
      {
         var i:int = 0;
         var sy:Number = NaN;
         var row:int = 0;
         var col:int = 0;
         var j:int = 0;
         var o1:View_FriTishi = null;
         var o2:View_FriTishi = null;
         var tmp:Object = null;
         var tip:View_FriTishi = null;
         if(isSort)
         {
            i = 0;
            while(i < this._tipArr.length - 1)
            {
               j = i + 1;
               while(j < this._tipArr.length)
               {
                  o1 = this._tipArr[i];
                  o2 = this._tipArr[j];
                  if(o1.med.state > o2.med.state)
                  {
                     tmp = o1;
                     this._tipArr[i] = o2;
                     this._tipArr[j] = tmp;
                  }
                  j += 1;
               }
               i += 1;
            }
         }
         sy = 1;
         i = 0;
         while(i < this._tipArr.length)
         {
            tip = this._tipArr[i];
            row = int(i / NUM_ROW);
            col = i % NUM_ROW;
            tip.x = 280 + row * this.OFFSET;
            tip.y = sy + col * this.OFFSET;
            i += 1;
         }
      }
   }
}

