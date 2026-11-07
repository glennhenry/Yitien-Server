package com.yiTian.view.modules.actions
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class NeirongPartTwo extends Sprite
   {
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>(10);
      
      private var maskS:Sprite;
      
      private var tf:MyTextField;
      
      private var iconBM:Bitmap;
      
      private var daysBm:Bitmap;
      
      private var _perV:int;
      
      private var _total:int;
      
      public function NeirongPartTwo()
      {
         super();
      }
      
      private function initUI2() : void
      {
         var pro:ScaleBitmap;
         var i:int;
         var grid:View_Grid = null;
         ComponentUtil.getScaleBitmap("Back_Diamond01",[11,11,1,1],this,{
            "x":0,
            "y":0,
            "width":640,
            "height":132
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("List_Back",this,{
            "x":6,
            "y":6
         },Global.HuiGuidm);
         this.iconBM = ComponentUtil.getBitmap("JiaZhi_Img06",this,{
            "x":465,
            "y":8
         },Global.HuiGuidm);
         ComponentUtil.getScaleBitmap("HuiKuiProgress_Back",[32,15,61,4],this,{
            "x":15,
            "y":91,
            "width":500,
            "height":34
         },Global.HuiGuidm);
         ComponentUtil.getButton("","Button_Recharge",this,{
            "x":520,
            "y":82,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               UIManager.yuanBaoXiang.visible = !UIManager.yuanBaoXiang.visible;
            }
         },Global.HuiGuidm);
         this.maskS = new Sprite();
         this.maskS.graphics.beginFill(0,0);
         this.maskS.graphics.drawRect(0,0,450,18);
         this.maskS.graphics.endFill();
         addChild(this.maskS);
         ComponentUtil.setPropertie(this.maskS,{
            "x":40,
            "y":100
         });
         pro = ComponentUtil.getScaleBitmap("HuiKuiProgress",[6,7,42,2],this,{
            "x":40,
            "y":100,
            "width":450,
            "height":16
         },Global.HuiGuidm);
         this.tf = ComponentUtil.getTextField("100/100",this,{
            "x":240,
            "y":100
         });
         pro.mask = this.maskS;
         this.daysBm = ComponentUtil.getBitmap("Text_Day01",this,{
            "x":16,
            "y":10
         },Global.HuiGuidm);
         i = 0;
         while(i < 10)
         {
            grid = new View_Grid();
            ComponentUtil.setPropertie(grid,{
               "x":15 + 45 * i,
               "y":45
            });
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_tf_count(true,false,true);
            addChild(grid);
            this.gridVec[i] = grid;
            i++;
         }
         this.setPerS();
      }
      
      public function updata(dataStr:String, iconId:String = "FuLiJZ_01", __type:int = 1) : void
      {
         var _arr:Array = null;
         var i:int = 0;
         var grid:View_Grid = null;
         var ss:String = null;
         var _aa:Array = null;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         _arr = dataStr.split(",");
         if(!_arr || !_arr.length)
         {
            return;
         }
         this.reset();
         i = 0;
         while(i < _arr.length)
         {
            grid = this.gridVec[i];
            grid.visible = true;
            ss = _arr[i];
            _aa = ss.split("_");
            if(_aa[0] == 1)
            {
               voI = new Vo_item();
               voI.id = _aa[1];
               voI.count = _aa[2];
               voI.Init_lib();
               grid.vo = voI;
            }
            else if(_aa[0] == 2)
            {
               voE = new Vo_equip();
               voE.id = _aa[1];
               voE.count = _aa[2];
               voE.Init_lib();
               grid.vo = voE;
            }
            i++;
         }
         if(Boolean(this.iconBM))
         {
            this.iconBM.bitmapData = ComponentUtil.getBitmapData(iconId,Global.HuiGuidm);
         }
         this.setTypeS(__type);
      }
      
      private function reset() : void
      {
         var item:View_Grid = null;
         for each(item in this.gridVec)
         {
            item.visible = false;
         }
      }
      
      public function setTypeS(_type:int) : void
      {
         if(_type == 1)
         {
            this.daysBm.bitmapData = ComponentUtil.getBitmapData("Text_Bag100",Global.HuiGuidm);
         }
         else if(_type == 2)
         {
            this.daysBm.bitmapData = ComponentUtil.getBitmapData("Text_Bag1000",Global.HuiGuidm);
         }
         else if(_type == 3)
         {
            this.daysBm.bitmapData = ComponentUtil.getBitmapData("Text_Bag5000",Global.HuiGuidm);
         }
      }
      
      public function setPer(perVa:int, total:int) : void
      {
         this._perV = perVa;
         this._total = total;
         this.maskS.width = 450 * this._perV / this._total;
         this.tf.text = this._perV + "/" + this._total;
      }
      
      private function setPerS() : void
      {
         this.maskS.width = 450 * this._perV / this._total;
         this.tf.text = this._perV + "/" + this._total;
      }
      
      public function loadComp() : void
      {
         if(!Global.HuiGuidm)
         {
            SingleLoader.add("lang/ch/OldPlayerHuiGui.swf",function(info:Object):void
            {
               Global.HuiGuidm = info.applicationDomain;
               initUI2();
            });
         }
         else
         {
            this.initUI2();
         }
      }
   }
}

