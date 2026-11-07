package com.yiTian.view.modules.Shopping.shoppingMall
{
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_store;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   
   public class Model_mall
   {
      
      public function Model_mall()
      {
         super();
      }
      
      public static function getPriceType(priceType:int) : String
      {
         var danWei:String = null;
         var _nn:int = 0;
         var vo:Vo_item = null;
         if(priceType == 16000)
         {
            danWei = LangConfig.getWord("21",0);
         }
         else if(priceType == 17000)
         {
            danWei = LangConfig.getWord("39",0);
         }
         else if(priceType == 18000)
         {
            danWei = LangConfig.getWord("124",0);
         }
         else if(priceType == 21000)
         {
            danWei = LangConfig.getWord("125",0);
         }
         else if(priceType == 37000)
         {
            danWei = "积分";
         }
         else if(priceType == -1)
         {
            danWei = "基金";
         }
         else
         {
            _nn = priceType / 1000;
            vo = new Vo_item();
            vo.id = _nn;
            vo.Init_lib();
            danWei = HtmlUtil.font(vo.str_name,Model_shop.get_color_arr[vo.color - 1]);
         }
         return danWei;
      }
      
      public static function getArrByName(nameSS:String, ... param) : Array
      {
         var arr:Array = null;
         var j:int = 0;
         var obj:Object = null;
         var itemStore:Vo_store = null;
         var matchName:String = null;
         var index:int = 0;
         var len:int = int(param.length);
         var itemArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            arr = param[i];
            if(Boolean(arr))
            {
               j = 0;
               while(j < arr.length)
               {
                  obj = arr[j];
                  if(obj is Vo_store)
                  {
                     itemStore = obj as Vo_store;
                     matchName = itemStore.name;
                     index = matchName.indexOf(nameSS);
                     if(index != -1)
                     {
                        itemArr.push(obj);
                     }
                  }
                  j++;
               }
            }
            i++;
         }
         return itemArr;
      }
      
      public static function getNameById(wpId:int) : Array
      {
         var _dArr:Array = [];
         var voI:Vo_item = new Vo_item();
         voI.id = wpId;
         voI.Init_lib();
         var nums:int = CommandManager.get_bag_count(wpId);
         _dArr.push(HtmlUtil.font(voI.str_name + "：",Model_shop.get_color_arr[voI.color - 1]),nums);
         return _dArr;
      }
      
      public static function getJieDuanBool(matchLvl:int) : Boolean
      {
         var heroLvl:int = GameUnitManager.hero.level;
         if(matchLvl >= 1 && matchLvl <= 39)
         {
            if(heroLvl >= 40)
            {
               return true;
            }
         }
         else if(matchLvl >= 40 && matchLvl <= 49)
         {
            if(heroLvl >= 50)
            {
               return true;
            }
         }
         else if(matchLvl >= 50 && matchLvl <= 59)
         {
            if(heroLvl >= 60)
            {
               return true;
            }
         }
         else if(matchLvl >= 60 && matchLvl <= 69)
         {
            if(heroLvl >= 70)
            {
               return true;
            }
         }
         else if(matchLvl >= 70 && matchLvl <= 79)
         {
            if(heroLvl >= 80)
            {
               return true;
            }
         }
         else if(matchLvl >= 80 && matchLvl <= 89)
         {
            if(heroLvl >= 90)
            {
               return true;
            }
         }
         return false;
      }
   }
}

