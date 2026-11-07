package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.actions.OldPlayerBack;
   import com.yiTian.view.modules.actions.YuanXiaoHuiguiTip;
   import com.yiTian.view.modules.actions.caiFuTong.CFTTips;
   import com.yiTian.view.modules.actions.ciRiLibao.tomorrDayGf.TomDayGift;
   import com.yiTian.view.modules.actions.ciRiLibao.tomorrDayGf.TomGifICon;
   import com.yiTian.view.modules.actions.ciRiLibao.tomorrDayGf.Vo_tomorrDaygf;
   import com.yiTian.view.modules.actions.huoYueDu.HuoYueDuPan;
   import com.yiTian.view.modules.actions.huoYueDu.HuoYueDuTip;
   import com.yiTian.view.modules.actions.huoYueDu.HuoYueMter;
   import com.yiTian.view.modules.actions.qqXuanfeng.QQXuanFeng;
   import flash.utils.IDataInput;
   import mx.utils.StringUtil;
   
   public class ActionsGCMessage
   {
      
      private var _time:String;
      
      public function ActionsGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_SHOW_BACKPLAYER_TIP] = this.GC_SHOW_BACKPLAYER_TIP;
         index[MessageType.GC_OPEN_BACKPLAYER_PAN] = this.GC_OPEN_BACKPLAYER_PAN;
         index[MessageType.GC_CHONGZHI_PAN] = this.GC_CHONGZHI_PAN;
         index[MessageType.GC_GETAWARD_BACKPLAYER] = this.GC_GETAWARD_BACKPLAYER;
         index[MessageType.GC_TEQUAN_PAN] = this.GC_TEQUAN_PAN;
         index[MessageType.GC_QQXUANFENG_TIP] = this.GC_QQXUANFENG_TIP;
         index[MessageType.GC_QQXUANFENG_GETAWARD] = this.GC_QQXUANFENG_GETAWARD;
         index[MessageType.GC_OPEN_CIRI_GF] = this.GC_OPEN_CIRI_GF;
         index[MessageType.GC_GET_CIRI_GF] = this.GC_GET_CIRI_GF;
         index[MessageType.GC_CIRI_BROADCAST] = this.GC_CIRI_BROADCAST;
         index[MessageType.GC_HUOYUEDU_APPLY] = this.GC_HUOYUEDU_APPLY;
         index[MessageType.GC_HUOYUEDU_GETAWARD] = this.GC_HUOYUEDU_GETAWARD;
         index[MessageType.GC_HUOYUEDU_JOIN] = this.GC_HUOYUEDU_JOIN;
         index[MessageType.REMIND_HUOYUEDU] = this.REMIND_HUOYUEDU;
         index[MessageType.GC_ISSHOW_HUOYUE_ICON] = this.GC_ISSHOW_HUOYUE_ICON;
         index[MessageType.GC_DROPEGGS_CTRL] = this.GC_DROPEGGS_CTRL;
         index[MessageType.GC_ISHOWCAIFUTONG] = this.GC_ISHOWCAIFUTONG;
      }
      
      private static function isShowHd(value:Boolean) : void
      {
         if(GameUnitManager.hero.level >= 20)
         {
            if(value)
            {
               TomGifICon.instance.show();
            }
            else
            {
               TomGifICon.instance.remove();
            }
         }
         else if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,lvUpHd);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,lvUpHd);
         }
      }
      
      private static function lvUpHd() : void
      {
         if(GameUnitManager.hero.level >= 20)
         {
            TomGifICon.instance.show();
         }
      }
      
      public function GC_SHOW_BACKPLAYER_TIP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            YuanXiaoHuiguiTip.instance.show();
         }
         else
         {
            YuanXiaoHuiguiTip.instance.remove();
         }
      }
      
      public function GC_OPEN_BACKPLAYER_PAN(patch:IDataInput) : void
      {
         var time:String = null;
         var noDenglu:int = 0;
         var denglu:int = 0;
         var status1:int = 0;
         var status2:int = 0;
         var status3:int = 0;
         var oldPB:OldPlayerBack = null;
         time = patch.readUTF();
         noDenglu = patch.readByte();
         denglu = patch.readByte();
         status1 = patch.readByte();
         status2 = patch.readByte();
         status3 = patch.readByte();
         this._time = time;
         oldPB = Singleton.getInstance(OldPlayerBack) as OldPlayerBack;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(oldPB,function():void
         {
            oldPB.showView(time,noDenglu,denglu,status1,status2,status3,1,0);
         });
      }
      
      public function GC_CHONGZHI_PAN(patch:IDataInput) : void
      {
         var chongZhi:int = 0;
         var status1:int = 0;
         var status2:int = 0;
         var status3:int = 0;
         var oldPB:OldPlayerBack = null;
         chongZhi = patch.readInt();
         status1 = patch.readByte();
         status2 = patch.readByte();
         status3 = patch.readByte();
         oldPB = Singleton.getInstance(OldPlayerBack) as OldPlayerBack;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(oldPB,function():void
         {
            oldPB.showView(_time,1,1,status1,status2,status3,2,chongZhi);
         });
      }
      
      public function GC_GETAWARD_BACKPLAYER(patch:IDataInput) : void
      {
         var bigType:int = 0;
         var type:int = 0;
         var oldPB:OldPlayerBack = null;
         bigType = patch.readByte();
         type = patch.readByte();
         var result:int = patch.readByte();
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功");
            oldPB = Singleton.getInstance(OldPlayerBack) as OldPlayerBack;
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(oldPB,function():void
            {
               oldPB.updateSecc(bigType,type);
            });
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("背包已满，清理背包");
         }
      }
      
      public function GC_TEQUAN_PAN(patch:IDataInput) : void
      {
         var chongZhi:int = 0;
         var status1:int = 0;
         var status2:int = 0;
         var status3:int = 0;
         var status4:int = 0;
         var status5:int = 0;
         var oldPB:OldPlayerBack = null;
         chongZhi = patch.readInt();
         status1 = patch.readByte();
         status2 = patch.readByte();
         status3 = patch.readByte();
         status4 = patch.readByte();
         status5 = patch.readByte();
         oldPB = Singleton.getInstance(OldPlayerBack) as OldPlayerBack;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(oldPB,function():void
         {
            oldPB.showView(_time,1,1,status1,status2,status3,3,chongZhi,status4,status5);
         });
      }
      
      public function GC_QQXUANFENG_TIP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var pnl:QQXuanFeng = Singleton.getInstance(QQXuanFeng) as QQXuanFeng;
         pnl.status = result;
      }
      
      public function GC_QQXUANFENG_GETAWARD(patch:IDataInput) : void
      {
         var pnl:QQXuanFeng = null;
         var result:int = patch.readByte();
         if(result == 1)
         {
            pnl = Singleton.getInstance(QQXuanFeng) as QQXuanFeng;
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
            {
               pnl.getEff();
            });
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("背包已满");
         }
      }
      
      public function GC_OPEN_CIRI_GF(patch:IDataInput) : void
      {
         var status:int = 0;
         var status1:int = patch.readByte();
         isShowHd(status1 == 1);
         var len:int = patch.readByte();
         var dataA:Array = [];
         var i:int = 0;
         while(i < len)
         {
            status = patch.readByte();
            dataA.push(status);
            Vo_tomorrDaygf.statusDic[i + 1] = status;
            i++;
         }
         TomGifICon.dealWidData(dataA);
         if(TomDayGift.isVisible)
         {
            TomDayGift.instance.update(dataA);
         }
      }
      
      public function GC_GET_CIRI_GF(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var xiaBiao:int = patch.readByte();
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功");
            TomDayGift.itemVec[xiaBiao].getAword();
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("未达标");
         }
      }
      
      private function GC_CIRI_BROADCAST(patch:IDataInput) : void
      {
         var roleId:Number = LongUtil.readLong(patch);
         var roleName:String = patch.readUTF();
         var day:int = patch.readByte();
         var str1:String = HtmlUtil.font("江湖   ","#ffffff",12) + HtmlUtil.font(HtmlUtil.link(HtmlUtil.underLine(roleName),roleId.toString()),"#afe4e4") + "参与登录有礼活动，再登录一天即可领取" + HtmlUtil.font("炫酷坐骑飞天猪","#04ff00") + HtmlUtil.font(HtmlUtil.link(HtmlUtil.underLine("【我要领取】"),"tomorrDayGift"),"#afe4e4");
         var str2:String = HtmlUtil.font("江湖   ","#ffffff",12) + HtmlUtil.font(HtmlUtil.link(HtmlUtil.underLine(roleName),roleId.toString()),"#afe4e4") + "在登录有礼活动中获得" + HtmlUtil.font("炫酷坐骑飞天猪","#04ff00") + HtmlUtil.font(HtmlUtil.link(HtmlUtil.underLine("【我要领取】"),"tomorrDayGift"),"#afe4e4");
         var arr:Array = [str1,str2];
         var str:String = StringUtil.substitute(arr[day] as String,roleName);
         UIManager.chatPanel.add(str,roleId,1,roleName);
      }
      
      public function GC_HUOYUEDU_APPLY(patch:IDataInput) : void
      {
         var len_B:int;
         var dataArrL:Array = null;
         var i:int = 0;
         var curHuoYueDu:int = 0;
         var dataArrM:Array = null;
         var pan:HuoYueDuPan = null;
         var len:int = 20;
         dataArrL = [];
         i = 0;
         while(i < len)
         {
            dataArrL.push(patch.readByte());
            i++;
         }
         curHuoYueDu = patch.readByte();
         len_B = 5;
         dataArrM = [];
         i = 0;
         while(i < len_B)
         {
            dataArrM.push(patch.readByte());
            i++;
         }
         HuoYueMter.dataArrM = dataArrM;
         HuoYueDuTip.instance.handle(dataArrM);
         pan = Singleton.getInstance(HuoYueDuPan) as HuoYueDuPan;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
         {
            pan.update(dataArrL,curHuoYueDu,dataArrM);
         });
      }
      
      public function GC_HUOYUEDU_GETAWARD(patch:IDataInput) : void
      {
         var _type:int = 0;
         var pan:HuoYueDuPan = null;
         _type = patch.readByte();
         pan = Singleton.getInstance(HuoYueDuPan) as HuoYueDuPan;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
         {
            if(pan.visible)
            {
               pan.getAward(_type);
            }
         });
      }
      
      public function GC_HUOYUEDU_JOIN(patch:IDataInput) : void
      {
         var pan:HuoYueDuPan = null;
         var _type:int = patch.readByte();
         var result:int = patch.readByte();
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("活动还没开始");
         }
         else if(result == 1)
         {
            pan = Singleton.getInstance(HuoYueDuPan) as HuoYueDuPan;
            pan.applyJoin(_type);
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("你还没有帮会哦");
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("要通关通天峰后才可开启此活动哦，亲！");
         }
      }
      
      public function REMIND_HUOYUEDU(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            HuoYueDuTip.instance.addEff();
         }
         else if(result == 0)
         {
            HuoYueDuTip.instance.removeEff();
         }
      }
      
      public function GC_ISSHOW_HUOYUE_ICON(patch:IDataInput) : void
      {
         HuoYueDuTip.instance.show();
      }
      
      public function GC_DROPEGGS_CTRL(patch:IDataInput) : void
      {
         UIManager.centerBroadcast.addMsg("不在活动时间内");
      }
      
      public function GC_ISHOWCAIFUTONG(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CFTTips.showTip(result == 1);
      }
   }
}

