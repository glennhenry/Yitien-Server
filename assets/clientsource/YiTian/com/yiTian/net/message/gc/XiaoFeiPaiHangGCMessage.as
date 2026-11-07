package com.yiTian.net.message.gc
{
   import com.utils.Util;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_XiaoFeiPaiHang;
   import com.yiTian.net.handler.XiaoFeiPaiHangHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.YTJSONParser;
   import com.yiTian.view.modules.qqJinQuan.qqJinQuanConfig;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequestMethod;
   import flash.utils.IDataInput;
   
   public class XiaoFeiPaiHangGCMessage
   {
      
      public function XiaoFeiPaiHangGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_XiaoFeiPaiHang_ICON] = GC_XiaoFeiPaiHang_ICON;
         index[MessageType.GC_XiaoFeiPaiHang_UPDATE] = GC_XiaoFeiPaiHang_UPDATE;
      }
      
      public static function GC_XiaoFeiPaiHang_ICON(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         trace("121000开关图标>>",flag);
      }
      
      public static function GC_XiaoFeiPaiHang_UPDATE(patch:IDataInput) : void
      {
         var arr:Array = [];
         Model_XiaoFeiPaiHang.startTime = patch.readInt();
         Model_XiaoFeiPaiHang.endTime = patch.readInt();
         var row:int = 1;
         while(Data_lib.hd[row][21] != 26)
         {
            row++;
         }
         Model_XiaoFeiPaiHang.StartAndEndTime = Data_lib.hd[row][4];
         var i:int = 0;
         while(i < 100)
         {
            if(Boolean(patch.bytesAvailable))
            {
               arr.push(patch.readUTF());
            }
            if(Boolean(patch.bytesAvailable))
            {
               arr.push(patch.readInt());
            }
            if(Boolean(patch.bytesAvailable))
            {
               arr.push(patch.readInt());
            }
            i++;
         }
         trace("121002收到数据长度>>",arr.length);
         XiaoFeiPaiHangHandle.Update(arr);
      }
      
      public static function getPhp() : void
      {
         var url:String = Util.rep("http://api1.app100621282.twsapp.com/openapi.php?mod=herorank&op=ybc&page={0}&pagesize={1}",0,100);
         qqJinQuanConfig.load(url,handleUnbind,URLLoaderDataFormat.TEXT,URLRequestMethod.POST);
      }
      
      private static function handleUnbind(e:*) : void
      {
         var s:String = null;
         var json:YTJSONParser = Singleton.getInstance(YTJSONParser);
         s = unescape((e.target.data as String).replace(/\\u/g,"%u"));
         var obj:Object = json.parseStringToObject(s);
         var arr:Array = [];
         var len:int = int(obj["rst"].length);
         if(len >= 100)
         {
            len = 100;
         }
         var i:int = 0;
         while(i < len)
         {
            arr.push(obj["rst"][i]["heroname"]);
            arr.push(int(obj["rst"][i]["zoneid"]));
            arr.push(int(obj["rst"][i]["yuanbao"]));
            i += 1;
         }
         var row:int = 1;
         while(Data_lib.hd[row][21] != 26)
         {
            row++;
         }
         Model_XiaoFeiPaiHang.StartAndEndTime = Data_lib.hd[row][4];
         XiaoFeiPaiHangHandle.Update(arr);
      }
   }
}

