package com.yiTian.view.modules.baby.babyManager
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.NpcBaby;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.baby.babyIcon.BabyBtnBesideRole;
   import com.yiTian.view.modules.baby.babyPan.BabyPYTipsPan;
   import com.yiTian.view.modules.baby.babyPan.View_babyPan;
   import com.yiTian.view.modules.broadcast.StrengthTip;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Model_baby
   {
      
      public static var _leftChild:Object;
      
      public static var _rightChild:Object;
      
      private static var _baby_strength:int;
      
      public static var baby_meiLi_lvl:int;
      
      public static var baby_meiLi_value:int;
      
      public static var isFuMo:int;
      
      public static var _baby_type_value:String;
      
      public static var times:uint;
      
      public static var days:uint;
      
      public static var strengthTip:String;
      
      public static var baby_wuGong_value:String;
      
      public static var role_beside_icon:BabyBtnBesideRole;
      
      private static var isPlayIng:Boolean;
      
      private static var tip:BitmapBtn;
      
      public static var leftTimes:uint = 0;
      
      public static var babyName:String = "";
      
      private static var isFrist:Boolean = true;
      
      public static var _is18:Boolean = false;
      
      public static var baba_type_choose:uint = 1;
      
      public static var baby_strength_exp:uint = 0;
      
      public static var baby_zhiHui_exp:uint = 0;
      
      public static var baby_lucky_exp:uint = 0;
      
      public static var baby_strength_lvl:uint = 1;
      
      public static var baby_zhiHui_lvl:uint = 1;
      
      public static var baby_lucky_lvl:uint = 1;
      
      public static var sex:uint = 1;
      
      private static var _isEnableRole_beside_icon:Boolean = true;
      
      private static var listBmArr:Array = [];
      
      private static var lastStrength:int = 0;
      
      private static const bitmapDir:String = "resource/image/baby/babyGX.png";
      
      public static var numsArr:Array = ["SZ_Ling","SZ_Yi","SZ_Er","SZ_San","SZ_Si","SZ_Wu","SZ_Liu","SZ_Qi","SZ_Ba","SZ_Jiu"];
      
      public function Model_baby()
      {
         super();
      }
      
      public static function set is18(value:Boolean) : void
      {
         _is18 = value;
      }
      
      public static function get is18() : Boolean
      {
         return _is18;
      }
      
      public static function refreshTip() : void
      {
         View_babyPan.instance.refreshTip();
      }
      
      public static function set baby_strength(value:int) : void
      {
         var names:String = null;
         var add:int = 0;
         if(_baby_strength != value && !isFrist)
         {
            names = "崽囡";
            add = value - _baby_strength;
            if(add > 0)
            {
               StrengthTip.showADD(_baby_strength,add,names + " ");
            }
            else if(add < 0)
            {
               StrengthTip.showSub(add,names);
            }
         }
         isFrist = false;
         _baby_strength = value;
      }
      
      public static function get baby_strength() : int
      {
         return _baby_strength;
      }
      
      public static function set baby_type_value(value:String) : void
      {
         var ss:String = null;
         var __arr:Array = null;
         _baby_type_value = value;
         var arr:Array = value.split(",");
         var _temArr:Array = [["baby_strength_lvl","baby_strength_exp"],["baby_zhiHui_lvl","baby_zhiHui_exp"],["baby_lucky_lvl","baby_lucky_exp"]];
         var i:uint = 0;
         while(i < arr.length)
         {
            ss = arr[i];
            __arr = ss.split("_");
            Model_baby[_temArr[i][0]] = __arr[0];
            Model_baby[_temArr[i][1]] = __arr[1];
            i++;
         }
      }
      
      public static function get baby_type_value() : String
      {
         return _baby_type_value;
      }
      
      public static function dataExplain(data:String) : void
      {
         var childN:NpcBaby = null;
         var _tempArr:Array = null;
         var i:int = 0;
         var _tempS:String = null;
         var obj:Object = null;
         for each(childN in NpcBaby.list)
         {
            GameUnitManager.removeUnit(childN);
         }
         _tempArr = data.split(";");
         i = 0;
         while(i < _tempArr.length)
         {
            _tempS = _tempArr[i];
            obj = new Object();
            obj.id = Number(_tempS.split("_")[0]);
            obj.modId = int(_tempS.split("_")[1]);
            obj.babyName = String(_tempS.split("_")[2]);
            if(i == 0)
            {
               _leftChild = obj;
            }
            else if(i == 1)
            {
               _rightChild = obj;
            }
            i++;
         }
         showChildNpc(934,585);
      }
      
      private static function showChildNpc(global_x:int, global_y:int) : void
      {
         getSpriUnit("leftChild",_leftChild.modId,global_x - 76,global_y - 9,_leftChild.id,_leftChild.babyName);
         getSpriUnit("rightChild",_rightChild.modId,global_x - 38,global_y - 24,_rightChild.id,_rightChild.babyName);
      }
      
      private static function getSpriUnit(_style:String, modId:uint, global_x:uint, global_y:uint, id:Number, name:String) : void
      {
         var npcBaby:NpcBaby = null;
         if(Boolean(modId))
         {
            npcBaby = GameUnitManager.findUnit(UnitType.BABY,id) as NpcBaby;
            if(!npcBaby)
            {
               npcBaby = GameUnitManager.getUnit(UnitType.BABY) as NpcBaby;
            }
            npcBaby.initBaby(id,modId,global_x,global_y,name);
            GameUnitManager.addUnit(npcBaby);
         }
      }
      
      public static function show(viewPan:*, func:String = "", param:* = null) : void
      {
         var handle:Function = null;
         handle = function():void
         {
            if(Boolean(func))
            {
               if(param != null)
               {
                  viewPan[func](param);
               }
               else
               {
                  viewPan[func]();
               }
            }
            else
            {
               viewPan.visible = !viewPan.visible;
            }
         };
         if(viewPan is Panel123)
         {
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(viewPan,handle);
         }
         else
         {
            handle();
         }
      }
      
      public static function get isEnableRole_beside_icon() : Boolean
      {
         return _isEnableRole_beside_icon;
      }
      
      public static function set isEnableRole_beside_icon(value:Boolean) : void
      {
         _isEnableRole_beside_icon = value;
         if(Boolean(role_beside_icon))
         {
            role_beside_icon.filters = _isEnableRole_beside_icon ? [] : Util.disabled;
            role_beside_icon.mouseEnabled = _isEnableRole_beside_icon;
         }
      }
      
      public static function show_besideRole_icon(isFly:Boolean = false) : void
      {
         var aimPoint:Point;
         var eff:Bitmap = null;
         if(!role_beside_icon)
         {
            role_beside_icon = new BabyBtnBesideRole();
         }
         role_beside_icon.filters = _isEnableRole_beside_icon ? [] : Util.disabled;
         role_beside_icon.mouseEnabled = _isEnableRole_beside_icon;
         role_beside_icon.init();
         UIManager.mainMenu.addChild(role_beside_icon);
         role_beside_icon.alpha = 0;
         if(!isFly)
         {
            role_beside_icon.alpha = 1;
            return;
         }
         eff = Utils.getLoadBitmap("resource/image/baby/Icon_JSZN.png");
         eff.x = Global.stage.stageWidth / 2;
         eff.y = Global.stage.stageHeight / 2;
         GameScene.upUILayer.addChild(eff);
         aimPoint = UIManager.mainMenu.getItemGlobalPosC("roleBtn");
         Tween.to(eff,1000,{
            "x":[aimPoint.x - 325,aimPoint.x + 25],
            "y":[aimPoint.y - 445,aimPoint.y - 5]
         },function():void
         {
            role_beside_icon.alpha = 1;
            eff.alpha = 0;
            eff.parent.removeChild(eff);
         });
      }
      
      public static function hide_besideRole_icon() : void
      {
         if(Boolean(role_beside_icon) && Boolean(role_beside_icon.parent))
         {
            role_beside_icon.parent.removeChild(role_beside_icon);
            role_beside_icon.remove();
         }
      }
      
      public static function getNumBmByMaths(value:uint, con:Sprite) : void
      {
         var currentPower:int = 0;
         var add:int = 0;
         var flag:int = 0;
         var play:Function = null;
         var resultFun:Function = function(values:int):void
         {
            var b:Bitmap = null;
            var ss:String = null;
            reset();
            var valueStr:String = values.toString();
            var len:uint = uint(valueStr.length);
            var i:uint = 0;
            while(i < len)
            {
               b = Pool.getObject(Bitmap);
               listBmArr.push(b);
               con.addChild(b);
               ss = valueStr.charAt(i);
               b.bitmapData = ComponentUtil.getBitmapData(numsArr[int(ss)],Global.ZNdm);
               i++;
            }
            resize();
         };
         var resize:Function = function():void
         {
            var bbb:Bitmap = null;
            var j:uint = 0;
            while(j < listBmArr.length)
            {
               bbb = listBmArr[j];
               ComponentUtil.setPropertie(bbb,{"x":11 * j});
               j++;
            }
         };
         var reset:Function = function():void
         {
            var bb:Bitmap = null;
            for each(bb in listBmArr)
            {
               if(Boolean(bb) && Boolean(bb.parent))
               {
                  bb.parent.removeChild(bb);
               }
               Pool.saveObject(bb);
            }
            listBmArr.splice(0);
         };
         reset();
         isPlayIng = false;
         if(lastStrength < value && !isFrist)
         {
            play = function():void
            {
               resultFun(currentPower);
               if(flag != 0)
               {
                  clearTimeout(flag);
                  flag = 0;
               }
               if(!isPlayIng)
               {
                  lastStrength = value;
               }
               if(currentPower < value)
               {
                  currentPower += add;
                  flag = setTimeout(play,100);
               }
               else
               {
                  resultFun(value);
                  lastStrength = value;
                  isPlayIng = false;
               }
            };
            currentPower = lastStrength;
            add = (value - lastStrength) / 20;
            if(add <= 0)
            {
               add = 1;
            }
            flag = int(setTimeout(play,100));
            isPlayIng = true;
         }
         else
         {
            resultFun(value);
            lastStrength = value;
            isPlayIng = false;
         }
      }
      
      public static function showPeiYangTBtn() : void
      {
         if(!tip)
         {
            tip = new BitmapBtn();
            tip.init();
            tip.setBgDir(bitmapDir);
            tip.clickCallBack = function():void
            {
               Model_baby.show(BabyPYTipsPan.instance);
               removeTip();
            };
         }
         UIManager.tipBtnContainer.addItem(tip);
      }
      
      public static function removeTip() : void
      {
         if(Boolean(tip) && UIManager.tipBtnContainer.contains(tip))
         {
            UIManager.tipBtnContainer.removeItem(tip);
         }
      }
   }
}

