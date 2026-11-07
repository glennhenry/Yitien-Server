package com.yiTian.view.modules.chat
{
   import com.utils.Util;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   
   public class View_FriTishi extends Sprite
   {
      
      public static var count_number:int = 0;
      
      private static var pool:Array = [];
      
      private var _med:ChatMediator;
      
      private var timeCount:int;
      
      private var bm_bg:Bitmap;
      
      private var bm_head:Bitmap;
      
      private var b:Boolean = false;
      
      public function View_FriTishi()
      {
         super();
         buttonMode = true;
         addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.bm_bg = new Bitmap();
         Utils.getLoadBitmap("resource/image/iconBg/grid_Skill_open.png",this.bm_bg);
         addChild(this.bm_bg);
         this.bm_head = new Bitmap();
         var _temp_1:* = this.bm_head;
         this.bm_head.y = 3;
         _temp_1.x = 3;
         addChild(this.bm_head);
      }
      
      public static function pop() : View_FriTishi
      {
         return Boolean(pool.length) ? pool.pop() : new View_FriTishi();
      }
      
      public function set med(value:ChatMediator) : void
      {
         if(Boolean(value))
         {
            value.targetTip = this;
            TipManager.bind(this,value.roleName);
         }
         this._med = value;
      }
      
      public function get med() : ChatMediator
      {
         return this._med;
      }
      
      public function init(_job:int, _sex:int) : void
      {
         this.bm_head = Utils.getLoadBitmap(Const_strImg.getPlayerHead(_job,_sex,2),this.bm_head);
         addChild(this.bm_head);
      }
      
      public function setEffectMove() : void
      {
         if(!hasEventListener(Event.ENTER_FRAME))
         {
            addEventListener(Event.ENTER_FRAME,this.effectHandle);
         }
      }
      
      public function removeEffectHandle() : void
      {
         transform.colorTransform = Util.colorNomal;
         if(hasEventListener(Event.ENTER_FRAME))
         {
            removeEventListener(Event.ENTER_FRAME,this.effectHandle);
         }
      }
      
      private function effectHandle(e:Event) : void
      {
         ++this.timeCount;
         if(this.timeCount % 15 == 0)
         {
            transform.colorTransform = this.b ? Util.colorNomal : Util.colorGlow;
            this.b = !this.b;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            TipManager.bind(this,LangConfig.getWord("29165",2) + this._med.roleName);
         }
      }
      
      public function cliHandle(e:MouseEvent) : void
      {
         e.stopPropagation();
         this._med.showPanel();
         this._med.state = ChatMediator.NONMSG;
         PriChatManager.getInstance().resetTipPos();
      }
      
      public function setPosition() : void
      {
      }
      
      public function dispose() : void
      {
         transform.colorTransform = Util.colorNomal;
         this.timeCount = 0;
         TipManager.unBind(this);
         PriChatManager.getInstance().removeTip(this);
         this.removeEffectHandle();
         this.visible = true;
         pool.push(this);
      }
   }
}

