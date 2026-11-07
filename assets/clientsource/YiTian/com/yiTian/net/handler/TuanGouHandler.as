package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_Lib_TuanGou_Item;
   import com.yiTian.data.model.Model_TuanGou;
   import com.yiTian.data.vo.Vo_TuanGouItem;
   import com.yiTian.data.vo.Vo_TuanGou_Dial_Goods_Item;
   import com.yiTian.data.vo.Vo_TuanGou_Player;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.tuanGou.ViewTuanGouTip;
   
   public class TuanGouHandler
   {
      
      private static var isFrist:Boolean;
      
      private static var isUpdate:Boolean;
      
      private static var isU:Boolean;
      
      public static var _data:Array;
      
      public static var grilID:int = 99116;
      
      public static var boyID:int = 99115;
      
      public static var gril:int = 99507;
      
      public static var boy:int = 99508;
      
      public static var isNewUse:Boolean = true;
      
      private static var tipViewer:ViewTuanGouTip = ViewTuanGouTip.instance;
      
      public function TuanGouHandler()
      {
         super();
      }
      
      public static function GC_TUANGOU_DIAL(weekCount:int, surplus:int, playerCount:int, suffer:int, biLi:int) : void
      {
         Model_TuanGou.keepObj.weekCount = weekCount;
         Model_TuanGou.keepObj.surplus = surplus;
         Model_TuanGou.keepObj.playerCount = playerCount;
         Model_TuanGou.keepObj.suffer = suffer;
         Model_TuanGou.keepObj.biLi = biLi;
         UIManager.tuanGou.updateTxt(Model_TuanGou.keepObj);
         UIManager.tuanGou.update();
      }
      
      public static function GC_TUANGOU_ALL(data:Array) : void
      {
         var o:Object = null;
         var vo:Vo_TuanGou_Player = null;
         Model_TuanGou.vecPlayAwards = new Vector.<Vo_TuanGou_Player>();
         for each(o in data)
         {
            vo = new Vo_TuanGou_Player();
            vo.name = o[0];
            vo.awards = vo.changelStr(o[1]);
            if(o[2] != grilID && o[2] != boyID)
            {
               vo.goodName = Data_lib.item[o[2]][1];
            }
            else
            {
               vo.goodName = Data_lib.equip[o[2]][1];
            }
            vo.goodCount = o[3];
            Model_TuanGou.vecPlayAwards.push(vo);
         }
         UIManager.tuanGou.updateName();
      }
      
      public static function GC_TUANGOU_ITEM(data:Array, heroData:Array) : void
      {
         var o:Object = null;
         var vo:Vo_TuanGouItem = null;
         var num:int = 0;
         var i:int = 0;
         var p:Object = null;
         var j:int = 0;
         var vo2:Vo_TuanGouItem = null;
         var k:int = 0;
         Model_TuanGou.vecItemVo = new Vector.<Vo_TuanGouItem>();
         var heroBuyItem:Vector.<Vo_TuanGouItem> = new Vector.<Vo_TuanGouItem>();
         for each(o in data)
         {
            vo = new Vo_TuanGouItem();
            vo.itemId = o[0];
            vo.yiShou = o[1];
            i = 1;
            while(i < 17)
            {
               if(vo.itemId == Data_lib.groupBuying[i][1])
               {
                  num = i;
                  break;
               }
               i++;
            }
            vo.name = Data_lib.item[vo.itemId][1];
            vo.yuanJia = Data_lib.groupBuying[num][Enum_Lib_TuanGou_Item.YUAN_JIA];
            vo.xianJia = Data_lib.groupBuying[num][Enum_Lib_TuanGou_Item.XIAN_JIA];
            vo.xianGou = Data_lib.groupBuying[num][Enum_Lib_TuanGou_Item.XIAN_GOU];
            vo.weiZhi = Data_lib.groupBuying[num][Enum_Lib_TuanGou_Item.XIA_BIAO];
            Model_TuanGou.vecItemVo.push(vo);
         }
         if(heroData.length > 0)
         {
            for each(p in heroData)
            {
               vo2 = new Vo_TuanGouItem();
               vo2.itemId = p[0];
               vo2.takeCount = p[1];
               heroBuyItem.push(vo2);
            }
            j = 0;
            while(j < Model_TuanGou.vecItemVo.length)
            {
               k = 0;
               while(k < heroBuyItem.length)
               {
                  if(Model_TuanGou.vecItemVo[j].itemId == heroBuyItem[k].itemId)
                  {
                     Model_TuanGou.vecItemVo[j].takeCount = heroBuyItem[k].takeCount;
                  }
                  k++;
               }
               j++;
            }
         }
         UIManager.tuanGou.updateItem();
      }
      
      public static function GC_TUANGOU_TAKE_GOODS(itemId:int, suffer:int) : void
      {
         var v:Vo_TuanGouItem = null;
         for each(v in Model_TuanGou.vecItemVo)
         {
            if(v.itemId == itemId)
            {
               v.yiShou += 1;
               v.takeCount += 1;
               Model_TuanGou.keepObj.weekCount += 1;
            }
         }
         Model_TuanGou.keepObj.suffer = suffer;
         UIManager.tuanGou.update();
      }
      
      public static function GC_TUANGOU_TAKE_GOODS_ERROR(error:int) : void
      {
         var showStr:String = null;
         switch(error)
         {
            case 2:
               showStr = "商品不存在";
               break;
            case 3:
               showStr = "银两不够";
               break;
            case 4:
               showStr = "礼卷不够";
               break;
            case 5:
               showStr = "本周团购数量已达上限";
               break;
            case 6:
               showStr = "购买此商品已达上限";
               break;
            case 7:
               showStr = "等级不够";
               break;
            case 8:
               showStr = "本周团购活动结束,欢迎参与下周的团购活动。";
               break;
            case 9:
               showStr = "不在活动时间内";
               break;
            default:
               return;
         }
         UIManager.centerBroadcast.addMsg(showStr);
      }
      
      public static function GC_TUANGOU_REQUEST_START(xiaBiao:int) : void
      {
         UIManager.tuanGou.wheelNum(xiaBiao);
      }
      
      public static function GC_TUAN_REQUEST_START_ERROR(error:int) : void
      {
         var showStr:String = null;
         switch(error)
         {
            case 2:
               showStr = "你已经没有抽取机会了";
               break;
            case 3:
               showStr = "等级未够";
               break;
            case 4:
               showStr = "本周团购活动结束，欢迎参与下周的团购活动。";
               break;
            default:
               return;
         }
         UIManager.centerBroadcast.addMsg(showStr);
      }
      
      public static function GC_TUANGOU_WHEEL_DATA(data:Array) : void
      {
         var _wheelgGods:Vo_TuanGou_Dial_Goods_Item = null;
         var str:String = null;
         var _arr:Array = null;
         var __arr:Array = null;
         var _sex:int = 0;
         var _ss:String = null;
         var _d:Array = null;
         var _sss:String = null;
         var _dd:Array = null;
         _data = data;
         Model_TuanGou.vecWheelGoods = new Vector.<Vo_TuanGou_Dial_Goods_Item>();
         var hero:Hero = GameUnitManager.hero;
         var j:int = 0;
         while(j < data.length)
         {
            _wheelgGods = new Vo_TuanGou_Dial_Goods_Item();
            _wheelgGods.xiaBiao = data[j][0];
            _wheelgGods.biaoJi = data[j][1];
            _wheelgGods.count = Data_lib.turntable_new[_wheelgGods.xiaBiao][3];
            str = Data_lib.turntable_new[_wheelgGods.xiaBiao][0];
            if(str.indexOf(",") == -1)
            {
               _arr = str.split("_");
               _wheelgGods.vo = getVo(_arr[0],_wheelgGods.count,_arr[2]);
            }
            else
            {
               __arr = str.split(",");
               _sex = hero.sex;
               if(_sex == 1)
               {
                  _ss = __arr[0];
                  _d = _ss.split("_");
                  _wheelgGods.vo = getVo(_d[0],1,_d[2]);
               }
               else if(_sex == 2)
               {
                  _sss = __arr[1];
                  _dd = _sss.split("_");
                  _wheelgGods.vo = getVo(_dd[0],1,_dd[2]);
               }
            }
            _wheelgGods.weiZhi = Data_lib.turntable_new[_wheelgGods.xiaBiao][1];
            Model_TuanGou.vecWheelGoods.push(_wheelgGods);
            j++;
         }
         UIManager.tuanGou.update();
      }
      
      private static function getVo(type:int, count:int, id:int) : Vo_valuable
      {
         var voI:Vo_item = null;
         if(type == 1)
         {
            voI = new Vo_item();
            voI.id = id;
            voI.count = count;
            voI.Init_lib();
            return voI as Vo_valuable;
         }
         var voE:Vo_equip = new Vo_equip();
         voE.id = id;
         voE.count = count;
         voE.Init_lib();
         return voE as Vo_valuable;
      }
      
      public static function GC_TUANGOU_MAOPAO(goodID:int, count:int, type:int) : void
      {
         var goodName:String = null;
         if(type == 2)
         {
            goodName = Data_lib.equip[goodID][1];
         }
         else if(type == 1)
         {
            goodName = Data_lib.item[goodID][1];
         }
         Model_TuanGou.maoPaoStr = "恭喜你抽中【" + "<font color=\'#ff0000\'>" + goodName + "</font>】" + count.toString() + "件";
      }
      
      public static function GC_TUANGOU_OPEN_OR_COLOSE(type:int) : void
      {
         if(type == 0)
         {
            show();
         }
         else if(type == 1)
         {
            if(UIManager.mainUiBtnContainer.hasBTN(tipViewer))
            {
               UIManager.mainUiBtnContainer.removeBTN(tipViewer);
            }
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.TuanGou,2]);
         }
      }
      
      private static function show() : void
      {
         if(GameUnitManager.hero.level < 35)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,show);
            return;
         }
         Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,show);
         UIManager.mainUiBtnContainer.addBTN(tipViewer);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.TuanGou,1]);
      }
   }
}

