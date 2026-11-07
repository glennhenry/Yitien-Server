package com.yiTian.view.modules.farm
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_farm;
   import com.yiTian.data.vo.Vo_farm_master;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.handler.FarmHandler;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   
   public class Farm_info extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private var _level:MyTextField;
      
      private var _exp:MyTextField;
      
      private var tf:TextFormat;
      
      public var logBtn:Button;
      
      public function Farm_info()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         this.addChild(this._bg);
         this._bg.bitmapData = ComponentUtil.getBitmapData("Back_Inf",Global.ShanZhuang_Imgsdm);
         this._level = ComponentUtil.getTextField("",this,{
            "x":18,
            "y":16 + 12,
            "color":12255105,
            "size":12,
            "leading":0
         });
         this._exp = ComponentUtil.getTextField("",this,{
            "x":18,
            "y":40 + 16,
            "color":13553330,
            "size":12,
            "leading":0,
            "realWidth":180
         });
         this._exp.realWidth = 160;
         this.tf = new TextFormat();
         this._exp.setTextFormat(this.tf);
         this.logBtn = ComponentUtil.getButton(LangConfig.getWord("216",9),"Button_RiZhi",this,{
            "x":100,
            "y":27
         },Global.ShanZhuang_Imgsdm);
         this.logBtn.addEventListener(MouseEvent.CLICK,this.onclicklogbtn);
      }
      
      private function onclicklogbtn(evt:MouseEvent) : void
      {
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            FarmHandler.openLog();
         }
      }
      
      protected function onOut(event:MouseEvent) : void
      {
         filters = null;
      }
      
      protected function onOver(event:MouseEvent) : void
      {
         filters = Util.glowFFFF00;
      }
      
      public function update(vo:Vo_farm_master) : void
      {
         if(!vo)
         {
            this._level.text = "";
            this._exp.text = "";
            return;
         }
         this._level.htmlText = "<font color=\'#fefefe\'>" + LangConfig.getWord("221",9) + "</font>" + "<font color = \'#fefe11\'>" + vo.farmLevel + "</font>";
         var max:uint = uint(Data_lib.Farm_villarank[vo.farmLevel][0]);
         this._exp.htmlText = "<font color = \'#fefefe\'>" + LangConfig.getWord("222",9) + "</font>" + "<font color = \'#fefe11\'>" + vo.farmExp + "/" + max + "</font>";
         this._exp.setTextFormat(this.tf);
      }
   }
}

