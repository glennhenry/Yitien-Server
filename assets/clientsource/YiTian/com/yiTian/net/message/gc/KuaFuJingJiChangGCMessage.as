package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_KuaFuJingJiChang;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.net.message.cg.KuaFuJingJiChangCGMessage;
   import com.yiTian.view.modules.kuafujingjichang.DRKFRank;
   import com.yiTian.view.modules.kuafujingjichang.DRKFjoinPanel;
   import com.yiTian.view.modules.kuafujingjichang.DRKFlawPanel;
   import com.yiTian.view.modules.kuafujingjichang.DRKFlistPanel;
   import com.yiTian.view.modules.kuafujingjichang.KuaFuJJCVO;
   import com.yiTian.view.modules.kuafujingjichang.MyTeamVo;
   import com.yiTian.view.modules.kuafujingjichang.PingLunVO;
   import com.yiTian.view.modules.kuafujingjichang.SeachPanel;
   import com.yiTian.view.modules.kuafujingjichang.TeamPanel;
   import com.yiTian.view.modules.kuafujingjichang.TeamVo;
   import com.yiTian.view.modules.kuafujingjichang.XiaYiShop;
   import com.yiTian.view.modules.kuafujingjichang.YaoQingPanel;
   import com.yiTian.view.modules.kuafujingjichang.YaoQingVO;
   import com.yiTian.view.modules.kuafujingjichang.extralDill.Model_DRKF;
   import com.yiTian.view.modules.kuafujingjichang.jieshouPanel;
   import com.yiTian.view.modules.kuafujingjichang.passwordPanel;
   import flash.utils.IDataInput;
   
   public class KuaFuJingJiChangGCMessage
   {
      
      public function KuaFuJingJiChangGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_KUAFUJJC_SEE] = GC_KUAFUJJC_SEE;
         index[MessageType.GC_KUAFUJJC_OPEN] = this.GC_KUAFUJJC_OPEN;
         index[MessageType.GC_KUAFUJJC_TEAM] = this.GC_KUAFUJJC_TEAM;
         index[MessageType.GC_KUAFUJJC_VALUE] = this.GC_KUAFUJJC_VALUE;
         index[MessageType.GC_KUAFUTEAM_NEW] = this.GC_KUAFUTEAM_NEW;
         index[MessageType.GC_KUAFUTEAM_JOIN] = this.GC_KUAFUTEAM_JOIN;
         index[MessageType.GC_LEAVE_DRKFTEAM] = this.GC_LEAVE_DRKFTEAM;
         index[MessageType.GC_KUAFUTEAM_REVISE] = this.GC_KUAFUTEAM_REVISE;
         index[MessageType.GC_KUAFUTEAM_CHECK] = this.GC_KUAFUTEAM_CHECK;
         index[MessageType.GC_KUAFUADD_QUICK] = this.GC_KUAFUADD_QUICK;
         index[MessageType.GC_KUAFUTEAM_INVITED] = this.GC_KUAFUTEAM_INVITED;
         index[MessageType.GC_KUAFUTEAM_YAOQING] = this.GC_KUAFUTEAM_YAOQING;
         index[MessageType.GC_YAOQING_JIESHOU] = this.GC_YAOQING_JIESHOU;
         index[MessageType.GC_YAOQING_TONGYI] = this.GC_YAOQING_TONGYI;
         index[MessageType.GC_DUIYUAN_READY] = this.GC_DUIYUAN_READY;
         index[MessageType.GC_DUIZHANG_STAR] = this.GC_DUIZHANG_STAR;
         index[MessageType.GC_BIANHUAN_LAW] = this.GC_BIANHUAN_LAW;
         index[MessageType.GC_TEAM_TS] = this.GC_TEAM_TS;
         index[MessageType.GC_KUAFUJJC_GETVALUE] = this.GC_KUAFUJJC_GETVALUE;
         index[MessageType.GC_PLAYER_VALUE] = this.GC_PLAYER_VALUE;
         index[MessageType.GC_SHOP_XIAYI] = this.GC_SHOP_XIAYI;
         index[MessageType.GC_TIAOZHAN_FAQI] = this.GC_TIAOZHAN_FAQI;
         index[MessageType.GC_TIAOZHAN_CLICK] = this.GC_TIAOZHAN_CLICK;
         index[MessageType.GC_TIAOZHAN_REMOVE] = this.GC_TIAOZHAN_REMOVE;
         index[MessageType.GC_TIAOZHAN_ADD] = this.GC_TIAOZHAN_ADD;
         index[MessageType.GC_STAR_PAIHANG] = this.GC_STAR_PAIHANG;
         index[MessageType.GC_STAR_PINGJIA] = this.GC_STAR_PINGJIA;
         index[MessageType.GC_GUANGBO_PINGJIA] = this.GC_GUANGBO_PINGJIA;
         index[MessageType.GC_KUAFU_JUMPBATTLE] = this.GC_KUAFU_JUMPBATTLE;
      }
      
      public static function GC_KUAFUJJC_SEE(patch:IDataInput) : void
      {
         KuaFuJJCVO.see = patch.readByte();
         UIManager.kuafuBtn.show();
      }
      
      public function GC_BIANHUAN_LAW(patch:IDataInput) : void
      {
         var id:int = 0;
         var type:int = 0;
         var chengGong:int = patch.readByte();
         id = patch.readInt();
         KuaFuJJCVO.weiZhi = patch.readUTF();
         type = patch.readInt();
         Model_KuaFuJingJiChang.zfId = id;
         if(chengGong == 1)
         {
            DRKFlawPanel.instance.visible = false;
            TeamPanel.instance.updateZhenFa(id,KuaFuJJCVO.weiZhi,type);
            UIManager.centerBroadcast.addMsg("保存成功");
         }
         else if(chengGong == 2)
         {
            UIManager.centerBroadcast.addMsg("未学习该阵法");
         }
      }
      
      public function GC_KUAFUJJC_OPEN(patch:IDataInput) : void
      {
         KuaFuJJCVO.click = patch.readByte();
         KuaFuJJCVO.isPanel = patch.readByte();
         if(KuaFuJJCVO.click == 0)
         {
            UIManager.centerBroadcast.addMsg("失败");
         }
         else if(KuaFuJJCVO.click == 1)
         {
            if(KuaFuJJCVO.isPanel != 1)
            {
               if(KuaFuJJCVO.isPanel == 2)
               {
                  KuaFuJingJiChangCGMessage.CG_KUAFUOPEN_YES();
               }
            }
         }
         else if(KuaFuJJCVO.click == 2)
         {
            UIManager.centerBroadcast.addMsg("不够等级");
         }
         else if(KuaFuJJCVO.click == 4)
         {
            UIManager.centerBroadcast.addMsg("已有队伍");
         }
         else if(KuaFuJJCVO.click == 3)
         {
            UIManager.centerBroadcast.addMsg("请在每日的16:00-17:00/22:00-24:00进入。");
         }
      }
      
      public function GC_KUAFUJJC_TEAM(patch:IDataInput) : void
      {
         var i:int;
         var j:int;
         var vo:TeamVo = null;
         var curPage:int = 0;
         if(SeachPanel.instance.visible)
         {
            return;
         }
         Model_KuaFuJingJiChang.listVo = [];
         KuaFuJJCVO.len = patch.readInt();
         i = 0;
         while(i < KuaFuJJCVO.len)
         {
            vo = new TeamVo();
            vo.team_id = patch.readInt();
            vo.team_name = patch.readUTF();
            vo.team_type = patch.readInt();
            vo.captain_id = LongUtil.readLong(patch);
            vo.captain_name = patch.readUTF();
            vo.captain_job = patch.readInt();
            vo.captain_sex = patch.readInt();
            vo.team_num = patch.readInt();
            vo.status = patch.readByte();
            vo.password = patch.readByte();
            Model_KuaFuJingJiChang.listVo.push(vo);
            i++;
         }
         Model_KuaFuJingJiChang.teamlist = [];
         j = 0;
         while(j < Model_KuaFuJingJiChang.listVo.length)
         {
            curPage = j / 6;
            if(!Model_KuaFuJingJiChang.teamlist[curPage])
            {
               Model_KuaFuJingJiChang.teamlist[curPage] = [];
            }
            Model_KuaFuJingJiChang.teamlist[curPage].push(Model_KuaFuJingJiChang.listVo[j]);
            j++;
         }
         DRKFjoinPanel.instance.visible = false;
         Global.delegate.dosomething(DRKFlistPanel.instance,function():void
         {
            DRKFlistPanel.instance.update();
            if(!DRKFlistPanel.instance.visible)
            {
               DRKFlistPanel.instance.visible = true;
            }
            if(KuaFuJJCVO.isPage)
            {
               if(KuaFuJJCVO.len != 0)
               {
                  DRKFlistPanel.instance.shuaxin();
               }
            }
         });
      }
      
      public function GC_KUAFUJJC_VALUE(patch:IDataInput) : void
      {
         var len:int;
         var i:int;
         var vo:MyTeamVo = null;
         Model_KuaFuJingJiChang.myTeamVo.length = 0;
         Model_KuaFuJingJiChang.team_id = patch.readInt();
         Model_KuaFuJingJiChang.team_Type = patch.readInt();
         Model_KuaFuJingJiChang.team_captain_id = LongUtil.readLong(patch);
         len = patch.readInt();
         Model_KuaFuJingJiChang.myTeamMembers = {};
         i = 0;
         while(i < len)
         {
            vo = new MyTeamVo();
            vo.id = LongUtil.readLong(patch);
            vo.name = patch.readUTF();
            vo.job = patch.readInt();
            vo.level = patch.readInt();
            vo.sex = patch.readByte();
            vo.num = patch.readInt();
            vo.isCaptain = patch.readInt();
            vo.zhanLi = patch.readInt();
            vo.Fashion = patch.readInt();
            vo.wuQi = patch.readInt();
            vo.zhenFa = patch.readUTF();
            vo.zhenFaArr = vo.zhenFa.split("_");
            vo.notZhenFa = patch.readUTF();
            vo.notZhenFaArr = vo.notZhenFa.split("_");
            vo.petValue = LongUtil.readLong(patch);
            vo.petId = patch.readInt();
            vo.petName = patch.readUTF();
            vo.petLevel = patch.readInt();
            vo.petHp = patch.readUTF();
            vo.heroHp = patch.readUTF();
            vo.heroMp = patch.readUTF();
            vo.wing = patch.readInt();
            vo.str_icon = (23020 + vo.job * 100 + vo.sex).toString();
            vo.petHpArr = vo.petHp.split("_");
            vo.heroHpArr = vo.heroHp.split("_");
            vo.heroMpArr = vo.heroMp.split("_");
            if(vo.id == GameUnitManager.hero.id && vo.isCaptain == 0)
            {
               Model_KuaFuJingJiChang.isCaptain = true;
            }
            Model_KuaFuJingJiChang.myTeamVo.push(vo);
            Model_KuaFuJingJiChang.myTeamMembers[vo.id] = vo;
            i++;
         }
         Model_KuaFuJingJiChang.myTeamVo.sort(function(o1:Object, o2:Object):int
         {
            return o1.isCaptain < o2.isCaptain ? -1 : 1;
         });
         vo.nowZhenFa = patch.readInt();
         vo.position = patch.readUTF();
         KuaFuJJCVO.weiZhi = vo.position;
         Global.delegate.dosomething(TeamPanel.instance,function():void
         {
            TeamPanel.instance.show();
            TeamPanel.instance.updateZhenFa(Model_KuaFuJingJiChang.team_id,vo.position,vo.nowZhenFa);
            if(TeamPanel.instance.readyBtn.enabled == false)
            {
               return;
            }
            TeamPanel.instance.isZDready();
         });
      }
      
      public function GC_KUAFUTEAM_NEW(patch:IDataInput) : void
      {
         KuaFuJJCVO.result = patch.readInt();
         switch(KuaFuJJCVO.result)
         {
            case 1:
               Global.delegate.dosomething(DRKFlistPanel.instance,function():void
               {
                  DRKFlistPanel.instance.visible = false;
                  if(Boolean(TeamPanel.instance.starBtn))
                  {
                     TeamPanel.instance.starBtn.visible = true;
                  }
                  if(Boolean(TeamPanel.instance.tiaoZhantf))
                  {
                     TeamPanel.instance.tiaoZhantf.visible = true;
                  }
               });
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("不够等级");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("次数已用完");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("已有队伍");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("场景不符");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("状态不符");
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("队伍已满人");
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("队伍不存在");
               break;
            case 9:
               UIManager.centerBroadcast.addMsg("正在撮合");
         }
      }
      
      public function GC_KUAFUTEAM_JOIN(patch:IDataInput) : void
      {
         KuaFuJJCVO.join = patch.readInt();
         switch(KuaFuJJCVO.join)
         {
            case 1:
               Global.delegate.dosomething(DRKFlistPanel.instance,function():void
               {
                  DRKFlistPanel.instance.visible = false;
                  passwordPanel.instance.hide();
               });
               Global.delegate.dosomething(UIManager.team,UIManager.team.show);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("不够等级");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("次数已用完");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("已有队伍");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("场景不符");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("状态不符");
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("队伍已满人");
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("队伍不存在");
               break;
            case 9:
               UIManager.centerBroadcast.addMsg("队伍正在撮合中");
               break;
            case 10:
               UIManager.centerBroadcast.addMsg("存在密码");
               break;
            case 11:
               UIManager.centerBroadcast.addMsg("密码不正确");
               break;
            case 12:
               UIManager.centerBroadcast.addMsg("正在撮合中");
               break;
            case 13:
               UIManager.centerBroadcast.addMsg("正在寻找队伍");
         }
      }
      
      public function GC_LEAVE_DRKFTEAM(patch:IDataInput) : void
      {
         KuaFuJJCVO.isleave = patch.readByte();
         UIManager.team.leavegc();
      }
      
      public function GC_KUAFUTEAM_REVISE(patch:IDataInput) : void
      {
         var type:int;
         var vo:TeamVo;
         var len2:int;
         var j:int;
         var k:int = 0;
         var i:int = 0;
         var curPage:int = 0;
         if(DRKFlistPanel.instance.visible == false)
         {
            return;
         }
         type = patch.readInt();
         vo = new TeamVo();
         vo.team_id = patch.readInt();
         vo.team_name = patch.readUTF();
         vo.team_type = patch.readInt();
         vo.team_num = patch.readInt();
         vo.captain_id = LongUtil.readLong(patch);
         vo.captain_name = patch.readUTF();
         vo.captain_job = patch.readInt();
         vo.captain_sex = patch.readInt();
         vo.status = patch.readByte();
         vo.password = patch.readByte();
         if(vo.team_num == 3 && vo.status != 0)
         {
            vo.status = 3;
         }
         len2 = int(Model_KuaFuJingJiChang.listVo.length);
         loop4:
         switch(type)
         {
            case 1:
               Model_KuaFuJingJiChang.listVo.push(vo);
               break;
            case 2:
               k = 0;
               while(true)
               {
                  if(k >= Model_KuaFuJingJiChang.listVo.length)
                  {
                     break loop4;
                  }
                  if(Model_KuaFuJingJiChang.listVo[k].team_id == vo.team_id)
                  {
                     break;
                  }
                  k += 1;
               }
               Model_KuaFuJingJiChang.listVo.splice(k,1);
               Model_KuaFuJingJiChang.listVo.push(vo);
               break;
            case 3:
               i = 0;
               while(true)
               {
                  if(i >= Model_KuaFuJingJiChang.listVo.length)
                  {
                     break loop4;
                  }
                  if(Model_KuaFuJingJiChang.listVo[i].team_id == vo.team_id)
                  {
                     break;
                  }
                  i += 1;
               }
               Model_KuaFuJingJiChang.listVo.splice(i,1);
         }
         Model_KuaFuJingJiChang.teamlist = [];
         j = 0;
         while(j < Model_KuaFuJingJiChang.listVo.length)
         {
            curPage = j / 6;
            if(!Model_KuaFuJingJiChang.teamlist[curPage])
            {
               Model_KuaFuJingJiChang.teamlist[curPage] = [];
            }
            Model_KuaFuJingJiChang.teamlist[curPage].push(Model_KuaFuJingJiChang.listVo[j]);
            j++;
         }
         if(passwordPanel.instance.visible == true || SeachPanel.instance.visible == true)
         {
            return;
         }
         DRKFjoinPanel.instance.visible = false;
         Global.delegate.dosomething(DRKFlistPanel.instance,function():void
         {
            DRKFlistPanel.instance.update();
            if(KuaFuJJCVO.isPage)
            {
               if(KuaFuJJCVO.len != 0)
               {
                  DRKFlistPanel.instance.shuaxin();
               }
            }
         });
      }
      
      public function GC_KUAFUTEAM_CHECK(patch:IDataInput) : void
      {
         KuaFuJJCVO.check = patch.readByte();
         SeachPanel.instance.visible = false;
         switch(KuaFuJJCVO.check)
         {
            case 2:
               UIManager.centerBroadcast.addMsg("房间列表中未有该房间");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("已经在这个队伍中");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("队伍存在密码");
               Global.delegate.dosomething(passwordPanel.instance,passwordPanel.instance.show);
         }
      }
      
      public function GC_KUAFUADD_QUICK(patch:IDataInput) : void
      {
         KuaFuJJCVO.quickadd = patch.readByte();
         if(KuaFuJJCVO.quickadd == 1)
         {
            Global.delegate.dosomething(DRKFlistPanel.instance,function():void
            {
               DRKFlistPanel.instance.visible = false;
            });
         }
         else if(KuaFuJJCVO.quickadd == 2)
         {
            UIManager.centerBroadcast.addMsg("没有可加入的队伍");
         }
      }
      
      public function GC_KUAFUTEAM_INVITED(patch:IDataInput) : void
      {
         KuaFuJJCVO.FriendArr = [];
         KuaFuJJCVO.invited = patch.readByte();
         KuaFuJJCVO.type = patch.readByte();
         KuaFuJJCVO.YQlen = patch.readInt();
         var i:int = 0;
         while(i < KuaFuJJCVO.YQlen)
         {
            YaoQingVO.id = LongUtil.readLong(patch);
            YaoQingVO.name = patch.readUTF();
            YaoQingVO.level = patch.readShort();
            YaoQingVO.sex = patch.readByte();
            YaoQingVO.job = patch.readByte();
            KuaFuJJCVO.FriendArr.push(YaoQingVO.id);
            KuaFuJJCVO.FriendArr.push(YaoQingVO.name);
            KuaFuJJCVO.FriendArr.push(YaoQingVO.level);
            KuaFuJJCVO.FriendArr.push(YaoQingVO.sex);
            KuaFuJJCVO.FriendArr.push(YaoQingVO.job);
            i++;
         }
         YaoQingPanel.instance.remove();
         if(KuaFuJJCVO.type != 1)
         {
            YaoQingPanel.instance.updata();
         }
      }
      
      public function GC_KUAFUTEAM_YAOQING(patch:IDataInput) : void
      {
         KuaFuJJCVO.yaoqing = patch.readByte();
         UIManager.team.yaoqinggc();
      }
      
      public function GC_YAOQING_JIESHOU(patch:IDataInput) : void
      {
         KuaFuJJCVO.teamid = patch.readInt();
         KuaFuJJCVO.playerid = LongUtil.readLong(patch);
         KuaFuJJCVO.playername = patch.readUTF();
         KuaFuJJCVO.playersex = patch.readByte();
         Global.delegate.dosomething(jieshouPanel.instance,jieshouPanel.instance.show);
      }
      
      public function GC_YAOQING_TONGYI(patch:IDataInput) : void
      {
         KuaFuJJCVO.tongyi = patch.readByte();
         switch(KuaFuJJCVO.tongyi)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("邀请成功");
               jieshouPanel.instance.visible = false;
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("你已在队伍中");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("当前副本不可进入");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("队伍已不存在");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("不够等级");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("队伍已满人");
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("队伍已进入战斗");
         }
      }
      
      public function GC_DUIYUAN_READY(patch:IDataInput) : void
      {
         var idstr:String;
         var type:int = 0;
         var id:Number = NaN;
         KuaFuJJCVO.readyArr.length = 0;
         type = patch.readByte();
         id = LongUtil.readLong(patch);
         KuaFuJJCVO.ready = patch.readByte();
         idstr = patch.readUTF();
         KuaFuJJCVO.readyArr = idstr.split("_");
         Global.delegate.dosomething(TeamPanel.instance,function():void
         {
            if(KuaFuJJCVO.ready == 1 && type == 1 && GameUnitManager.hero.id == id)
            {
               if(TeamPanel.instance.ZDbox.selected == false)
               {
                  UIManager.centerBroadcast.addMsg("准备成功");
                  TeamPanel.instance.readyBtn.visible = false;
                  TeamPanel.instance.quxiaoBtn.visible = true;
               }
               else
               {
                  TeamPanel.instance.readyBtn.visible = false;
                  TeamPanel.instance.quxiaoBtn.visible = true;
               }
            }
            else if(KuaFuJJCVO.ready == 1 && type == 2 && GameUnitManager.hero.id == id)
            {
               UIManager.centerBroadcast.addMsg("取消成功");
               TeamPanel.instance.readyBtn.visible = true;
               TeamPanel.instance.quxiaoBtn.visible = false;
            }
            else if(KuaFuJJCVO.ready == 1 && type == 3 && GameUnitManager.hero.id == id)
            {
               if(!TeamPanel.instance.visible)
               {
                  if(TeamPanel.instance.ZDbox.visible)
                  {
                     TeamPanel.instance.readyBtn.visible = true;
                     TeamPanel.instance.quxiaoBtn.visible = false;
                  }
                  else
                  {
                     TeamPanel.instance.readyBtn.visible = false;
                     TeamPanel.instance.quxiaoBtn.visible = false;
                     TeamPanel.instance.starBtn.visible = true;
                     TeamPanel.instance.tiaoZhantf.visible = true;
                  }
               }
            }
            else if(KuaFuJJCVO.ready == 1 && type == 4 && GameUnitManager.hero.id == id)
            {
               if(TeamPanel.instance.ZDbox.visible && TeamPanel.instance.ZDbox.selected)
               {
                  TeamPanel.instance.readyBtn.visible = false;
                  TeamPanel.instance.quxiaoBtn.visible = true;
               }
               else if(!TeamPanel.instance.ZDbox.visible)
               {
                  TeamPanel.instance.readyBtn.visible = false;
                  TeamPanel.instance.quxiaoBtn.visible = false;
                  TeamPanel.instance.starBtn.visible = true;
                  TeamPanel.instance.tiaoZhantf.visible = true;
               }
            }
            TeamPanel.instance.ready();
         });
      }
      
      public function GC_DUIZHANG_STAR(patch:IDataInput) : void
      {
         KuaFuJJCVO.star = patch.readByte();
         switch(KuaFuJJCVO.star)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("开始匹配");
               TeamPanel.instance.starBtn.enabled = false;
               TeamPanel.instance.tiaoZhantf.visible = false;
               TeamPanel.instance.inviteBtn.enabled = false;
               TeamPanel.instance.readyBtn.enabled = false;
               TeamPanel.instance.quxiaoBtn.enabled = false;
               TeamPanel.instance.cuohe();
               TeamPanel.instance.isPlayerReady(true,0);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("没有找到合适的队伍");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("你不是队长");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("有队员没有准备");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("有队员等级不符");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("等10秒冷却时间");
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("队伍正在匹配中");
         }
      }
      
      public function GC_TEAM_TS(patch:IDataInput) : void
      {
         var isTs:int = patch.readByte();
         if(isTs == 1)
         {
            UIManager.centerBroadcast.addMsg("踢出成功");
         }
      }
      
      public function GC_KUAFUJJC_GETVALUE(patch:IDataInput) : void
      {
         var getScore:int = 0;
         var martialArts:int = 0;
         var f:Function = null;
         var finish:int = patch.readByte();
         getScore = patch.readInt();
         martialArts = patch.readInt();
         var lianShaNum:int = Boolean(patch.bytesAvailable) ? patch.readInt() : 0;
         Model_DRKF.lianShaNun = lianShaNum;
         if(finish == 1)
         {
            f = function():void
            {
               UIManager.centerBroadcast.addMsg("胜利,获得积分:" + getScore,1);
               UIManager.centerBroadcast.addMsg("获得侠义值:" + martialArts,1);
               Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,f);
            };
         }
         else if(finish == 0)
         {
            f = function():void
            {
               UIManager.centerBroadcast.addMsg("失败,减少积分:" + Math.abs(getScore),1);
               UIManager.centerBroadcast.addMsg("获得侠义值:" + martialArts,1);
               Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,f);
            };
         }
         else if(finish == 3)
         {
            UIManager.centerBroadcast.addMsg("在本次的撮合对手中，暂未撮合到对手，请重新选撮合");
         }
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,f);
         if(Boolean(TeamPanel.instance))
         {
            TeamPanel.instance.removecuohe();
         }
         if(Boolean(TeamPanel.instance))
         {
            TeamPanel.instance.removezhaoxun();
         }
         if(TeamPanel.instance.ZDbox.selected)
         {
            if(Boolean(TeamPanel.instance.readyBtn))
            {
               TeamPanel.instance.readyBtn.visible = false;
            }
            if(Boolean(TeamPanel.instance.readyBtn))
            {
               TeamPanel.instance.readyBtn.enabled = true;
            }
            if(Boolean(TeamPanel.instance.quxiaoBtn))
            {
               TeamPanel.instance.quxiaoBtn.enabled = true;
            }
            if(Boolean(TeamPanel.instance.quxiaoBtn))
            {
               TeamPanel.instance.quxiaoBtn.visible = true;
            }
            KuaFuJingJiChangCGMessage.CG_DUIYUAN_READY(1);
            return;
         }
         if(Boolean(TeamPanel.instance.quxiaoBtn))
         {
            TeamPanel.instance.quxiaoBtn.visible = false;
         }
         if(Boolean(TeamPanel.instance.readyBtn))
         {
            TeamPanel.instance.readyBtn.visible = true;
         }
         if(Boolean(TeamPanel.instance.starBtn))
         {
            TeamPanel.instance.starBtn.enabled = true;
         }
         if(Boolean(TeamPanel.instance.tiaoZhantf))
         {
            TeamPanel.instance.tiaoZhantf.visible = !TeamPanel.instance.ZDbox.visible;
         }
         if(Boolean(TeamPanel.instance.readyBtn))
         {
            TeamPanel.instance.readyBtn.enabled = true;
         }
         if(Boolean(TeamPanel.instance.inviteBtn))
         {
            TeamPanel.instance.inviteBtn.enabled = true;
         }
         if(Boolean(TeamPanel.instance.quxiaoBtn))
         {
            TeamPanel.instance.quxiaoBtn.enabled = true;
         }
         TeamPanel.instance.isZDready();
      }
      
      public function GC_PLAYER_VALUE(patch:IDataInput) : void
      {
         KuaFuJJCVO.paiming = patch.readInt();
         KuaFuJJCVO.jifen = patch.readInt();
         KuaFuJJCVO.wuxiazhi = patch.readInt();
         KuaFuJJCVO.cishu = patch.readInt();
         Global.delegate.dosomething(TeamPanel.instance,TeamPanel.instance.updata);
         Global.delegate.dosomething(XiaYiShop.instance,XiaYiShop.instance.updata);
      }
      
      public function GC_SHOP_XIAYI(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         switch(type)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("购买成功");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("该物品不存在");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("侠义值不足");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("称号等级不够");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("背包已满");
         }
      }
      
      public function GC_TIAOZHAN_FAQI(patch:IDataInput) : void
      {
         var id:Number = LongUtil.readLong(patch);
         var name:String = patch.readUTF();
         var quhao:int = patch.readInt();
         var vip:int = patch.readInt();
         var teamName:String = patch.readUTF();
         var teamid:int = patch.readInt();
         var str:String = "<font color=\'#FF0000\'> 跨服</font>   <u><font color=\'#33CCFF\'>" + name + "</font></u>竟如此嚣张跋扈，胆敢发起全服挑战令，<font color=\'#FFFF00\'>【<a href=\'event:kftz_" + id + "_" + quhao + "_" + teamid + "\'><u>点击挑战</u></a>】</font>";
         UIManager.chatPanel.add(str,id,8,name);
      }
      
      public function GC_TIAOZHAN_CLICK(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         switch(type)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("非常遗憾，你尚未在多人竞技创建队伍");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("队伍中有未准备的队友");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("太过于嚣张，已被玩家应战");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("正在厮杀中");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("撮合中");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("队员不能挑战");
         }
      }
      
      public function GC_TIAOZHAN_REMOVE(patch:IDataInput) : void
      {
         if(Boolean(TeamPanel.instance))
         {
            TeamPanel.instance.removezhaoxun();
         }
      }
      
      public function GC_TIAOZHAN_ADD(patch:IDataInput) : void
      {
         TeamPanel.instance.zhaoxun();
      }
      
      public function GC_STAR_PAIHANG(patch:IDataInput) : void
      {
         var i:int;
         var vo:PingLunVO = null;
         var len:int = patch.readInt();
         Model_KuaFuJingJiChang.PJVo.length = 0;
         i = 0;
         while(i < len)
         {
            vo = new PingLunVO();
            vo.index = patch.readByte();
            vo.teamLvl = patch.readInt();
            vo.GZnum = patch.readInt();
            vo.LYnum = patch.readInt();
            vo.PJnum = patch.readInt();
            vo._teamname = patch.readUTF();
            vo._name = patch.readUTF();
            vo._job = patch.readUTF();
            vo._sex = patch.readUTF();
            vo._body = patch.readUTF();
            vo.teamnum = patch.readByte();
            vo._weaponDir = patch.readUTF();
            vo.PJnum = patch.readByte();
            vo.wing = patch.readUTF();
            Model_KuaFuJingJiChang.PJVo.push(vo);
            i++;
         }
         Model_KuaFuJingJiChang.PJVo.sort(function(a:PingLunVO, b:PingLunVO):Number
         {
            return a.index - b.index;
         });
         Global.delegate.dosomething(DRKFRank.instance,DRKFRank.instance.updata);
      }
      
      public function GC_STAR_PINGJIA(patch:IDataInput) : void
      {
         var i:int = 0;
         var type:int = patch.readByte();
         var guanzhu:int = patch.readByte();
         var count:int = patch.readInt();
         var index:int = patch.readByte();
         var num:int = patch.readInt();
         if(type == 1)
         {
            i = 0;
            while(i < Model_KuaFuJingJiChang.PJVo.length)
            {
               Model_KuaFuJingJiChang.PJVo[i].PJnum = num;
               i++;
            }
            if(guanzhu == 1)
            {
               Model_KuaFuJingJiChang.PJVo[index - 1].GZnum = count;
            }
            else if(guanzhu == 2)
            {
               Model_KuaFuJingJiChang.PJVo[index - 1].LYnum = count;
            }
         }
         else
         {
            if(type == 2)
            {
               UIManager.centerBroadcast.addMsg("评价失败");
               return;
            }
            if(type == 3)
            {
               UIManager.centerBroadcast.addMsg("评价次数已满");
            }
            else if(type == 4)
            {
               UIManager.centerBroadcast.addMsg("不能评价自己");
            }
         }
         Global.delegate.dosomething(DRKFRank.instance,DRKFRank.instance.updata);
      }
      
      public function GC_GUANGBO_PINGJIA(patch:IDataInput) : void
      {
         var str:String = null;
         var teamName:String = patch.readUTF();
         var count:int = patch.readInt();
         var type:int = patch.readByte();
         if(type == 1)
         {
            str = "<font color=\'#FF0000\'> 关注：</font>   粉丝数量大增，<font color=\'#33CCFF\'>" + teamName + "</font>成为众多武林人士妹纸中的NO.1！<font color=\'#FFFF00\'>【<a href=\'event:kfpj\'><u>立刻去评价</u></a>】</font>";
         }
         else if(type == 2)
         {
            str = "<font color=\'#FF0000\'> 冷遇：</font>   好杯具，<font color=\'#33CCFF\'>" + teamName + "</font>路过之处，一片狼藉，真是名誉扫地<font color=\'#FFFF00\'>【<a href=\'event:kfpj\'><u>立刻去评价</u></a>】</font>";
         }
         UIManager.chatPanel.add(str,0,8);
      }
      
      private function GC_KUAFU_JUMPBATTLE(patch:IDataInput) : void
      {
         BattleManager.jumpBattle();
      }
   }
}

