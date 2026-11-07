package com.yiTian.view.modules.guangMingDing
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.list.List;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_unit;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.view.modules.friends.Model_Friends;
   import flash.display.Sprite;
   
   public class Child_InviteList extends Sprite
   {
      
      public var _list:List;
      
      public var type:Number;
      
      public var _data:Array;
      
      public function Child_InviteList()
      {
         super();
         this._list = new List(367,297,ListItem);
         this._list.x = 6;
         this._list.y = 12;
         this._list.scrollAutoType = ScrollAutoType.REMAIN;
         addChild(this._list);
      }
      
      public function tapperShowMethod(info:Object) : Boolean
      {
         Global.control.registerCallBack(Msg_guangMingDing.INVITE_REFRESH,this.updateList);
         this.updateList();
         return true;
      }
      
      public function tapperHideMethod(info:Object) : Boolean
      {
         Global.control.removeCallBack(Msg_guangMingDing.INVITE_REFRESH,this.updateList);
         return true;
      }
      
      private function updateList() : void
      {
         if(this.type == 1)
         {
            this.getFriendsList();
         }
         else
         {
            this.getBangList();
         }
      }
      
      public function getFriendsList() : void
      {
         var v:Vo_unit = null;
         var src:Array = [];
         for each(v in Model_Friends.friendArr)
         {
            if(v.level >= GuangMingDingConfig.LV_REQUIRE && v.isOnline)
            {
               src.push(v);
            }
         }
         this._list.source = src;
         this._data = src;
      }
      
      public function getBangList() : void
      {
         GuangMingDingCGMessage.CG_GMD_INVITE_INFO(this.type);
      }
   }
}

import com.ui.containers.list.IListItem;
import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.config.Enum_job;
import com.yiTian.manager.UIManager;
import com.yiTian.net.handler.GuangMingDingCGMessage;
import com.yiTian.view.modules.guangMingDing.Enum_guangMingDing;
import com.yiTian.view.modules.guangMingDing.Model_guangMingDing;
import flash.events.MouseEvent;
import flash.utils.getTimer;

class ListItem extends IListItem
{
   
   private static var _last:int = -2000;
   
   private var _btn:Button;
   
   private var _tfName:MyTextField;
   
   private var _tfJob:MyTextField;
   
   private var _tfLv:MyTextField;
   
   public var playerId:Number;
   
   public function ListItem()
   {
      super();
      ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "y":35,
         "width":350,
         "height":2
      },Global.Img_Cdm);
      this._tfName = ComponentUtil.getTextField("",this,{
         "x":21,
         "y":7,
         "color":3394815
      });
      this._tfJob = ComponentUtil.getTextField("",this,{
         "x":124,
         "y":7,
         "color":11523767
      });
      this._tfLv = ComponentUtil.getTextField("",this,{
         "x":206,
         "y":7,
         "color":11523767
      });
      ComponentUtil.getButton("邀请","Button_Two64",this,{
         "x":268,
         "y":6,
         "textColor":16184781,
         "callBack":this.inviteClickHd
      },Global.Img_Cdm);
      buttonMode = false;
      mouseChildren = true;
   }
   
   private function inviteClickHd(e:MouseEvent) : void
   {
      var now:int = getTimer();
      if(Model_guangMingDing.teamInfo.length >= 3)
      {
         UIManager.centerBroadcast.addMsg("房间人数已满");
         return;
      }
      if(now - _last > 2000)
      {
         GuangMingDingCGMessage.CG_GMD_INVITE_PLAYER(this.playerId);
         _last = now;
      }
      else
      {
         UIManager.centerBroadcast.addMsg("您的操作太频繁，请稍等片刻");
      }
   }
   
   override public function set data(value:Object) : void
   {
      if(value is Array)
      {
         this._tfName.text = value[Enum_guangMingDing.INVITE_ROLE_NAME];
         this._tfLv.text = value[Enum_guangMingDing.INVITE_ROLE_LEVEL];
         this._tfJob.htmlText = Enum_job.getMenPai(value[Enum_guangMingDing.INVITE_ROLE_JOB],true);
         this.playerId = value[Enum_guangMingDing.INVITE_ROLE_ID];
      }
      else
      {
         this._tfName.text = value.name;
         this._tfLv.text = value.level;
         this._tfJob.htmlText = Enum_job.getMenPai(value.job,true);
         this.playerId = value.id;
      }
   }
}
