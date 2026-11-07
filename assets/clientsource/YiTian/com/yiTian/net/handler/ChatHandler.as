package com.yiTian.net.handler
{
   import com.ui.controls.MyTextField;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.chat.ChatMediator;
   import com.yiTian.view.modules.chat.ChatTip;
   import com.yiTian.view.modules.chat.PriChatManager;
   import com.yiTian.view.modules.chat.View_ChatPanel;
   import com.yiTian.view.modules.chatM.face.Model_face;
   import com.yiTian.view.modules.paihang.FlowerVO;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   
   public class ChatHandler
   {
      
      private static var tempTf:MyTextField;
      
      public function ChatHandler()
      {
         super();
      }
      
      public static function GC_CHAT(chatStatus:int, chatType:int, roleId:Number, sex:int, roleName:String, vip:int, chatContact:String, job:int, diaLvl:int, isYearDia:int, huangZLv:int, isHuangZYear:int, huiyuan:int, huiyuanYear:int, superLan:int, superLanYear:int, isSuperHuang:int, isTongBu:int, faceInfo:String) : void
      {
         var loadurl:String = null;
         var loader:URLLoader = null;
         var url:URLRequest = null;
         if(chatType != 8)
         {
            if(chatType == 4)
            {
               Utils.print(GameUnitManager.hero.id,roleId,isTongBu,".........");
               roleName = Model_heFu.repNameByHero(roleName);
               if(Model_bang.bangQQGroupOpenId != "" && isTongBu == 1 && GameUnitManager.hero.id == roleId)
               {
                  if(!tempTf)
                  {
                     tempTf = new MyTextField();
                  }
                  tempTf.htmlText = chatContact;
                  loadurl = "http://api1.app100621282.twsapp.com/openapi.php?mod=qqgroup&op=send&group_openid=" + Model_bang.bangQQGroupOpenId + "&msg=" + encodeURI(tempTf.text) + "&union_id=" + Model_bang.bangQQGroupUnionId + "&zoneid=" + Global.zoneid + "&openid=" + Global.account + "&openkey=" + Global.openkey + "&pf=" + Global.pf;
                  loader = new URLLoader();
                  url = new URLRequest(loadurl);
                  url.method = URLRequestMethod.GET;
                  loader.dataFormat = URLLoaderDataFormat.TEXT;
                  loader.load(url);
               }
            }
            else
            {
               roleName = Model_heFu.repNameByHero(roleName);
            }
         }
         roleName = Model_heFu.repNameByHero(roleName);
         UIManager.chatPanel.addMessage(chatType,chatContact,roleName,sex,vip,roleId,job,diaLvl,isYearDia,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang,faceInfo);
      }
      
      public static function GC_SID_CHAT_BLACKNAME(res:int) : void
      {
         if(res == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("622",0));
         }
      }
      
      public static function GC_SID_CHAT_M() : void
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("623",0));
      }
      
      public static function GC_SID_CHAT(chatStatus:int, otherRoleIcon:int, isFriend:int, otherRoleMap:String, otherRoleId:Number, otherRoleName:String, _sex:int, _job:int, body:int, weapon:int, horse:int, vipLv:int, crossType:int, wingId:int) : void
      {
         var mgr:PriChatManager = PriChatManager.getInstance();
         var med:ChatMediator = mgr.findMed(otherRoleId);
         otherRoleName = Model_heFu.repNameByHero(otherRoleName);
         if(med == null)
         {
            med = new ChatMediator();
            med.roleId = otherRoleId;
            med.roleJob = _job;
            med.roleName = otherRoleName;
            med.roleSex = _sex;
            mgr.addMed(med);
         }
         med.roleBody = body;
         med.roleHorse = horse;
         med.roleWeapon = weapon;
         med.roleWing = wingId;
         med.vipLv = vipLv;
         med.crossType = crossType;
         med.state = ChatMediator.NONMSG;
         if(Boolean(crossType))
         {
            FlowerVO.isKuaFu = true;
         }
         else
         {
            FlowerVO.isKuaFu = false;
         }
         med.showPanel();
         UIManager.friendPanel.addContact(med);
         mgr.resetTipPos();
      }
      
      public static function GC_SID_CHAT_SEND(chatStatus:int, otherRoleId:Number, roleName:String, time:int, chatContact:String, sex:int, job:int, body:int, weapon:int, horse:int, vipLv:int, crossType:int, wingId:int, faceInfo:String) : void
      {
         var i:int = 0;
         var id:int = 0;
         var voim:Vo_item = null;
         var mgr:PriChatManager = PriChatManager.getInstance();
         var med:ChatMediator = mgr.findMed(otherRoleId);
         roleName = Model_heFu.repNameByHero(roleName);
         Model_face.chatRoleHasOwnedFaceInfo[roleName] = [];
         var tArr:Array = faceInfo.split(",");
         if(Boolean(tArr) && Boolean(tArr.length))
         {
            i = 0;
            while(i < tArr.length)
            {
               id = int(tArr[i]);
               voim = new Vo_item();
               voim.id = id;
               voim.Init_lib();
               Model_face.chatRoleHasOwnedFaceInfo[roleName].push(voim.face_icon_id);
               i++;
            }
         }
         if(med == null)
         {
            med = new ChatMediator();
            med.roleId = otherRoleId;
            med.roleJob = job;
            med.roleName = roleName;
            med.roleSex = sex;
            med.crossType = crossType;
            med.roleBody = body;
            med.roleWeapon = weapon;
            med.roleHorse = horse;
            med.roleWing = wingId;
            med.vipLv = vipLv;
            med.crossType = crossType;
            mgr.addMed(med);
         }
         med.addContent(roleName,chatContact,time);
         UIManager.friendPanel.addContact(med);
         mgr.resetTipPos();
      }
      
      public static function showHandle(equips:Array) : void
      {
         if(!equips[0].length)
         {
            return;
         }
         var temEquipVo:Vo_equip = new Vo_equip();
         temEquipVo.Init_sever_bag(equips[0]);
         var temChatTip:ChatTip = ChatTip.getInstance();
         temChatTip.show(temEquipVo);
      }
      
      public static function GC_SC_BROAR(roleId:Number, name:String, day:int) : void
      {
         name = Model_heFu.repNameByHero(name);
         var str2:String = "";
         if(day == 1)
         {
            str2 = "获得了" + HtmlUtil.font("炫酷翅膀","#ff6600");
         }
         var str:String = "恭喜玩家" + HtmlUtil.link(HtmlUtil.font(HtmlUtil.underLine(name),"#3888e9"),roleId.toString()) + "拿到了第" + day + "天首充奖励，" + str2 + "，真是豪爽大方，高富帅啊！" + "<u><a href=\'event:cgx_chongzhi\'><font color=\'#00ff00\'>【我要奖励】</font></a></u>";
         UIManager.chatPanel.add(str,roleId,102,name);
      }
      
      public static function GC_BECOME_WUHUN(roleId:Number, name:String, job:int) : void
      {
         name = Model_heFu.repNameByHero(name);
         var ssName:String = HtmlUtil.font("【" + name + "】",UIManager.chatPanel.job_color_arr[Enum_job.getBaseJob(job) - 1]);
         var str:String = " " + HtmlUtil.font(View_ChatPanel.Str_channel[0],"#ffffff") + " " + LangConfig.getWord("1137",0,HtmlUtil.link(ssName,roleId.toString()));
         UIManager.chatPanel.add(str,roleId,1,name);
      }
      
      public static function GC_QuanFuGongGao(roleId:Number, name:String, resultId:int) : void
      {
         name = Model_heFu.repNameByHero(name);
         var itemArr:Array = Data_lib.czfk[resultId][1].split(",");
         var itemStr:Array = itemArr[itemArr.length - 1].split("_");
         var str:String = "恭喜玩家" + HtmlUtil.link(HtmlUtil.font(HtmlUtil.underLine(name),"#3888e9"),roleId.toString()) + "领取了充值回馈的" + Data_lib.czfk[resultId][0] + "元宝大礼包，获得了稀有道具" + Enum_BroadCastTool.instance.getItemText(itemStr[1],12) + "*" + itemStr[2] + "  " + "<u><a href=\'event:ChongZhiDaLiBao\'><font color=\'#00ff00\'>【我也要礼包】</font></a></u>";
         UIManager.chatPanel.add(str,roleId,102,name);
      }
   }
}

