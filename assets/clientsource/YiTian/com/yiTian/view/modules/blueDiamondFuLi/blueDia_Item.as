package com.yiTian.view.modules.blueDiamondFuLi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.net.message.cg.BlueDiamondFuLiCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class blueDia_Item extends Sprite
   {
      
      private var gridVec:Vector.<View_Grid>;
      
      private var _effArr:Vector.<Effect> = new Vector.<Effect>();
      
      private var _btnTextArr:Array = ["领取","可领取","已领取"];
      
      private var _getAwardBtn:Button;
      
      private var _UpTimeTF:MyTextField;
      
      private var _curTimeTF:MyTextField;
      
      public var _index:int = 0;
      
      public var times:int = 0;
      
      private var numOneIcon:Bitmap;
      
      private var numTwoIcon:Bitmap;
      
      public function blueDia_Item()
      {
         var i:int = 0;
         var grid:View_Grid = null;
         super();
         ComponentUtil.getBitmap("Text_XFCS",this,{
            "x":0,
            "y":5
         },Global.LZFLdm);
         this.gridVec = new Vector.<View_Grid>(6);
         i = 0;
         while(i < this.gridVec.length)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_tf_count(true,false,true);
            ComponentUtil.setPropertie(grid,{
               "x":179 + 47 * i,
               "y":3
            });
            addChild(grid);
            grid.visible = false;
            this.gridVec[i] = grid;
            i++;
         }
         this._getAwardBtn = ComponentUtil.getButton("领取","Button_TwoBule91",this,{
            "x":470,
            "y":9
         },Global.Img_Cdm);
         this._getAwardBtn.callBack = this.getAward;
         this._getAwardBtn.label = this._btnTextArr[0];
         this._getAwardBtn.enabled = false;
         this.numOneIcon = ComponentUtil.getBitmap("num_0",this,{
            "x":70,
            "y":0
         },Global.LZFLdm);
         this.numTwoIcon = ComponentUtil.getBitmap("num_0",this,{
            "x":75,
            "y":0
         },Global.LZFLdm);
         this._UpTimeTF = ComponentUtil.getTextField("",this,{"x":75});
         this._curTimeTF = ComponentUtil.getTextField("",this,{
            "x":0,
            "y":25,
            "color":15726591,
            "size":12,
            "leading":0
         });
      }
      
      private function getAward(e:MouseEvent) : void
      {
         BlueDiamondFuLi_Panel.INDEX = this._index;
         BlueDiamondFuLiCGMessage.getAward(this._index + 1);
      }
      
      public function dispose() : void
      {
         this.reset();
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
      }
      
      public function addEff(arr:Array) : void
      {
         var effect:Effect = null;
         var grid:View_Grid = null;
         var i:int = 0;
         if(Boolean(this.gridVec.length))
         {
            i = this.gridVec.length - 1;
            while(i >= 0)
            {
               if(arr[i] == 1)
               {
                  grid = this.gridVec[i] as View_Grid;
                  effect = EffectManager.addEffect("35176",grid,1200,17,18,true);
                  this._effArr.push(effect);
               }
               i--;
            }
         }
      }
      
      private function setNumBitmap(num:int) : void
      {
         var ge:int = 0;
         var shi:int = int(num / 10);
         ge = num % 10;
         if(shi > 0)
         {
            this.numOneIcon.bitmapData = ComponentUtil.getBitmapData("num_" + shi,Global.LZFLdm);
            this.numOneIcon.visible = true;
            this.numTwoIcon.bitmapData = ComponentUtil.getBitmapData("num_" + ge,Global.LZFLdm);
            this.numTwoIcon.x = 80;
            return;
         }
         this.numOneIcon.visible = false;
         this.numTwoIcon.bitmapData = ComponentUtil.getBitmapData("num_" + ge,Global.LZFLdm);
         this.numTwoIcon.x = 75;
      }
      
      public function removeEff() : void
      {
         var i:int = 0;
         var eff:Effect = null;
         if(Boolean(this._effArr.length))
         {
            i = this._effArr.length - 1;
            while(i >= 0)
            {
               eff = this._effArr[i] as Effect;
               this._effArr.splice(i,1);
               EffectManager.removeEffect(eff);
               eff = null;
               i--;
            }
         }
      }
      
      private function reset() : void
      {
         var grid:View_Grid = null;
         this.removeEff();
         for each(grid in this.gridVec)
         {
            grid.vo = null;
         }
      }
      
      public function initData(arr:Array, _times:int, index:int) : void
      {
         var effArr:Array = null;
         var i:int = 0;
         var _grid:View_Grid = null;
         var _type:int = 0;
         var _id:int = 0;
         var _count:int = 0;
         var _isAddEff:int = 0;
         var _voI:Vo_item = null;
         var _voE:Vo_equip = null;
         this.reset();
         this._index = index;
         this.times = _times;
         effArr = [];
         i = 0;
         while(i < arr.length)
         {
            _grid = this.gridVec[i];
            _grid.visible = true;
            _type = int(arr[i][0]);
            _id = int(arr[i][1]);
            _count = int(arr[i][2]);
            _isAddEff = int(arr[i][3]);
            effArr.push(_isAddEff);
            if(_type == 1)
            {
               _voI = new Vo_item();
               _voI.id = _id;
               _voI.count = _count;
               _voI.Init_lib();
               _voI.bBind = true;
               _grid.vo = _voI;
            }
            else if(_type == 2)
            {
               _voE = new Vo_equip();
               _voE.id = _id;
               _voE.count = _count;
               _voE.Init_lib();
               _voE.bBind = true;
               _grid.vo = _voE;
            }
            i++;
         }
         this.addEff(effArr);
         this.setNumBitmap(_times);
      }
      
      public function checkStatus(t:int) : void
      {
         if(t >= this.times)
         {
            this.updateStatus(1);
         }
         else
         {
            this.updateStatus(0);
         }
         this._curTimeTF.htmlText = "<font color=\'#eff7ff\'>当前续费<font color=\'#04ff00\'>" + t + "</font>次</font>";
      }
      
      public function updateStatus(value:int) : void
      {
         this.status = value;
      }
      
      public function set status(value:int) : void
      {
         if(value == 0)
         {
            this._getAwardBtn.label = this._btnTextArr[0];
            this._getAwardBtn.enabled = false;
         }
         else if(value == 1)
         {
            this._getAwardBtn.label = this._btnTextArr[1];
            this._getAwardBtn.enabled = true;
         }
         else if(value == 2)
         {
            this._getAwardBtn.label = this._btnTextArr[2];
            this._getAwardBtn.enabled = false;
         }
      }
      
      public function getAwards() : void
      {
         var grid:View_Grid = null;
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            grid = this.gridVec[i];
            ComboTweenStep.toBag(grid);
            i++;
         }
         this._getAwardBtn.enabled = false;
         this._getAwardBtn.label = this._btnTextArr[2];
      }
   }
}

