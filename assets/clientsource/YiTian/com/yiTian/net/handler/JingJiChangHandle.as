package com.yiTian.net.handler
{
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_jingJiChang;
   import com.yiTian.data.vo.Vo_jingJiChang;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.JingJiChangCGMessage;
   
   public class JingJiChangHandle
   {
      
      public function JingJiChangHandle()
      {
         super();
      }
      
      public static function GC_JINGJICHANG(len:int, tiaoZhanItem:Array, shengRate:int, canWar:int, curPosition:int, lfTime:int, jjc_jf:int, self_vx:int, pet_vx:int, xuanYaoTimes:int) : void
      {
         var temVo_JJC:Vo_jingJiChang = null;
         trace("数据:",tiaoZhanItem,len,shengRate,canWar,curPosition,lfTime);
         Model_jingJiChang.hero_position = self_vx;
         Model_jingJiChang.pet_position = pet_vx;
         Model_jingJiChang.jjc_data = [];
         Model_jingJiChang.jjc_jifen = jjc_jf;
         var i:int = 0;
         while(i < len)
         {
            temVo_JJC = new Vo_jingJiChang();
            temVo_JJC.init(tiaoZhanItem[i]);
            Model_jingJiChang.jjc_data.push(temVo_JJC);
            i++;
         }
         UIManager.jjc_panel.updata(len,shengRate,canWar,curPosition,lfTime,xuanYaoTimes);
      }
      
      public static function GC_GET_WAR_INFO(len:int, tz_item:Array) : void
      {
         trace("战报数据：",tz_item,len);
         UIManager.jjc_panel.updataZB(len,tz_item);
      }
      
      public static function CG_DEKARON(_price:int = 1) : void
      {
         if(!UIManager.storeTip.visible)
         {
            UIManager.storeTip.visible = true;
         }
         UIManager.storeTip.wpid = 0;
         UIManager.storeTip.isStore = false;
         UIManager.storeTip.isStore_youhui = false;
         UIManager.storeTip.Imformate_text.text = LangConfig.getWord("341",0) + String(_price) + LangConfig.getWord("342",0);
      }
      
      public static function GC_DEKARON_RANDOM(result:int, time:int, win_rate:int, canWar_Num:int, jjc_jifen:int) : void
      {
         Model_jingJiChang.jjc_jifen = jjc_jifen;
         UIManager.jjc_panel.Time_text.text = String(DateUtil.getMSBySecond2(time));
         UIManager.jjc_panel._leftTime = time;
         Model_jingJiChang.canWar = canWar_Num;
         UIManager.jjc_panel.TXChiShu_text.text = String(canWar_Num);
         UIManager.jjc_panel.WinPecent_text.text = String(win_rate + "%");
      }
      
      public static function GC_CANCEL_COOLTIME(jjc_jifen:int) : void
      {
         Model_jingJiChang.jjc_jifen = jjc_jifen;
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("456",0));
      }
      
      public static function GC_PAIHANG(len:int, tiaoZhanItem:Array) : void
      {
         var temVo_JJC:Vo_jingJiChang = null;
         if(!UIManager.pai_ming.visible)
         {
            UIManager.pai_ming.visible = true;
         }
         UIManager.pai_ming.parent.setChildIndex(UIManager.pai_ming,UIManager.pai_ming.parent.numChildren - 1);
         Model_jingJiChang.jjc_paihang = [];
         var i:int = 0;
         while(i < len)
         {
            temVo_JJC = new Vo_jingJiChang();
            temVo_JJC.init(tiaoZhanItem[i]);
            Model_jingJiChang.jjc_paihang.push(temVo_JJC);
            i++;
         }
         if(len % 10 == 0)
         {
            UIManager.pai_ming.totalPage = len / 10;
         }
         else
         {
            UIManager.pai_ming.totalPage = len / 10 + 1;
         }
         UIManager.pai_ming.Page_text.text = "1/" + String(UIManager.pai_ming.totalPage);
         UIManager.pai_ming.updata(1);
      }
      
      public static function GC_PAIHANG_CHECK(result:int) : void
      {
         if(result == 1)
         {
            if(!UIManager.cz_info.visible)
            {
               UIManager.cz_info.visible = true;
            }
            UIManager.cz_info.Button_Set.label = LangConfig.getWord("6",0);
            UIManager.cz_info.parent.setChildIndex(UIManager.cz_info,UIManager.cz_info.parent.numChildren - 1);
            UIManager.cz_info.updata(Model_jingJiChang.paiHang_role_id,Model_jingJiChang.paiHang_name,Model_jingJiChang.paiHang_level,Model_jingJiChang.paiHang_job,Model_jingJiChang.paiHang_sex,Model_jingJiChang.paiHang_petId,Model_jingJiChang.hero_position,Model_jingJiChang.pet_position,Model_jingJiChang.paiHang_petIcon);
         }
         else if(result == -1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("457",0));
         }
      }
      
      public static function GC_UPDATA_TIPS(res:int) : void
      {
         if(res == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("458",0));
         }
      }
      
      public static function GC_RANDOM_RESULT(res:int) : void
      {
         if(res == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("459",0));
            return;
         }
         UIManager.jjc_panel.getTips();
      }
      
      public static function GC_JING_ADD(res:int) : void
      {
         JingJiChangCGMessage.CG_GET_PAIMING();
      }
      
      public static function GC_JING_WAR_MY_DATA(_arr:Array) : void
      {
         if(!_arr)
         {
            return;
         }
         UIManager.jjc_panel.upMyWarInfor(_arr);
      }
      
      public static function GC_JING_RESULT(battleId:int, gain:int, otherRoleName:String, battleResult:int) : void
      {
         var s:Function = null;
         if(gain > 0)
         {
            s = function():void
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29010",2,gain),1);
               Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,s);
               if(battleResult == 1)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("29415",2),1);
               }
               else
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("29414",2),1);
               }
            };
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,s);
         }
      }
      
      public static function GC_SPEED(result:int) : void
      {
         UIManager.jjc_panel.setTime();
      }
   }
}

