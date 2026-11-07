package com.yiTian.view.modules.pet.petD
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.pet.PetVO;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Model_pet
   {
      
      private static var petZZItem:PetZiZhiItem;
      
      public static var desCripArr:Array = ["<font color=\'#00ffff\'>" + "宠物资质突破" + "</font>" + "<font color=\'#ff7700\'>" + "\n当宠物等级到达80，资质100时，可突破成\n为灵宠，获得更帅气头衔，资质上限提高至150！" + "</font>","<font color=\'#00ffff\'>" + "宠物资质突破" + "</font>" + "<font color=\'#ff7700\'>" + "\n当宠物等级到达90，资质150时，可突破成\n为仙宠，获得更帅气头衔，资质上限提高至200！" + "</font>","<font color=\'#00ffff\'>" + "宠物资质突破" + "</font>" + "<font color=\'#ff7700\'>" + "\n当宠物等级到达100，资质200时，可突破成\n为圣宠，获得更帅气头衔，资质上限提高至250！" + "</font>","<font color=\'#00ffff\'>" + "宠物资质突破" + "</font>" + "<font color=\'#ff7700\'>" + "\n当宠物等级到达110，资质250时，可突破成\n为神宠，获得更帅气头衔，资质上限提高至300！" + "</font>","<font color=\'#00ffff\'>" + "宠物资质突破" + "</font>" + "<font color=\'#ff7700\'>" + "\n当宠物等级到达120，资质300时，可突破成\n为玄宠，获得更帅气头衔，资质上限提高至350！" + "</font>","<font color=\'#00ffff\'>" + "宠物资质突破" + "</font>" + "<font color=\'#ff7700\'>" + "\n当宠物等级到达120，资质300时，可突破成\n为玄宠，获得更帅气头衔，资质上限提高至350！" + "</font>"];
      
      private static var _metiarialArr:Array = [];
      
      public static var idArr:Array = [44715];
      
      public static var typeChangedDesArr:Array = [["<font color=\'#de45c7\'>" + "极品" + "</font>","<font color=\'#de45c7\'>" + "灵品" + "</font>"],["<font color=\'#de45c7\'>" + "灵品" + "</font>","<font color=\'#ff7700\'>" + "仙品" + "</font>"],["<font color=\'#ff7700\'>" + "仙品" + "</font>","<font color=\'#ff7700\'>" + "圣品" + "</font>"],["<font color=\'#ff7700\'>" + "圣品" + "</font>","<font color=\'#c53232\'>" + "神品" + "</font>"],["<font color=\'#c53232\'>" + "神品" + "</font>","<font color=\'#ffd700\'>" + "玄品" + "</font>"],["<font color=\'#c53232\'>" + "玄品" + "</font>","<font color=\'#ffd700\'>" + "XX品" + "</font>"]];
      
      public static var typeChangedValArr:Array = [["<font color=\'#04ff00\'>" + "100" + "</font>","<font color=\'#33CCFF\'>" + "150" + "</font>"],["<font color=\'#33CCFF\'>" + "150" + "</font>","<font color=\'#de45c7\'>" + "200" + "</font>"],["<font color=\'#de45c7\'>" + "200" + "</font>","<font color=\'#ff7700\'>" + "250" + "</font>"],["<font color=\'#ff7700\'>" + "250" + "</font>","<font color=\'#c53232\'>" + "300" + "</font>"],["<font color=\'#c53232\'>" + "300" + "</font>","<font color=\'#ffd700\'>" + "350" + "</font>"],["<font color=\'#ffd700\'>" + "350" + "</font>","<font color=\'#ffd700\'>" + "(350+)" + "</font>"]];
      
      public function Model_pet()
      {
         super();
      }
      
      public static function get metiarialArr() : Array
      {
         var dic:Dictionary = null;
         var key:String = null;
         var _index:int = 0;
         if(!_metiarialArr.length)
         {
            dic = Data_lib.XiZiZi;
            for(key in dic)
            {
               _index = int(key);
               _metiarialArr[_index - 1] = [dic[key][1],dic[key][2],dic[key][3]];
            }
         }
         return _metiarialArr;
      }
      
      public static function handleOfPetXiZhi(xiZhiValue:int) : Object
      {
         var maxWidth:int = 0;
         var jinJiLevl:int = 0;
         var obj:Object = new Object();
         if(xiZhiValue <= 100)
         {
            maxWidth = 100;
            if(xiZhiValue != 100)
            {
               jinJiLevl = 0;
            }
            else
            {
               jinJiLevl = 1;
            }
         }
         else if(xiZhiValue > 100 && xiZhiValue <= 150)
         {
            maxWidth = 150;
            if(xiZhiValue != 150)
            {
               jinJiLevl = 0;
            }
            else
            {
               jinJiLevl = 2;
            }
         }
         else if(xiZhiValue > 150 && xiZhiValue <= 200)
         {
            maxWidth = 200;
            if(xiZhiValue != 200)
            {
               jinJiLevl = 0;
            }
            else
            {
               jinJiLevl = 3;
            }
         }
         else if(xiZhiValue > 200 && xiZhiValue <= 250)
         {
            maxWidth = 250;
            if(xiZhiValue != 250)
            {
               jinJiLevl = 0;
            }
            else
            {
               jinJiLevl = 4;
            }
         }
         else if(xiZhiValue > 250 && xiZhiValue <= 300)
         {
            maxWidth = 300;
            if(xiZhiValue != 300)
            {
               jinJiLevl = 0;
            }
            else
            {
               jinJiLevl = 5;
            }
         }
         else if(xiZhiValue > 300 && xiZhiValue <= 350)
         {
            maxWidth = 350;
            if(xiZhiValue != 350)
            {
               jinJiLevl = 0;
            }
            else
            {
               jinJiLevl = 6;
            }
         }
         obj.maxWidth = maxWidth;
         obj.jinJiLevl = jinJiLevl;
         return obj;
      }
      
      public static function addUnit(parent:DisplayObjectContainer) : void
      {
         if(!petZZItem)
         {
            petZZItem = new PetZiZhiItem();
            parent.addChild(petZZItem);
         }
      }
      
      public static function addBagsUpdateFrame() : void
      {
         Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,bagUpdate);
      }
      
      public static function removeBagsUpdateFrame() : void
      {
         Global.control.removeCallBack(Enum_MsgType.BAG_UPDATE,bagUpdate);
      }
      
      private static function bagUpdate() : void
      {
         petZZItem.bagUpdate();
      }
      
      public static function updateLvl(lvl:int) : void
      {
         if(lvl < 1)
         {
            return;
         }
         petZZItem.update(lvl);
      }
      
      public static function updateRate(res:int = 0) : void
      {
         var vo:PetVO = UIManager.petPanel.petVO;
         var rate:int = vo.succRate;
         if(rate == 0)
         {
            rate = 5;
         }
         petZZItem.upRate(rate);
         petZZItem.updateSucce(res);
      }
      
      public static function addMoveTips(gridVec:Vector.<View_Grid>) : void
      {
         var tuPoNums:int = 0;
         var add_tips:Function = function(index:int):void
         {
            var vo:Vo_Skill;
            var gg:View_Grid = null;
            var n:int = 0;
            if(index >= tuPoNums)
            {
               return;
            }
            gg = gridVec[index];
            vo = gg.vo as Vo_Skill;
            if(Boolean(vo) && vo.str_name.indexOf("特级") != -1)
            {
               add_tips(++index);
               return;
            }
            n = int(setTimeout(function():void
            {
               clearTimeout(n);
               var petMoveTip:* = PetMoveObj.instance;
               petMoveTip.setTextDescrip("开启特级",new Point(0,4));
               petMoveTip.move(gg.x - 17,gg.y - 50,UIManager.petPanel);
               add_tips(++index);
            },1));
         };
         if(!gridVec || !gridVec.length)
         {
            return;
         }
         tuPoNums = tuPoMsgHd();
         if(tuPoNums <= 0)
         {
            return;
         }
         add_tips(0);
      }
      
      public static function moveTipsRemove() : void
      {
         var item:PetMoveObj = null;
         var i:int = PetMoveObj.list.length - 1;
         while(i >= 0)
         {
            item = PetMoveObj.list[i];
            item.remove();
            i--;
         }
      }
      
      private static function tuPoMsgHd() : int
      {
         var petVO:PetVO = UIManager.petPanel.petVO;
         if(Boolean(petVO.isTuPo))
         {
            if(petVO.CZLevel < 22)
            {
               return 1;
            }
            if(petVO.CZLevel < 24)
            {
               return 2;
            }
            if(petVO.CZLevel < 25)
            {
               return 3;
            }
            if(petVO.CZLevel < 27)
            {
               return 4;
            }
            if(petVO.CZLevel < 28)
            {
               return 5;
            }
            if(petVO.CZLevel < 30)
            {
               return 6;
            }
            return 7;
         }
         if(petVO.CZLevel < 22)
         {
            return 0;
         }
         if(petVO.CZLevel < 24)
         {
            return 1;
         }
         if(petVO.CZLevel < 25)
         {
            return 2;
         }
         if(petVO.CZLevel < 27)
         {
            return 3;
         }
         if(petVO.CZLevel < 28)
         {
            return 4;
         }
         if(petVO.CZLevel < 30)
         {
            return 5;
         }
         return 6;
      }
   }
}

