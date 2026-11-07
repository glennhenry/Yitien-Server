package com.yiTian.view.modules.chatM
{
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_chat;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.BattleUnit;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.manager.BattleUnitManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import flash.events.TextEvent;
   
   public class ChatPanM
   {
      
      private static var _instance:ChatPanM;
      
      private var world:ChatL;
      
      private var fujin:ChatL;
      
      private var team:ChatL;
      
      private var banghui:ChatL;
      
      private var chanArr:Array = [];
      
      private var nowChatChann:ChatL;
      
      public function ChatPanM()
      {
         super();
         this.world = new ChatL(269,194,TestScroll.LEFT,UIManager.chatPanel);
         this.fujin = new ChatL(269,194,TestScroll.LEFT,UIManager.chatPanel);
         this.team = new ChatL(269,194,TestScroll.LEFT,UIManager.chatPanel);
         this.banghui = new ChatL(269,194,TestScroll.LEFT,UIManager.chatPanel);
         this.chanArr.push(this.world,this.fujin,this.team,this.banghui);
      }
      
      public static function get instance() : ChatPanM
      {
         if(!_instance)
         {
            _instance = new ChatPanM();
         }
         return _instance;
      }
      
      public function reset() : void
      {
         var item:ChatL = null;
         for each(item in this.chanArr)
         {
            item.hide();
         }
      }
      
      private function getChan(_chan:int) : ChatL
      {
         return this.chanArr[_chan - 1] as ChatL;
      }
      
      public function addMes(chan:int = 1, str:String = "", dataL:Object = null, isShow:Boolean = false) : void
      {
         this.reset();
         var chatPan:ChatL = this.getChan(chan);
         if(isShow)
         {
            if(this.nowChatChann != chatPan)
            {
               if(Boolean(this.nowChatChann))
               {
                  this.nowChatChann.hide();
               }
               this.nowChatChann = chatPan;
            }
         }
         if(Boolean(this.nowChatChann))
         {
            this.nowChatChann.show();
         }
         chatPan.init(str,dataL,this.linkHd);
      }
      
      public function getData(chatType:int, chatContact:String, roleName:String, sex:int, vip:int, roleId:Number, job:int, diaLvl:int, isYearDia:int, huangZLv:int, isHuangZYear:int, huiyuan:int, huiyuanYear:int, superLan:int, superLanYear:int, isSuperHuang:int) : void
      {
         var role:Role = null;
         var unit:BattleUnit = null;
         var str:String = ChatMter.getChannel(chatType) + ChatMter.getSpace(diaLvl,isYearDia,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear) + ChatMter.getSex(sex) + ChatMter.getName(roleName,job,roleId) + ChatMter.getVip(vip) + ChatMter.getContact(chatContact);
         var obj:Object = {
            "id":roleId,
            "name":roleName,
            "linkArr":Model_chat.chat_save,
            "chat_type":chatType,
            "diaLvl":diaLvl,
            "isYearDia":isYearDia,
            "hzLvl":huangZLv,
            "isYearHz":isHuangZYear,
            "isHuiyuan":huiyuan,
            "isHuiYuanYear":huiyuanYear,
            "superLan":superLan,
            "superLanYear":superLanYear,
            "contant":chatContact
         };
         if(chatType == 2)
         {
            role = GameUnitManager.findUnit(roleId,UnitType.PLAYER) as Role;
            if(GameUnitManager.hero.level >= 30)
            {
               if(Boolean(role))
               {
                  role.say(HtmlUtil.font(chatContact,"#fffc70"));
               }
               if(Global.isInBattle)
               {
                  unit = BattleUnitManager.findUnit(roleId) as BattleUnit;
                  if(Boolean(unit))
                  {
                     unit.say(HtmlUtil.font(chatContact,"#fffc70"));
                  }
               }
            }
         }
         this.addMes(chatType,str,obj);
      }
      
      public function setLock(value:int) : void
      {
         if(Boolean(this.nowChatChann))
         {
            if(value == 1)
            {
               this.nowChatChann.lock = false;
            }
            else
            {
               this.nowChatChann.lock = true;
            }
         }
      }
      
      private function linkHd(e:TextEvent, data:Object) : void
      {
         ChatMter.getLinkHd(e,data);
      }
   }
}

