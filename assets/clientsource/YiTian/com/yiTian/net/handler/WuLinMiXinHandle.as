package com.yiTian.net.handler
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_WuLinMiXin;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.WuLinMiXin.View_WuLinMiXin_MainButton;
   import com.yiTian.view.modules.WuLinMiXin.View_WuLinMiXin_MainMenu;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class WuLinMiXinHandle
   {
      
      public function WuLinMiXinHandle()
      {
         super();
      }
      
      public static function UpdateAllStatus(_arr:Array) : void
      {
         Model_WuLinMiXin.statusArray = _arr;
      }
      
      public static function SetMainButtonEffect(_times:int) : void
      {
         if(_times > 0)
         {
            View_WuLinMiXin_MainButton.instance.effectBegin();
         }
         else
         {
            View_WuLinMiXin_MainButton.instance.effectEnd();
         }
      }
      
      public static function UpdatePrizeOwner(_name:String, _num:int) : void
      {
         View_WuLinMiXin_MainMenu.instance.UpdatePrizeOwner(_name,_num);
      }
      
      public static function UpdateItemRecord(_nameArr:Array, _kindArr:Array, _itemArr:Array) : void
      {
         View_WuLinMiXin_MainMenu.instance.UpdateItemRecord(_nameArr,_kindArr,_itemArr);
      }
      
      public static function UpdatePrizeRecord(_nameArr:Array, _kindArr:Array, _moneyArr:Array) : void
      {
         View_WuLinMiXin_MainMenu.instance.UpdatePrizeRecord(_nameArr,_kindArr,_moneyArr);
      }
      
      public static function UpdatePrizePool(_prize:int) : void
      {
         View_WuLinMiXin_MainMenu.instance.UpdatePrizePool(_prize);
      }
      
      public static function AddPool(_num:int) : void
      {
         View_WuLinMiXin_MainMenu.instance.AddPool(_num);
      }
      
      public static function UpdateOpenTimes() : void
      {
         View_WuLinMiXin_MainMenu.instance.UpdateOpenTimes();
      }
      
      public static function UpdateStatus(_id:int, _isPlay:Boolean = false) : void
      {
         View_WuLinMiXin_MainMenu.instance.setCardStatus(_id,Model_WuLinMiXin.statusArray[_id],_isPlay);
      }
      
      public static function ItemFlyToBag(_id:int, itemID:int) : void
      {
         var item:Vo_item = null;
         var equip:Vo_equip = null;
         var dic:Dictionary = Data_lib.wulinmixin;
         var str:String = Data_lib.wulinmixin[itemID][2];
         var grid:View_Grid = new View_Grid();
         var arr:Array = str.split("_");
         if(arr[0] == 1)
         {
            item = new Vo_item();
            item.id = arr[1];
            item.Init_lib();
            grid.vo = item;
         }
         else if(arr[0] == 2)
         {
            equip = new Vo_equip();
            equip.id = arr[1];
            equip.Init_lib();
            grid.vo = equip;
         }
         View_WuLinMiXin_MainMenu.instance.OpenAnimation(_id,grid);
      }
      
      public static function MoneyFlyToBag(_id:int) : void
      {
         var point:Point = new Point(View_WuLinMiXin_MainMenu.instance["card_" + _id].x + 40,View_WuLinMiXin_MainMenu.instance["card_" + _id].y + 51);
         var point2:Point = UIManager.mainMenu.getbagPoint();
         EffectManager.flyEff(View_WuLinMiXin_MainMenu.instance.localToGlobal(point),point2);
      }
   }
}

