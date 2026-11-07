package com.yiTian.net.message.gc
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.net.handler.QifuHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.actions.qifu.Child_grid;
   import com.yiTian.view.modules.actions.qifu.Child_jifenPan;
   import com.yiTian.view.modules.actions.qifu.Model_qifu;
   import com.yiTian.view.modules.actions.qifu.QifuPan;
   import com.yiTian.view.modules.actions.qifu.QifuTip;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class QifuGCMessage
   {
      
      private var _succeFailArr:Array = ["兑换成功","兑换失败"];
      
      public function QifuGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_QIFU_ICON_SHOW] = this.GC_QIFU_ICON_SHOW;
         index[MessageType.GC_OPEN_QIFU_PAN] = this.GC_OPEN_QIFU_PAN;
         index[MessageType.GC_QIFU_TYPE] = this.GC_QIFU_TYPE;
         index[MessageType.GC_QIFU_DUIHUAN] = this.GC_QIFU_DUIHUAN;
      }
      
      public function GC_QIFU_ICON_SHOW(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            QifuTip.instance.show();
         }
         else
         {
            QifuTip.instance.hide();
         }
      }
      
      public function GC_OPEN_QIFU_PAN(patch:IDataInput) : void
      {
         var index:int = 0;
         var ss:String = null;
         var obj:Object = null;
         var strName:String = null;
         var count:int = 0;
         var color:int = 0;
         var dataStr:String = null;
         var _name:String = null;
         var _index:int = 0;
         var _ss:String = null;
         var _obj:Object = null;
         var _strName:String = null;
         var _count:int = 0;
         var _color:int = 0;
         var _dataStr:String = null;
         var startNum:int = patch.readInt();
         var curQIfuTimes:int = patch.readInt();
         var lenM:int = patch.readByte();
         var arrM:Array = [];
         var sex:int = GameUnitManager.hero.sex - 1;
         var i:int = 0;
         while(i < lenM)
         {
            index = patch.readByte();
            ss = this.handlLvl(Data_lib.qifuAward[index][sex]);
            obj = this.turnHandle(ss);
            strName = obj.name;
            count = int(obj.count);
            color = int(obj.color);
            dataStr = HtmlUtil.font("恭喜您获得 ","#cccccc") + HtmlUtil.font(strName + " *" + count,Model_shop.get_color_arr[color - 1]);
            arrM.push(dataStr);
            i++;
         }
         var lenG:int = patch.readByte();
         var arrG:Array = [];
         var j:int = 0;
         while(j < lenG)
         {
            _name = patch.readUTF();
            _index = patch.readByte();
            _ss = this.handlLvl(Data_lib.qifuAward[_index][sex]);
            _obj = this.turnHandle(_ss);
            _strName = _obj.name;
            _count = int(_obj.count);
            _color = int(_obj.color);
            _dataStr = HtmlUtil.font(_name,"#f9ff00") + HtmlUtil.font(" 获得 ","#cccccc") + HtmlUtil.font(_strName + "*" + _count,Model_shop.get_color_arr[_color - 1]);
            arrG.push(_dataStr);
            j++;
         }
         QifuHandle.GC_OPEN_QIFU_PAN(arrM,arrG,curQIfuTimes,startNum);
      }
      
      private function turnHandle(ss:String) : Object
      {
         var vI:Vo_item = null;
         var vE:Vo_equip = null;
         var a:Array = ss.split("_");
         var _ty:int = int(a[0]);
         var _id:int = int(a[1]);
         var _count:int = int(a[2]);
         var obj:Object = new Object();
         if(_ty == 1)
         {
            vI = new Vo_item();
            vI.id = _id;
            vI.count = _count;
            vI.Init_lib();
            obj.name = HtmlUtil.font(vI.str_name,Model_shop.get_color_arr[vI.color - 1]);
            obj.count = vI.count;
            obj.color = vI.color;
         }
         else if(_ty == 2)
         {
            vE = new Vo_equip();
            vE.id = _id;
            vE.count = _count;
            vE.Init_lib();
            obj.name = HtmlUtil.font(vE.str_name,Model_shop.get_color_arr[vE.color - 1]);
            obj.count = vE.count;
            obj.color = vE.color;
         }
         return obj;
      }
      
      public function GC_QIFU_TYPE(patch:IDataInput) : void
      {
         var len:int;
         var arrM:Array;
         var arrG:Array;
         var arrL:Array;
         var arrK:Array;
         var sex:int;
         var _name:String;
         var i:int;
         var index:int = 0;
         var _count:int = 0;
         var _ss:String = null;
         var _obj:Object = null;
         var _strName:String = null;
         var _color:int = 0;
         var _cn:int = 0;
         var _dataStr:String = null;
         var dataStr:String = null;
         var __dataS:String = null;
         Child_grid.isRunning = true;
         len = patch.readByte();
         arrM = [];
         arrG = [];
         arrL = [];
         arrK = [];
         sex = GameUnitManager.hero.sex - 1;
         _name = GameUnitManager.hero.name;
         i = 0;
         while(i < len)
         {
            index = patch.readByte();
            _count = patch.readByte();
            trace(index,_count);
            _ss = this.handlLvl(Data_lib.qifuAward[index][sex]);
            _obj = this.turnHandle(_ss);
            _strName = _obj.name;
            _color = int(_obj.color);
            _cn = int(_obj.count);
            _count = _cn * _count;
            _dataStr = HtmlUtil.font(_name,"#16776960") + HtmlUtil.font(" 获得 ","#cccccc") + HtmlUtil.font(_strName + "*" + _count,Model_shop.get_color_arr[_color - 1]);
            dataStr = HtmlUtil.font("恭喜您获得 ","#cccccc") + HtmlUtil.font(_strName + " *" + _count,Model_shop.get_color_arr[_color - 1]);
            __dataS = HtmlUtil.font(_strName + "*" + _count,Model_shop.get_color_arr[_color - 1]);
            arrM.push(dataStr);
            arrG.push(_dataStr);
            arrL.push([__dataS,_color]);
            arrK.push([index,_count,_color]);
            i++;
         }
         arrL.sort(function(a:Array, b:Array):Number
         {
            if(a[1] > b[1])
            {
               return 1;
            }
            if(a[1] < b[1])
            {
               return -1;
            }
            return 0;
         });
         QifuHandle.GC_QIFU_TYPE(arrM,arrG,arrL,arrK);
      }
      
      private function handlLvl(str:String) : String
      {
         return str;
      }
      
      public function GC_QIFU_DUIHUAN(patch:IDataInput) : void
      {
         var result:int = 0;
         var point:Point = null;
         result = patch.readByte();
         if(result > 0 && result < 3)
         {
            WuXingMter.getPan(QifuPan,function(pan:QifuPan):void
            {
               var _type:int = 0;
               if(result == 1)
               {
                  _type = Child_jifenPan.jifenType;
                  pan.releaseJifen(_type);
               }
               point = new Point(pan.x - 40,pan.y + pan.height / 2);
               Model_qifu.addMes(_succeFailArr[result - 1],point);
            });
         }
      }
   }
}

