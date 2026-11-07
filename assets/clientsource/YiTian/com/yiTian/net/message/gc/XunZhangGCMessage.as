package com.yiTian.net.message.gc
{
   import com.ui.controls.MyTextField;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.actions.yaAn.YaAnTip;
   import com.yiTian.view.modules.xunZhang.XunZhangMter;
   import flash.display.Sprite;
   import flash.utils.IDataInput;
   
   public class XunZhangGCMessage
   {
      
      private var arr:Array = ["升阶成功","升阶失败","背包材料不够","阅历等级不够","银子不够","没装备"];
      
      private var _arr:Array = ["勋章等级不够不能雕刻更高一级的星石","输入的是(1.2.3)之外的类型","雕刻等级不符合","找不到该星石(输入的道具ID不对)","背包材料不够"];
      
      public function XunZhangGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_XUNZHANG_DIAOKE] = this.GC_XUNZHANG_DIAOKE;
         index[MessageType.GC_XUNZHANG_JINJIE] = this.GC_XUNZHANG_JINJIE;
         index[MessageType.GC_XUNZHANG_ADDEFF] = GC_XUNZHANG_ADDEFF;
         index[MessageType.GC_SHOW_YAAN_ICON] = GC_SHOW_YAAN_ICON;
      }
      
      public static function GC_XUNZHANG_ADDEFF(patch:IDataInput = null) : void
      {
         var centerX:int;
         var centerY:int;
         var sp:Sprite = null;
         var tf1:MyTextField = null;
         var tf2:MyTextField = null;
      }
      
      public static function GC_SHOW_YAAN_ICON(patch:IDataInput = null) : void
      {
         YaAnTip.show(patch != null ? patch.readByte() : 1);
      }
      
      public function GC_XUNZHANG_JINJIE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         UIManager.centerBroadcast.addMsg(this.arr[result - 1]);
      }
      
      public function GC_XUNZHANG_DIAOKE(patch:IDataInput) : void
      {
         XunZhangMter.witchOne = patch.readByte();
         XunZhangMter.upToLvl = patch.readByte();
         UIManager.centerBroadcast.addMsg(this._arr[XunZhangMter.upToLvl - 1]);
         if(XunZhangMter.upToLvl > 5)
         {
            UIManager.centerBroadcast.addMsg("雕刻成功");
         }
      }
   }
}

