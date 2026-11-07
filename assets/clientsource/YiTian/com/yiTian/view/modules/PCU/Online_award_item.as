package com.yiTian.view.modules.PCU
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_pcu_status;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.net.message.cg.OnLineAwardCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class Online_award_item extends Sprite
   {
      
      private var _id:int;
      
      protected var btn:Button;
      
      protected var tf:MyTextField;
      
      protected var has_get_bm:Bitmap;
      
      public var status:int;
      
      private const countTime:int = 300;
      
      private var curTime:int;
      
      private var timer:Timer;
      
      private var grids:Array = [];
      
      private var beginTime:int;
      
      public function Online_award_item(id:int)
      {
         super();
         this._id = id;
         this.btn.addEventListener(MouseEvent.CLICK,this.onClickHandle);
      }
      
      protected function initGrid(id:int, beginX:int) : void
      {
         var datastr:String = null;
         var data:Array = null;
         var grid:View_Grid = null;
         var i:int = 0;
         var itemData:Array = null;
         var item:Vo_item = null;
         var equip:Vo_equip = null;
         if(id < 5)
         {
            datastr = Data_lib.zaixianfuli[id + 1][0];
         }
         else
         {
            datastr = Data_lib.banghuifuli[id - 4][1];
         }
         data = datastr.split(",");
         var len:int = int(data.length);
         i = 0;
         while(i < len)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.PCU;
            grid.set_tf_count(true);
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.x = beginX + 3 + i * 49;
            grid.y = 3 + 9;
            grid.isAutoLoad = true;
            grid.index = i;
            addChild(grid);
            this.grids.push(grid);
            itemData = data[i].split("_");
            if(itemData[0] == 1)
            {
               item = new Vo_item();
               item.id = itemData[1];
               item.Init_lib();
               grid.vo = item;
            }
            else if(itemData[0] == 2)
            {
               equip = new Vo_equip();
               equip.id = itemData[1];
               equip.Init_lib();
               grid.vo = equip;
            }
            grid.count = itemData[2];
            i++;
         }
      }
      
      public function flyToBag() : void
      {
         var len:int = int(this.grids.length);
         var i:int = 0;
         while(i < len)
         {
            ComboTweenStep.toBag(View_Grid(this.grids[i]));
            i++;
         }
      }
      
      public function initBm() : void
      {
         this.has_get_bm.bitmapData = ComponentUtil.getBitmapData("Text_Got",Global.PCU_Imgsdm);
      }
      
      public function startCount() : void
      {
         this.curTime = this.countTime;
         GameScene.instance.addFrameCallBack(this.onCountDown);
         this.beginTime = getTimer();
      }
      
      public function resetCount() : void
      {
         if(GameScene.instance.hasFrameCallBack(this.onCountDown))
         {
            GameScene.instance.removeFrameCallBack(this.onCountDown);
         }
      }
      
      public function setButton(_status:int) : void
      {
         this.status = _status;
         switch(this.status)
         {
            case Enum_pcu_status.CAN_NOT_GET:
               this.btn.visible = false;
               this.tf.visible = true;
               this.has_get_bm.visible = false;
               this.tf.text = "未符合";
               break;
            case Enum_pcu_status.CAN_GET:
               this.btn.visible = true;
               this.tf.visible = false;
               this.has_get_bm.visible = false;
               break;
            case Enum_pcu_status.HAS_GET:
               this.btn.visible = false;
               this.tf.visible = false;
               this.has_get_bm.visible = true;
         }
      }
      
      private function onClickHandle(e:MouseEvent) : void
      {
         OnLineAwardCGMessage.CG_PCU_GET_REWARD(this._id);
      }
      
      private function onCountDown() : void
      {
         var now:int = getTimer();
         var useTime:int = (now - this.beginTime) / 1000;
         this.curTime = this.countTime - useTime;
         if(this.curTime > 0)
         {
            this.tf.text = String(int(this.curTime / 60)) + ":" + String(this.curTime % 60 + 100).substr(1);
         }
         else
         {
            GameScene.instance.removeFrameCallBack(this.onCountDown);
            OnLineAwardCGMessage.CG_PCU_CAN_REWARD(this._id);
            this.tf.text = "0:00";
         }
      }
   }
}

