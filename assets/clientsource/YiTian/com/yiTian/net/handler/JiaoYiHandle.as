package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_trans;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_trans;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.JiaoYiCGMessage;
   import com.yiTian.utils.Tween;
   
   public class JiaoYiHandle
   {
      
      public function JiaoYiHandle()
      {
         super();
      }
      
      public static function GC_JIAOYI(tem_arr:Array) : void
      {
         var tem_vo_trans:Vo_trans = new Vo_trans();
         tem_vo_trans.init(tem_arr);
         update_save_data(tem_vo_trans);
         var tem_num:int = handle_tipe();
         if(tem_num == -1)
         {
            UIManager.smallMap.removeTip(2);
         }
         if(UIManager.trans_panel.visible)
         {
            UIManager.trans_panel.update_trans_item(Model_trans.trans_list_data_arr);
         }
         else
         {
            UIManager.smallMap.addTip(2);
         }
      }
      
      public static function GC_JIAOYI_FAIL() : void
      {
         UIManager.centerBroadcast.addMsg("<font color=\'#ff0000\'>" + LangConfig.getWord("98",0) + "</font></a>");
      }
      
      public static function GC_JIAOYI_LIST(arr:Array = null, len:int = 0) : void
      {
         var tem_trans_vo:Vo_trans = null;
         Model_trans.trans_list_data_arr = [];
         var i:int = 0;
         while(i < arr.length)
         {
            tem_trans_vo = new Vo_trans();
            tem_trans_vo.init(arr[i]);
            Model_trans.trans_list_data_arr.push(tem_trans_vo);
            i++;
         }
         var tem_num:int = handle_tipe();
         if(tem_num == -1)
         {
            UIManager.smallMap.removeTip(2);
         }
         else
         {
            UIManager.smallMap.addTip(2);
         }
         if(!UIManager.trans_panel.visible)
         {
            UIManager.trans_panel.visible = true;
         }
         UIManager.trans_panel.update_trans_item(Model_trans.trans_list_data_arr);
      }
      
      public static function GC_JIAOYI_QUERY(jy_id:Number, items:Array, equips:Array, _items:Array, _equips:Array, role_YB:int, role_YL:int, otherRole_YB:int, otherRole_YL:int) : void
      {
         if(!UIManager.trans_chck.visible)
         {
            UIManager.trans_chck.visible = true;
         }
         UIManager.trans_chck.parent.setChildIndex(UIManager.trans_chck,UIManager.trans_chck.parent.numChildren - 1);
         UIManager.trans_chck.update(jy_id,items,equips,_items,_equips,role_YB,role_YL,otherRole_YB,otherRole_YL);
      }
      
      public static function GC_JIAOYI_RETURN(jy_id:int, otherRoleId:int, jy_result:int, get_status:int) : void
      {
      }
      
      public static function GET_GOODS_HANDLE(arr:Array) : void
      {
         var tem_item:Vo_item = null;
         var tem_equip:Vo_equip = null;
         var i:int = 0;
         while(i < arr.length)
         {
            if(arr[i][0] == 1)
            {
               tem_item = new Vo_item();
               tem_item.id = arr[i][1];
               tem_item.Init_lib();
               Tween.gridToBagBezierFuncDef(tem_item,-1,Global.stage.stageWidth / 2,200);
            }
            else if(arr[i][0] == 2)
            {
               tem_equip = new Vo_equip();
               tem_equip.id = arr[i][1];
               tem_equip.Init_lib();
               Tween.gridToBagBezierFuncDef(tem_equip,-1,Global.stage.stageWidth / 2,200);
            }
            i++;
         }
      }
      
      public static function GC_TRANS_RETURN(res:int) : void
      {
         var temArr:Array = null;
         var i:int = 0;
         if(res == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("99",0));
            return;
         }
         if(res == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("100",0));
         }
         else if(res == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("59",0));
            UIManager.trans_chck.reset_data_handle();
         }
         else if(res == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("101",0));
         }
         else if(res == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("102",0));
         }
         else
         {
            if(res == 5)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("103",0));
               return;
            }
            if(res == -1)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("104",0));
               return;
            }
            if(res == -2)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("105",0));
               return;
            }
            if(res == 6)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("106",0));
               return;
            }
            if(res == 7)
            {
               temArr = UIManager.trans_panel.jyItem_sava;
               i = 0;
               while(i < temArr.length)
               {
                  if(Model_trans.trans_id == temArr[i].jyId)
                  {
                     temArr[i].setGetBtn(false);
                     break;
                  }
                  i++;
               }
            }
         }
         if(UIManager.trans_send_panel.visible)
         {
            UIManager.trans_send_panel.visible = false;
         }
         if(UIManager.trans_chck.visible)
         {
            UIManager.trans_chck.visible = false;
         }
         JiaoYiCGMessage.CG_JIAOYI_LIST();
      }
      
      private static function update_save_data(_vo_trans:Vo_trans) : void
      {
         var tem_num:int = 0;
         if(!Model_trans.trans_list_data_arr.length)
         {
            Model_trans.trans_list_data_arr.push(_vo_trans);
         }
         else
         {
            tem_num = get_save_data_index(_vo_trans);
            if(tem_num == -1)
            {
               if(Model_trans.trans_list_data_arr.length == 10)
               {
                  specialHandle();
               }
               Model_trans.trans_list_data_arr.unshift(_vo_trans);
            }
            else
            {
               Model_trans.trans_list_data_arr[tem_num] = _vo_trans;
            }
         }
      }
      
      private static function handle_tipe() : int
      {
         var tem_vo_trans:Vo_trans = new Vo_trans();
         var i:int = 0;
         while(i < Model_trans.trans_list_data_arr.length)
         {
            tem_vo_trans = Model_trans.trans_list_data_arr[i];
            if(!(tem_vo_trans.trans_status == 1 || tem_vo_trans.trans_status == 2 || tem_vo_trans.trans_status == 6))
            {
               return i;
            }
            if(tem_vo_trans.trans_status == 6)
            {
               if(tem_vo_trans.receive_status != 1)
               {
               }
            }
            else if(tem_vo_trans.receive_status == 1)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private static function specialHandle() : void
      {
         var tem_vo_trans:Vo_trans = new Vo_trans();
         var i:int = 0;
         while(i < Model_trans.trans_list_data_arr.length)
         {
            tem_vo_trans = Model_trans.trans_list_data_arr[i];
            if(tem_vo_trans.trans_status == 1 || tem_vo_trans.trans_status == 2 || tem_vo_trans.trans_status == 6)
            {
               if(tem_vo_trans.trans_status == 6)
               {
                  if(tem_vo_trans.receive_status != 1)
                  {
                     Model_trans.trans_list_data_arr.splice(i,1);
                     return;
                  }
               }
               else if(tem_vo_trans.receive_status != 1)
               {
                  Model_trans.trans_list_data_arr.splice(i,1);
                  return;
               }
            }
            i++;
         }
      }
      
      private static function data_sort_handle() : void
      {
         var i:int = 0;
         while(i < Model_trans.trans_list_data_arr.length)
         {
            trace(Model_trans.trans_list_data_arr[i]);
            i++;
         }
      }
      
      private static function get_save_data_index(_vo_trans:Vo_trans) : int
      {
         var tem_vo_jiaoyi:Vo_trans = null;
         var i:int = 0;
         while(i < Model_trans.trans_list_data_arr.length)
         {
            tem_vo_jiaoyi = Model_trans.trans_list_data_arr[i];
            if(tem_vo_jiaoyi.trans_id == _vo_trans.trans_id)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      public static function GET_RESULT_TIP(rs:int) : void
      {
         if(rs == 1)
         {
            UIManager.smallMap.addTip(2);
         }
         else
         {
            UIManager.smallMap.removeTip(2);
         }
      }
      
      public static function GC_JIAOYI_REP(result:int, jy_Id:int, roleJyStatus:int, roleGetStatus:int) : void
      {
         trace("回复之后。错了。。");
      }
   }
}

