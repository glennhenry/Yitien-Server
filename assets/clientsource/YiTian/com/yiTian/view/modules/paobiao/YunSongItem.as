package com.yiTian.view.modules.paobiao
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class YunSongItem extends Sprite
   {
      
      public static var BS:int = 0;
      
      public static var EXP1:int = 1;
      
      public static var EXP2:int = 2;
      
      public static var EXP3:int = 3;
      
      private var txtExp:MyTextField;
      
      private var txtBindSilver:MyTextField;
      
      public var index:int;
      
      private var vecId:Vector.<int> = new <int>[46252,46253,46254,46255];
      
      private var _isChoose:Boolean;
      
      public function YunSongItem(value:int)
      {
         var bm:Bitmap = null;
         var b:Bitmap = null;
         var t:MyTextField = null;
         var vo:Vo_item = null;
         super();
         this.index = value;
         this.buttonMode = true;
         this.graphics.beginFill(0,0);
         this.graphics.drawRect(0,0,200,155);
         this.graphics.endFill();
         bm = new Bitmap();
         addChild(bm);
         Utils.loadTitle("lang/ch/PaoBiao_Imgs.swf","Che_Lv" + (this.index + 1),bm,null,null);
         b = new Bitmap();
         Utils.loadTitle("lang/ch/PaoBiao_Imgs.swf","TextTitle",b,null,this);
         this.txtExp = ComponentUtil.getTextField(Data_lib.attribute[20][0],this,{"color":16776960});
         this.txtBindSilver = ComponentUtil.getTextField(Data_lib.attribute[29][0],this,{"color":16776960});
         t = ComponentUtil.getTextField(LangConfig.getWord("10319",1),this);
         if(Boolean(this.index))
         {
            vo = new Vo_item();
            vo.id = this.vecId[this.index - 1];
            vo.Init_lib();
         }
         if(this.index == 0)
         {
            this.txtExp.x = 38;
            this.txtExp.y = 21;
            this.txtBindSilver.x = this.txtExp.x;
            this.txtBindSilver.y = this.txtExp.y + 16;
            t.x = this.txtExp.x - 35;
            t.y = this.txtExp.y + 32;
            bm.x = 33;
         }
         else if(this.index == 1)
         {
            this.txtExp.x = 122;
            this.txtExp.y = 23;
            this.txtBindSilver.x = this.txtExp.x;
            this.txtBindSilver.y = this.txtExp.y + 15;
            t.x = this.txtExp.x - 35;
            t.y = this.txtExp.y + 32;
            t.text = LangConfig.getWord("10320",1) + " " + vo.str_name;
            b.x = 85;
         }
         else if(this.index == 2)
         {
            this.txtExp.x = 40;
            this.txtExp.y = 22;
            this.txtBindSilver.x = this.txtExp.x;
            this.txtBindSilver.y = this.txtExp.y + 16;
            t.x = this.txtExp.x - 35;
            t.y = this.txtExp.y + 32;
            t.htmlText = LangConfig.getWord("10320",1) + " <font color=\'" + ColorConstant.getColorStr(ColorConstant.GREEN) + "\'>" + vo.str_name + "</font>";
            bm.x = 5;
         }
         else if(this.index == 3)
         {
            this.txtExp.x = 40;
            this.txtExp.y = 22;
            this.txtBindSilver.x = this.txtExp.x;
            this.txtBindSilver.y = this.txtExp.y + 16;
            t.x = this.txtExp.x - 35;
            t.y = this.txtExp.y + 32;
            t.htmlText = LangConfig.getWord("10320",1) + " <font color=\'" + ColorConstant.getColorStr(ColorConstant.BLUE) + "\'>" + vo.str_name + "</font>";
            bm.x = 10;
         }
         else if(this.index == 4)
         {
            this.txtExp.x = 127;
            this.txtExp.y = 24;
            this.txtBindSilver.x = this.txtExp.x;
            this.txtBindSilver.y = this.txtExp.y + 15;
            t.x = this.txtExp.x - 35;
            t.y = this.txtExp.y + 32;
            t.htmlText = LangConfig.getWord("10320",1) + " <font color=\'" + ColorConstant.getColorStr(ColorConstant.PURPLE) + "\'>" + vo.str_name + "</font>";
            b.x = 85;
         }
         this.filters = Util.disabled;
      }
      
      public function update() : void
      {
         var i:Number = NaN;
         var dicP:Dictionary = Data_lib.paoBiao;
         this.txtBindSilver.text = dicP[GameUnitManager.hero.level][BS];
         var val:Number = 1 + this.index * 0.25;
         if(Boolean(PaoBiaoVO.isTime))
         {
            i = 1.5;
         }
         else
         {
            i = 1;
         }
         this.txtExp.text = String(val * dicP[GameUnitManager.hero.level][YunSongItem["EXP" + PaoBiaoVO.times]] * i);
         this.txtBindSilver.text = String(val * dicP[GameUnitManager.hero.level][BS] * i);
      }
      
      public function set choose(value:Boolean) : void
      {
         if(value)
         {
            this.filters = [];
         }
         else
         {
            this.filters = Util.disabled;
         }
         this._isChoose = value;
      }
      
      public function get isChoose() : Boolean
      {
         return this._isChoose;
      }
   }
}

