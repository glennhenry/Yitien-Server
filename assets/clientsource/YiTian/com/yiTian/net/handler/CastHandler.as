package com.yiTian.net.handler
{
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.cast.View_equip_ChengZhuang_jingLian;
   import com.yiTian.view.modules.panel.Enum_panel_cast;
   import flash.geom.Point;
   
   public class CastHandler
   {
      
      public function CastHandler()
      {
         super();
      }
      
      public static function GC_ADD_HOLE(result:int) : void
      {
         if(result == 1)
         {
            UIManager.castPanel.update_success_hold(result);
         }
         else if(result == 2)
         {
            UIManager.castPanel.update_success_hold(result);
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("415",0));
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("416",0));
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("417",0));
         }
         else if(result == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("97",0));
         }
         else if(result == 7)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("418",0));
         }
         else if(result == 8)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("419",0));
         }
         else if(result == 9)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1164",0));
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("420",0));
         }
      }
      
      public static function GC_INLAY(result:int) : void
      {
         if(result == 1)
         {
            UIManager.castPanel.update_inlay();
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("421",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("416",0));
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("422",0));
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("423",0));
         }
         else if(result == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("185",0));
         }
         else if(result == 7)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("97",0));
         }
         else if(result == 8)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("424",0));
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("420",0));
         }
      }
      
      public static function GC_UNLOAD(result:int) : void
      {
         if(result == 1)
         {
            UIManager.castPanel.update_success_unLoad();
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("425",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("416",0));
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("426",0));
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("97",0));
         }
         else if(result == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("427",0));
         }
         else if(result == 7)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("428",0));
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("420",0));
         }
      }
      
      public static function GC_DECOMPOSE(result:int, vec:Vector.<int>) : void
      {
         if(result == 1)
         {
            UIManager.castPanel.update_decompose_count(vec);
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("429",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("446",0));
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("430",0));
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("431",0));
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("420",0));
         }
      }
      
      public static function GC_POLISH(result:int, vec:Vector.<int>) : void
      {
         if(result == 1)
         {
            UIManager.castPanel.update_polish_txt(vec);
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("416",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("432",0));
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("433",0));
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("97",0));
         }
         else if(result == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("428",0));
         }
         else if(result == 7)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("47",0));
         }
         else if(result == 8)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1164",0));
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("420",0));
         }
      }
      
      public static function GC_INTENSIFY(result:int) : void
      {
         if(result == 1)
         {
            UIManager.castPanel.intensGetEffect(result);
            if(GameUnitManager.hero.level < 30 && UIManager.castPanel.visible)
            {
               UIManager.castPanel.visible = false;
            }
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("416",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("434",0));
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("435",0));
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("97",0));
         }
         else if(result == 6)
         {
            UIManager.castPanel.intensGetEffect(result);
         }
         else if(result == 7)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("436",0));
         }
         else if(result == 8)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("437",0));
         }
         else if(result == 9)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("726",0));
         }
         else if(result == 10)
         {
            UIManager.centerBroadcast.addMsg("神级强化石不足");
         }
         else if(result == 11)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1164",0));
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("420",0));
         }
      }
      
      public static function GC_GEM_COMPOSE(result:int) : void
      {
         if(result == 1)
         {
            UIManager.castPanel.update_success_gemCompose();
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("438",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("439",0));
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("440",0));
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("441",0));
         }
         else if(result == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("442",0));
         }
         else if(result == 7)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("38",0));
         }
      }
      
      public static function GC_RIDE_COMPOSE(result:int) : void
      {
         if(result == 1)
         {
            UIManager.castPanel.updata_create();
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("443",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("444",0));
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("445",0));
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("446",0));
         }
         else if(result == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("112",0));
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("420",0));
         }
      }
      
      public static function GC_POLISH_OK(res:int) : void
      {
         if(res == 1)
         {
            UIManager.castPanel.update_success_changed();
         }
         else if(res == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("447",0));
         }
      }
      
      public static function GC_INSTEN_CHANGED(res:int) : void
      {
         if(res == 1)
         {
            UIManager.castPanel.update_success_insChanged();
         }
         else if(res == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("448",0));
            UIManager.castPanel.update_fail_insChanged();
         }
         else if(res == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("449",0));
         }
         else if(res == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("450",0));
         }
         else if(res == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("446",0));
         }
         else if(res == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("112",0));
         }
         else if(res == 7)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("216",0));
         }
         else if(res == 8)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("451",0));
         }
         else if(res == 9)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("452",0));
         }
         else if(res == 10)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("725",0));
         }
         else if(res == 11)
         {
            UIManager.centerBroadcast.addMsg("紫装以下品阶（含紫装）强化转移不能超过20级以上(强化转移装备等级不能超过20级)");
         }
         else if(res == 12)
         {
            UIManager.centerBroadcast.addMsg("橙装转移/暗金转移的转移装备一定要是紫装品阶以上（紫色装备才能转移橙装属性或者暗金属性）");
         }
         else if(res == 13)
         {
            UIManager.centerBroadcast.addMsg("橙装转移的转移装备一定要50级(50级以上的橙装才可转移)");
         }
         else if(res == 14)
         {
            UIManager.centerBroadcast.addMsg("暗金转移的转移装备一定要110级（110级以上装备才能转移暗金属性）");
         }
      }
      
      public static function GC_RIDE_UP(res:int) : void
      {
         if(res != 1)
         {
            if(res == 2)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("453",0));
            }
            else if(res == 3)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("454",0));
            }
            else if(res == 4)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("446",0));
            }
            else if(res == 5)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("455",0));
            }
         }
      }
      
      public static function GC_CZ_REFINE(res:int) : void
      {
         var _p:Point = null;
         var __p:Point = null;
         if(res == 1)
         {
            UIManager.castPanel.updata_refine();
            _p = (UIManager.castPanel.get_child_cast_panel(Enum_panel_cast.EQUIP_CZ_JINGLIAN) as View_equip_ChengZhuang_jingLian).getGridPos();
            EffectManager.effWord(LangConfig.getWord("953",0),_p);
         }
         else if(res == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("954",0));
         }
         else if(res == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("955",0));
         }
         else if(res == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("956",0));
         }
         else if(res == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("957",0));
         }
         else if(res == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("958",0));
         }
         else if(res == 7)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("959",0));
         }
         else if(res == 8)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("960",0));
         }
         else if(res == 9)
         {
            UIManager.centerBroadcast.addMsg("该装备精练的等级已经是最大值了");
         }
         else if(res == 10)
         {
            View_Alert.show(HtmlUtil.font("橙色装备精练为","#ffffff") + HtmlUtil.font("暗金装备","#04ff00") + "\n" + HtmlUtil.font("橙装强化属性增加为","#ffffff") + HtmlUtil.font("2倍","#04ff00",13) + "\n " + HtmlUtil.font("暗金装备可以洗练出","#ffffff") + HtmlUtil.font("2级、3级技能","#04ff00"),View_Alert.OK);
            UIManager.castPanel.updata_refine();
            __p = (UIManager.castPanel.get_child_cast_panel(Enum_panel_cast.EQUIP_CZ_JINGLIAN) as View_equip_ChengZhuang_jingLian).getGridPos();
            EffectManager.effWord(LangConfig.getWord("953",0),__p);
         }
      }
      
      public static function GC_CZ_XILIAN(res:int) : void
      {
         var _p:Point = null;
         if(res == 1)
         {
            UIManager.castPanel.updata_cz_polish();
            UIManager.castPanel.updata_refine();
            _p = (UIManager.castPanel.get_child_cast_panel(Enum_panel_cast.EQUIP_CZ_JINGLIAN) as View_equip_ChengZhuang_jingLian).getGridPos();
            EffectManager.effWord(LangConfig.getWord("962",0),_p);
         }
         else if(res == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("954",0));
         }
         else if(res == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("963",0));
         }
         else if(res == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("964",0));
         }
         else if(res == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("965",0));
         }
         else if(res == 6)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("966",0));
         }
         else if(res == 7)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("960",0));
         }
      }
   }
}

