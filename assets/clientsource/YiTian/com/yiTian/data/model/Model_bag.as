package com.yiTian.data.model
{
   import com.utils.ColorConstant;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.config.valuable.Enum_equip_type;
   import com.yiTian.data.config.valuable.Enum_equip_type_group;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.config.valuable.Enum_item_type;
   import com.yiTian.data.config.valuable.Enum_item_type_result;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.MiJingCangZong.View_MiJingCangZong_menu;
   import com.yiTian.view.modules.Shopping.shoppingMall.ShoppingMallPan;
   import com.yiTian.view.modules.YueBingShangCheng.View_YueBingShangCheng;
   import com.yiTian.view.modules.activity.kaifuItem.Model_KaiFuGem;
   import com.yiTian.view.modules.chatM.face.Model_face;
   import com.yiTian.view.modules.gongcehuodong.View_GongCejishi;
   import com.yiTian.view.modules.horse.View_horseLibPanel;
   import com.yiTian.view.modules.horse.View_horsePanel;
   import com.yiTian.view.modules.newRolePan.View_rolePan;
   import com.yiTian.view.modules.newYear.Config_NewYear;
   import com.yiTian.view.modules.newYear.View_nianGaoSMailPnl;
   import com.yiTian.view.modules.panel.Enum_panel_cast;
   import com.yiTian.view.modules.panel.Enum_panel_role;
   import com.yiTian.view.modules.pet.PetPanel;
   import com.yiTian.view.modules.skill.View_SkillPanel;
   import com.yiTian.view.modules.tianMing.View_BlessingFruit;
   import com.yiTian.view.modules.tianMing.View_TianMing;
   import com.yiTian.view.modules.tuanGou.tuanGouLBYH.CangBaoTuPan;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import com.yiTian.view.modules.wuXing.WuxingIconTip;
   import com.yiTian.view.modules.xunZhang.XunZhang;
   import flash.events.MouseEvent;
   
   public class Model_bag
   {
      
      public static var curTime:uint;
      
      public static var openType:int;
      
      private static const MAX_CANUSE:int = 180;
      
      public static var curLeftCDs:int = 5000;
      
      public static var PWD_TYPE_SETTING_0:int = 0;
      
      public static var PWD_TYPE_SETTING_1:int = 1;
      
      public static var PWD_TYPE_SETTING_2:int = 2;
      
      public static var PWD_TYPE_SETTING_3:int = 3;
      
      public static var PWD_TYPE_SETTING_4:int = 4;
      
      public static var PWD_STATE_UNLOCK_T:int = 0;
      
      public static var PWD_STATE_UNLOCK_F:int = 1;
      
      public static var PWD_STATE_LOCK_T:int = 2;
      
      public static var EJiMiMaSOURCE_URL:String = "lang/ch/EJMiMa_Imgs.swf";
      
      public static var MIN_PWD_LEN:int = 6;
      
      public static var pwdLockState:int = 0;
      
      public static var pwdResetLeftDays:int = 0;
      
      public static var isCastDiscard:int = 0;
      
      public static var PWD_MAX_RESET_DAYS:int = 3;
      
      public static var colorArr:Array = [1,2,3,4,5];
      
      private var bInit_canUse:Boolean;
      
      private var _canUse:int;
      
      private var _used:int;
      
      private var vec:Vector.<Vo_valuable>;
      
      private var i:int;
      
      private var len:int;
      
      public function Model_bag()
      {
         super();
         this.bInit_canUse = false;
      }
      
      public static function handleOf(vo_item:Vo_item) : void
      {
         var targetPnl:View_nianGaoSMailPnl = null;
         var viewT:int = 0;
         var arr:Array = null;
         var pan:ShoppingMallPan = null;
         var pnl:View_horsePanel = null;
         var horseLibPnl:View_horseLibPanel = null;
         var temId:int = vo_item.id;
         var _type:int = vo_item.type;
         if(Global.pf == "qqgame")
         {
            if(vo_item.id == 46415)
            {
               UIManager.centerBroadcast.addMsg("麒麟卡只能在黄钻区域才能使用");
               return;
            }
         }
         else if(vo_item.id == 46463)
         {
            UIManager.centerBroadcast.addMsg("布鲁卡只能在蓝钻区域才能使用");
            return;
         }
         if(vo_item.id == Config_NewYear.NIANGAOID)
         {
            targetPnl = Singleton.getInstance(View_nianGaoSMailPnl);
            Global.delegate.dosomething(targetPnl,targetPnl.show);
            return;
         }
         if(vo_item.type == 394 || vo_item.type == 390)
         {
            viewT = vo_item.type == 394 ? 1 : 0;
            if(Boolean(Model_role.xunZhangVo))
            {
               WuXingMter.getPan(XunZhang,function(pan:XunZhang):void
               {
                  pan.openView(viewT);
               });
            }
            else
            {
               UIManager.centerBroadcast.addMsg("您还没有佩戴勋章哦亲");
            }
            return;
         }
         if(temId == 44648)
         {
            if(GameUnitManager.hero.level >= 50)
            {
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(9);
               }
               else
               {
                  UIManager.castPanel.openView(9);
               }
            }
            return;
         }
         if(vo_item.id == 44979)
         {
            if(!CangBaoTuPan.instance.visible)
            {
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(CangBaoTuPan.instance,function():void
               {
                  CangBaoTuPan.instance.show(vo_item.id,vo_item.gridId);
               });
            }
            else
            {
               UIManager.centerBroadcast.addMsg("藏宝图已打开");
            }
            return;
         }
         if(vo_item.id == 44684 || vo_item.id == 44685)
         {
            UIManager.petPanel.visible = true;
            UIManager.petPanel.btnVec[3].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            return;
         }
         if(vo_item.id == 44701)
         {
            Global.delegate.dosomething(View_MiJingCangZong_menu.instance,function():void
            {
               View_MiJingCangZong_menu.instance.visible = true;
            });
            return;
         }
         if(vo_item.id == 45006)
         {
            Global.delegate.dosomething(View_YueBingShangCheng.instance,function():void
            {
               View_YueBingShangCheng.instance.visible = true;
            });
            return;
         }
         if(vo_item.id >= 45554 && vo_item.id <= 45560)
         {
            UIManager.centerBroadcast.addMsg("集市已关闭，请把字出售商店",1);
            return;
         }
         if(vo_item.id >= 45611 && vo_item.id <= 45617)
         {
            Global.delegate.dosomething(View_GongCejishi.instance,function():void
            {
               View_GongCejishi.instance.visible = true;
            });
         }
         if(vo_item.type == 420)
         {
            if(Model_wing.HuanHuaDanID > 0 && vo_item.id != Data_lib.wingChange[Model_wing.HuanHuaDanID][0])
            {
               View_Alert.show("你确定要用" + HtmlUtil.font(vo_item.str_name,ColorConstant.getItemColorStr((vo_item as Vo_valuable).color)) + "覆盖" + HtmlUtil.font(Data_lib.item[Data_lib.wingChange[Model_wing.HuanHuaDanID][0]][1],ColorConstant.getItemColorStr(Data_lib.item[Data_lib.wingChange[Model_wing.HuanHuaDanID][0]][12])) + "吗？",2,function():void
               {
                  BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo_item.gridId,1);
               },null,null,null,340);
            }
            else
            {
               BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo_item.gridId,1);
            }
            return;
         }
         if(vo_item.type == 428)
         {
            for each(arr in Model_face.data)
            {
               if(vo_item.face_icon_id != 0 && arr[0] == vo_item.face_icon_id)
               {
                  UIManager.centerBroadcast.addMsg("在有效期内不能使用同样表情",1);
                  return;
               }
            }
            BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo_item.gridId,1);
            return;
         }
         switch(_type)
         {
            case 220:
               UIManager.petPanel.openView(PetPanel.NEIDAN,temId);
               break;
            case 230:
               UIManager.petPanel.openView(PetPanel.XIZI,temId);
               break;
            case 240:
               UIManager.petPanel.openView(PetPanel.LIANHUA,temId);
               break;
            case 1:
            case 107:
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(1);
                  break;
               }
               UIManager.castPanel.openView(1);
               break;
            case 102:
            case 104:
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(0);
                  break;
               }
               UIManager.castPanel.openView(0);
               break;
            case 108:
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(2);
                  break;
               }
               UIManager.castPanel.openView(2);
               break;
            case 121:
               UIManager.mappanel.visible = true;
               UIManager.mappanel.setSXM();
               break;
            case 130:
            case 131:
               UIManager.skillPanel.visible = true;
               UIManager.skillPanel.get_first_grid_select(0);
               break;
            case 160:
               pan = Singleton.getInstance(ShoppingMallPan) as ShoppingMallPan;
               pan.visible = true;
               break;
            case 170:
               WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
               {
                  pan.showView(Enum_panel_role.MERIDIAN);
               });
               break;
            case 310:
               pnl = Singleton.getInstance(View_horsePanel);
               Global.delegate.dosomething(pnl,function():void
               {
                  pnl.show(1);
               });
               break;
            case 300:
            case 387:
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(5);
                  break;
               }
               UIManager.castPanel.openView(5);
               break;
            case 180:
            case 181:
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(6);
                  break;
               }
               UIManager.castPanel.openView(6);
               break;
            case 338:
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(2);
                  break;
               }
               UIManager.castPanel.openView(2);
               break;
            case 320:
               UIManager.chatPanel.getExtrLaba();
               break;
            case 344:
            case 345:
            case 415:
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(Enum_panel_cast.EQUIP_CZ_JINGLIAN);
                  break;
               }
               UIManager.castPanel.openView(Enum_panel_cast.EQUIP_CZ_JINGLIAN);
               break;
            case 346:
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(Enum_panel_cast.EQUIP_CZ_XILIAN);
                  break;
               }
               UIManager.castPanel.openView(Enum_panel_cast.EQUIP_CZ_XILIAN);
               break;
            case 363:
               View_TianMing.instance.visible = true;
               break;
            case 382:
               View_TianMing.instance.visible = true;
               View_BlessingFruit.instance.visible = true;
               break;
            case 378:
               UIManager.skillPanel.handleHighLevelBookUse(vo_item);
               break;
            case 387:
               UIManager.castPanel.visible = true;
               UIManager.castPanel.openView(5);
               break;
            case 388:
               horseLibPnl = Singleton.getInstance(View_horseLibPanel);
               Global.delegate.dosomething(horseLibPnl,function():void
               {
                  horseLibPnl.show(1);
               });
               break;
            case 389:
               WuxingIconTip.cliHd();
               break;
            case 4:
               if(GameUnitManager.hero.level < 50)
               {
                  UIManager.centerBroadcast.addMsg("50级开启神装晋级");
                  return;
               }
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(10);
                  break;
               }
               UIManager.castPanel.openView(10);
               break;
            case 421:
               View_SkillPanel.openType = 1;
               UIManager.skillPanel.visible = !UIManager.skillPanel.visible;
               break;
            case 422:
               Model_KaiFuGem.askOpenDiscountView(vo_item.id,vo_item.gridId);
               break;
            case 423:
               BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo_item.gridId,1);
         }
      }
      
      public function init(equips:Array, items:Array) : void
      {
         this.vec = new Vector.<Vo_valuable>(MAX_CANUSE);
         this.set_vec_equip(equips);
         this.set_vec_item(items);
         this.update_used();
      }
      
      public function tidy(equips:Array, items:Array) : void
      {
         this.vec = new Vector.<Vo_valuable>(MAX_CANUSE);
         this.set_vec_equip(equips);
         this.set_vec_item(items);
         this.update_used();
      }
      
      public function update(equips:Array, items:Array, bTip:Boolean = false) : void
      {
         this.set_vec_equip(equips,bTip);
         this.set_vec_item(items,bTip);
         this.update_used();
      }
      
      public function empty_some(arr_gridId:Array) : void
      {
         this.len = arr_gridId.length;
         this.i = 0;
         while(this.i < this.len)
         {
            this.vec[arr_gridId[this.i] - 1] = null;
            ++this.i;
         }
         this.update_used();
      }
      
      public function get_vec_filter(filter:int, $v:Vector.<Vo_valuable> = null, arr_id:Array = null) : Vector.<Vo_valuable>
      {
         var vo_item:Vo_item = null;
         var i:int = 0;
         var j:int = 0;
         var temNum:int = 0;
         var jj:int = 0;
         var v:Vector.<Vo_valuable> = new Vector.<Vo_valuable>();
         if($v == null)
         {
            $v = this.vec;
         }
         if($v == null)
         {
            return new Vector.<Vo_valuable>();
         }
         this.len = $v.length;
         switch(filter)
         {
            case Enum_filter.ALL:
               return $v;
            case Enum_filter.EQUIP_ALL:
               this.i = 0;
               while(this.i < this.len)
               {
                  if($v[this.i] is Vo_equip)
                  {
                     v.push($v[this.i]);
                  }
                  ++this.i;
               }
               break;
            case Enum_filter.EQUIP_ALL_INTENS:
               this.i = 0;
               while(this.i < this.len)
               {
                  if($v[this.i] is Vo_equip && ($v[this.i] as Vo_equip).type != 12 && ($v[this.i] as Vo_equip).type != 10 && (($v[this.i] as Vo_equip).lv != 21 || ($v[this.i] as Vo_equip).lv != 32) && ($v[this.i] as Vo_equip).id != 99121 && ($v[this.i] as Vo_equip).id != 99122 && ($v[this.i] as Vo_equip).lv < 32)
                  {
                     v.push($v[this.i]);
                  }
                  ++this.i;
               }
               break;
            case Enum_filter.EQUIP_ALL_INTENS_CHANGE:
               this.i = 0;
               while(this.i < this.len)
               {
                  if($v[this.i] is Vo_equip && ($v[this.i] as Vo_equip).type != 12 && ($v[this.i] as Vo_equip).id != 96679 && ($v[this.i] as Vo_equip).id != 96680 && ($v[this.i] as Vo_equip).id != 96681 && ($v[this.i] as Vo_equip).id != 96682 && ($v[this.i] as Vo_equip).id != 96683 && ($v[this.i] as Vo_equip).id != 96684 && ($v[this.i] as Vo_equip).id != 96685 && ($v[this.i] as Vo_equip).id != 96686 && ($v[this.i] as Vo_equip).id != 96687 && ($v[this.i] as Vo_equip).id != 96688)
                  {
                     v.push($v[this.i]);
                  }
                  ++this.i;
               }
               break;
            case Enum_filter.EQUIP_CAN_DIANHUA:
               this.i = 0;
               while(this.i < this.len)
               {
                  if($v[this.i] is Vo_equip && ($v[this.i] as Vo_equip).id_tz != 0 && ($v[this.i] as Vo_equip).color >= 4 && ($v[this.i] as Vo_equip).lv_use >= 50 && (($v[this.i] as Vo_equip).id_tz == 4 || ($v[this.i] as Vo_equip).id_tz == 6 || ($v[this.i] as Vo_equip).id_tz == 8))
                  {
                     v.push($v[this.i]);
                  }
                  ++this.i;
               }
               break;
            case Enum_filter.EQUIP_CAN_JINJI:
               this.i = 0;
               while(this.i < this.len)
               {
                  if($v[this.i] is Vo_equip && ($v[this.i] as Vo_equip).type != 12 && ($v[this.i] as Vo_equip).type != 10 && ($v[this.i] as Vo_equip).type != 11 && (($v[this.i] as Vo_equip).lv == 10 || ($v[this.i] as Vo_equip).lv == 21) && ($v[this.i] as Vo_equip).color >= 4)
                  {
                     v.push($v[this.i]);
                  }
                  ++this.i;
               }
               break;
            case Enum_filter.ITEM_ALL:
               this.i = 0;
               while(this.i < this.len)
               {
                  if($v[this.i] is Vo_item)
                  {
                     v.push($v[this.i]);
                  }
                  ++this.i;
               }
               break;
            case Enum_filter.ID:
               i = 0;
               while(i < arr_id.length)
               {
                  j = 0;
                  while(j < this.len)
                  {
                     if(Boolean($v[j]) && arr_id[i] == $v[j].id)
                     {
                        v.push($v[j]);
                     }
                     j++;
                  }
                  i++;
               }
               break;
            case Enum_filter.WHITE:
               i = 0;
               while(i < this.len)
               {
                  if(Boolean($v[i]) && $v[i].color == Enum_color.WHITE)
                  {
                     v.push($v[i]);
                  }
                  i++;
               }
               break;
            case Enum_filter.GREEN:
               i = 0;
               while(i < this.len)
               {
                  if(Boolean($v[i]) && $v[i].color == Enum_color.GREEN)
                  {
                     v.push($v[i]);
                  }
                  i++;
               }
               break;
            case Enum_filter.BLUE:
               i = 0;
               while(i < this.len)
               {
                  if(Boolean($v[i]) && $v[i].color == Enum_color.BLUE)
                  {
                     v.push($v[i]);
                  }
                  i++;
               }
               break;
            case Enum_filter.PUPLE:
               i = 0;
               while(i < this.len)
               {
                  if(Boolean($v[i]) && $v[i].color == Enum_color.PURPLE)
                  {
                     v.push($v[i]);
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_HOLE:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if($v[i].type != Enum_equip_type.FASHION && $v[i].type != Enum_equip_type.RIDE && $v[i].type != 12)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_INLAY:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if($v[i].type != Enum_equip_type.FASHION && $v[i].type != Enum_equip_type.RIDE)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_UNLOAD:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if($v[i].type != Enum_equip_type.FASHION && $v[i].type != Enum_equip_type.RIDE)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_INTENSIFY:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     v.push($v[i]);
                  }
                  i++;
               }
               break;
            case Enum_filter.CZ_EQUIP:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip && $v[i].color >= 5 || $v[i] is Vo_equip && $v[i].color == 4 && $v[i].lv_use >= 50)
                  {
                     if(!($v[i].color == 6 && ($v[i] as Vo_equip).maxRefine != 0 && ($v[i] as Vo_equip).maxRefine == ($v[i] as Vo_equip).jingLianCount || $v[i].id == 99509 || $v[i] is Vo_equip && $v[i].color == 5 && $v[i] is Vo_equip && $v[i].lv_use < 110 && ($v[i] as Vo_equip).maxRefine != 0 && ($v[i] as Vo_equip).maxRefine == ($v[i] as Vo_equip).jingLianCount))
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.CG_XILIAN_EQUIP:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip && $v[i].color >= 5 && $v[i].id != 99509 && $v[i].type != 12)
                  {
                     v.push($v[i]);
                  }
                  i++;
               }
               break;
            case Enum_filter.GEM_COMPOSE:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_item)
                  {
                     vo_item = $v[i] as Vo_item;
                     if(vo_item.type == Enum_item_type.GEM)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.COMPOSED_WP:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_item)
                  {
                     vo_item = $v[i] as Vo_item;
                     if(vo_item.num_combining > 0)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_DECOMPOSE:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     temNum = this.handle(($v[i] as Vo_equip).vec_gemId);
                     if($v[i].type != Enum_equip_type.FASHION && $v[i].type != Enum_equip_type.RIDE && temNum == -1 && ($v[i] as Vo_equip).color != 5 && $v[i].type != 12 && $v[i].color != 6 && $v[i].lv < 22)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_POLISH:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if($v[i].type != Enum_equip_type.FASHION && $v[i].type != Enum_equip_type.RIDE && $v[i].type != 12)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_ARMOR:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if(($v[i] as Vo_equip).type_group == Enum_equip_type_group.ARMOR)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_JEWELRY:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if(($v[i] as Vo_equip).type_group == Enum_equip_type_group.JEWELRY)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_WEAPON:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if(($v[i] as Vo_equip).type == Enum_equip_type.WEAPON)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_CLOTH:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if(($v[i] as Vo_equip).type == Enum_equip_type.CLOTH)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_PANT:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if(($v[i] as Vo_equip).type == Enum_equip_type.PANT)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_SHOE:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if(($v[i] as Vo_equip).type == Enum_equip_type.SHOE)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_HAT:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if(($v[i] as Vo_equip).type == Enum_equip_type.HAT)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_SASH:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if(($v[i] as Vo_equip).type == Enum_equip_type.SASH)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_WRISTLET:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if(($v[i] as Vo_equip).type == Enum_equip_type.WRISTLET)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_NECKLACE:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if(($v[i] as Vo_equip).type == Enum_equip_type.NECKLACE)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_RING:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if(($v[i] as Vo_equip).type == Enum_equip_type.RING)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_RIDE:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if(($v[i] as Vo_equip).type == Enum_equip_type.RIDE)
                     {
                        if(($v[i] as Vo_equip).id != 99509)
                        {
                           v.push($v[i]);
                        }
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.EQUIP_FASHION:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     if(($v[i] as Vo_equip).type == Enum_equip_type.FASHION)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.GRID_ID:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_valuable)
                  {
                     jj = 0;
                     while(jj < arr_id.length)
                     {
                        if(($v[i] as Vo_valuable).gridId == arr_id[jj])
                        {
                           v.push($v[i]);
                        }
                        jj++;
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.TYPE_CREATE:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_item)
                  {
                     jj = 0;
                     while(jj < arr_id.length)
                     {
                        if(($v[i] as Vo_item).type == arr_id[jj])
                        {
                           v.push($v[i]);
                        }
                        jj++;
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.SEVER_ID:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_equip)
                  {
                     jj = 0;
                     while(jj < arr_id.length)
                     {
                        if(($v[i] as Vo_equip).id_server == arr_id[jj])
                        {
                           v.push($v[i]);
                        }
                        jj++;
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.ITEM_GEM:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_item)
                  {
                     if(($v[i] as Vo_item).type == Enum_item_type.GEM)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.ITEM_STUFF:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_item)
                  {
                     if(($v[i] as Vo_item).type == Enum_item_type.STUFF)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.ITEM_ELSE:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_item)
                  {
                     vo_item = $v[i] as Vo_item;
                     if(vo_item.type != Enum_item_type.STUFF && vo_item.type != Enum_item_type.GEM)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.ITEM_DRUG_LIFE:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_item)
                  {
                     vo_item = $v[i] as Vo_item;
                     if(vo_item.type == Enum_item_type.DRUG && vo_item.type_result == Enum_item_type_result.LIFE)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.ITEM_DRUG_MANA:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_item)
                  {
                     vo_item = $v[i] as Vo_item;
                     if(vo_item.type == Enum_item_type.DRUG && vo_item.type_result == Enum_item_type_result.MANA)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.ITEM_PET_NEIDAN:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_item)
                  {
                     if($v[i].type == Enum_item_type.PET_NEIDAN)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.ITEM_PET_APTITUDE:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_item)
                  {
                     if($v[i].type == Enum_item_type.PET_APTITUDE)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.ITEM_PET_GROW:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_item)
                  {
                     if($v[i].type == Enum_item_type.PET_GROW)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.ITEM_BUFF_LIFE:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_item)
                  {
                     vo_item = $v[i] as Vo_item;
                     if(vo_item.type == Enum_item_type.BAG_LIFE)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
               break;
            case Enum_filter.ITEM_BUFF_MANA:
               i = 0;
               while(i < this.len)
               {
                  if($v[i] is Vo_item)
                  {
                     vo_item = $v[i] as Vo_item;
                     if(vo_item.type == Enum_item_type.BAG_MANA)
                     {
                        v.push($v[i]);
                     }
                  }
                  i++;
               }
         }
         this.update_used();
         return v;
      }
      
      private function handle(vecArr:Vector.<int>) : int
      {
         var i:int = 0;
         while(i < vecArr.length)
         {
            if(vecArr[i] != 0)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      public function get_count(id:int, bind:int = 2) : int
      {
         var vo:Vo_valuable = null;
         var count:int = 0;
         if(!this.vec)
         {
            return 0;
         }
         this.len = this.vec.length;
         if(bind == 2)
         {
            this.i = 0;
            while(this.i < this.len)
            {
               vo = this.vec[this.i];
               if(Boolean(vo) && vo.id == id)
               {
                  count += vo.count;
               }
               ++this.i;
            }
         }
         else if(bind == 1)
         {
            this.i = 0;
            while(this.i < this.len)
            {
               vo = this.vec[this.i];
               if(Boolean(vo) && Boolean(vo.id == id) && vo.bBind == false)
               {
                  count += vo.count;
               }
               ++this.i;
            }
         }
         else if(bind == 0)
         {
            this.i = 0;
            while(this.i < this.len)
            {
               vo = this.vec[this.i];
               if(Boolean(vo) && Boolean(vo.id == id) && vo.bBind)
               {
                  count += vo.count;
               }
               ++this.i;
            }
         }
         return count;
      }
      
      public function getUseGridIdById(_id:int) : int
      {
         var vo:Vo_valuable = null;
         var i:int = 0;
         while(i < this.len)
         {
            vo = this.vec[i];
            if(Boolean(vo) && vo.id == _id)
            {
               return vo.gridId;
            }
            i++;
         }
         return 0;
      }
      
      public function set canUse(value:int) : void
      {
         this._canUse = value;
         if(this._canUse > MAX_CANUSE)
         {
            try
            {
               throw new Error("可用格子数>180");
            }
            catch(e:Error)
            {
               Utils.print("可用格子数>180",e.getStackTrace(),e);
            }
         }
         if(this.bInit_canUse)
         {
            while(this.vec.length < this._canUse)
            {
               this.vec.push(null);
            }
            CommandManager.update_bag();
         }
         else
         {
            this.bInit_canUse = true;
         }
      }
      
      public function get canUse() : int
      {
         return this._canUse;
      }
      
      public function get used() : int
      {
         return this._used;
      }
      
      private function update_used() : void
      {
         this._used = 0;
         this.i = 0;
         while(this.i < this._canUse)
         {
            if(this.vec[this.i] != null)
            {
               ++this._used;
            }
            ++this.i;
         }
      }
      
      private function set_vec_equip(equips:Array, bTip:Boolean = false) : void
      {
         var vo_equip:Vo_equip = null;
         var vec_temp:Vector.<Vo_valuable> = null;
         if(!equips)
         {
            return;
         }
         if(bTip)
         {
            vec_temp = new Vector.<Vo_valuable>();
            this.i = 0;
            while(this.i < equips.length)
            {
               vo_equip = new Vo_equip();
               vo_equip.Init_sever_bag(equips[this.i]);
               this.vec[vo_equip.gridId - 1] = vo_equip;
               vec_temp.push(vo_equip);
               ++this.i;
            }
            CommandManager.inform_updateTip(vec_temp);
         }
         else
         {
            this.i = 0;
            while(this.i < equips.length)
            {
               vo_equip = new Vo_equip();
               vo_equip.Init_sever_bag(equips[this.i]);
               this.vec[vo_equip.gridId - 1] = vo_equip;
               ++this.i;
            }
         }
      }
      
      private function set_vec_item(items:Array, bTip:Boolean = false) : void
      {
         var vo_item:Vo_item = null;
         var vec_temp:Vector.<Vo_valuable> = null;
         if(!items)
         {
            return;
         }
         if(bTip)
         {
            vec_temp = new Vector.<Vo_valuable>();
            this.i = 0;
            while(this.i < items.length)
            {
               vo_item = new Vo_item();
               vo_item.Init_sever_bag(items[this.i]);
               this.vec[vo_item.gridId - 1] = vo_item;
               vec_temp.push(vo_item);
               ++this.i;
            }
            CommandManager.inform_updateTip(vec_temp);
         }
         else
         {
            this.i = 0;
            while(this.i < items.length)
            {
               vo_item = new Vo_item();
               vo_item.Init_sever_bag(items[this.i]);
               this.vec[vo_item.gridId - 1] = vo_item;
               ++this.i;
            }
         }
      }
      
      public function getGridId(id:int, needCount:int, bind:int = 2) : String
      {
         var vo:Vo_valuable = null;
         var len:int = 0;
         var num:int = 0;
         var prevSum:int = 0;
         var disNum:int = 0;
         var result:String = null;
         var arr:Array = [];
         var idStr:String = "";
         var countStr:String = "";
         if(!this.vec)
         {
            return "0";
         }
         this.len = this.vec.length;
         if(bind == 2)
         {
            this.i = 0;
            while(this.i < this.len)
            {
               vo = this.vec[this.i];
               if(Boolean(vo) && vo.id == id)
               {
                  arr.push({
                     "gridId":vo.gridId,
                     "count":vo.count
                  });
               }
               ++this.i;
            }
         }
         else if(bind == 1)
         {
            this.i = 0;
            while(this.i < this.len)
            {
               vo = this.vec[this.i];
               if(Boolean(vo) && Boolean(vo.id == id) && vo.bBind == false)
               {
                  arr.push({
                     "gridId":vo.gridId,
                     "count":vo.count
                  });
               }
               ++this.i;
            }
         }
         else if(bind == 0)
         {
            this.i = 0;
            while(this.i < this.len)
            {
               vo = this.vec[this.i];
               if(Boolean(vo) && Boolean(vo.id == id) && vo.bBind)
               {
                  arr.push({
                     "gridId":vo.gridId,
                     "count":vo.count
                  });
               }
               ++this.i;
            }
         }
         if(Boolean(arr.length))
         {
            len = int(arr.length);
            num = 0;
            prevSum = 0;
            disNum = 0;
            this.i = 0;
            while(this.i < len)
            {
               prevSum = num;
               num += arr[this.i].count;
               if(num >= needCount)
               {
                  disNum = needCount - prevSum;
                  idStr += arr[this.i].gridId + "";
                  countStr += disNum + "";
                  return idStr + "," + countStr;
               }
               idStr += arr[this.i].gridId + "_";
               countStr += arr[this.i].count + "_";
               ++this.i;
            }
            if(num < needCount)
            {
               return "0";
            }
         }
         return "0";
      }
      
      public function getIdByName(str:String) : Array
      {
         var vo:Vo_valuable = null;
         var len:int = int(this.vec.length);
         var arr:Array = [];
         this.i = 0;
         while(this.i < len)
         {
            vo = this.vec[this.i];
            if(Boolean(vo) && vo.str_name == str)
            {
               arr.push(vo.id);
            }
            ++this.i;
         }
         return arr;
      }
   }
}

