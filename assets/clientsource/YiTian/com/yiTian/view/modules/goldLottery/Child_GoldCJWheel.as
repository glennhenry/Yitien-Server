package com.yiTian.view.modules.goldLottery
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_GoldCJ;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import flash.display.Sprite;
   
   public class Child_GoldCJWheel extends Sprite
   {
      
      private static var MAX_NUM:int = 10;
      
      private var totalRotation:int;
      
      private var curRotation:int;
      
      private var round:Sprite;
      
      private var points:Sprite;
      
      private var fRotation:int;
      
      private var sRotation:uint;
      
      private var fastSD:int = 9;
      
      private var slowSD:int = 3;
      
      private var curIndex:int = 0;
      
      private var perNum:int;
      
      public var gridView:Child_GoldCJGrid;
      
      public var forTimes:int;
      
      public function Child_GoldCJWheel()
      {
         super();
         this.round = new Sprite();
         addChild(this.round);
         this.points = new Sprite();
         this.points.x = 113 + 91 - 18;
         this.points.y = 94 + 91;
         addChild(this.points);
         ComponentUtil.getBitmap("Back_Round",this.round,{
            "x":0,
            "y":0
         },Global.YuanBaoCJ_Imgsdm);
         ComponentUtil.getBitmap("ZhiZhen_Img",this.points,{
            "x":-91,
            "y":-91
         },Global.YuanBaoCJ_Imgsdm);
         this.perNum = 360 / MAX_NUM;
         this.points.rotation = -18;
      }
      
      public function start(index:int) : void
      {
         index--;
         this.fRotation = 360 * this.forTimes;
         var offNum:int = index < this.curIndex ? int(index + 10 - this.curIndex) : int(index - this.curIndex);
         this.sRotation = this.perNum * offNum;
         this.totalRotation = this.fRotation + this.sRotation;
         GameScene.instance.addFrameCallBack(this.onRotation);
         this.curIndex = index;
      }
      
      private function onRotation() : void
      {
         var gridIndex:int = 0;
         var a:Array = null;
         var n:int = this.points.rotation - this.perNum / 2;
         if(n % this.perNum == 0)
         {
            if(!this.gridView)
            {
               return;
            }
            gridIndex = n >= 0 ? int(n / this.perNum + 1) : int((360 + n) / this.perNum + 1);
            this.gridView.singleMoveHandler(gridIndex == Model_GoldCJ.REWARD_NUM ? 0 : gridIndex);
         }
         if(this.fRotation > 0)
         {
            this.fRotation -= this.fastSD;
            this.points.rotation += this.fastSD;
         }
         else if(this.sRotation > 0)
         {
            this.sRotation -= this.slowSD;
            this.points.rotation += this.slowSD;
         }
         else
         {
            GameScene.instance.removeFrameCallBack(this.onRotation);
            Model_GoldCJ.isRunning = false;
            if(Model_GoldCJ.curCJType == 1)
            {
               this.gridView.flyToBag(this.curIndex);
            }
            UIManager.goldCJ.setBtnEnable();
            if(Model_GoldCJ.curCJType != 1)
            {
               a = Model_GoldCJ.rewardList;
               if(!UIManager.goldCJ.rewardListPanel)
               {
                  UIManager.goldCJ.rewardListPanel = new Child_GoldCJRewardList();
               }
               UIManager.goldCJ.rewardListPanel.update(a);
            }
         }
      }
   }
}

