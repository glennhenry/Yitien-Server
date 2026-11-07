package com.yiTian.manager
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_OtherTip_Type;
   import com.yiTian.data.config.valuable.Enum_equip_type;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.model.Model_ChunJieNianGao;
   import com.yiTian.data.vo.Vo_BangUpdateInfo;
   import com.yiTian.data.vo.Vo_DynamicTip;
   import com.yiTian.data.vo.Vo_Pet;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.data.vo.Vo_TianMing;
   import com.yiTian.data.vo.Vo_XingZuoCountAtb;
   import com.yiTian.data.vo.Vo_XingZuoStar;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_petEquip;
   import com.yiTian.data.vo.Vo_shuXingDan;
   import com.yiTian.data.vo.Vo_unit;
   import com.yiTian.gameUnit.role.BattleUnit;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.modules.Card.View_cardTips;
   import com.yiTian.view.modules.Card.View_cardTotalAttribute_Tips;
   import com.yiTian.view.modules.Card.Vo_card;
   import com.yiTian.view.modules.Card.Vo_cardTotalAttribute;
   import com.yiTian.view.modules.banhui.Vo_BangZF;
   import com.yiTian.view.modules.guangMingDing.Vo_MiJi;
   import com.yiTian.view.modules.marriage.VO_MarriageAttribute;
   import com.yiTian.view.modules.role.Enum_role_equip;
   import com.yiTian.view.modules.shenBing.Vo_ShenBingAtb;
   import com.yiTian.view.modules.shenBing.Vo_ShenBingSkill;
   import com.yiTian.view.modules.shenBing.Vo_ShenbingTipInfo;
   import com.yiTian.view.modules.team.MemberVO;
   import com.yiTian.view.modules.tianTi.Vo_xinFa;
   import com.yiTian.view.modules.tip.tips.View_BangHuiUpdateTip;
   import com.yiTian.view.modules.tip.tips.View_BattleUnitTip;
   import com.yiTian.view.modules.tip.tips.View_CommonTip;
   import com.yiTian.view.modules.tip.tips.View_DynamicStrTip;
   import com.yiTian.view.modules.tip.tips.View_Equip;
   import com.yiTian.view.modules.tip.tips.View_Friend_Tip;
   import com.yiTian.view.modules.tip.tips.View_Item;
   import com.yiTian.view.modules.tip.tips.View_Marrige_Attribute_Tip;
   import com.yiTian.view.modules.tip.tips.View_MiJiTip;
   import com.yiTian.view.modules.tip.tips.View_Pet_Tip;
   import com.yiTian.view.modules.tip.tips.View_ShenbingBTip;
   import com.yiTian.view.modules.tip.tips.View_SkillTip;
   import com.yiTian.view.modules.tip.tips.View_XingZuoAtbCountTip;
   import com.yiTian.view.modules.tip.tips.View_ZFTip;
   import com.yiTian.view.modules.tip.tips.View_ZhenXing_Tip;
   import com.yiTian.view.modules.tip.tips.View_ZhuanZhiAttTip;
   import com.yiTian.view.modules.tip.tips.View_babyTip;
   import com.yiTian.view.modules.tip.tips.View_displayObjectTip;
   import com.yiTian.view.modules.tip.tips.View_petEquipTip;
   import com.yiTian.view.modules.tip.tips.View_speSkillTip;
   import com.yiTian.view.modules.tip.tips.View_tip;
   import com.yiTian.view.modules.tip.tips.View_xinFa_Tip;
   import com.yiTian.view.modules.tip.tips.View_xingZuoAtbTip;
   import com.yiTian.view.modules.tip.tips.shenBing.View_ShenBingAtbTip;
   import com.yiTian.view.modules.tip.tips.shenBing.View_ShenBingSkillTip;
   import com.yiTian.view.modules.tip.tips.shuXingDan.shuXingDanTip;
   import com.yiTian.view.modules.tip.tips.tianMing.View_MyTianMing_Tip;
   import com.yiTian.view.modules.tip.tips.tianMing.View_TaoZhuang_Tip;
   import com.yiTian.view.modules.tip.tips.tianMing.View_TianMing_Tip;
   import com.yiTian.view.modules.tip.tips.xunZhang.View_xunZhangTip;
   import com.yiTian.view.modules.wuXing.VoTip_wuXing;
   import com.yiTian.view.modules.wuXing.Vo_WuxingC;
   import com.yiTian.view.modules.wuXing.Vo_wuXing;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class TipManager
   {
      
      public static var view_tip:View_tip;
      
      public static var view_equip:View_Equip = new View_Equip();
      
      private static var view_CommonTip:View_CommonTip = new View_CommonTip();
      
      private static var view_babyTip:View_babyTip = new View_babyTip();
      
      private static var view_tip_equip:View_Equip = new View_Equip();
      
      private static var view_tip_item:View_Item = new View_Item();
      
      private static var view_tip_skill:View_SkillTip = new View_SkillTip();
      
      private static var view_tip_SpeSkill:View_speSkillTip = new View_speSkillTip();
      
      private static var view_tip_BattleUnit:View_BattleUnitTip = new View_BattleUnitTip();
      
      private static var view_tip_friend:View_Friend_Tip = new View_Friend_Tip();
      
      private static var view_tip_pet:View_Pet_Tip = new View_Pet_Tip();
      
      private static var view_tip_bangUpdateMsg:View_BangHuiUpdateTip = new View_BangHuiUpdateTip();
      
      private static var view_tip_zhenfa:View_ZFTip = new View_ZFTip();
      
      private static var view_tip_zhenxing:View_ZhenXing_Tip = new View_ZhenXing_Tip();
      
      private static var view_tip_xinfa:View_xinFa_Tip = new View_xinFa_Tip();
      
      private static var view_marriage_attribute_tip:View_Marrige_Attribute_Tip = new View_Marrige_Attribute_Tip();
      
      private static var view_tianMing:View_TianMing_Tip = new View_TianMing_Tip();
      
      private static var view_myTianMing:View_MyTianMing_Tip = new View_MyTianMing_Tip();
      
      private static var view_taoZhuang:View_TaoZhuang_Tip = new View_TaoZhuang_Tip();
      
      private static var view_zhuanZhiAttTip:View_ZhuanZhiAttTip = new View_ZhuanZhiAttTip();
      
      private static var view_wuXing:VoTip_wuXing = new VoTip_wuXing();
      
      private static var view_gmd_buffTip:View_MiJiTip = new View_MiJiTip();
      
      private static var view_xunZhang:View_xunZhangTip = new View_xunZhangTip();
      
      private static var view_petZhuangBei:View_petEquipTip = new View_petEquipTip();
      
      private static var view_shenBingSkillTip:View_ShenBingSkillTip = new View_ShenBingSkillTip();
      
      private static var view_shenBingAtbTip:View_ShenBingAtbTip = new View_ShenBingAtbTip();
      
      private static var view_shuXingDanTip:shuXingDanTip = new shuXingDanTip();
      
      private static var view_ShenbingBTip:View_ShenbingBTip = new View_ShenbingBTip();
      
      private static var view_DynamicStrTip:View_DynamicStrTip = new View_DynamicStrTip();
      
      private static var view_XingZuoATip:View_xingZuoAtbTip = new View_xingZuoAtbTip();
      
      private static var view_XingZuoAtbCountTip:View_XingZuoAtbCountTip = new View_XingZuoAtbCountTip();
      
      private static var view_cardTips:View_cardTips = new View_cardTips();
      
      private static var view_cardTotalAttribute_Tips:View_cardTotalAttribute_Tips = new View_cardTotalAttribute_Tips();
      
      private static var view_displayObjectTip:View_displayObjectTip = new View_displayObjectTip();
      
      private static var targetDic:Dictionary = new Dictionary();
      
      private static var _typeDic:Dictionary = new Dictionary();
      
      public function TipManager()
      {
         super();
      }
      
      public static function Init() : void
      {
         view_equip.Init();
         view_equip.visible = false;
         GameScene.upUILayer.addChild(view_equip);
         view_CommonTip.Init();
         view_babyTip.Init();
         view_tip_equip.Init();
         view_tip_item.Init();
         view_tip_skill.Init();
         view_tip_SpeSkill.Init();
         view_tip_BattleUnit.Init();
         view_tip_friend.Init();
         view_tip_pet.Init();
         view_tip_bangUpdateMsg.Init();
         view_tip_zhenfa.Init();
         view_tip_zhenxing.Init();
         view_tip_xinfa.Init();
         view_marriage_attribute_tip.Init();
         view_tianMing.Init();
         view_myTianMing.Init();
         view_zhuanZhiAttTip.Init();
         view_wuXing.Init();
         view_gmd_buffTip.Init();
         view_xunZhang.Init();
         view_petZhuangBei.Init();
         view_taoZhuang.Init();
         view_shenBingSkillTip.Init();
         view_shenBingAtbTip.Init();
         view_shuXingDanTip.Init();
         view_ShenbingBTip.Init();
         view_DynamicStrTip.Init();
         view_cardTips.Init();
         view_displayObjectTip.Init();
      }
      
      public static function update(obj:Object, type:int = 1, stoneLvl:int = 0, posA:Array = null) : void
      {
         var vo_grid:Vo_grid = null;
         var point:Point = null;
         if(obj == null)
         {
            return;
         }
         hide();
         if(obj is Vo_grid)
         {
            vo_grid = obj as Vo_grid;
            if(vo_grid is Vo_TianMing)
            {
               if(type == Enum_type_grid.TIANMING)
               {
                  view_tip = view_tianMing;
               }
               else if(type == Enum_type_grid.MY_TIAMMING)
               {
                  view_tip = view_myTianMing;
               }
            }
            else if(obj is Vo_ShenBingSkill)
            {
               view_tip = view_shenBingSkillTip;
            }
            else if(vo_grid is Vo_equip)
            {
               if((vo_grid as Vo_equip).type == 12)
               {
                  view_tip = view_xunZhang;
                  view_tip.Show(obj);
                  GameScene.upUILayer.addChild(view_tip);
                  return;
               }
               view_tip = view_tip_equip;
               show_sub(vo_grid as Vo_equip,type,stoneLvl);
            }
            else if(vo_grid is Vo_item)
            {
               view_tip = view_tip_item;
               if(vo_grid.id == 45341)
               {
                  vo_grid.str_describe = Data_lib.item[45341][Enum_lib_item.STR_DESCRIBE];
                  vo_grid.str_describe = vo_grid.str_describe.replace("{0}",String(Model_ChunJieNianGao.NianGaoCount));
               }
               if(vo_grid.id == 45384)
               {
                  vo_grid.str_describe = Data_lib.item[45384][Enum_lib_item.STR_DESCRIBE];
                  vo_grid.str_describe = vo_grid.str_describe.replace("{0}",String(Model_ChunJieNianGao.YuanXiaoCount));
               }
            }
            else if(vo_grid is Vo_Skill)
            {
               if((vo_grid as Vo_Skill).isSpecial)
               {
                  view_tip = view_tip_SpeSkill;
               }
               else
               {
                  view_tip = view_tip_skill;
               }
            }
            else if(vo_grid is Vo_Pet)
            {
               view_tip = view_tip_pet;
            }
            else if(vo_grid is MemberVO)
            {
               view_tip = view_tip_zhenxing;
            }
            else if(obj is Vo_petEquip)
            {
               view_tip = view_petZhuangBei;
            }
         }
         else if(obj is BattleUnit)
         {
            view_tip = view_tip_BattleUnit;
         }
         else if(obj is Vo_ShenbingTipInfo)
         {
            view_tip = view_ShenbingBTip;
         }
         else if(obj is Vo_DynamicTip)
         {
            view_tip = view_DynamicStrTip;
         }
         else if(obj is String && obj != "")
         {
            view_tip = view_CommonTip;
         }
         else if(obj is Array)
         {
            if(Boolean(posA))
            {
               View_babyTip.gapArr = posA;
            }
            view_babyTip.dispose();
            view_tip = view_babyTip;
         }
         else if(obj is Vo_unit)
         {
            view_tip = view_tip_friend;
         }
         else if(obj is Vo_BangUpdateInfo)
         {
            view_tip = view_tip_bangUpdateMsg;
         }
         else if(obj is Vo_BangZF)
         {
            view_tip = view_tip_zhenfa;
         }
         else if(obj is Vo_xinFa)
         {
            view_tip = view_tip_xinfa;
         }
         else if(obj is VO_MarriageAttribute)
         {
            view_tip = view_marriage_attribute_tip;
         }
         else if(obj is Vo_wuXing || obj is Vo_WuxingC)
         {
            view_tip = view_wuXing;
         }
         else if(obj is Vo_MiJi)
         {
            view_tip = view_gmd_buffTip;
         }
         else if(obj is Vo_ShenBingAtb)
         {
            view_tip = view_shenBingAtbTip;
         }
         else if(obj is Vo_shuXingDan)
         {
            view_tip = view_shuXingDanTip;
         }
         else if(obj is Vo_XingZuoStar)
         {
            view_tip = view_XingZuoATip;
         }
         else if(obj is Vo_XingZuoCountAtb)
         {
            view_tip = view_XingZuoAtbCountTip;
         }
         else if(obj is Vo_card)
         {
            view_tip = view_cardTips;
         }
         else if(obj is Vo_cardTotalAttribute)
         {
            view_tip = view_cardTotalAttribute_Tips;
         }
         else if(obj is DisplayObject)
         {
            view_tip = view_displayObjectTip;
         }
         else if(obj.typeId == Enum_OtherTip_Type.TIANMING)
         {
            view_tip = view_taoZhuang;
         }
         else if(obj.typeId == Enum_OtherTip_Type.ZHUANZHI)
         {
            view_tip = view_zhuanZhiAttTip;
         }
         if(obj is Vo_grid == false)
         {
            point = new Point(Global.stage.mouseX + 10,Global.stage.mouseY + 10);
            if(point.x + view_tip.width > Global.stage.stageWidth)
            {
               view_tip.x = point.x - view_tip.width;
               if(view_tip.x < 0)
               {
                  view_tip.x = 0;
               }
            }
            else
            {
               view_tip.x = point.x;
            }
            if(point.y + view_tip.height > Global.stage.stageHeight)
            {
               view_tip.y = point.y - view_tip.height - 10;
            }
            else
            {
               view_tip.y = point.y;
            }
            if(view_tip.y < 0)
            {
               view_tip.y = 0;
            }
         }
         view_tip.Show(obj,type,stoneLvl);
         GameScene.upUILayer.addChild(view_tip);
      }
      
      public static function getEqView() : View_Equip
      {
         return view_tip_equip;
      }
      
      public static function getItView() : View_Item
      {
         return view_tip_item;
      }
      
      public static function hide() : void
      {
         if(Boolean(view_tip) && GameScene.upUILayer.contains(view_tip))
         {
            GameScene.upUILayer.removeChild(view_tip);
         }
         if(Boolean(view_equip))
         {
            view_equip.visible = false;
         }
      }
      
      private static function show_sub(vo:Vo_equip, type:int = 1, stoneLvl:int = 0) : void
      {
         var vo_equip:Vo_equip = null;
         var min:int = 0;
         if(vo.bDress)
         {
            return;
         }
         var vec:Vector.<Vo_equip> = CommandManager.get_role_vec_equip();
         switch(vo.type)
         {
            case Enum_equip_type.WEAPON:
               vo_equip = vec[Enum_role_equip.WEAPON];
               break;
            case Enum_equip_type.CLOTH:
               vo_equip = vec[Enum_role_equip.CLOTH];
               break;
            case Enum_equip_type.PANT:
               vo_equip = vec[Enum_role_equip.PANT];
               break;
            case Enum_equip_type.SHOE:
               vo_equip = vec[Enum_role_equip.SHOE];
               break;
            case Enum_equip_type.HAT:
               vo_equip = vec[Enum_role_equip.HAT];
               break;
            case Enum_equip_type.SASH:
               vo_equip = vec[Enum_role_equip.SASH];
               break;
            case Enum_equip_type.WRISTLET:
               vo_equip = vec[Enum_role_equip.WRISTLET];
               break;
            case Enum_equip_type.NECKLACE:
               vo_equip = vec[Enum_role_equip.NECKLACE];
               break;
            case Enum_equip_type.RING:
               min = int.MAX_VALUE;
               vo_equip = null;
               if(vec[Enum_role_equip.RING1] != null)
               {
                  min = vec[Enum_role_equip.RING1].strength;
                  vo_equip = vec[Enum_role_equip.RING1];
               }
               if(vec[Enum_role_equip.RING2] != null)
               {
                  if(min > vec[Enum_role_equip.RING2].strength)
                  {
                     min = vec[Enum_role_equip.RING2].strength;
                     vo_equip = vec[Enum_role_equip.RING2];
                  }
               }
               break;
            case Enum_equip_type.FASHION:
               vo_equip = vec[Enum_role_equip.FASHION];
               break;
            case Enum_equip_type.RIDE:
               vo_equip = vec[Enum_role_equip.RIDE];
         }
         if(Boolean(vo_equip))
         {
            view_equip.Show(vo_equip,1);
            view_equip.visible = true;
         }
      }
      
      public static function bind(target:DisplayObject, str:Object, posA:Array = null) : void
      {
         if(Boolean(targetDic[target]))
         {
            targetDic[target] = str;
            if(Boolean(posA))
            {
               _typeDic[target] = posA;
            }
            return;
         }
         targetDic[target] = str;
         if(Boolean(posA))
         {
            _typeDic[target] = posA;
         }
         target.addEventListener(MouseEvent.ROLL_OVER,rollOver);
         target.addEventListener(MouseEvent.MOUSE_MOVE,rollOver);
         target.addEventListener(MouseEvent.ROLL_OUT,rollOut);
      }
      
      public static function unBind(target:DisplayObject) : void
      {
         if(!targetDic[target])
         {
            return;
         }
         target.removeEventListener(MouseEvent.ROLL_OVER,rollOver);
         target.removeEventListener(MouseEvent.MOUSE_MOVE,rollOver);
         target.removeEventListener(MouseEvent.ROLL_OUT,rollOut);
         delete targetDic[target];
      }
      
      private static function rollOver(e:MouseEvent) : void
      {
         update(targetDic[e.currentTarget],1,0,_typeDic[e.currentTarget]);
      }
      
      private static function rollOut(e:MouseEvent) : void
      {
         hide();
      }
   }
}

