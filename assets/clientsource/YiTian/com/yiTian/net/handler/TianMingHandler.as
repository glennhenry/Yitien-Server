package com.yiTian.net.handler
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_TianMing;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_TianMing;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TianMingCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.Shopping.shoppingMall.ShoppingMallPan;
   import com.yiTian.view.modules.newRolePan.RoleMter;
   import com.yiTian.view.modules.newRolePan.View_rolePan;
   import com.yiTian.view.modules.tianMing.View_BlessingFruit;
   import com.yiTian.view.modules.tianMing.View_TianFu;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class TianMingHandler
   {
      
      private static var expTianming:Array = [47141,47142,47143,47144,47145];
      
      public function TianMingHandler()
      {
         super();
      }
      
      public static function useFruitEff() : void
      {
         var startPoint:Point = View_BlessingFruit.instance.getNowPos();
         var barPoint:Point = new Point(20 + View_TianFu.instance.tianFu_bar.barWidth,275);
         var endPoint:Point = View_TianFu.instance.localToGlobal(barPoint);
         EffectManager.flyEff(startPoint,endPoint);
      }
      
      public static function addFlyEff(x:Number) : void
      {
         var startPoint:Point = View_TianFu.instance.localToGlobal(new Point(436 + 17,135));
         var endPoint:Point = View_TianFu.instance.localToGlobal(new Point(5 + x,270));
         EffectManager.flyEff(startPoint,endPoint);
      }
      
      public static function goToShop() : void
      {
         var pan:ShoppingMallPan = null;
         pan = Singleton.getInstance(ShoppingMallPan) as ShoppingMallPan;
         View_Alert.show(LangConfig.getWord("80109",8),View_Alert.OK_CANCAL,function():void
         {
            pan.openView(0,2);
         },null,null,null,310,LangConfig.getWord("80110",8),LangConfig.getWord("80111",8));
      }
      
      public static function makeTip(data:Array, type:int) : String
      {
         var content:String = null;
         var str:String = null;
         var value:Array = null;
         var valueType:String = null;
         var typeStr:String = null;
         var str1:String = 80061 + type + "";
         var str2:String = 80063 + type + "";
         var dataArr:Array = data[1].split(",");
         content = LangConfig.getWord(str1,8,data[0]);
         for each(str in dataArr)
         {
            value = str.split("_");
            valueType = Data_lib.attribute[value[0]][0];
            type = int(Data_lib.attribute[value[0]][1]);
            typeStr = type == 1 ? "" : "%";
            content += "<br>" + "  " + LangConfig.getWord(str2,8,valueType,value[1],typeStr);
         }
         return content;
      }
      
      public static function gc_comp_bag_tianming(id:int, exp:int, otherId:int, type:int) : void
      {
         var str:String = null;
         var otherName:String = null;
         var otherColor:int = 0;
         var name:String = Data_lib.item[id][Enum_lib_item.STR_NAME];
         var color:int = int(Data_lib.item[id][Enum_lib_item.COLOR]);
         if(otherId > 0)
         {
            otherName = Data_lib.item[otherId][Enum_lib_item.STR_NAME];
            otherColor = int(Data_lib.item[otherId][Enum_lib_item.COLOR]);
            if(type == 0)
            {
               str = LangConfig.getWord("80230",8,Model_shop.get_color_arr[color - 1],name,Model_shop.get_color_arr[otherColor - 1],otherName,exp);
            }
            else
            {
               str = LangConfig.getWord("80231",8,Model_shop.get_color_arr[color - 1],name,Model_shop.get_color_arr[otherColor - 1],otherName,exp);
            }
         }
         else
         {
            str = LangConfig.getWord("80094",8,Model_shop.get_color_arr[color - 1],name,exp);
         }
         View_Alert.show(str,View_Alert.OK_CANCAL,function():void
         {
            TianMingCGMessage.CG_COMP_BAG_TIANMING(2);
         });
      }
      
      public static function makeVoArray(patch:IDataInput) : Vector.<Array>
      {
         var arr:Array = null;
         var sysId:int = 0;
         var id:int = 0;
         var level:int = 0;
         var exp:int = 0;
         var value:int = 0;
         var eat_lock:int = 0;
         var voVec:Vector.<Array> = new Vector.<Array>();
         var len:int = patch.readInt();
         var i:int = 0;
         while(i < len)
         {
            arr = [];
            sysId = patch.readInt();
            id = patch.readInt();
            level = patch.readInt();
            exp = patch.readInt();
            value = patch.readInt();
            eat_lock = patch.readByte();
            arr.push(sysId,id,level,exp,value,eat_lock);
            voVec.push(arr);
            i++;
         }
         return voVec;
      }
      
      public static function upDataTianMing(source:Vector.<Array>, dataVec:Vector.<Vo_TianMing>) : void
      {
         var vo:Vo_TianMing = null;
         dataVec.length = 0;
         var len:int = int(source.length);
         var i:int = 0;
         while(i < len)
         {
            vo = new Vo_TianMing();
            vo.Init_sever_bag(source[i]);
            vo.gridId = i;
            dataVec.push(vo);
            i++;
         }
      }
      
      public static function upDataMyTianMing(source:Vector.<Array>, dataVec:Vector.<Vo_TianMing>) : void
      {
         var i:int;
         var vo:Vo_TianMing = null;
         var arr:Array = null;
         dataVec.length = 0;
         i = 0;
         while(i < 5)
         {
            vo = new Vo_TianMing();
            vo.gridId = i;
            if(i < source.length)
            {
               arr = source[i];
               if(arr[0] != 0)
               {
                  vo.Init_sever_bag(arr);
               }
            }
            else
            {
               vo.lock = true;
               vo.str_name = "lock";
            }
            dataVec.push(vo);
            i++;
         }
         RoleMter.tianMingDataVec = dataVec;
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            pan.updateBind();
         });
      }
      
      public static function grid_up(event:MouseEvent) : void
      {
         var upType:int = 0;
         var dragType:int = 0;
         var dragVo:Vo_TianMing = null;
         var upVo:Vo_TianMing = null;
         if(!UIManager.isDrag)
         {
            return;
         }
         var upGrid:View_Grid = event.target as View_Grid;
         var dragGrid:View_Grid = UIManager.dragObj.grid;
         if(upGrid != dragGrid)
         {
            upType = upGrid.type - Enum_type_grid.TIANMING;
            dragType = dragGrid.type - Enum_type_grid.TIANMING;
            dragVo = dragGrid.vo as Vo_TianMing;
            if(Boolean(upGrid.vo))
            {
               upVo = upGrid.vo as Vo_TianMing;
               if(upVo.id_server != 0)
               {
                  if(upVo.eat_lock || dragVo.eat_lock)
                  {
                     UIManager.centerBroadcast.addMsg("天命已锁定，请解锁");
                     return;
                  }
                  if(upType == 1 && expTianming.indexOf(dragVo.id) != -1)
                  {
                     UIManager.centerBroadcast.addMsg("天命经验不可拖动到命格中");
                     return;
                  }
                  acceptComp(dragType,dragVo,upType,upVo);
               }
               else if(upVo.id_server == 0 && upVo.str_name != "lock")
               {
                  changTianMing(dragType,dragVo,upType,upVo);
               }
            }
            else if(dragType == 1)
            {
               retrieveTianMing(dragVo,upGrid);
            }
         }
         UIManager.stopDrag();
      }
      
      private static function retrieveTianMing(dragVo:Vo_TianMing, upGrid:View_Grid) : void
      {
         TianMingCGMessage.CG_USE_TIANMING(1,dragVo.id_server,dragVo.gridId,0,0,upGrid.gridId);
      }
      
      private static function changTianMing(dragType:int, dragVo:Vo_TianMing, upType:int, upVo:Vo_TianMing) : void
      {
         if(expTianming.indexOf(dragVo.id) != -1)
         {
            UIManager.centerBroadcast.addMsg("天命经验不可拖动到命格中");
            return;
         }
         TianMingCGMessage.CG_USE_TIANMING(dragType,dragVo.id_server,dragVo.gridId,upType,upVo.id_server,upVo.gridId);
      }
      
      private static function acceptComp(dragType:int, dragVo:Vo_TianMing, upType:int, upVo:Vo_TianMing) : void
      {
         var str:String = getTip(dragVo,upVo);
         View_Alert.show(str,View_Alert.OK_CANCAL,function():void
         {
            TianMingCGMessage.CG_USE_TIANMING(dragType,dragVo.id_server,dragVo.gridId,upType,upVo.id_server,upVo.gridId);
         });
      }
      
      private static function getTip(vo1:Vo_TianMing, vo2:Vo_TianMing) : String
      {
         var levelExp:int = 0;
         var arr:Array = [vo1,vo2];
         arr.sort(sortFun);
         var minVo:Vo_TianMing = arr[0];
         var maxVo:Vo_TianMing = arr[1];
         var minColor:int = int(Data_lib.item[minVo.id][Enum_lib_item.COLOR]);
         var minColorStr:String = Model_shop.get_color_arr[minColor - 1];
         var minName:String = Data_lib.item[minVo.id][Enum_lib_item.STR_NAME];
         var maxColor:int = int(Data_lib.item[maxVo.id][Enum_lib_item.COLOR]);
         var maxColorStr:String = Model_shop.get_color_arr[maxColor - 1];
         var maxName:String = Data_lib.item[maxVo.id][Enum_lib_item.STR_NAME];
         if(expTianming.indexOf(minVo.id) != -1)
         {
            levelExp = int(Enum_TianMing.TYPE_EXP_EXP[(minVo.id - Enum_TianMing.FIRSTID) % 5]);
         }
         else
         {
            levelExp = int(Enum_TianMing.TYPE_EXP[(minVo.id - Enum_TianMing.FIRSTID) % 5]);
         }
         if(Enum_TianMing.isDJ(maxVo.id))
         {
            levelExp = 480;
         }
         var exp:int = maxVo.level >= Enum_TianMing.TIANMING_MAXLEVEL ? 0 : int(minVo.exp + levelExp);
         return LangConfig.getWord("80095",8,maxColorStr,maxName,minColorStr,minName,exp);
      }
      
      private static function sortFun(vo1:Vo_TianMing, vo2:Vo_TianMing) : int
      {
         var level1:int = 0;
         var level2:int = 0;
         var exp1:int = 0;
         var exp2:int = 0;
         var type1:int = (vo1.id - Enum_TianMing.FIRSTID) % 5;
         var type2:int = (vo2.id - Enum_TianMing.FIRSTID) % 5;
         if(Enum_TianMing.isDJ(vo1.id))
         {
            type1 = 6;
         }
         if(Enum_TianMing.isDJ(vo2.id))
         {
            type2 = 6;
         }
         if(type1 == type2)
         {
            level1 = vo1.level;
            level2 = vo2.level;
            if(level1 == level2)
            {
               exp1 = vo1.exp;
               exp2 = vo2.exp;
               return exp1 - exp2;
            }
            return level1 - level2;
         }
         return type1 - type2;
      }
   }
}

