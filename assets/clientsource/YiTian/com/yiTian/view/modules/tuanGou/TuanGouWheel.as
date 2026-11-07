package com.yiTian.view.modules.tuanGou
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_TuanGou;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TuanGouCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class TuanGouWheel extends Sprite
   {
      
      private const r:int = 110;
      
      private var vecGrids:Vector.<Object>;
      
      private var MaxSd:int = 10;
      
      private var MinSd:int = 0;
      
      private var ASd:Number;
      
      private var speed:Number = 0;
      
      private var RotationLong:Number;
      
      private var isClick:Boolean = true;
      
      private var weiZhi:int = 3;
      
      private var goodsNum:int = 12;
      
      private var min:int = 2;
      
      private var max:int = 5;
      
      private var bt:Button;
      
      private var startBtn:Button;
      
      private var round:Sprite;
      
      private var points:Sprite;
      
      private var spr:Sprite = new Sprite();
      
      private var temp:Bitmap = new Bitmap();
      
      private var isFrist:Boolean = true;
      
      private var obj:*;
      
      private var t:MyTextField;
      
      public function TuanGouWheel()
      {
         super();
         if(!this.round)
         {
            this.round = new Sprite();
            this.round.x = 532;
            this.round.y = 121;
            this.addChild(this.round);
            Utils.loadTitle("lang/ch/TuanGou_Imgs.swf","Round",new Bitmap(),{
               "x":0,
               "y":0
            },this.round,this.onLoadCom);
         }
         addChild(this.spr);
         if(!this.points)
         {
            this.points = new Sprite();
            this.points.x = 626 + 65;
            this.points.y = 184 + 100;
            this.addChild(this.points);
            Utils.loadTitle("lang/ch/TuanGou_Imgs.swf","Points",this.temp,null,null,this.onCom);
         }
      }
      
      private function onCom() : void
      {
         var b:Bitmap = new Bitmap(this.temp.bitmapData,"auto",true);
         ComponentUtil.setPropertie(b,{
            "x":-65,
            "y":-100
         });
         this.points.addChild(b);
      }
      
      private function onLoadCom() : void
      {
         if(!this.startBtn)
         {
            this.startBtn = ComponentUtil.getButton("","Button_YaoJiang",this,{
               "x":644,
               "y":236,
               "textColor":16184781
            },Utils.swfPool["lang/ch/TuanGou_Imgs.swf"]);
            this.startBtn.addEventListener(MouseEvent.CLICK,this.onClick);
            this.judgeCLick();
         }
      }
      
      private function showItem() : void
      {
         var grid:View_Grid = null;
         var len:int = 0;
         var i:int = 0;
         var px:Number = NaN;
         var py:Number = NaN;
         var txt:MyTextField = null;
         if(this.isFrist)
         {
            this.isFrist = false;
            this.vecGrids = new Vector.<Object>();
            len = int(Model_TuanGou.vecWheelGoods.length);
            i = 0;
            while(i < len)
            {
               px = Math.sin(Math.PI / 6 * (Model_TuanGou.vecWheelGoods[i].weiZhi - 0.5)) * this.r;
               py = Math.cos(Math.PI / 6 * (Model_TuanGou.vecWheelGoods[i].weiZhi - 0.5)) * this.r;
               grid = new View_Grid();
               grid.type = Enum_type_grid.NO_DRAG;
               grid.set_bmp_over();
               grid.set_tf_count();
               grid.set_bmp_bg();
               grid.x = 675 + px;
               grid.y = 265 - py;
               grid.vo = Model_TuanGou.vecWheelGoods[i].vo;
               grid.set_bmp_select();
               TipManager.unBind(grid);
               this.spr.addChild(grid);
               this.vecGrids.push(grid);
               txt = ComponentUtil.getTextField("",this,{
                  "x":675 + px,
                  "y":265 - py,
                  "size":14,
                  "color":16711680
               });
               i++;
            }
         }
      }
      
      public function update() : void
      {
         this.showItem();
         this.setGrey();
         this.judgeCLick();
      }
      
      private function judgeCLick() : void
      {
         if(Model_TuanGou.keepObj.surplus > 0)
         {
            if(Boolean(this.startBtn))
            {
               this.startBtn.enabled = true;
            }
         }
         else if(Boolean(this.startBtn))
         {
            this.startBtn.enabled = false;
         }
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         if(this.isClick)
         {
            TuanGouCGMessage.CG_TUANGOU_REQUEST_START();
            this.startBtn.enabled = false;
         }
      }
      
      public function start(num:int) : void
      {
         var i:int = 0;
         while(i < this.vecGrids.length)
         {
            if(Model_TuanGou.vecWheelGoods[i].xiaBiao == num)
            {
               this.obj = this.vecGrids[i];
               this.weiZhi = Model_TuanGou.vecWheelGoods[i].weiZhi;
            }
            i++;
         }
         if(this.weiZhi == 12)
         {
            this.weiZhi = 0;
         }
         if(this.isClick)
         {
            this.RotationLong = 360 * 3 + (this.weiZhi - 0.5) * 30;
            this.ASd = (this.MaxSd * this.MaxSd - this.MinSd * this.MinSd) / this.RotationLong;
            if(Model_TuanGou.keepObj.surplus - 1 >= 0)
            {
               --Model_TuanGou.keepObj.surplus;
            }
            UIManager.tuanGou.updateShengYuTxt();
            this.speed = 0;
            this.points.rotation = 0;
            this.isClick = false;
            this.startBtn.enabled = false;
            GameScene.instance.addFrameCallBack(this.Onrotation);
         }
      }
      
      private function Onrotation(interenal:int) : void
      {
         var i:int = 0;
         var p:Point = null;
         if(this.speed >= this.MaxSd)
         {
            this.speed = 2 * this.MaxSd - this.speed;
            this.ASd = -this.ASd;
         }
         this.speed += this.ASd;
         if(this.speed > 0)
         {
            this.points.rotation += this.speed;
         }
         else
         {
            this.isClick = true;
            if(UIManager.tuanGou.visible)
            {
               p = localToGlobal(new Point(this.obj.x,this.obj.y));
               Tween.gridToBagBezierFuncDef(this.obj.vo,-1,p.x,p.y);
            }
            i = 0;
            while(i < this.vecGrids.length)
            {
               if(this.obj == this.vecGrids[i])
               {
                  Model_TuanGou.vecWheelGoods[i].biaoJi = 1;
               }
               i++;
            }
            this.obj.filters = Util.disabled;
            this.judgeCLick();
            UIManager.centerBroadcast.addMsg(Model_TuanGou.maoPaoStr);
            GameScene.instance.removeFrameCallBack(this.Onrotation);
         }
      }
      
      private function setGrey() : void
      {
         var index:int = 0;
         if(Model_TuanGou.vecWheelGoods.length == 0)
         {
            return;
         }
         var i:int = 0;
         while(i < Model_TuanGou.vecWheelGoods.length)
         {
            index = int(Model_TuanGou.vecWheelGoods[i].xiaBiao - 1);
            if(Model_TuanGou.vecWheelGoods[i].biaoJi == 1)
            {
               this.vecGrids[index].filters = Util.disabled;
            }
            else
            {
               this.vecGrids[index].filters = [];
            }
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.update();
         }
      }
   }
}

