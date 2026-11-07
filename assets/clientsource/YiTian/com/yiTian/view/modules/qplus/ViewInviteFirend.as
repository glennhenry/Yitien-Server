package com.yiTian.view.modules.qplus
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QplusShareCGMessage;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   
   public class ViewInviteFirend extends Sprite
   {
      
      public static var instance:ViewInviteFirend;
      
      private static const INVITEGOALID:Array = [23,24,25,26,27,28,29,30];
      
      public static const INVITELEN:int = 8;
      
      private var fixHei:int = 30;
      
      private var itemLen:int = 7;
      
      private var itemArr:Vector.<InviteItem> = new Vector.<InviteItem>();
      
      private var getGiftBtn:Button;
      
      private var inviteFriendBtn:Button;
      
      private var curInviteArr:Array;
      
      private var selId:int;
      
      private var curItem:InviteItem;
      
      public function ViewInviteFirend()
      {
         super();
         this.init();
         instance = this;
      }
      
      private function init() : void
      {
         var i:int = 0;
         var item:InviteItem = null;
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":0,
            "y":0,
            "width":456,
            "height":344
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":2,
            "y":2,
            "width":452,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":2,
            "y":22,
            "width":452,
            "height":38
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":2,
            "y":83,
            "width":452,
            "height":258
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("30093",3),this,{
            "x":203,
            "y":2,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":2,
            "y":63,
            "width":452,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("30089",3),this,{
            "x":203,
            "y":63,
            "color":16764206,
            "size":12,
            "leading":0
         });
         i = 0;
         while(i <= this.itemLen)
         {
            item = new InviteItem();
            addChild(item);
            this.itemArr.push(item);
            item.x = 3;
            if(i == 0)
            {
               item.y = 21;
            }
            else
            {
               item.y = 82 + (i - 1) * this.fixHei;
            }
            item.buttonMode = true;
            item.addEventListener(MouseEvent.CLICK,this.selItemHandle);
            item.addEventListener(MouseEvent.MOUSE_OVER,this.overItemHandle);
            item.addEventListener(MouseEvent.MOUSE_OUT,this.outItemHandle);
            i++;
         }
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":4,
            "y":292,
            "width":450,
            "height":2
         },Global.Img_Cdm);
         this.getGiftBtn = ComponentUtil.getButton("","BT_YQHaoYou",this,{
            "x":265,
            "y":296,
            "textColor":16184781
         },Global.FengXiang_Imgsdm);
         this.inviteFriendBtn = ComponentUtil.getButton("","BT_YQHy",this,{
            "x":77,
            "y":296,
            "textColor":16184781
         },Global.FengXiang_Imgsdm);
         this.getGiftBtn.addEventListener(MouseEvent.CLICK,this.getGiftHandle);
         this.inviteFriendBtn.addEventListener(MouseEvent.CLICK,this.inviteFirendHandle);
         this.setItemText();
      }
      
      private function selItemHandle(evt:MouseEvent) : void
      {
         this.reset();
         var selItem:InviteItem = evt.currentTarget as InviteItem;
         this.selId = selItem.itemId;
         if(selItem.itemState == 1)
         {
            this.getGiftBtn.enabled = true;
            this.getGiftBtn.mouseEnabled = true;
         }
         else
         {
            this.getGiftBtn.enabled = false;
            this.getGiftBtn.mouseEnabled = false;
         }
         selItem.selItem = true;
         selItem.clkSel = true;
      }
      
      private function overItemHandle(evt:MouseEvent) : void
      {
         this.curItem = evt.currentTarget as InviteItem;
         if(this.curItem.clkSel)
         {
            return;
         }
         this.curItem.selItem = true;
      }
      
      private function outItemHandle(evt:MouseEvent) : void
      {
         var item:InviteItem = evt.currentTarget as InviteItem;
         if(!item.clkSel)
         {
            item.selItem = false;
         }
         if(!this.curItem.clkSel)
         {
            this.curItem.selItem = false;
         }
      }
      
      private function reset() : void
      {
         var l:int = 0;
         var item:InviteItem = null;
         l = 0;
         while(l < INVITELEN)
         {
            item = this.itemArr[l] as InviteItem;
            item.selItem = false;
            item.clkSel = false;
            l++;
         }
      }
      
      private function getGiftHandle(evt:MouseEvent) : void
      {
         var l:int = 0;
         var item:InviteItem = null;
         var p:Point = null;
         var cont:int = 0;
         l = 0;
         while(l < INVITELEN)
         {
            item = this.itemArr[l] as InviteItem;
            if(item.clkSel && item.itemId == this.selId)
            {
               if(item.itemState == 1)
               {
                  QplusShareCGMessage.CG_GETING_GIFT(this.selId);
                  p = item.rewardEffP;
                  p = item.localToGlobal(p);
                  Global.control.sendNotification(Enum_MsgType.QPLUS_SHARE_EFFTER,p);
                  break;
               }
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("30094",3));
               break;
            }
            cont++;
            l++;
         }
         if(cont == INVITELEN)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30095",3));
         }
      }
      
      private function inviteFirendHandle(evt:MouseEvent) : void
      {
         ExternalInterface.call("inviteFriend");
      }
      
      private function setItemText() : void
      {
         var l:int = 0;
         var item:InviteItem = null;
         l = 0;
         while(l < INVITELEN)
         {
            item = this.itemArr[l] as InviteItem;
            item.itemId = INVITEGOALID[l];
            item.itemText = Data_lib.qplusShare[int(INVITEGOALID[l])];
            l++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            InviteItem(this.itemArr[0]).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      public function set inviteData(arr:Array) : void
      {
         var l:int = 0;
         var item:InviteItem = null;
         this.curInviteArr = arr;
         l = 0;
         while(l < INVITELEN)
         {
            item = this.itemArr[l] as InviteItem;
            item.requireState = this.curInviteArr[l];
            if(item.clkSel)
            {
               if(item.itemState == 1)
               {
                  this.getGiftBtn.enabled = true;
                  this.getGiftBtn.mouseEnabled = true;
               }
               else
               {
                  this.getGiftBtn.enabled = false;
                  this.getGiftBtn.mouseEnabled = false;
               }
            }
            l++;
         }
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Point;

class InviteItem extends Sprite
{
   
   private var _itemTxt:MyTextField;
   
   private var _bitBg:Bitmap;
   
   private var _itemStr:String;
   
   private var _itemP:Point;
   
   public var itemId:int;
   
   public var itemState:int;
   
   private var curBoo:Boolean = false;
   
   private var selMc:DisplayObject;
   
   public var clkSel:Boolean = false;
   
   private var curStr:String = "YWanCheng";
   
   public function InviteItem()
   {
      super();
      this.initItem();
   }
   
   private function initItem() : void
   {
      ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "x":0,
         "y":0,
         "width":450,
         "height":2
      },Global.Img_Cdm);
      this._itemTxt = ComponentUtil.getTextField("一二三四五六七八九十一二三四五六七八九八九十一二三四",this,{
         "x":14,
         "y":8,
         "size":12,
         "leading":0
      });
      this._bitBg = ComponentUtil.getBitmap("YWanCheng",this,{
         "x":300,
         "y":8
      },Global.FengXiang_Imgsdm);
      this.selMc = ComponentUtil.getDisplayObject("Item_Select",this,{
         "width":450,
         "height":30
      });
      this.selMc.visible = false;
   }
   
   public function set itemText(str:String) : void
   {
      this._itemStr = str;
      this._itemTxt.text = str;
      if(Boolean(this._bitBg) && Boolean(this.contains(this._bitBg)))
      {
         this._bitBg.x = this._itemTxt.x + this._itemTxt.width + 20;
      }
   }
   
   public function set selItem(boo:Boolean) : void
   {
      if(this.curBoo == boo)
      {
         return;
      }
      this.curBoo = boo;
      this.selMc.visible = boo;
      if(this.itemId == 23)
      {
         this.selMc.height = 40;
      }
      else
      {
         this.selMc.height = 30;
      }
   }
   
   public function get selItem() : Boolean
   {
      return this.selMc.visible;
   }
   
   public function set requireState(state:int) : void
   {
      switch(state)
      {
         case 0:
            this.bitBgShow(false);
            this._itemTxt.htmlText = "<font color=\'#999999\'>" + this._itemStr + "</font>";
            this.itemState = 0;
            break;
         case 1:
            this.bitBgShow(true);
            this._itemTxt.htmlText = "<font color=\'#f9ff00\'>" + this._itemStr + "</font>";
            this.itemState = 1;
            break;
         case 2:
            this.bitBgShow(true,"YLingQu");
            this._itemTxt.htmlText = "<font color=\'#04ff00\'>" + this._itemStr + "</font>";
            this.itemState = 2;
      }
   }
   
   public function get rewardEffP() : Point
   {
      return this._itemP;
   }
   
   private function bitBgShow(value:Boolean, str:String = "YWanCheng") : void
   {
      var curX:Number = NaN;
      if(value)
      {
         if(!this._bitBg)
         {
            this._bitBg = ComponentUtil.getBitmap(str,this,{
               "x":278,
               "y":10
            },Global.FengXiang_Imgsdm);
         }
         else if(this.curStr != str)
         {
            curX = Number(this._bitBg.x);
            if(this.contains(this._bitBg))
            {
               removeChild(this._bitBg);
            }
            this._bitBg = null;
            this._bitBg = ComponentUtil.getBitmap(str,this,{
               "x":curX,
               "y":10
            },Global.FengXiang_Imgsdm);
            this.curStr = str;
         }
         addChild(this._bitBg);
         this._itemP = new Point(this._bitBg.x - 10,this._bitBg.y + 6);
      }
      else if(Boolean(this._bitBg) && Boolean(this.contains(this._bitBg)))
      {
         removeChild(this._bitBg);
      }
   }
}
