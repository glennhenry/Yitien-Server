package com.yiTian.view.modules.chat
{
   import com.ui.containers.Canvas;
   
   public class ChatList extends Canvas
   {
      
      private static const LISTLEN:int = 50;
      
      protected var list:Array = [];
      
      private var _width:int;
      
      private var _data:Object;
      
      private var text_contact:String;
      
      private var extrPool:Array = [];
      
      public function ChatList(wid:int, hei:int, position:String, _tf_widh:int = 255, visWid:int = 0)
      {
         super(wid,hei,position,visWid);
         this.tf_width = _tf_widh;
         visible = true;
      }
      
      public function set tf_width(value:int) : void
      {
         this._width = value;
      }
      
      public function get tf_width() : int
      {
         return this._width;
      }
      
      public function addItem(text:String, txt_position:int, data:Object = null, fun:Function = null) : void
      {
         var rtf:RichTF = null;
         if(this.lock && this.list.length == LISTLEN)
         {
            this.extrPool.push([text,txt_position,data,fun]);
            return;
         }
         rtf = RichTF.getRichTF();
         rtf.width = 248;
         rtf.x = txt_position;
         rtf.init(text,data,fun);
         addChild(rtf);
         this.list.push(rtf);
         if(this.list.length > LISTLEN)
         {
            this.removeItem();
         }
         this.align();
      }
      
      public function set resetList_TF_width(size:int) : void
      {
      }
      
      protected function removeItem() : void
      {
         this.list[0].dispose();
         removeChild(this.list[0]);
         this.list.shift();
      }
      
      override public function set ThumbBa(thumbBarStr:String) : void
      {
         super.ThumbBa = thumbBarStr;
      }
      
      override public function align() : void
      {
         var nowY:int = 0;
         var i:int = 0;
         while(i < this.list.length)
         {
            this.list[i].y = nowY;
            nowY += this.list[i].height;
            i++;
         }
         super.align();
      }
      
      override public function set lock(value:Boolean) : void
      {
         var i:int = 0;
         super.lock = value;
         if(!value)
         {
            if(Boolean(this.extrPool.length))
            {
               i = this.extrPool.length - 1;
               while(i >= 0)
               {
                  this.addItem(this.extrPool[i][0],this.extrPool[i][1],this.extrPool[i][2],this.extrPool[i][3]);
                  this.extrPool.splice(i,1);
                  i--;
               }
            }
         }
      }
      
      override public function get lock() : Boolean
      {
         return super.lock;
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         while(i < this.list.length)
         {
            removeChild(this.list[i]);
            i++;
         }
         this.list = [];
      }
   }
}

