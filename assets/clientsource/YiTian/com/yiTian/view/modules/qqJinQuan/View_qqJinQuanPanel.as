package com.yiTian.view.modules.qqJinQuan
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequestMethod;
   import flash.text.TextFieldAutoSize;
   
   public class View_qqJinQuanPanel extends Panel123
   {
      
      private var _bg:DisplayObject;
      
      private var _tfRemain:MyTextField;
      
      private var _btnBuy:Button;
      
      private var _vecGrids:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var _vecTf:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var _packageId:int;
      
      private var _price:int;
      
      private var _txt1:TxtNum;
      
      private var _txt2:TxtNum;
      
      public function View_qqJinQuanPanel()
      {
         super();
         regResource("lang/ch/JinQuan_Imgs.swf","JinQuan_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         var grid:View_Grid = null;
         var tf:MyTextField = null;
         this._bg = ComponentUtil.getBitmap("Back_JinQuan",this,{
            "x":0,
            "y":0
         },Global.JinQuan_Imgsdm);
         move = new Rectangle(0,0,this._bg.width,this._bg.height);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":477,
            "y":22,
            "textColor":16184781
         },Global.JinQuan_Imgsdm);
         this._btnBuy = ComponentUtil.getButton("","Button_Buy",this,{
            "x":205,
            "y":314,
            "textColor":16184781,
            "callBack":this.buyClickHd
         },Global.JinQuan_Imgsdm);
         i = 0;
         while(i < 3)
         {
            grid = new View_Grid(true);
            grid.x = 136 + 105 * i;
            grid.y = 209;
            grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
            grid.set_bmp_over(true,null);
            addChild(grid);
            this._vecGrids.push(grid);
            tf = ComponentUtil.getTextField("",this,{
               "x":grid.x + 32,
               "y":grid.y + 64,
               "size":16,
               "bold":true,
               "realWidth":0,
               "color":15654365
            });
            tf.autoSize = TextFieldAutoSize.CENTER;
            this._vecTf.push(tf);
            i += 1;
         }
         this._txt1 = new TxtNum();
         this._txt1.x = 138;
         this._txt1.y = 150;
         addChild(this._txt1);
         this._txt2 = new TxtNum();
         this._txt2.x = 271;
         this._txt2.y = 150;
         addChild(this._txt2);
         this._tfRemain = ComponentUtil.getTextField("",this,{
            "x":228,
            "y":118,
            "color":16771584,
            "size":18,
            "bold":true
         });
         this._tfRemain.autoSize = TextFieldAutoSize.CENTER;
         this._tfRemain.text = "121314";
         super.initDynamicView();
      }
      
      private function buyClickHd(e:MouseEvent) : void
      {
         qqJinQuanConfig.buyFromQQ(this._packageId);
      }
      
      public function updataSolds() : void
      {
         var a:Array = null;
         var type:int = 0;
         var id:int = 0;
         var num:int = 0;
         var vo:Vo_item = null;
         var infos:Array = qqJinQuanConfig.getDicArr();
         this._packageId = infos[2];
         var tmp:Array = Util.splicObj(infos[3] as String,",_") as Array;
         var i:int = 0;
         while(i < 3)
         {
            a = tmp[i];
            type = int(a[0]);
            id = int(a[1]);
            num = int(a[2]);
            if(type == 1)
            {
               vo = new Vo_item();
               vo.id = id;
               vo.Init_lib();
               this._vecGrids[i].vo = vo;
            }
            this._vecTf[i].text = "×" + num;
            i += 1;
         }
         this._txt1.num = infos[0];
         this._txt2.num = infos[1];
      }
      
      public function updateJinQuanRemain(v:int) : void
      {
         this._tfRemain.text = v.toString();
      }
      
      public function requestRemain() : void
      {
         qqJinQuanConfig.load(qqJinQuanConfig.getRemainUrl(),this.onDataComplete,URLLoaderDataFormat.TEXT,URLRequestMethod.GET);
      }
      
      private function onDataComplete(e:Event) : void
      {
         var infoTxt:String = e.target.data;
         var infos:Array = infoTxt.split("|");
         this.updateJinQuanRemain(infos[0]);
      }
      
      public function show() : void
      {
         super.visible = true;
         pop(Global.stage.mouseX / Global.stage.stageWidth,Global.stage.mouseY / Global.stage.stageHeight,0.5,0.5,0.1,1,500);
         this.updataSolds();
         this.requestRemain();
      }
      
      public function hide() : void
      {
         super.visible = false;
      }
      
      override public function get width() : Number
      {
         return this._bg.width;
      }
      
      override public function get height() : Number
      {
         return this._bg.height;
      }
   }
}

import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

class TxtNum extends Sprite
{
   
   private var _curNum:int;
   
   private var _bms:Array = [];
   
   public function TxtNum()
   {
      super();
   }
   
   public function set num(v:int) : void
   {
      if(v == this._curNum)
      {
         return;
      }
      this._curNum = v;
      this.convert();
   }
   
   private function convert() : void
   {
      var bm:Bitmap = null;
      var i:int = 0;
      var ch:String = null;
      var bmd:BitmapData = null;
      var bm2:Bitmap = null;
      var str:String = Enum_BroadCastTool.instance.getBitStr(this._curNum);
      for each(bm in this._bms)
      {
         bm.bitmapData = null;
         removeChild(bm);
      }
      this._bms.splice(0);
      i = 0;
      while(i < str.length)
      {
         ch = str.charAt(i);
         bmd = ComponentUtil.getBitmapData("Num_" + ch,Global.JinQuan_Imgsdm);
         bm2 = new Bitmap();
         bm2.bitmapData = bmd;
         bm2.x = i * 32;
         addChild(bm2);
         this._bms.push(bm2);
         i += 1;
      }
   }
}
