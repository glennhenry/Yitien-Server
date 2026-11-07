package com.yiTian.view.modules.joinfriends
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.QuestGuiManager;
   import com.yiTian.net.message.cg.FriendCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class JoinFriendsPanel extends Panel
   {
      
      private const LEN:int = 10;
      
      private var btnAllJoin:Button;
      
      private var vecItem:Vector.<JoinFriendsItem>;
      
      private var back:DisplayObject;
      
      private var _data:Array;
      
      public function JoinFriendsPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":658,
            "height":400
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":610,
            "height":350
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":50,
            "width":590,
            "height":303
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":624,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnAllJoin = ComponentUtil.getButton(LangConfig.getWord("10611",1),"Button_Orange",this,{
            "x":292,
            "y":358,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnAllJoin.textColor = 16383744;
         this.btnAllJoin.textOverColor = 16383744;
         this.btnAllJoin.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(e:MouseEvent) : void
      {
         var l:int = 0;
         var d:Array = null;
         var i:int = 0;
         if(Boolean(this._data) && Boolean(this._data.length))
         {
            l = int(this._data.length);
            d = [];
            i = 0;
            while(i < l)
            {
               d.push(this._data[i][3]);
               i++;
            }
            FriendCGMessage.CG_JOINFRIENDS_ALL(d);
         }
      }
      
      public function update(value:Array) : void
      {
         this._data = value;
         var i:int = this.LEN;
         while(Boolean(i--))
         {
            if(Boolean(value[i]))
            {
               this.vecItem[i].updata(value[i]);
            }
            else
            {
               this.vecItem[i].updata(null);
            }
         }
      }
      
      public function showJoinFriends() : void
      {
         this.visible = true;
         FriendCGMessage.CG_JOINFRIENDS();
         QuestGuiManager.addKuang(this,this.btnAllJoin.x - 5,this.btnAllJoin.y - 5,this.btnAllJoin.width + 11,this.btnAllJoin.height + 9);
         QuestGuiManager.addJian(this,this.btnAllJoin.x + this.btnAllJoin.width,this.btnAllJoin.y,180);
      }
      
      public function showCloseGuide() : void
      {
         QuestGuiManager.addKuang(this,CloseButton.x - 5,CloseButton.y - 5,CloseButton.width + 10,CloseButton.height + 10);
         QuestGuiManager.addJian(this,CloseButton.width + CloseButton.x + 3,CloseButton.height / 2 + CloseButton.y,180);
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:int = 0;
         var item:JoinFriendsItem = null;
         super.visible = value;
         if(value)
         {
            if(!this.vecItem)
            {
               this.vecItem = new Vector.<JoinFriendsItem>(this.LEN,true);
               i = this.LEN;
               while(Boolean(i--))
               {
                  item = new JoinFriendsItem();
                  item.x = 54 + (94 + 18) * (i % 5);
                  item.y = 70 + (118 + 15) * Math.floor(i / 5);
                  addChild(item);
                  this.vecItem[i] = item;
               }
               this.update([]);
               Utils.loadTitle("lang/ch/JoinFriends_Imgs.swf","Title_JoinFriends",new Bitmap(),{
                  "x":246,
                  "y":5
               },this);
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
   }
}

