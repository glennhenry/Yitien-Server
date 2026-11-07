package com.yiTian.view.modules.chat
{
   import com.yiTian.manager.GameUnitManager;
   
   public class ChatMediator
   {
      
      public static const INIT:int = 0;
      
      public static const NEWMSG:int = 1;
      
      public static const NONMSG:int = 2;
      
      public static const HIDE:int = 3;
      
      private var _state:int;
      
      public var roleId:Number;
      
      public var roleName:String;
      
      public var roleJob:int;
      
      public var roleSex:int;
      
      public var sceneName:String;
      
      public var roleBody:int;
      
      public var roleWeapon:int;
      
      public var roleHorse:int;
      
      public var roleWing:int;
      
      public var vipLv:int;
      
      public var isKuaFu:int;
      
      public var isFriend:int;
      
      private var content:Array = [];
      
      private var _targetPanel:View_PrivaChatPanel;
      
      private var _targetTip:View_FriTishi;
      
      public var crossType:int;
      
      public function ChatMediator()
      {
         super();
      }
      
      public function set targetPanel(value:View_PrivaChatPanel) : void
      {
         this._targetPanel = value;
      }
      
      public function get targetPanel() : View_PrivaChatPanel
      {
         return this._targetPanel;
      }
      
      public function set targetTip(value:View_FriTishi) : void
      {
         this._targetTip = value;
      }
      
      public function get targetTip() : View_FriTishi
      {
         return this._targetTip;
      }
      
      public function showPanel() : void
      {
         var arr:Array = null;
         if(!this._targetPanel)
         {
            this._targetPanel = View_PrivaChatPanel.pop();
            this._targetPanel.med = this;
            for each(arr in this.content)
            {
               this._targetPanel.showMessage(arr[0],arr[1],arr[2]);
            }
         }
         this._targetPanel.visible = !this._targetPanel.visible;
      }
      
      public function addContent(roleName:String, str:String, time:int) : void
      {
         var manager:PriChatManager = PriChatManager.getInstance();
         if(!this._targetTip)
         {
            this._targetTip = View_FriTishi.pop();
            this._targetTip.med = this;
            this._targetTip.init(this.roleJob,this.roleSex);
            manager.addTip(this._targetTip);
         }
         this.content.push([roleName,time,str]);
         if(this.content.length > 35)
         {
            this.content.splice(0,1);
         }
         if(roleName != GameUnitManager.hero.name && (!this._targetPanel || !this._targetPanel.visible))
         {
            this.state = NEWMSG;
         }
         else
         {
            this.state = NONMSG;
         }
         if(Boolean(this._targetPanel))
         {
            this._targetPanel.showMessage(roleName,time,str);
            if(roleName != GameUnitManager.hero.name)
            {
               this._targetPanel.maimeng();
            }
         }
      }
      
      public function set state(value:int) : void
      {
         switch(value)
         {
            case INIT:
               trace("init state");
               break;
            case NEWMSG:
               if(!this._targetTip)
               {
                  this._targetTip = View_FriTishi.pop();
                  this._targetTip.med = this;
                  this._targetTip.init(this.roleJob,this.roleSex);
                  PriChatManager.getInstance().addTip(this._targetTip);
               }
               this._targetTip.setEffectMove();
               break;
            case NONMSG:
               if(!this._targetTip)
               {
                  this._targetTip = View_FriTishi.pop();
                  this._targetTip.med = this;
                  this._targetTip.init(this.roleJob,this.roleSex);
                  PriChatManager.getInstance().addTip(this._targetTip);
               }
               this._targetTip.removeEffectHandle();
               break;
            case HIDE:
               this._targetTip.dispose();
               this._targetTip.med = null;
               this._targetTip = null;
               if(Boolean(this.targetPanel))
               {
                  this.targetPanel.dispose();
                  this.targetPanel.med = null;
                  this.targetPanel = null;
               }
               break;
            default:
               throw new Error("error");
         }
         this._state = value;
      }
      
      public function get state() : int
      {
         return this._state;
      }
   }
}

