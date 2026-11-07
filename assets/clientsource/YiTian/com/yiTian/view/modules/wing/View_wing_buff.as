package com.yiTian.view.modules.wing
{
   import com.utils.ColorConstant;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_wing;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.WingCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_wing_buff extends Sprite
   {
      
      private static var _instance:View_wing_buff;
      
      private var bm:Bitmap;
      
      private var count:int;
      
      public function View_wing_buff()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         this.init();
      }
      
      public static function get instance() : View_wing_buff
      {
         if(!_instance)
         {
            _instance = new View_wing_buff();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this.bm = Utils.getLoadBitmap("resource/image/buff/wing.png");
         addChild(this.bm);
         addEventListener(MouseEvent.ROLL_OVER,this.rollOverHandle);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandle);
      }
      
      public function updateTime(seconds:int) : void
      {
         if(seconds > 0)
         {
            this.count = seconds * 1000;
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.callBack);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.callBack);
         }
      }
      
      private function rollOverHandle(e:MouseEvent) : void
      {
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onChangeShowTime);
      }
      
      private function rollOutHandle(e:MouseEvent) : void
      {
         TipManager.hide();
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onChangeShowTime);
      }
      
      private function callBack(interval:int) : void
      {
         this.count -= interval;
         if(this.count <= 0)
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.callBack);
            WingCGMessage.CG_WING_BUFF_TIMEOUT();
         }
      }
      
      private function onChangeShowTime(interval:int) : void
      {
         var i:* = undefined;
         var str:String = "";
         str += Data_lib.item[Data_lib.wingChange[Model_wing.HuanHuaDanID][0]][1] + "<br/>";
         str += "剩余时间：" + DateUtil.getHMSBySecond(this.count / 1000) + "<br/>";
         var ShuXing:Array = (Data_lib.wingChange[Model_wing.HuanHuaDanID][9] as String).split(",");
         var t_arr:Array = [];
         for(i in ShuXing)
         {
            t_arr = (ShuXing[i] as String).split("_");
            str += HtmlUtil.font(i + 1 + ".增加人物",ColorConstant.getColorStr(ColorConstant.YELLOW_SAND)) + HtmlUtil.font(Data_lib.attribute[t_arr[0]][0],ColorConstant.getColorStr(ColorConstant.GREEN)) + HtmlUtil.font(t_arr[1],ColorConstant.getColorStr(ColorConstant.YELLOW)) + "<br/>";
         }
         TipManager.update(str);
      }
   }
}

