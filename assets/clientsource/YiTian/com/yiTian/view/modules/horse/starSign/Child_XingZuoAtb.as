package com.yiTian.view.modules.horse.starSign
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_xingZuo;
   import com.yiTian.data.config.valuable.Enum_equip_type;
   import flash.display.Sprite;
   
   public class Child_XingZuoAtb extends Sprite
   {
      
      public var _tfAtb:MyTextField;
      
      public var tfMargin:Number = 4;
      
      public function Child_XingZuoAtb()
      {
         super();
         this._tfAtb = ComponentUtil.getTextField("",this,{
            "x":20,
            "color":16777011,
            "leading":3
         });
         ComponentUtil.getBitmap("Line_XZXX",this,null,Global.XingZuodm);
      }
      
      public function setText(txt:String) : void
      {
         this._tfAtb.htmlText = txt;
         this._tfAtb.y = this.tfMargin - this._tfAtb.textHeight;
      }
      
      public function setSignIndex(index:int) : void
      {
         var aa:Array = null;
         var arr:Array = null;
         var ar:Array = null;
         var type:Number = NaN;
         var value:Number = NaN;
         var n:String = null;
         var ss:String = "";
         var atbStr:String = Data_lib.xingZuoStar[index][Enum_xingZuo.LIB_ATB];
         if(!(atbStr == "" || atbStr == "0"))
         {
            aa = Util.splicObj(atbStr,",_") as Array;
            arr = [];
            for each(ar in aa)
            {
               type = Number(ar[0]);
               value = Number(ar[1]);
               arr.push("<font color=\'#ffff55\'>" + Data_lib.attribute[type][0] + "：</font>" + "<font color=\'#55ff55\'>" + value + "</font>");
            }
            ss += arr.join("\n");
         }
         atbStr = Data_lib.xingZuoStar[index][Enum_xingZuo.LIB_ATB_EQUIP];
         if(!(atbStr == "" || atbStr == "0"))
         {
            aa = Util.splicObj(atbStr,",_") as Array;
            arr = [];
            for each(ar in aa)
            {
               type = Number(ar[0]);
               value = Number(ar[1]);
               n = Enum_equip_type.TXT[type - 1];
               arr.push("<font color=\'#ffff55\'>" + n + "：</font>" + "<font color=\'#55ff55\'>+" + value * 1000 + "‰</font>");
            }
            if(ss != "")
            {
               ss += "\n";
            }
            ss += arr.join("\n");
         }
         ss += "\n" + "<font color=\'#ffff55\'>星泪：</font><font color=\'#55ff55\'>" + Data_lib.xingZuoStar[index][Enum_xingZuo.LIB_COST_XINGLEI] + "</font>";
         ss += "\n" + "<font color=\'#ffff55\'>银两：</font><font color=\'#55ff55\'>" + Data_lib.xingZuoStar[index][Enum_xingZuo.LIB_COST_SILVER] + "</font>";
         ss += "\n" + "<font color=\'#ffff55\'>概率：</font><font color=\'#55ff55\'>" + Data_lib.xingZuoStar[index][Enum_xingZuo.LIB_SHOW_LV] + "</font>";
         this.setText(ss);
      }
   }
}

