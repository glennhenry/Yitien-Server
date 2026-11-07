package com.yiTian.net.handler
{
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.paihang.PaiHangVO;
   import com.yiTian.view.modules.pata.CityDiaoXiang;
   
   public class PaiHangHandler
   {
      
      private static const positionArr:Array = [[3493.45,1971.1],[3151.85,2145.8],[2996.35,2062.4],[3326.35,1869.75]];
      
      private static const typeDX:Array = [0,2,4,6];
      
      public function PaiHangHandler()
      {
         super();
      }
      
      public static function GC_PAIHANG_DENGJI(result:int, phVO:PaiHangVO) : void
      {
         phVO.isShowZhiYe = true;
         phVO.curPaiHangType = 1;
         UIManager.paiHangPanel.paiHangVO = phVO;
         if(UIManager.paiHangPanel.visible)
         {
            UIManager.paiHangPanel.update();
         }
      }
      
      public static function GC_PAIHANG_ZHANLI(result:int, phVO:PaiHangVO) : void
      {
         phVO.isShowZhiYe = true;
         phVO.curPaiHangType = 2;
         UIManager.paiHangPanel.paiHangVO = phVO;
         if(UIManager.paiHangPanel.visible)
         {
            UIManager.paiHangPanel.update();
         }
      }
      
      public static function GC_PAIHANG_CAIFU(result:int, phVO:PaiHangVO) : void
      {
         phVO.isShowZhiYe = false;
         phVO.curPaiHangType = 3;
         UIManager.paiHangPanel.paiHangVO = phVO;
         if(UIManager.paiHangPanel.visible)
         {
            UIManager.paiHangPanel.update();
         }
      }
      
      public static function GC_PAIHANG_MY(result:int, phVO:PaiHangVO) : void
      {
         if(phVO.curPaiHangType == 1 || phVO.curPaiHangType == 2)
         {
            phVO.isShowZhiYe = true;
         }
         else if(phVO.curPaiHangType == 4)
         {
            phVO.isShowKunLunClass = true;
         }
         else if(phVO.curPaiHangType == 5)
         {
            phVO.isShowWuLinDaHuiClass = true;
         }
         else if(phVO.curPaiHangType == 8)
         {
            phVO.isShowMeiLiClass = true;
         }
         else if(phVO.curPaiHangType == 9)
         {
            phVO.isShowFlowersClass = true;
         }
         phVO.isMyFlat = true;
         UIManager.paiHangPanel.paiHangVO = phVO;
         if(UIManager.paiHangPanel.visible)
         {
            UIManager.paiHangPanel.update();
         }
      }
      
      public static function GC_PAIHANG_KUNLUN(result:int, phVO:PaiHangVO) : void
      {
         phVO.isShowKunLunClass = true;
         phVO.curPaiHangType = 4;
         UIManager.paiHangPanel.paiHangVO = phVO;
         if(UIManager.paiHangPanel.visible)
         {
            UIManager.paiHangPanel.update();
         }
      }
      
      public static function GC_PAIHANG_WULINDAHUI(result:int, phVO:PaiHangVO) : void
      {
         phVO.isShowWuLinDaHuiClass = true;
         phVO.curPaiHangType = 5;
         UIManager.paiHangPanel.paiHangVO = phVO;
         if(UIManager.paiHangPanel.visible)
         {
            UIManager.paiHangPanel.update();
         }
      }
      
      public static function GC_PAIHANG_PET(result:int, phVO:PaiHangVO) : void
      {
         phVO.curPaiHangType = 6;
         UIManager.paiHangPanel.paiHangVO = phVO;
         if(UIManager.paiHangPanel.visible)
         {
            UIManager.paiHangPanel.update();
         }
      }
      
      public static function GC_PAIHANG_BANGHUI(result:int, phVO:PaiHangVO) : void
      {
         phVO.curPaiHangType = 7;
         UIManager.paiHangPanel.paiHangVO = phVO;
         if(UIManager.paiHangPanel.visible)
         {
            UIManager.paiHangPanel.update();
         }
      }
      
      public static function GC_PAIHANG_MEILI(result:int, phVO:PaiHangVO) : void
      {
         phVO.isShowMeiLiClass = true;
         phVO.curPaiHangType = 8;
         UIManager.paiHangPanel.paiHangVO = phVO;
         if(UIManager.paiHangPanel.visible)
         {
            UIManager.paiHangPanel.update();
         }
      }
      
      public static function GC_PAIHANG_FLOWERS(result:int, phVO:PaiHangVO) : void
      {
         phVO.isShowFlowersClass = true;
         phVO.curPaiHangType = 9;
         UIManager.paiHangPanel.paiHangVO = phVO;
         if(UIManager.paiHangPanel.visible)
         {
            UIManager.paiHangPanel.update();
         }
      }
      
      public static function GC_CITY_DIAOXIANG(result:int, arr:Array) : void
      {
         var unit:GameUnit = null;
         var diaoXiang:CityDiaoXiang = null;
         var isHave:Boolean = false;
         var m:Number = NaN;
         var n:uint = 0;
         PaiHangVO.diaoXiangArr = arr;
         var i:Number = 0;
         while(i < 4)
         {
            unit = GameUnitManager.findUnit(i,UnitType.CITY_DIAOXIANG);
            if(Boolean(unit))
            {
               GameUnitManager.removeUnit(unit);
            }
            i++;
         }
         i = 0;
         while(i < arr.length)
         {
            diaoXiang = GameUnitManager.findUnit(i,UnitType.CITY_DIAOXIANG) as CityDiaoXiang;
            if(!Boolean(diaoXiang))
            {
               diaoXiang = GameUnitManager.getUnit(UnitType.CITY_DIAOXIANG) as CityDiaoXiang;
               diaoXiang.init(i,arr[i][0],arr[i][1],arr[i][2],arr[i][3],arr[i][4],arr[i][5],arr[i][6],arr[i][7],arr[i][8],arr[i][11],arr[i][12],arr[i][13],positionArr[arr[i][0] / 2][0],positionArr[arr[i][0] / 2][1],arr[i][arr[i].length - 2],arr[i][arr[i].length - 1][0],arr[i][arr[i].length - 1][1],arr[i][arr[i].length - 1][2]);
               GameUnitManager.addUnit(diaoXiang);
            }
            i++;
         }
         var a:Array = [];
         if(i < 4)
         {
            m = 0;
            while(m < typeDX.length)
            {
               isHave = false;
               n = 0;
               while(n < arr.length)
               {
                  if(typeDX[m] == arr[n][0])
                  {
                     isHave = true;
                     break;
                  }
                  n++;
               }
               if(!isHave)
               {
                  a.push(typeDX[m]);
               }
               m++;
            }
            m = i;
            n = 0;
            while(n < a.length)
            {
               diaoXiang = GameUnitManager.findUnit(m,UnitType.CITY_DIAOXIANG) as CityDiaoXiang;
               if(!Boolean(diaoXiang))
               {
                  diaoXiang = GameUnitManager.getUnit(UnitType.CITY_DIAOXIANG) as CityDiaoXiang;
                  diaoXiang.init(m,0,0,null,0,0,0,0,0,0,null,0,null,positionArr[a[n] / 2][0],positionArr[a[n] / 2][1],0,0,0,"");
                  GameUnitManager.addUnit(diaoXiang);
               }
               m++;
               n++;
            }
         }
      }
   }
}

