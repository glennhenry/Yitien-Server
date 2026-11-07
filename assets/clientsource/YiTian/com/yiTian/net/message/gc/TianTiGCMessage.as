package com.yiTian.net.message.gc
{
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.net.handler.tianTiHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class TianTiGCMessage
   {
      
      public function TianTiGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ZMR] = this.GC_ZMR;
         index[MessageType.GC_TIANTI] = this.GC_TIANTI;
         index[MessageType.GC_TIANTIBATTLE] = this.GC_TIANTIBATTLE;
         index[MessageType.GC_XINFA] = this.GC_XINFA;
         index[MessageType.GC_XINFACJ] = this.GC_XINFACJ;
         index[MessageType.GC_XINFACJ2] = this.GC_XINFACJ2;
         index[MessageType.GC_TIANTIAUTOB] = this.GC_TIANTIAUTOB;
         index[MessageType.GC_TIANTIREWARDS] = this.GC_TIANTIREWARDS;
         index[MessageType.GC_XINFALVUP] = this.GC_XINFALVUP;
         index[MessageType.GC_XINFA_GOD] = this.GC_XINFA;
         index[MessageType.GC_XINFACJ_GOD] = this.GC_XINFACJ;
         index[MessageType.GC_XINFACJ2_GOD] = this.GC_XINFACJ2;
         index[MessageType.GC_XINFALV] = this.GC_XINFALV;
      }
      
      public function GC_ZMR(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         tianTiHandle.GC_ZMR(type);
      }
      
      public function GC_TIANTI(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var curLevel:int = patch.readByte();
         var refreshTimes:int = patch.readByte();
         var recordLv:int = patch.readByte();
         tianTiHandle.GC_TIANTI(0,curLevel,refreshTimes,recordLv);
      }
      
      public function GC_TIANTIBATTLE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var battleResult:int = patch.readByte();
         var lv:int = patch.readByte();
         var battleId:int = patch.readInt();
         var xinFa:int = patch.readInt();
         var gainXinFa:int = patch.readShort();
         tianTiHandle.GC_TIANTIBATTLE(result,battleResult,lv,battleId,xinFa,gainXinFa);
      }
      
      public function GC_XINFA(patch:IDataInput) : void
      {
         var lv:int = 0;
         var curExp:int = 0;
         var result:int = patch.readByte();
         var xinfa:int = patch.readInt();
         var arr:Array = [];
         var i:int = 0;
         while(i < 5)
         {
            lv = patch.readShort();
            curExp = patch.readInt();
            arr.push(lv,curExp);
            i += 1;
         }
         tianTiHandle.GC_XINFA(result,xinfa,arr);
      }
      
      public function GC_XINFACJ(patch:IDataInput) : void
      {
         var i:int = 0;
         var lv:int = 0;
         var exp:int = 0;
         var result:int = patch.readByte();
         var arr:Array = [];
         i = 0;
         while(i < 5)
         {
            arr.push(patch.readByte());
            i += 1;
         }
         var xinfa:int = patch.readInt();
         var nxtInfo:Array = [];
         i = 0;
         while(i < 5)
         {
            lv = patch.readShort();
            exp = patch.readInt();
            nxtInfo.push(lv,exp);
            i += 1;
         }
         tianTiHandle.GC_XINFACJ(result,arr,xinfa,nxtInfo);
      }
      
      public function GC_XINFACJ2(patch:IDataInput) : void
      {
         var result:Array = null;
         var nxtInfo:Array = null;
         var gainValues:Array = null;
         var j:int = 0;
         var point:int = 0;
         var lv:int = 0;
         var exp:int = 0;
         var gainValue:int = 0;
         var len:int = patch.readByte();
         var results:Array = [];
         var nxtInfos:Array = [];
         var gains:Array = [];
         var i:int = 0;
         while(i < len)
         {
            result = [];
            nxtInfo = [];
            gainValues = [];
            j = 0;
            while(j < 5)
            {
               point = patch.readByte();
               result.push(point);
               j += 1;
            }
            j = 0;
            while(j < 5)
            {
               lv = patch.readShort();
               exp = patch.readInt();
               gainValue = patch.readShort();
               nxtInfo.push(lv,exp);
               gainValues.push(gainValue);
               j += 1;
            }
            results.push(result);
            nxtInfos.push(nxtInfo);
            gains.push(gainValues);
            i += 1;
         }
         var xf:int = patch.readInt();
         tianTiHandle.GC_XINFACJ2(results,nxtInfos,gains,xf);
      }
      
      public function GC_TIANTIAUTOB(patch:IDataInput) : void
      {
         var lv:int = 0;
         var gainInfos:Array = null;
         var gLen:int = 0;
         var j:int = 0;
         var jyd:int = 0;
         var type:int = 0;
         var id:int = 0;
         var num:int = 0;
         var len:int = patch.readByte();
         var infos:Array = [];
         var i:int = 0;
         while(i < len)
         {
            lv = patch.readInt();
            gainInfos = [];
            gLen = patch.readByte();
            j = 0;
            while(j < gLen)
            {
               type = patch.readByte();
               id = patch.readInt();
               num = patch.readInt();
               gainInfos.push([type,id,num]);
               j += 1;
            }
            jyd = patch.readByte();
            infos.push([lv,gainInfos,jyd]);
            i += 1;
         }
         var bagFlag:int = patch.readByte();
         tianTiHandle.GC_TIANTIAUTOB(infos,bagFlag);
      }
      
      public function GC_TIANTIREWARDS(patch:IDataInput) : void
      {
         var _sData:String = null;
         var _arrData:Array = null;
         var strData:String = null;
         var j:int = 0;
         var _add:String = null;
         var servData:Array = [];
         var i:int = 0;
         while(i < 7)
         {
            _sData = patch.readUTF();
            if(_sData != "")
            {
               _arrData = _sData.split("_");
               _arrData[1] = Model_heFu.repNameByHero(_arrData[1]);
               strData = "";
               j = 0;
               while(j < _arrData.length)
               {
                  _add = j == _arrData.length - 1 ? "" : "_";
                  strData += _arrData[j] + _add;
                  j++;
               }
               servData.push(strData);
            }
            else
            {
               servData.push(_sData);
            }
            i += 1;
         }
         tianTiHandle.GC_TIANTIREWARDS(servData);
      }
      
      public function GC_XINFALVUP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         tianTiHandle.GC_XINFALVUP(result);
      }
      
      public function GC_XINFALV(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         tianTiHandle.GC_XINFA_STATUS(result);
      }
   }
}

