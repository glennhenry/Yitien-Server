package com.yiTian.manager
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.valuable.Enum_equip_type;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.config.valuable.Enum_item_type;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.net.handler.FruitShopHandler;
   import com.yiTian.view.modules.guaji.Model_guajiInfo;
   import com.yiTian.view.modules.newRolePan.ComparePan;
   import com.yiTian.view.modules.role.Enum_role_equip;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   
   public class CommandManager
   {
      
      private static var i:int;
      
      private static var len:int;
      
      public function CommandManager()
      {
         super();
      }
      
      public static function inform_bagVisible(value:Boolean) : void
      {
         if(!value)
         {
            if(UIManager.zaHuoDian.visible)
            {
               UIManager.zaHuoDian.visible = false;
            }
            if(UIManager.sold_set.visible)
            {
               UIManager.sold_set.visible = false;
            }
         }
      }
      
      public static function inform_updateTip(vec_temp:Vector.<Vo_valuable>) : void
      {
         var vo_item:Vo_item = null;
         var vo_equip:Vo_equip = null;
         var vec_role:Vector.<Vo_equip> = null;
         len = vec_temp.length;
         i = 0;
         for(; i < len; ++i)
         {
            if(vec_temp[i] is Vo_item)
            {
               vo_item = vec_temp[i] as Vo_item;
               if(vo_item.type == Enum_item_type.VIP)
               {
                  if(GameUnitManager.hero.vip == 0)
                  {
                     UIManager.panel_updateTip.update(vo_item);
                  }
               }
               else if(vo_item.type == Enum_item_type.MERIDIAN_PILL)
               {
                  UIManager.panel_updateTip.update(vo_item);
               }
               else if(vo_item.type == Enum_item_type.BAG_LIFE || vo_item.type == Enum_item_type.BAG_MANA)
               {
                  UIManager.panel_updateTip.update(vo_item);
               }
               else if(vo_item.type == Enum_item_type.BAG_FRESHMAN)
               {
                  if(GameUnitManager.hero.level >= Data_lib.item[vo_item.id][Enum_lib_item.LV_USE])
                  {
                     UIManager.panel_updateTip.update(vo_item);
                  }
               }
               else if(vo_item.type == Enum_item_type.BOOK_SKILL_UP)
               {
                  if(UIManager.skillPanel.canUpSkill(vo_item) != null)
                  {
                     UIManager.panel_updateTip.update(vo_item);
                  }
               }
               else if(vo_item.type == Enum_item_type.BOOK_SKILL)
               {
                  if(UIManager.skillPanel.canLearnd())
                  {
                     UIManager.panel_updateTip.update(vo_item);
                  }
               }
               else if(vo_item.type == Enum_item_type.FUYUAN_WAWA)
               {
                  if(Model_guajiInfo.getInstance().wawaTime < 60)
                  {
                     UIManager.panel_updateTip.update(vo_item);
                  }
               }
               else if(vo_item.type == Enum_item_type.CHANGED_PET)
               {
                  UIManager.panel_updateTip.update(vo_item);
               }
               else if(vo_item.type == 423)
               {
                  UIManager.panel_updateTip.update(vo_item);
               }
            }
            else if(vec_temp[i] is Vo_equip)
            {
               vo_equip = vec_temp[i] as Vo_equip;
               if(vo_equip.lv_use <= GameUnitManager.hero.level)
               {
                  if(!(vo_equip.job != 5 && Enum_job.getBaseJob(GameUnitManager.hero.job) != vo_equip.job))
                  {
                     if(!(vo_equip.sex != 0 && GameUnitManager.hero.sex != vo_equip.sex))
                     {
                        vec_role = ModelManager.rolePanel.vec_equip;
                        if(vo_equip.type == Enum_equip_type.WEAPON)
                        {
                           if(Boolean(vec_role[Enum_role_equip.WEAPON]) && vec_role[Enum_role_equip.WEAPON].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.CLOTH)
                        {
                           if(Boolean(vec_role[Enum_role_equip.CLOTH]) && vec_role[Enum_role_equip.CLOTH].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.PANT)
                        {
                           if(Boolean(vec_role[Enum_role_equip.PANT]) && vec_role[Enum_role_equip.PANT].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.SHOE)
                        {
                           if(Boolean(vec_role[Enum_role_equip.SHOE]) && vec_role[Enum_role_equip.SHOE].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.HAT)
                        {
                           if(Boolean(vec_role[Enum_role_equip.HAT]) && vec_role[Enum_role_equip.HAT].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.SASH)
                        {
                           if(Boolean(vec_role[Enum_role_equip.SASH]) && vec_role[Enum_role_equip.SASH].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.WRISTLET)
                        {
                           if(Boolean(vec_role[Enum_role_equip.WRISTLET]) && vec_role[Enum_role_equip.WRISTLET].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.NECKLACE)
                        {
                           if(Boolean(vec_role[Enum_role_equip.NECKLACE]) && vec_role[Enum_role_equip.NECKLACE].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.RING)
                        {
                           if(Boolean(vec_role[Enum_role_equip.RING1] && vec_role[Enum_role_equip.RING1].strength >= vo_equip.strength) && Boolean(vec_role[Enum_role_equip.RING2]) && vec_role[Enum_role_equip.RING2].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.RIDE)
                        {
                           if(Boolean(vec_role[Enum_role_equip.RIDE]) && vec_role[Enum_role_equip.RIDE].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.FASHION)
                        {
                           if(Boolean(vec_role[Enum_role_equip.FASHION]) && Boolean(vec_role[Enum_role_equip.FASHION].strength >= vo_equip.strength) || vo_equip.daoTime == -2)
                           {
                              continue;
                           }
                        }
                        UIManager.panel_updateTip.update(vo_equip);
                     }
                  }
               }
            }
         }
      }
      
      public static function inform_hero_lvUp(lv:int) : void
      {
         var vo_item:Vo_item = null;
         var vo_equip:Vo_equip = null;
         var vec_role:Vector.<Vo_equip> = null;
         var vec_temp:Vector.<Vo_valuable> = ModelManager.bag.get_vec_filter(Enum_filter.ALL);
         len = vec_temp.length;
         i = 0;
         for(; i < len; ++i)
         {
            if(vec_temp[i] is Vo_item)
            {
               vo_item = vec_temp[i] as Vo_item;
               if(vo_item.type == Enum_item_type.BAG_FRESHMAN)
               {
                  if(lv >= Data_lib.item[vo_item.id][Enum_lib_item.LV_USE])
                  {
                     UIManager.panel_updateTip.update(vo_item);
                  }
               }
               else if(vo_item.type == Enum_item_type.MERIDIAN_PILL)
               {
                  UIManager.panel_updateTip.update(vo_item);
               }
               else if(vo_item.type == Enum_item_type.BOOK_SKILL_UP)
               {
                  if(Boolean(UIManager.skillPanel.canUpSkill(vo_item)))
                  {
                     UIManager.panel_updateTip.update(vo_item);
                  }
               }
               else if(vo_item.type == Enum_item_type.BOOK_SKILL)
               {
                  if(UIManager.skillPanel.canLearnd())
                  {
                     UIManager.panel_updateTip.update(vo_item);
                  }
               }
            }
            else if(vec_temp[i] is Vo_equip)
            {
               vo_equip = vec_temp[i] as Vo_equip;
               if(vo_equip.lv_use <= lv)
               {
                  if(!(vo_equip.job != 5 && Enum_job.getBaseJob(GameUnitManager.hero.job) != vo_equip.job))
                  {
                     if(!(vo_equip.sex != 0 && GameUnitManager.hero.sex != vo_equip.sex))
                     {
                        vec_role = ModelManager.rolePanel.vec_equip;
                        if(vo_equip.type == Enum_equip_type.WEAPON)
                        {
                           if(Boolean(vec_role[Enum_role_equip.WEAPON]) && vec_role[Enum_role_equip.WEAPON].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.CLOTH)
                        {
                           if(Boolean(vec_role[Enum_role_equip.CLOTH]) && vec_role[Enum_role_equip.CLOTH].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.PANT)
                        {
                           if(Boolean(vec_role[Enum_role_equip.PANT]) && vec_role[Enum_role_equip.PANT].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.SHOE)
                        {
                           if(Boolean(vec_role[Enum_role_equip.SHOE]) && vec_role[Enum_role_equip.SHOE].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.HAT)
                        {
                           if(Boolean(vec_role[Enum_role_equip.HAT]) && vec_role[Enum_role_equip.HAT].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.SASH)
                        {
                           if(Boolean(vec_role[Enum_role_equip.SASH]) && vec_role[Enum_role_equip.SASH].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.WRISTLET)
                        {
                           if(Boolean(vec_role[Enum_role_equip.WRISTLET]) && vec_role[Enum_role_equip.WRISTLET].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.NECKLACE)
                        {
                           if(Boolean(vec_role[Enum_role_equip.NECKLACE]) && vec_role[Enum_role_equip.NECKLACE].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.RING)
                        {
                           if(Boolean(vec_role[Enum_role_equip.RING1] && vec_role[Enum_role_equip.RING1].strength >= vo_equip.strength) && Boolean(vec_role[Enum_role_equip.RING2]) && vec_role[Enum_role_equip.RING2].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.RIDE)
                        {
                           if(Boolean(vec_role[Enum_role_equip.RIDE]) && vec_role[Enum_role_equip.RIDE].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        else if(vo_equip.type == Enum_equip_type.FASHION)
                        {
                           if(Boolean(vec_role[Enum_role_equip.FASHION]) && vec_role[Enum_role_equip.FASHION].strength >= vo_equip.strength)
                           {
                              continue;
                           }
                        }
                        UIManager.panel_updateTip.update(vo_equip);
                     }
                  }
               }
            }
         }
      }
      
      public static function update_depot() : void
      {
         UIManager.depotPanel.update();
      }
      
      public static function update_bag(result:int = 1, equips:Array = null) : void
      {
         UIManager.bagPanel.update();
         if(result != 7)
         {
            if(UIManager.castPanel.visible)
            {
               UIManager.castPanel.update_up_down();
            }
         }
         if(result == 4)
         {
            if(UIManager.castPanel.visible)
            {
               UIManager.castPanel.changeEquipBag(equips);
            }
         }
         Global.control.sendNotification(Enum_MsgType.BAG_UPDATE,null);
      }
      
      public static function get_depot_vec() : Vector.<Vo_valuable>
      {
         return ModelManager.depot.vec;
      }
      
      public static function get_depot_canUse() : int
      {
         return ModelManager.depot.canUse;
      }
      
      public static function get_depot_used() : int
      {
         return ModelManager.depot.getUsed();
      }
      
      public static function get_vec_meridian() : Vector.<int>
      {
         return ModelManager.rolePanel.vec_meridian;
      }
      
      public static function get_role_vec_equip() : Vector.<Vo_equip>
      {
         return ModelManager.rolePanel.vec_equip;
      }
      
      public static function get_otherRole_vec_equip() : Vector.<Vo_equip>
      {
         var vec_voEquip:Vector.<Vo_equip> = null;
         WuXingMter.getPan(ComparePan,function(pan:ComparePan):void
         {
            vec_voEquip = pan.vec_voEequip_cache;
         });
         return vec_voEquip;
      }
      
      public static function get_paiHang_vec_equip() : Vector.<Vo_equip>
      {
         return UIManager.paiHangPanel.vec_Vo_equip_cache;
      }
      
      public static function get_bag_vec(filter:int, $v:Vector.<Vo_valuable> = null, arr_id:Array = null) : Vector.<Vo_valuable>
      {
         return ModelManager.bag.get_vec_filter(filter,$v,arr_id);
      }
      
      public static function get_bag_count(id:int, bind:int = 2) : int
      {
         return ModelManager.bag.get_count(id,bind);
      }
      
      public static function getGridIdById(id:int) : int
      {
         return ModelManager.bag.getUseGridIdById(id);
      }
      
      public static function get_bag_used() : int
      {
         return ModelManager.bag.used;
      }
      
      public static function get_bag_canUse() : int
      {
         if(ModelManager.bag.canUse == 0)
         {
            return 50;
         }
         return ModelManager.bag.canUse;
      }
      
      public static function get_serverTime() : Date
      {
         return ModelManager.little_system.get_serverTime();
      }
      
      public static function getCanUseToolNum(id:int, bind:int = 2) : int
      {
         var temp:int = ModelManager.bag.get_count(id,bind);
         if(temp == 0)
         {
            return 0;
         }
         var dateStr:String = Data_lib.item[id][Enum_lib_item.USEABLE_DATE].split("_")[0];
         var yStr:int = int(dateStr.split("-")[0]);
         var mStr:int = int(dateStr.split("-")[1]);
         var dStr:int = int(dateStr.split("-")[2]);
         var temH:int = int(Data_lib.item[id][Enum_lib_item.USEABLE_DATE].split("_")[1].split(":")[0]);
         var temMi:int = int(Data_lib.item[id][Enum_lib_item.USEABLE_DATE].split("_")[1].split(":")[1]);
         var temS:int = int(Data_lib.item[id][Enum_lib_item.USEABLE_DATE].split("_")[1].split(":")[2]);
         var temDate:Date = new Date(yStr,mStr - 1,dStr,temH,temMi,temS);
         var a:uint = FruitShopHandler.dateNum;
         var dateNum:int = uint(temDate.time / 1000) - a;
         if(dateNum > 0)
         {
            return temp;
         }
         return 0;
      }
      
      public static function getHorseID(id:int) : int
      {
         var horsID:int = 0;
         var newID:int = 0;
         var getID:Function = function(ids:int):int
         {
            var arr:Array = Data_lib.zqtj.toArray();
            var len:int = int(arr.length);
            var i:int = 0;
            while(i < len)
            {
               if(arr[i][5] == ids || arr[i][9] == ids)
               {
                  return arr[i][8];
               }
               i++;
            }
            return 0;
         };
         horsID = getID(id);
         if(horsID == 0)
         {
            newID = int(Data_lib.item[id][Enum_lib_item.ID_COMBINING]);
            if(newID != 0)
            {
               horsID = getID(newID);
            }
         }
         return horsID;
      }
   }
}

