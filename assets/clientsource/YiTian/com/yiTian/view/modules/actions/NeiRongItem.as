package com.yiTian.view.modules.actions
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class NeiRongItem extends Sprite
   {
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>(10);
      
      private var iconBm:Bitmap;
      
      private var daysBm:Bitmap;
      
      private var _dataStr:String;
      
      private var _iconId:String;
      
      public function NeiRongItem()
      {
         super();
      }
      
      private function initUI2() : void
      {
         var grid:View_Grid = null;
         ComponentUtil.getScaleBitmap("Back_Diamond01",[11,11,1,1],this,{
            "x":0,
            "y":0,
            "width":640,
            "height":95
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("List_Back",this,{
            "x":6,
            "y":6
         },Global.HuiGuidm);
         this.daysBm = ComponentUtil.getBitmap("Text_Day01",this,{
            "x":16,
            "y":10
         },Global.HuiGuidm);
         this.iconBm = ComponentUtil.getBitmap("JiaZhi_Img06",this,{
            "x":465,
            "y":8
         },Global.HuiGuidm);
         var i:int = 0;
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
      }
      
      public function updata(dataStr:String, iconId:String = "FuLiJZ_01", __days:int = 1) : void
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
         this._dataStr = dataStr;
         this._iconId = iconId;
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
         if(Boolean(this.iconBm))
         {
            this.iconBm.bitmapData = ComponentUtil.getBitmapData(iconId,Global.HuiGuidm);
         }
         this.setTypeS(__days);
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
            this.daysBm.bitmapData = ComponentUtil.getBitmapData("Text_Day01",Global.HuiGuidm);
         }
         else if(_type == 2)
         {
            this.daysBm.bitmapData = ComponentUtil.getBitmapData("Text_Day02",Global.HuiGuidm);
         }
         else if(_type == 3)
         {
            this.daysBm.bitmapData = ComponentUtil.getBitmapData("Text_Day03",Global.HuiGuidm);
         }
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

