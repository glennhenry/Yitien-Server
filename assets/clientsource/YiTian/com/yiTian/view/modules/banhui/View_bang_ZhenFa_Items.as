package com.yiTian.view.modules.banhui
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.manager.TipManager;
   import com.yiTian.view.modules.team.View_ZFGrid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class View_bang_ZhenFa_Items extends Sprite
   {
      
      public static var BANG_BASIC_ZF_ARR:Array = [80100,80200,80300,80400,80500,80600,80700,80800,80900,81000];
      
      private var ZhuangTai_text:MyTextField;
      
      public var grid:View_ZFGrid;
      
      private var _zfType:int;
      
      private var _level:int;
      
      private var _vo:Vo_BangZF;
      
      public var selected:Boolean = false;
      
      public function View_bang_ZhenFa_Items()
      {
         super();
         mouseChildren = false;
         this.init();
      }
      
      public function init() : void
      {
         this.ZhuangTai_text = ComponentUtil.getTextField("00/00",this,{
            "y":48,
            "color":16764206,
            "realWidth":38,
            "size":12,
            "leading":0
         });
         this.ZhuangTai_text.autoSize = TextFieldAutoSize.CENTER;
         this.grid = new View_ZFGrid();
         addChild(this.grid);
         addEventListener(MouseEvent.MOUSE_MOVE,this.moveHd);
         addEventListener(MouseEvent.MOUSE_OUT,this.outHd);
      }
      
      private function moveHd(evt:MouseEvent) : void
      {
         TipManager.update(this._vo);
      }
      
      private function outHd(evt:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      public function get zfType() : int
      {
         return this._zfType;
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function setData(zfType:int, level:int, img:Boolean) : void
      {
         var vo:Vo_BangZF = new Vo_BangZF(zfType,level);
         vo.isLoadImg = img;
         this.grid.vo = vo;
         this._vo = vo;
         this._zfType = zfType;
         this._level = level;
         if(level < 1)
         {
            vo = null;
            this.ZhuangTai_text.text = "";
         }
         else
         {
            this.ZhuangTai_text.text = Model_bang.selfZFLevelArr[zfType - 1].toString() + "/" + Model_bang.bangZFLevelArr[zfType - 1].toString();
         }
         var id:int = BANG_BASIC_ZF_ARR[this._zfType - 1] + 1;
         this._vo.descript = Data_lib.zhenfa[id][3];
      }
      
      public function set select(value:Boolean) : void
      {
         this.grid.selected = value;
      }
   }
}

