package com.yiTian.net.message.gc
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.YellowDiaHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.cast.baishiZengyi.View_baoshiZY;
   import com.yiTian.view.modules.guide.View_guide;
   import com.yiTian.view.modules.yellowDiamond.Model_txAction;
   import com.yiTian.view.modules.yellowDiamond.View_TJdaLIbao;
   import com.yiTian.view.modules.yellowDiamond.View_hzTribute;
   import com.yiTian.view.modules.yellowDiamond.View_qqHuiyuan;
   import com.yiTian.view.modules.yellowDiamond.XinyueTip;
   import com.yiTian.view.modules.yellowDiamond.newAct.NewYearAct;
   import com.yiTian.view.modules.yellowDiamond.newAct.NewYearActTip;
   import com.yiTian.view.modules.yellowDiamond.newAct.QZoneGift;
   import flash.utils.IDataInput;
   
   public class YelloDiaGCMessage
   {
      
      public static var TJ_type:int;
      
      public static var statusSave:int;
      
      public static var isTrue:Boolean = false;
      
      private var arr:Array = ["恭喜你宝石增益成功","没有可镶嵌宝石的装备，不能进行宝石镶刻","身上装备耐久为0，不能镶嵌宝石","宝石等级已满"];
      
      private var tipsArr:Array = ["背包不够","领取成功"];
      
      public function YelloDiaGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_YELLOWDIAMOND] = this.GC_YELLOWDIAMOND;
         index[MessageType.GC_YELLOWDIAMOND_AWARD] = this.GC_YELLOWDIAMOND_AWARD;
         index[MessageType.GC_YELLOWDIAMOND_EFF] = this.GC_YELLOWDIAMOND_EFF;
         index[MessageType.GC_OPEN_QQGIFT] = this.GC_OPEN_QQGIFT;
         index[MessageType.GC_GET_QQGIFT] = this.GC_GET_QQGIFT;
         index[MessageType.GC_KUANGHUAN_GIFT] = this.GC_KUANGHUAN_GIFT;
         index[MessageType.GC_KUANGHUAN_GET_GIFT] = this.GC_KUANGHUAN_GET_GIFT;
         index[MessageType.GC_OLD_PLAYERS_RETURN] = this.GC_OLD_PLAYERS_RETURN;
         index[MessageType.GC_OLD_PLAYERS_RETURN_GETGOODS] = this.GC_OLD_PLAYERS_RETURN_GETGOODS;
         index[MessageType.GC_XIANSHI_HUODONG] = this.GC_XIANSHI_HUODONG;
         index[MessageType.GC_XIANSHI_HUODONG_3366] = this.GC_XIANSHI_HUODONG_3366;
         index[MessageType.GC_XIANSHI_GET] = this.GC_XIANSHI_GET;
         index[MessageType.GC_XIANSHI_GET_3366] = this.CG_XIANSHI_GET_3366;
         index[MessageType.GC_OPEN_AIWAN_GIFT] = this.GC_OPEN_AIWAN_GIFT;
         index[MessageType.GC_GET_AIWAN_GIFT] = this.GC_GET_AIWAN_GIFT;
         index[MessageType.GC_OPEN_CHITU_GIFT] = this.GC_OPEN_CHITU_GIFT;
         index[MessageType.GC_GET_CHITU_GIFT] = this.GC_GET_CHITU_GIFT;
         index[MessageType.GC_HZ_XIANLI_GIFT] = this.GC_HZ_XIANLI_GIFT;
         index[MessageType.GC_LZ_XIANLI_GIFT] = this.GC_LZ_XIANLI_GIFT;
         index[MessageType.GC_TUIJIAN_DALIBAO] = this.GC_TUIJIAN_DALIBAO;
         index[MessageType.GC_TUIJIAN_LIBAO_SEND] = this.GC_TUIJIAN_LIBAO_SEND;
         index[MessageType.GC_OPEN_HONGZUAN] = this.GC_OPEN_HONGZUAN;
         index[MessageType.GC_SHOW_XINYUE_TIP] = this.GC_SHOW_XINYUE_TIP;
         index[MessageType.GC_GET_XINYUE_GIFT] = this.GC_GET_XINYUE_GIFT;
         index[MessageType.GC_SET_XINYUE] = this.GC_SET_XINYUE;
         index[MessageType.GC_ICON_HIDE_SEND] = this.GC_ICON_HIDE_SEND;
         index[MessageType.GC_QQZONE_GIFT] = this.GC_QQZONE_GIFT;
         index[MessageType.GC_QQZONE_GET_GIFT] = this.GC_QQZONE_GET_GIFT;
         index[MessageType.GC_BAISHI_QIANKE] = this.GC_BAISHI_QIANKE;
         index[MessageType.GC_SHOW_FESTIVAL_TIP] = this.GC_SHOW_FESTIVAL_TIP;
         index[MessageType.GC_CUR_OPEN_ACT] = this.GC_CUR_OPEN_ACT;
         index[MessageType.GC_GET_NEWYEAR_AWARD] = this.GC_GET_NEWYEAR_AWARD;
         index[MessageType.GC_HUANGZUAN_XF_SHOWPAN] = this.GC_HUANGZUAN_XF_SHOWPAN;
         index[MessageType.GC_HUANGZUAN_XF_ASK] = this.GC_HUANGZUAN_XF_ASK;
         index[MessageType.GC_HONGZUAN_ICON_CTR] = this.GC_HONGZUAN_ICON_CTR;
      }
      
      public function GC_YELLOWDIAMOND(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(!result)
         {
            return;
         }
         var isDiaCustor:int = patch.readByte();
         var isYeaDiaCustor:int = patch.readByte();
         var DiaLevel:int = patch.readByte();
         var canLvlGoodsGet:int = patch.readByte();
         var canLvlGrowGoodsGet:int = patch.readByte();
         var yeaCostCanGet:int = patch.readByte();
         var haohua:int = patch.readByte();
         var yeaNewsCanGet:int = patch.readByte();
         var _level:int = patch.readShort();
         var isYellowPetCanGet:int = patch.readByte();
         YellowDiaHandle.YelloDiaGCMessage(isDiaCustor,isYeaDiaCustor,DiaLevel,canLvlGoodsGet,canLvlGrowGoodsGet,yeaCostCanGet,yeaNewsCanGet,_level,isYellowPetCanGet,haohua);
      }
      
      public function GC_YELLOWDIAMOND_AWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(!result)
         {
            return;
         }
         var type:int = patch.readByte();
         var _level:int = patch.readShort();
         var canGetAward:int = patch.readByte();
         YellowDiaHandle.GC_YELLOWDIAMOND_AWARD(type,_level,canGetAward);
      }
      
      public function GC_YELLOWDIAMOND_EFF(patch:IDataInput) : void
      {
         YellowDiaHandle.GC_YELLOWDIAMOND_EFF();
      }
      
      public function GC_OPEN_QQGIFT(patch:IDataInput) : void
      {
         var days:int = patch.readShort();
         var status:int = patch.readByte();
         YellowDiaHandle.GC_OPEN_QQGIFT(days,status);
      }
      
      public function GC_GET_QQGIFT(patch:IDataInput) : void
      {
         YellowDiaHandle.GC_GET_QQGIFT();
      }
      
      public function GC_GET_AIWAN_GIFT(patch:IDataInput) : void
      {
         YellowDiaHandle.GC_GET_AIWAN_GIFT();
      }
      
      public function GC_KUANGHUAN_GIFT(patch:IDataInput) : void
      {
         YellowDiaHandle.GC_KUANGHUAN_GIFT();
      }
      
      public function GC_KUANGHUAN_GET_GIFT(patch:IDataInput) : void
      {
         YellowDiaHandle.GC_KUANGHUAN_GET_GIFT();
      }
      
      public function GC_OLD_PLAYERS_RETURN(patch:IDataInput) : void
      {
         YellowDiaHandle.GC_OLD_PLAYERS_RETURN();
      }
      
      public function GC_OLD_PLAYERS_RETURN_GETGOODS(patch:IDataInput) : void
      {
         YellowDiaHandle.GC_OLD_PLAYERS_RETURN_GETGOODS();
      }
      
      public function GC_XIANSHI_HUODONG(patch:IDataInput) : void
      {
         var _arr:Array = null;
         var result:int = patch.readByte();
         if(!result)
         {
            return;
         }
         var leastLvl:int = patch.readShort();
         var startTime:String = patch.readUTF();
         var endTime:String = patch.readUTF();
         var len:int = patch.readByte();
         var dataArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            _arr = [];
            _arr.push(patch.readByte());
            _arr.push(patch.readInt());
            _arr.push(patch.readByte());
            dataArr.push(_arr);
            i++;
         }
         YellowDiaHandle.GC_XIANSHI_HUODONG(leastLvl,startTime,endTime,dataArr);
      }
      
      public function GC_XIANSHI_HUODONG_3366(patch:IDataInput) : void
      {
         this.GC_XIANSHI_HUODONG(patch);
      }
      
      public function GC_XIANSHI_GET(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         YellowDiaHandle.GC_XIANSHI_GET(result);
      }
      
      public function CG_XIANSHI_GET_3366(patch:IDataInput) : void
      {
         this.GC_XIANSHI_GET(patch);
      }
      
      public function GC_OPEN_AIWAN_GIFT(patch:IDataInput) : void
      {
         var days:int = patch.readShort();
         var status:int = patch.readByte();
         Utils.print("参数错误打印：","登陆天数：",days.toString(),"    状态：",status.toString());
         YellowDiaHandle.GC_OPEN_AIWAN_GIFT(days,status);
      }
      
      public function GC_OPEN_CHITU_GIFT(patch:IDataInput) : void
      {
         var days:int = patch.readShort();
         var status:int = patch.readByte();
         YellowDiaHandle.GC_OPEN_CHITU_GIFT(days,status);
      }
      
      public function GC_GET_CHITU_GIFT(patch:IDataInput) : void
      {
         YellowDiaHandle.GC_GET_CHITU_GIFT();
      }
      
      public function GC_HZ_XIANLI_GIFT(patch:IDataInput) : void
      {
         if(Global.pf == Enum_SPStr.QQ3366 || Global.pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.GUANWANG)
         {
            return;
         }
         var times:int = patch.readByte();
         if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.QQGAME || Enum_SPStr.isIwan(Global.pf))
         {
            View_hzTribute.times = times;
         }
      }
      
      public function GC_LZ_XIANLI_GIFT(patch:IDataInput) : void
      {
         if(Global.pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.GUANWANG)
         {
            return;
         }
         var times:int = patch.readByte();
         Utils.print("协议20046:","蓝钻" + times);
         if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQ3366 || Enum_SPStr.isIwan(Global.pf))
         {
            View_hzTribute.times = times;
         }
      }
      
      public function GC_TUIJIAN_DALIBAO(patch:IDataInput) : void
      {
         var ss:String = null;
         var _arr:Array = null;
         var _pan:View_guide = null;
         var timeStart:String = null;
         var timeEnd:String = null;
         var pan:View_TJdaLIbao = null;
         var _daraS:String = patch.readUTF();
         var witchIn:int = patch.readByte();
         var usersType:int = patch.readByte();
         var _dataArr:Array = _daraS.split(",");
         var len:int = int(_dataArr.length);
         var data:Array = [];
         var i:int = 0;
         while(i < len)
         {
            ss = _dataArr[i];
            _arr = ss.split("_");
            data.push([_arr[0],_arr[1],_arr[2]]);
            i++;
         }
         TJ_type = usersType;
         if(usersType == 0)
         {
            if(Boolean(Global.objPan) && Global.objPan is View_guide)
            {
               _pan = Global.objPan as View_guide;
               _pan.initSource(data);
            }
         }
         else if(usersType == 1)
         {
            timeStart = patch.readUTF();
            timeEnd = patch.readUTF();
            pan = Singleton.getInstance(View_TJdaLIbao) as View_TJdaLIbao;
            pan.show(data,timeStart,timeEnd);
            pan.initSource();
         }
      }
      
      public function GC_TUIJIAN_LIBAO_SEND(patch:IDataInput) : void
      {
         var pan:View_guide = null;
         var _pan:View_TJdaLIbao = null;
         var result:int = patch.readByte();
         if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("背包已满");
         }
         else if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功");
            if(TJ_type == 0)
            {
               if(Boolean(Global.objPan) && Global.objPan is View_guide)
               {
                  pan = Global.objPan as View_guide;
                  pan.getAwards();
               }
            }
            else if(TJ_type == 1)
            {
               _pan = Singleton.getInstance(View_TJdaLIbao) as View_TJdaLIbao;
               _pan.getAwards();
            }
         }
      }
      
      public function GC_OPEN_HONGZUAN(patch:IDataInput) : void
      {
         var pan:View_hzTribute = null;
         var statusHZ:int = patch.readByte();
         var getStatus:int = patch.readByte();
         pan = Singleton.getInstance(View_hzTribute) as View_hzTribute;
         pan.hzGetStatus = getStatus == 0;
         pan.statusHZ = statusHZ == 1;
         if(statusHZ == 1 && getStatus == 1)
         {
            if(pan.visible)
            {
               pan.visible = false;
            }
            View_qqHuiyuan.instance.remove();
         }
         if(pan.visible)
         {
            return;
         }
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
         {
            pan.show();
         });
      }
      
      public function GC_SHOW_XINYUE_TIP(patch:IDataInput) : void
      {
         var tip:XinyueTip = null;
         if(Global.pf == Enum_SPStr.GUANWANG)
         {
            tip = XinyueTip.instance;
            tip.show();
         }
      }
      
      public function GC_GET_XINYUE_GIFT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功，请查看邮件");
         }
         else
         {
            UIManager.centerBroadcast.addMsg("已经领取过礼包了");
         }
         var tip:XinyueTip = XinyueTip.instance;
         tip.remove();
      }
      
      public function GC_SET_XINYUE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            if(GameUnitManager.hero.isShow == 1)
            {
               UIManager.centerBroadcast.addMsg("您已设置心悦徽章正常显示");
            }
            else
            {
               UIManager.centerBroadcast.addMsg("您已设置心悦徽章不被显示");
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg("设置失败");
         }
      }
      
      public function GC_QQZONE_GIFT(patch:IDataInput) : void
      {
         var type:int = 0;
         var id:int = 0;
         var count:int = 0;
         QZoneGift.instance.show();
         var _arr:Array = [];
         var leastLvl:int = patch.readShort();
         var startTime:String = patch.readUTF();
         var endTime:String = patch.readUTF();
         var len:int = patch.readByte();
         var i:int = 0;
         while(i < len)
         {
            type = patch.readByte();
            id = patch.readInt();
            count = patch.readByte();
            _arr.push([type,id,count]);
            i++;
         }
         Model_txAction.QZoneArr = _arr;
         Model_txAction.startTime = startTime;
         Model_txAction.endTime = endTime;
         Model_txAction.leastLvl = leastLvl;
      }
      
      public function GC_QQZONE_GET_GIFT(patch:IDataInput) : void
      {
         UIManager.xshdPan.getData();
         QZoneGift.instance.remove();
      }
      
      public function GC_BAISHI_QIANKE(patch:IDataInput) : void
      {
         var pan:View_baoshiZY = null;
         var result:int = patch.readByte();
         if(result == 1)
         {
            isTrue = true;
            pan = Singleton.getInstance(View_baoshiZY) as View_baoshiZY;
            pan.getSeEff();
            return;
         }
         UIManager.centerBroadcast.addMsg(this.arr[result - 1]);
      }
      
      public function GC_ICON_HIDE_SEND(patch:IDataInput) : void
      {
         trace("没处理？");
      }
      
      public function GC_SHOW_FESTIVAL_TIP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         statusSave = result;
         if(GameUnitManager.hero.level < 30)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.lvHd);
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.lvHd);
         NewYearActTip.instance.show(result == 1);
         if(result == 0)
         {
            NewYearAct.instance.hide();
         }
      }
      
      private function lvHd() : void
      {
         if(GameUnitManager.hero.level >= 30)
         {
            if(statusSave == 1)
            {
               NewYearActTip.instance.show(true);
               Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.lvHd);
            }
         }
      }
      
      public function GC_CUR_OPEN_ACT(patch:IDataInput) : void
      {
         var curAct:int = patch.readByte();
         var isLan:int = patch.readByte();
         var isGet:int = patch.readByte();
         NewYearAct.instance.show(curAct,isLan,isGet);
      }
      
      public function GC_GET_NEWYEAR_AWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         UIManager.centerBroadcast.addMsg(this.tipsArr[result]);
         NewYearAct.instance.getAwards();
      }
      
      private function GC_HUANGZUAN_XF_SHOWPAN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var roleName:String = Model_heFu.repNameByHero(patch.readUTF());
         YellowDiaHandle.GC_HUANGZUAN_XF_SHOWPAN(result,roleName);
      }
      
      private function GC_HUANGZUAN_XF_ASK(patch:IDataInput) : void
      {
         var isEnable:int = patch.readByte();
         YellowDiaHandle.GC_HUANGZUAN_XF_ASK(isEnable);
      }
      
      private function GC_HONGZUAN_ICON_CTR(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            View_qqHuiyuan.instance.show();
         }
         else
         {
            View_qqHuiyuan.instance.remove();
         }
      }
   }
}

