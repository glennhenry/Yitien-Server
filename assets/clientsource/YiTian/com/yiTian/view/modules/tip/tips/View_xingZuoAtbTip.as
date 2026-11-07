package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_xingZuo;
   import com.yiTian.data.config.valuable.Enum_equip_type;
   import com.yiTian.data.vo.Vo_XingZuoStar;
   import com.yiTian.view.modules.horse.starSign.Model_XingZuo;
   import flash.display.DisplayObject;
   
   public class View_xingZuoAtbTip extends View_tip
   {
      
      private var _tfName:MyTextField;
      
      private var _info:MyTextField;
      
      private var _line:DisplayObject;
      
      private var _tfTip:MyTextField;
      
      public var margin:Number = 8;
      
      private var _type:int = 1;
      
      private var _vo:Vo_XingZuoStar;
      
      private var _isInit:Boolean = false;
      
      public function View_xingZuoAtbTip()
      {
         super();
      }
      
      override public function Init() : void
      {
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         this.tryInit2();
         this._type = type;
         var vo:Vo_XingZuoStar = obj as Vo_XingZuoStar;
         this._vo = vo;
         this._tfName.text = Data_lib.xingZuoStar[vo.index][Enum_xingZuo.LIB_NAME];
         this.showAtb();
         border.width = this._line.x + this._line.width + this.margin;
         border.height = this._info.y + this._info.textHeight + this.margin;
      }
      
      private function showAtb() : void
      {
         var aa:Array = null;
         var arr:Array = null;
         var ar:Array = null;
         var type:Number = NaN;
         var value:Number = NaN;
         var n:String = null;
         var si:int = 0;
         var state:int = 0;
         var ss:String = "";
         var atbStr:String = Data_lib.xingZuoStar[this._vo.index][Enum_xingZuo.LIB_ATB];
         if(!(atbStr == "" || atbStr == "0"))
         {
            aa = Util.splicObj(atbStr,",_") as Array;
            arr = [];
            for each(ar in aa)
            {
               type = Number(ar[0]);
               value = Number(ar[1]);
               arr.push("<font color=\'#ffff55\'>" + Data_lib.attribute[type][0] + "：</font>" + "<font color=\'#55ff55\'>+" + value + "</font>");
            }
            ss += arr.join("\n");
         }
         atbStr = Data_lib.xingZuoStar[this._vo.index][Enum_xingZuo.LIB_ATB_EQUIP];
         if(!(atbStr == "" || atbStr == "0"))
         {
            aa = Util.splicObj(atbStr,",_") as Array;
            arr = [];
            for each(ar in aa)
            {
               type = Number(ar[0]);
               value = Number(ar[1]);
               n = Enum_equip_type.TXT[type - 1];
               arr.push("<font color=\'#ffff55\'>" + n + "：</font>" + "<font color=\'#55ff55\'>+" + (Number(value) * 1000 + "‰") + "</font>");
            }
            ss += arr.join("\n");
         }
         if(this._type == 1)
         {
            si = Model_XingZuo.curSignIndex;
            state = this._vo.index <= si ? 1 : 0;
            ss += state == 1 ? "\n<font color=\'#ffff55\'>状态：</font><font color=\'#55ff55\'>已激活</font>" : "\n<font color=\'#ffff55\'>状态：</font><font color=\'#ff5555\'>未激活</font>";
            if(state == 0)
            {
               ss += "\n" + "<font color=\'#ffff55\'>点亮概率：</font>" + Data_lib.xingZuoStar[this._vo.index][Enum_xingZuo.LIB_SHOW_LV];
               ss += "\n" + "<font color=\'#ffff55\'>需要星泪：</font>" + Data_lib.xingZuoStar[this._vo.index][Enum_xingZuo.LIB_COST_XINGLEI];
               ss += "\n" + "<font color=\'#ffff55\'>需要银两：</font>" + Data_lib.xingZuoStar[this._vo.index][Enum_xingZuo.LIB_COST_SILVER];
            }
         }
         this._info.htmlText = ss;
      }
      
      private function tryInit2() : void
      {
         if(this._isInit)
         {
            return;
         }
         this._isInit = true;
         addBorder();
         this._line = ComponentUtil.getDisplayObject("Lines",this,{
            "x":this.margin,
            "y":30,
            "size":14,
            "width":140
         });
         this._tfName = ComponentUtil.getTextField("",this,{
            "x":this.margin,
            "y":this.margin,
            "color":16777045
         });
         this._info = ComponentUtil.getTextField("",this,{
            "x":this.margin,
            "y":35,
            "leading":4,
            "color":5635925
         });
      }
   }
}

