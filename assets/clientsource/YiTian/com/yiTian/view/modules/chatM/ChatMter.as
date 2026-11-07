package com.yiTian.view.modules.chatM
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.role.LZBmp;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.QiJuHandler;
   import com.yiTian.net.message.cg.ChatCGMessage;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.chat.ChatTip;
   import com.yiTian.view.modules.playerExtend.View_PlayerExtendPanel;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.TextEvent;
   
   public class ChatMter
   {
      
      private static var _Str_channel:Array;
      
      private static var _vip_sign:Array;
      
      private static var _chatType:int;
      
      public static var sexA:Array = ["♂","♀"];
      
      private static var sex_color_arr:Array = ["#7CCCF2","#E87AF3"];
      
      private static var chan_color_arr:Array = ["#ffffff","#b3fd6a","#03B6FF","#32CD32"];
      
      public static var job_color_arr:Array = ["#ff5d38","#1ecbf8","#83e200","#e230ce"];
      
      private static var colorArr:Array = ["#ffffff","#1ABA36","#19FFDA","#BB00FF"];
      
      public function ChatMter()
      {
         super();
      }
      
      public static function get vip_sign() : Array
      {
         if(!_vip_sign)
         {
            _vip_sign = ["","<a href=\'event:vip_hun\'>" + LangConfig.getWord("60108",6) + "</a>","<a href=\'event:vip_hun\'>" + LangConfig.getWord("60108",6) + "</a>","<a href=\'event:vip_hun\'>" + LangConfig.getWord("60108",6) + "</a>"];
         }
         return _vip_sign;
      }
      
      public static function get Str_channel() : Array
      {
         if(!_Str_channel)
         {
            _Str_channel = [LangConfig.getWord("842",0),LangConfig.getWord("843",0),LangConfig.getWord("844",0),LangConfig.getWord("523",0),LangConfig.getWord("845",0)];
         }
         return _Str_channel;
      }
      
      public static function getSpace(diaLvl:int, isYear:int, huangZLv:int, isHuangZYear:int, huiyuan:int = 0, isHuiYuanYear:int = 0, superLan:int = 0, superLanYear:int = 0) : String
      {
         if(Global.pf == Enum_SPStr.QQ3366 || Enum_SPStr.isUnion(Global.pf))
         {
            return "";
         }
         if(Global.pf == "qqgame")
         {
            if(Boolean(superLanYear) && superLan > 0)
            {
               return "        ";
            }
            if(superLan > 0)
            {
               return "    ";
            }
            if(Boolean(isYear) && diaLvl > 0)
            {
               return "        ";
            }
            if(diaLvl > 0)
            {
               return "    ";
            }
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG)
         {
            if(Boolean(isHuiYuanYear) && huiyuan > 0)
            {
               return "             ";
            }
            if(huiyuan > 0)
            {
               return "          ";
            }
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            if(Boolean(isHuangZYear) && huangZLv > 0)
            {
               return "        ";
            }
            if(huangZLv > 0)
            {
               return "    ";
            }
         }
         return "";
      }
      
      public static function getChannel(channel:int) : String
      {
         return HtmlUtil.font(" " + Str_channel[channel - 1] + "  ",chan_color_arr[channel - 1]);
      }
      
      public static function getSex(sex:int) : String
      {
         return HtmlUtil.font(sexA[sex - 1],sex_color_arr[sex - 1]);
      }
      
      public static function getName(name:String, job:int, roleId:Number) : String
      {
         if(roleId == GameUnitManager.hero.id)
         {
            return HtmlUtil.font("【" + name + "】",job_color_arr[Enum_job.getBaseJob(job) - 1]);
         }
         return HtmlUtil.link(HtmlUtil.font("【" + name + "】",job_color_arr[Enum_job.getBaseJob(job) - 1]),String(roleId));
      }
      
      public static function getVip(vip:int) : String
      {
         return HtmlUtil.font(vip_sign[vip] + "：",Boolean(vip) ? colorArr[vip] : "#f9ff00");
      }
      
      public static function getContact(chatContact:String) : String
      {
         return HtmlUtil.font(chatContact,"#fffc70");
      }
      
      public static function getLinkHd(e:TextEvent, data:Object) : void
      {
         var pan:View_PlayerExtendPanel = null;
         var temType:int = 0;
         var temId:Number = NaN;
         var temVoItem:Vo_item = null;
         var temChatTip:ChatTip = null;
         var teamData:Array = null;
         var teamId:int = 0;
         var teamType:int = 0;
         var tem:int = 0;
         GameScene.instance.onTextEventLink();
         var temStr:String = e.text;
         if(temStr.slice(0,4) == "show")
         {
            temType = int(temStr.slice(5,6));
            temId = Number(temStr.slice(7,temStr.length));
            if(temType == 2)
            {
               ChatCGMessage.CG_SHOW(temId);
            }
            else
            {
               temVoItem = new Vo_item();
               temVoItem.id = temId;
               temVoItem.Init_lib();
               temChatTip = ChatTip.getInstance();
               temChatTip.show(temVoItem);
            }
            return;
         }
         if(temStr.slice(0,4) == "invi")
         {
            if(!data.id || data.id == GameUnitManager.hero.id)
            {
               return;
            }
            TeamCGMessage.CG_DIRECT_TEAM_STATE(0,data.id.toString());
            return;
         }
         if(temStr.slice(0,4) == "role")
         {
            if(!data.id || data.id == GameUnitManager.hero.id)
            {
               return;
            }
            Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,data.id);
            return;
         }
         if(temStr.slice(0,4) == "qiju")
         {
            if(!data.id || data.id == GameUnitManager.hero.id)
            {
               return;
            }
            teamData = temStr.split("_");
            teamId = int(teamData[1]);
            teamType = int(teamData[2]);
            QiJuHandler.joinQijuTeam(teamId,teamType);
            return;
         }
         if(temStr.slice(0,4) == "ping")
         {
            UIManager.smallMap.bangClick(null);
            return;
         }
         if(temStr.slice(0,4) == "open")
         {
            RoleCGMessage.CG_CHECK_OTHERROLE(data.id);
            return;
         }
         if(temStr == "becomeWuHun")
         {
            UIManager.vipPanel.visible = !UIManager.vipPanel.visible;
            return;
         }
         if(temStr == "cgx_libao")
         {
            UIManager.shouChongPanel.visible = !UIManager.shouChongPanel.visible;
            return;
         }
         if(temStr == "cgx_chongzhi")
         {
            UIManager.yuanBaoXiang.visible = !UIManager.yuanBaoXiang.visible;
            return;
         }
         if(temStr == "jingjichang")
         {
            Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,data.id);
            return;
         }
         if(temStr == "vip_hun")
         {
            UIManager.vipPanel.visible = !UIManager.vipPanel.visible;
            return;
         }
         if(temStr == "bangYao")
         {
            UIManager.bangMoneyTree.visible = !UIManager.bangMoneyTree.visible;
            return;
         }
         pan = View_PlayerExtendPanel.instance;
         pan.visible = true;
         pan.x = Global.stage.mouseX;
         pan.y = Global.stage.mouseY;
         if(pan.y + pan.height > Global.stage.stageHeight)
         {
            tem = pan.y + pan.height - Global.stage.stageHeight;
            pan.y = Global.stage.mouseY - tem - 10;
         }
         View_PlayerExtendPanel._priChatOtherRoleId = Number(e.text);
         View_PlayerExtendPanel._OtherRoleName = data.name;
         View_PlayerExtendPanel._chatContant = data.contant;
      }
      
      public static function addDia(diaLvl:int, isYearDia:int, hzLvl:int = 0, isYearHz:int = 0, isHuiyuan:int = 0, isHuiyuanYear:int = 0, superLan:int = 0, superLanYear:int = 0, LZbmp:LZBmp = null, _chatBack:Bitmap = null, chatType:int = 0) : Bitmap
      {
         _chatType = chatType;
         if(Global.pf == "qqgame")
         {
            if(superLanYear == 0 && superLan > 0)
            {
               return Utils.getLoadBitmap(LZBmp.getsuperLan(superLan),LZbmp.bmp,null,function():void
               {
                  resize(LZbmp,3,_chatBack);
               });
            }
            if(superLan > 0)
            {
               return Utils.getLoadBitmap(LZBmp.getsuperLanYear(superLan),LZbmp.bmp,null,function():void
               {
                  resize(LZbmp,3,_chatBack);
               });
            }
            if(isYearDia == 0 && diaLvl > 0)
            {
               return Utils.getLoadBitmap(LZBmp.getLvlUrl(diaLvl),LZbmp.bmp,null,function():void
               {
                  resize(LZbmp,3,_chatBack);
               });
            }
            if(diaLvl > 0)
            {
               return Utils.getLoadBitmap(LZBmp.getYearUrl(diaLvl),LZbmp.bmp,null,function():void
               {
                  resize(LZbmp,3,_chatBack);
               });
            }
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG)
         {
            if(isHuiyuanYear == 0 && isHuiyuan > 0)
            {
               return Utils.getLoadBitmap(LZBmp.getQQHuiYuan(isHuiyuan),LZbmp.bmp,null,function():void
               {
                  resize(LZbmp,0,_chatBack);
               });
            }
            if(isHuiyuan > 0)
            {
               return Utils.getLoadBitmap(LZBmp.getQQHuiYuanYear(isHuiyuan),LZbmp.bmp,null,function():void
               {
                  resize(LZbmp,3,_chatBack);
               });
            }
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            if(isYearHz == 0 && hzLvl > 0)
            {
               return Utils.getLoadBitmap(LZBmp.getLvlUrl_h(hzLvl),LZbmp.bmp,null,function():void
               {
                  resize(LZbmp,3,_chatBack);
               });
            }
            if(hzLvl > 0)
            {
               return Utils.getLoadBitmap(LZBmp.getYearUrl_h(hzLvl),LZbmp.bmp,null,function():void
               {
                  resize(LZbmp,3,_chatBack);
               });
            }
         }
         return null;
      }
      
      private static function resize(LZbmp:DisplayObject, _space:int = 0, _chatBack:DisplayObject = null) : void
      {
         LZbmp.x = _chatBack.x + _chatBack.width;
         if(_chatType == 6)
         {
            LZbmp.x = 0;
         }
         LZbmp.y = _space;
      }
   }
}

