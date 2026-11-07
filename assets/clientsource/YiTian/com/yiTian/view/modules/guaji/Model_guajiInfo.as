package com.yiTian.view.modules.guaji
{
   import com.utils.Util;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class Model_guajiInfo
   {
      
      private static var instance:Model_guajiInfo;
      
      public var lqRoomInfoArr:Array;
      
      private var _ziChenRoomInfo:Array;
      
      private var _lanChenRoomInfo:Array;
      
      private var _lvChenRoomInfo:Array;
      
      private var _qysxData:Array;
      
      public var sxType:int = 0;
      
      public var lastUpdateWawaTime:int = 0;
      
      public var qiangDuoLastTime:int = -200000;
      
      public var currentSXName:String = "";
      
      public var wawaTime:int = 0;
      
      public var gjdType:int = 0;
      
      public var gjdRemain:int = 0;
      
      public var curBufBM:Bitmap2;
      
      private var gjdSP:Sprite;
      
      public var gjdLastupdateTime:int;
      
      public var isClickedWaWaShuangXiu:Boolean = false;
      
      public var lastQuestSXTime:int;
      
      public var tipBtn:BitmapBtn;
      
      public var isBaiYinVip:Boolean = false;
      
      public function Model_guajiInfo()
      {
         super();
         if(Boolean(instance))
         {
            throw new Error("singlon error");
         }
         instance = this;
         this._ziChenRoomInfo = new Array();
         this._lanChenRoomInfo = new Array();
         this._lvChenRoomInfo = new Array();
         this.lqRoomInfoArr = [this._ziChenRoomInfo,this._lanChenRoomInfo,this._lvChenRoomInfo];
         this._qysxData = new Array();
      }
      
      public static function getInstance() : Model_guajiInfo
      {
         if(instance)
         {
         }
         return instance;
      }
      
      public function upGJDBuffFilters() : void
      {
         var v:Boolean = UIManager.guajiPanel.visible;
         if(v && Boolean(this.gjdSP))
         {
            this.gjdSP.filters = null;
         }
         else if(Boolean(this.gjdSP))
         {
            this.gjdSP.filters = Util.disabled;
         }
      }
      
      public function updateGJDBuff(gjdType1:int = -1, gjdRemain1:int = -1) : void
      {
         var url:String = null;
         if(gjdType1 == -1)
         {
            gjdType1 = this.gjdType;
         }
         if(gjdRemain1 == -1)
         {
            gjdRemain1 = this.gjdRemain;
         }
         this.gjdType = gjdType1 - 46614 <= 0 ? gjdType1 : int(gjdType1 - 46614);
         this.gjdRemain = gjdRemain1;
         if(Boolean(this.curBufBM) && (this.gjdType <= 0 || this.gjdRemain <= 0))
         {
            this.curBufBM.load(null);
            UIManager.heroHead.removeBuff(this.gjdSP);
         }
         if(this.gjdType > 0 && gjdRemain1 > 0)
         {
            if(!this.curBufBM)
            {
               this.gjdSP = new Sprite();
               this.curBufBM = new Bitmap2();
               this.gjdSP.addChild(this.curBufBM);
               this.gjdSP.addEventListener(MouseEvent.MOUSE_MOVE,this.gjdSPMoveHd);
               this.gjdSP.addEventListener(MouseEvent.ROLL_OUT,this.gjdSPOutHd);
            }
            url = this.getBuffUrlByLv();
            this.curBufBM.load(url);
            UIManager.heroHead.addBuff(this.gjdSP);
         }
         if(UIManager.guajiPanel.visible == true)
         {
            UIManager.guajiPanel.setGjdType(gjdRemain1 == 0 ? 0 : this.gjdType);
         }
      }
      
      public function getBuffUrlByLv() : String
      {
         if(this.gjdType < 0 || this.gjdType > 4)
         {
            return "";
         }
         var buffID:int = this.gjdType + 39905;
         return "resource/image/buff/" + Data_lib.buffer[buffID][11] + ".png";
      }
      
      public function useGjdItem(vo:Vo_item, num:int = 1) : void
      {
         var gjdType2:int = vo.id - 46614;
         if(this.gjdRemain > 0 && this.gjdType != 0 && gjdType2 != this.gjdType)
         {
            View_Alert.show(LangConfig.getWord("29408",2,Enum_BroadCastTool.instance.getItemText(vo.id),this.getGjdColorNameByType(this.gjdType)),View_Alert.OK_CANCAL,function():void
            {
               BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,num);
            });
         }
         else
         {
            BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,num);
         }
      }
      
      public function getGjdColorNameByType(t:int) : String
      {
         if(t > 0 && t <= 4)
         {
            return Enum_BroadCastTool.instance.getItemText(t + 46614,12);
         }
         return "";
      }
      
      public function getGjdDescript(t:int) : String
      {
         var buffID:int = 0;
         if(t > 0 && t <= 4)
         {
            buffID = int(Data_lib.item[t + 46614][Enum_lib_item.RESULT]);
            return LangConfig.getWord("29410",2) + Data_lib.buffer[buffID][4] * 100 + "%";
         }
         return "";
      }
      
      public function getRealGJDTipStr() : String
      {
         var tipStr:String = null;
         var remain:int = 0;
         if(this.gjdType == 0 || this.gjdRemain == 0)
         {
            return LangConfig.getWord("29411",2);
         }
         var now:int = getTimer();
         if(remain < 0)
         {
            remain = 0;
         }
         if(UIManager.guajiPanel.visible)
         {
            remain = this.gjdRemain - (now - this.gjdLastupdateTime) / 1000;
         }
         else
         {
            remain = this.gjdRemain;
         }
         return this.getGJDTipStr(this.gjdType,remain);
      }
      
      public function getGJDTipStr(type:int, remain:int) : String
      {
         var vEnabled:Boolean = UIManager.guajiPanel.visible;
         var fen:int = Math.round(remain % 3600 / 60);
         var shi:int = remain / 3600;
         if(fen >= 60)
         {
            fen = 0;
            shi += 1;
         }
         var timeStr:String = Enum_BroadCastTool.instance.getBitStr(shi) + LangConfig.getWord("10450",1) + Enum_BroadCastTool.instance.getBitStr(fen) + LangConfig.getWord("10451",1);
         return this.getGjdColorNameByType(this.gjdType) + "<br/>" + this.getGjdDescript(this.gjdType) + "<br/>" + LangConfig.getWord("935",0) + " " + timeStr;
      }
      
      private function gjdSPMoveHd(event:MouseEvent) : void
      {
         TipManager.update(this.getRealGJDTipStr());
      }
      
      private function gjdSPOutHd(event:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      public function set qysxData(value:Array) : void
      {
         var arr:Array = null;
         this._qysxData.splice(0,this._qysxData.length);
         for each(arr in value)
         {
            this._qysxData.push({
               "id":arr[0],
               "name":arr[1],
               "level":arr[2],
               "sex":arr[3]
            });
         }
      }
      
      public function get qysxData() : Array
      {
         return this._qysxData;
      }
      
      public function set ziChenRoomInfo(value:Array) : void
      {
         this.updatelqInfoByIndex(this._ziChenRoomInfo,value);
      }
      
      public function set lanChenRoomInfo(value:Array) : void
      {
         this.updatelqInfoByIndex(this._lanChenRoomInfo,value);
      }
      
      public function set lvChenRoomInfo(value:Array) : void
      {
         this.updatelqInfoByIndex(this._lvChenRoomInfo,value);
      }
      
      public function resetlqData() : void
      {
         this._ziChenRoomInfo = new Array();
         this._lanChenRoomInfo = new Array();
         this._lvChenRoomInfo = new Array();
         this.lqRoomInfoArr = [this._ziChenRoomInfo,this._lanChenRoomInfo,this._lvChenRoomInfo];
      }
      
      private function updatelqInfoByIndex(disArr:Array, srcArr:Array) : void
      {
         var index:uint = 0;
         while(index < srcArr.length)
         {
            disArr[srcArr[index][0]] = srcArr[index];
            index++;
         }
      }
      
      public function get haslqRoom() : Boolean
      {
         var arr1:Array = null;
         var arr2:Array = null;
         loop0:
         for each(arr1 in this.lqRoomInfoArr)
         {
            var _loc6_:int = 0;
            var _loc7_:* = arr1;
            do
            {
               for each(arr2 in _loc7_)
               {
               }
               continue loop0;
            }
            while(arr2[1] != GameUnitManager.hero.id);
            return true;
         }
         return false;
      }
   }
}

