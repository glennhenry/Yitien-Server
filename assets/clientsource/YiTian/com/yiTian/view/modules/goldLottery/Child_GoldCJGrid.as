package com.yiTian.view.modules.goldLottery
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_GoldCJ;
   import com.yiTian.data.vo.Vo_GoldCJ;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.GoldCJCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Child_GoldCJGrid extends Sprite
   {
      
      private var btnCon:Sprite;
      
      private var bm:Bitmap;
      
      private var gridArr:Array = new Array(10);
      
      private var lockBtnArr:Array = new Array(10);
      
      private var unlockBtnArr:Array = new Array(10);
      
      private var _targetIndex:int;
      
      public function Child_GoldCJGrid()
      {
         var g:View_Grid = null;
         var i:int = 0;
         var proper:Object = null;
         var lock:Button = null;
         var unlock:Button = null;
         super();
         this.parseData();
         this.btnCon = new Sprite();
         addChild(this.btnCon);
         var len1:int = int(this.gridArr.length);
         i = 0;
         while(i < len1)
         {
            g = new View_Grid();
            g.set_bmp_bg();
            g.set_bmp_over(true,null);
            g.set_tf_count(true,false,true);
            g.index = i;
            g.vo = Model_GoldCJ.voArr[i].vo;
            this.gridArr[i] = g;
            proper = Model_GoldCJ.posArr2[i];
            ComponentUtil.setPropertie(g,{
               "x":proper.x,
               "y":proper.y
            });
            addChild(g);
            proper = Model_GoldCJ.posArr1[i];
            lock = ComponentUtil.getButton("","Button_Lock",this,{
               "name":"l_" + (i + 1),
               "textColor":16184781,
               "callBack":this.onUnlockHandler
            },Global.YuanBaoCJ_Imgsdm);
            ComponentUtil.setPropertie(lock,{
               "x":proper.x,
               "y":proper.y
            });
            lock.visible = false;
            this.lockBtnArr[i] = lock;
            unlock = ComponentUtil.getButton("","Button_UnLock",this,{
               "name":"ul_" + (i + 1),
               "textColor":16184781,
               "callBack":this.onLockHandler
            },Global.YuanBaoCJ_Imgsdm);
            ComponentUtil.setPropertie(unlock,{
               "x":proper.x,
               "y":proper.y
            });
            unlock.visible = false;
            this.unlockBtnArr[i] = unlock;
            i++;
         }
         this.bm = ComponentUtil.getBitmap("Point_Img",this,{
            "x":-3,
            "y":109,
            "visible":false
         },Global.YuanBaoCJ_Imgsdm);
         this.bm.visible = false;
      }
      
      private function onUnlockHandler(e:MouseEvent) : void
      {
         if(Model_GoldCJ.isRunning)
         {
            UIManager.centerBroadcast.addMsg("正在抽取中");
            return;
         }
         var target:Button = e.target as Button;
         var idx:int = int(target.name.split("_")[1]);
         if(this.isCanLockByIndex(idx))
         {
            GoldCJCGMessage.CG_GLOD_CJ_LOCK_GRID(idx);
         }
      }
      
      private function onLockHandler(e:MouseEvent) : void
      {
         if(Model_GoldCJ.isRunning)
         {
            UIManager.centerBroadcast.addMsg("正在抽取中");
            return;
         }
         var target:Button = e.target as Button;
         var idx:int = int(target.name.split("_")[1]);
         if(this.isCanLockByIndex(idx))
         {
            GoldCJCGMessage.CG_GLOD_CJ_LOCK_GRID(idx);
         }
      }
      
      private function isCanLockByIndex(index:int) : Boolean
      {
         var canLockNum:int = 0;
         var i:int = 0;
         if(Model_GoldCJ.totalCJTimes < Model_GoldCJ.timesArr[0])
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("20049",11,Model_GoldCJ.timesArr[0]));
            return false;
         }
         if(Model_GoldCJ.totalCJTimes >= Model_GoldCJ.timesArr[2])
         {
            canLockNum = 3;
         }
         else if(Model_GoldCJ.totalCJTimes >= Model_GoldCJ.timesArr[1])
         {
            canLockNum = 2;
         }
         else
         {
            canLockNum = Model_GoldCJ.totalCJTimes >= Model_GoldCJ.timesArr[0] ? 1 : 0;
         }
         var arr1:Array = Model_GoldCJ.voArr;
         var vo:Vo_GoldCJ = arr1[index - 1];
         var arr2:Array = Model_GoldCJ.lockStr.split("_");
         if(arr2.length > 0 && arr2[0] != "")
         {
            i = 0;
            while(i < arr2.length)
            {
               if(vo.index == arr2[i])
               {
                  return true;
               }
               i++;
            }
            if(arr2.length < canLockNum)
            {
               return true;
            }
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("20050",11));
            return false;
         }
         return true;
      }
      
      public function updateLock(isLock:int, index:int) : void
      {
         if(isLock == 1)
         {
            if(Boolean(this.lockBtnArr[index - 1]) && Boolean(this.unlockBtnArr[index - 1]) && Boolean(this.gridArr[index - 1]))
            {
               this.lockBtnArr[index - 1].visible = true;
               this.unlockBtnArr[index - 1].visible = false;
               this.gridArr[index - 1].set_grey(true);
            }
         }
         else if(Boolean(this.lockBtnArr[index - 1]) && Boolean(this.unlockBtnArr[index - 1]))
         {
            this.lockBtnArr[index - 1].visible = false;
            this.unlockBtnArr[index - 1].visible = true;
            this.gridArr[index - 1].set_grey(false);
         }
      }
      
      public function singleMoveHandler(cIndex:int) : void
      {
         this._targetIndex = cIndex;
         var g:View_Grid = this.gridArr[cIndex];
         var vo:Vo_GoldCJ = Model_GoldCJ.voArr[cIndex];
         if(!g || !vo)
         {
            return;
         }
         if(!this.bm.visible)
         {
            this.bm.visible = true;
         }
         if(vo.isLock == 1)
         {
            this.bm.visible = false;
            return;
         }
         ComponentUtil.setPropertie(this.bm,{
            "x":g.x - 19,
            "y":g.y - 19
         });
      }
      
      public function flyToBag(gIndex:int) : void
      {
         var grid:View_Grid = null;
         var toIndex:int = 0;
         var time:int = 200;
         grid = this.gridArr[gIndex];
         if(!grid)
         {
            return;
         }
         toIndex = int(setTimeout(function():void
         {
            comboToBagHandler(grid,grid.vo.count,1,0);
            clearTimeout(toIndex);
         },time));
      }
      
      public function stepByStepHandler(index:int) : void
      {
         var arr:Array = Model_GoldCJ.rewardList;
         if(!Model_GoldCJ.rewardList[index])
         {
            return;
         }
         var i:int = int(Model_GoldCJ.rewardList[index].index);
         var g:View_Grid = this.gridArr[i - 1];
         index++;
         this.comboToBagHandler(g,g.vo.count,1,index);
      }
      
      private function comboToBagHandler(gg:View_Grid, count:int, t:int, index:int) : void
      {
         var num:int = 0;
         if(!gg)
         {
            return;
         }
         if(t > count)
         {
            if(Model_GoldCJ.curCJType != 1)
            {
               this.stepByStepHandler(index);
            }
            return;
         }
         num = int(setTimeout(function():void
         {
            ComboTweenStep.toBag(gg,0,0);
            ++t;
            comboToBagHandler(gg,count,t,index);
            clearTimeout(num);
         },200));
      }
      
      private function parseData() : void
      {
         var itemVO:Vo_GoldCJ = null;
         var type:int = 0;
         var id:int = 0;
         var count:int = 0;
         var index:int = 0;
         var idx:String = null;
         for(idx in Data_lib.goldCJ)
         {
            type = int(Data_lib.goldCJ[idx][0].split("_")[0]);
            id = int(Data_lib.goldCJ[idx][0].split("_")[1]);
            count = int(Data_lib.goldCJ[idx][0].split("_")[2]);
            index = int(Data_lib.goldCJ[idx][2]);
            itemVO = new Vo_GoldCJ();
            itemVO.index = index;
            itemVO.vo.type = type;
            itemVO.vo.id = id;
            itemVO.vo.count = count;
            itemVO.vo.Init_lib();
            Model_GoldCJ.voArr.push(itemVO);
         }
         Model_GoldCJ.voArr.sortOn("index",Array.NUMERIC);
      }
   }
}

