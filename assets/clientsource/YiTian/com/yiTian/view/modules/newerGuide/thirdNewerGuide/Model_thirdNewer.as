package com.yiTian.view.modules.newerGuide.thirdNewerGuide
{
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.GuideCGMessage;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import flash.events.MouseEvent;
   
   public class Model_thirdNewer
   {
      
      public static const PETINDEX:int = 1;
      
      public static const WEAPONINDEX:int = 2;
      
      public static var modelIdArr:Array = [20902,20903,20904,20905];
      
      private static var idArr:Vector.<int> = new <int>[46302,46303,46304,46305];
      
      private static var _petIdIdex:int = 0;
      
      private static var __cnt:int = 0;
      
      private static var __arr:Array = [];
      
      private static var timeArr:Array = [1000,2000];
      
      public function Model_thirdNewer()
      {
         super();
      }
      
      public static function get nextPetId() : int
      {
         ++_petIdIdex;
         _petIdIdex = _petIdIdex >= modelIdArr.length ? 0 : _petIdIdex;
         return modelIdArr[_petIdIdex];
      }
      
      public static function get prePetId() : int
      {
         --_petIdIdex;
         _petIdIdex = _petIdIdex < 0 ? int(modelIdArr.length - 1) : _petIdIdex;
         return modelIdArr[_petIdIdex];
      }
      
      public static function showPan(type:int) : void
      {
         if(type == 1)
         {
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(Child_panPet.instance,Child_panPet.instance.show);
         }
         else if(type == 2)
         {
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(Child_panWeapon.instance,Child_panWeapon.instance.show);
         }
      }
      
      public static function hidePan(type:int) : void
      {
         if(type == 1)
         {
            if(Child_panPet.instance.visible)
            {
               Child_panPet.instance.visible = false;
            }
         }
         else if(type == 2)
         {
            if(Child_panWeapon.instance.visible)
            {
               Child_panWeapon.instance.visible = false;
            }
         }
      }
      
      public static function butHd(e:MouseEvent) : void
      {
         switch(e.target.tabIndex)
         {
            case 1:
               if(GameUnitManager.hero.money < 168)
               {
                  UIManager.centerBroadcast.addMsg("元宝不够");
                  UIManager.yuanBaoXiang.visible = true;
                  return;
               }
               PetCGMessage.CG_PET_BIANSHENGKA(idArr[_petIdIdex]);
               break;
            case 2:
               if(GameUnitManager.hero.money < 15)
               {
                  UIManager.centerBroadcast.addMsg("元宝不够");
                  UIManager.yuanBaoXiang.visible = true;
                  return;
               }
               if(CommandManager.get_bag_canUse() - CommandManager.get_bag_used() < 1)
               {
                  UIManager.centerBroadcast.addMsg("背包已满");
                  return;
               }
               GuideCGMessage.CG_BUYWEAPON();
         }
      }
      
      public static function addConUnit() : void
      {
         var ss:BtnSpr = new BtnSpr();
         __arr.push(ss);
         var type:int = Math.random() * 2 + 1;
         thirdNewerContainer.instance.addBtn(ss,type);
         ++__cnt;
      }
      
      public static function insideMove() : void
      {
         var num:int = Math.random() * __arr.length;
         var disObj:BtnSpr = __arr[num];
         var type:int = Math.random() * 2 + 1;
         var time:int = int(timeArr[type - 1]);
         if(disObj.status == type)
         {
            return;
         }
         thirdNewerContainer.instance.moveBtn(disObj,type,time,thirdNewerContainer.INSIDE_MOVE);
      }
      
      public static function removeUnit() : void
      {
         var num:int = Math.random() * __arr.length;
         var disObj:BtnSpr = __arr[num];
         thirdNewerContainer.instance.removeBtn(disObj,disObj.status);
      }
   }
}

