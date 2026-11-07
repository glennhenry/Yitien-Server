package com.yiTian.net.message.gc
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.BlueDiamondHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.blueDiamondND.lanZuan.QQGameCJBtn;
   import com.yiTian.view.modules.blueDiamondND.xiaofeiCJ.Model_xiaoFeiCJ;
   import com.yiTian.view.modules.blueDiamondND.xiaofeiCJ.XFTipBtn;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.utils.IDataInput;
   
   public class BlueDiamondNDGCMessage
   {
      
      public function BlueDiamondNDGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_BLUE_DIAMOND_SHOW_BUTTON] = this.GC_BLUE_DIAMOND_SHOW_BUTTON;
         index[MessageType.GC_BLUE_REQUEST_INITDATA] = this.GC_BLUE_REQUEST_INITDATA;
         index[MessageType.GC_BLUE_DIAMOND_START] = this.GC_BLUE_DIAMOND_START;
         index[MessageType.GC_BLUE_CHAT] = this.GC_BLUE_CHAT;
         index[MessageType.GC_XFCJ_SHOWICON] = this.GC_XFCJ_SHOWICON;
         index[MessageType.GC_XFCJ_OPENPAN] = this.GC_XFCJ_OPENPAN;
         index[MessageType.GC_XFCJ_CHOUJIANG] = this.GC_XFCJ_CHOUJIANG;
         index[MessageType.GC_XFCJ2_OPENPAN] = this.GC_XFCJ2_OPENPAN;
         index[MessageType.GC_XFCJ2_CHOUJIANG] = this.GC_XFCJ2_CHOUJIANG;
         index[MessageType.GC_QQGAMECJ_SHOWICON] = this.GC_QQGAMECJ_SHOWICON;
         index[MessageType.GC_QQGAMECJ_OPENPAN] = this.GC_QQGAMECJ_OPENPAN;
         index[MessageType.GC_QQGAMECJ_CHOUJIANG] = this.GC_QQGAMECJ_CHOUJIANG;
         index[MessageType.GC_QQGAMEXF_SHOWPAN] = this.GC_QQGAMEXF_SHOWPAN;
         index[MessageType.GC_ZHUANPAN_LOGIN] = this.GC_ZHUANPAN_LOGIN;
         index[MessageType.GC_ZHUANPAN_PLAY] = this.GC_ZHUANPAN_PLAY;
         index[MessageType.GC_ZHUANPAN_OPEN] = this.GC_ZHUANPAN_OPEN;
         index[MessageType.GC_XINGYUNCHONGZHI_LOGIN] = this.GC_XINGYUNCHONGZHI_LOGIN;
         index[MessageType.GC_XINGYUNCHONGZHI_PLAY] = this.GC_XINGYUNCHONGZHI_PLAY;
         index[MessageType.GC_XINGYUNCHONGZHI_OPEN] = this.GC_XINGYUNCHONGZHI_OPEN;
      }
      
      private function GC_XINGYUNCHONGZHI_LOGIN(patch:IDataInput) : void
      {
      }
      
      private function GC_XINGYUNCHONGZHI_PLAY(patch:IDataInput) : void
      {
         var name:String = patch.readUTF();
         var job:int = patch.readByte();
         var paiXuHao:int = patch.readByte();
         var goodsID:int = patch.readInt();
         var count:int = patch.readShort();
         var curYuanBao:int = patch.readInt();
         var MaxYuanBao:int = patch.readInt();
         BlueDiamondHandler.GC_BLUE_DIAMOND_START(name,job,paiXuHao,goodsID,count,curYuanBao,MaxYuanBao,Model_xiaoFeiCJ.cjPan(Model_xiaoFeiCJ.XYZH));
      }
      
      private function GC_XINGYUNCHONGZHI_OPEN(patch:IDataInput) : void
      {
         var name:String = null;
         var job:int = 0;
         var ID:int = 0;
         var goodsCount:int = 0;
         var tempArr:Array = null;
         var shengYu:int = patch.readByte();
         var curYuanBao:int = patch.readInt();
         var maxYuanBao:int = patch.readInt();
         var isOver:String = patch.readUTF();
         var len:int = patch.readShort();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            name = patch.readUTF();
            job = patch.readByte();
            ID = patch.readInt();
            goodsCount = patch.readShort();
            tempArr = [];
            tempArr.push(name,job,ID,goodsCount);
            arr.push(tempArr);
            i++;
         }
         var startTime:String = patch.readUTF();
         var endTime:String = patch.readUTF();
         BlueDiamondHandler.GC_BLUE_REQUEST_INITDATA(arr,shengYu,curYuanBao,maxYuanBao,isOver,startTime,endTime,Model_xiaoFeiCJ.cjPan(Model_xiaoFeiCJ.XYZH));
      }
      
      private function GC_ZHUANPAN_LOGIN(patch:IDataInput) : void
      {
         var b:int = patch.readByte();
         if(b == 2)
         {
            UIManager.centerBroadcast.addMsg("不在活动时间内");
         }
      }
      
      private function GC_ZHUANPAN_PLAY(patch:IDataInput) : void
      {
         var name:String = patch.readUTF();
         var job:int = patch.readByte();
         var paiXuHao:int = patch.readByte();
         var goodsID:int = patch.readInt();
         var count:int = patch.readShort();
         var curYuanBao:int = patch.readInt();
         var MaxYuanBao:int = patch.readInt();
         BlueDiamondHandler.GC_BLUE_DIAMOND_START(name,job,paiXuHao,goodsID,count,curYuanBao,MaxYuanBao,Model_xiaoFeiCJ.cjPan(Model_xiaoFeiCJ.XFZP));
      }
      
      private function GC_ZHUANPAN_OPEN(patch:IDataInput) : void
      {
         var name:String = null;
         var job:int = 0;
         var ID:int = 0;
         var goodsCount:int = 0;
         var tempArr:Array = null;
         var shengYu:int = patch.readByte();
         var curYuanBao:int = patch.readInt();
         var maxYuanBao:int = patch.readInt();
         var isOver:String = patch.readUTF();
         var len:int = patch.readShort();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            name = patch.readUTF();
            job = patch.readByte();
            ID = patch.readInt();
            goodsCount = patch.readShort();
            tempArr = [];
            tempArr.push(name,job,ID,goodsCount);
            arr.push(tempArr);
            i++;
         }
         var startTime:String = patch.readUTF();
         var endTime:String = patch.readUTF();
         BlueDiamondHandler.GC_BLUE_REQUEST_INITDATA(arr,shengYu,curYuanBao,maxYuanBao,isOver,startTime,endTime,Model_xiaoFeiCJ.cjPan(Model_xiaoFeiCJ.XFZP));
      }
      
      private function GC_XFCJ_SHOWICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            XFTipBtn.show();
         }
         else
         {
            XFTipBtn.hide();
         }
      }
      
      private function GC_QQGAMECJ_SHOWICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            QQGameCJBtn.show();
         }
         else
         {
            QQGameCJBtn.hide();
         }
      }
      
      private function GC_QQGAMECJ_OPENPAN(patch:IDataInput) : void
      {
         var name:String = null;
         var type:int = 0;
         var id:int = 0;
         var count:int = 0;
         var leftTimes:int = patch.readByte();
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            name = patch.readUTF();
            type = patch.readByte();
            id = patch.readInt();
            count = patch.readByte();
            arr.push([name,1,id,count]);
            i++;
         }
         var startTime:String = patch.readUTF();
         var isOver:String = patch.readUTF();
         BlueDiamondHandler.GC_BLUE_REQUEST_INITDATA(arr,leftTimes,0,0,isOver,startTime,"",Model_xiaoFeiCJ.cjPan(Model_xiaoFeiCJ.LZSTR));
      }
      
      private function GC_XFCJ_OPENPAN(patch:IDataInput) : void
      {
         var name:String = null;
         var type:int = 0;
         var id:int = 0;
         var count:int = 0;
         var leftTimes:int = patch.readByte();
         var current:int = patch.readInt();
         var max:int = patch.readInt();
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            name = patch.readUTF();
            type = patch.readByte();
            id = patch.readInt();
            count = patch.readInt();
            arr.push([name,1,id,count]);
            i++;
         }
         var startTime:String = patch.readUTF();
         var isOver:String = patch.readUTF();
         BlueDiamondHandler.GC_BLUE_REQUEST_INITDATA(arr,leftTimes,current,max,isOver,startTime,"",Model_xiaoFeiCJ.cjPan(Model_xiaoFeiCJ.XFSTR));
      }
      
      private function GC_XFCJ2_OPENPAN(patch:IDataInput) : void
      {
         var name:String = null;
         var type:int = 0;
         var id:int = 0;
         var count:int = 0;
         var leftTimes:int = patch.readByte();
         var current:int = patch.readInt();
         var max:int = patch.readInt();
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            name = patch.readUTF();
            type = patch.readByte();
            id = patch.readInt();
            count = patch.readInt();
            arr.push([name,1,id,count]);
            i++;
         }
         var startTime:String = patch.readUTF();
         var isOver:String = patch.readUTF();
         BlueDiamondHandler.GC_BLUE_REQUEST_INITDATA(arr,leftTimes,current,max,isOver,startTime,"",Model_xiaoFeiCJ.cjPan(Model_xiaoFeiCJ.XFSTR2));
      }
      
      private function GC_XFCJ_CHOUJIANG(patch:IDataInput) : void
      {
         var index:int = patch.readByte();
         var name:String = GameUnitManager.hero.name;
         var paiXuHao:int = index - 1;
         var goodsID:int = int(Data_lib.XFCJ[index][0].split("_")[1]);
         var count:int = int(Data_lib.XFCJ[index][0].split("_")[2]);
         BlueDiamondHandler.GC_BLUE_DIAMOND_START(name,1,paiXuHao,goodsID,count,0,0,Model_xiaoFeiCJ.cjPan(Model_xiaoFeiCJ.XFSTR));
      }
      
      private function GC_XFCJ2_CHOUJIANG(patch:IDataInput) : void
      {
         var index:int = patch.readByte();
         var name:String = GameUnitManager.hero.name;
         var paiXuHao:int = index - 1;
         var goodsID:int = int(Data_lib.XFCJ2[index][0].split("_")[1]);
         var count:int = int(Data_lib.XFCJ2[index][0].split("_")[2]);
         BlueDiamondHandler.GC_BLUE_DIAMOND_START(name,1,paiXuHao,goodsID,count,0,0,Model_xiaoFeiCJ.cjPan(Model_xiaoFeiCJ.XFSTR2));
      }
      
      private function GC_QQGAMECJ_CHOUJIANG(patch:IDataInput) : void
      {
         var index:int = patch.readByte();
         var name:String = GameUnitManager.hero.name;
         var paiXuHao:int = index - 1;
         var goodsID:int = int(Data_lib.qqGameChoujiang[index][0].split("_")[1]);
         var count:int = int(Data_lib.qqGameChoujiang[index][0].split("_")[2]);
         BlueDiamondHandler.GC_BLUE_DIAMOND_START(name,1,paiXuHao,goodsID,count,0,0,Model_xiaoFeiCJ.cjPan(Model_xiaoFeiCJ.LZSTR));
      }
      
      private function GC_BLUE_DIAMOND_SHOW_BUTTON(patch:IDataInput) : void
      {
         var show:int = patch.readByte();
         BlueDiamondHandler.GC_BLUE_DIAMOND_SHOW_BUTTON(show);
      }
      
      private function GC_BLUE_DIAMOND_START(patch:IDataInput) : void
      {
         var name:String = patch.readUTF();
         var job:int = patch.readByte();
         var paiXuHao:int = patch.readByte();
         var goodsID:int = patch.readInt();
         var count:int = patch.readShort();
         var curYuanBao:int = patch.readInt();
         var MaxYuanBao:int = patch.readInt();
         BlueDiamondHandler.GC_BLUE_DIAMOND_START(name,job,paiXuHao,goodsID,count,curYuanBao,MaxYuanBao,UIManager.blueDiamondND);
      }
      
      private function GC_BLUE_REQUEST_INITDATA(patch:IDataInput) : void
      {
         var name:String = null;
         var job:int = 0;
         var ID:int = 0;
         var goodsCount:int = 0;
         var tempArr:Array = null;
         var shengYu:int = patch.readByte();
         var curYuanBao:int = patch.readInt();
         var maxYuanBao:int = patch.readInt();
         var isOver:String = patch.readUTF();
         var len:int = patch.readShort();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            name = patch.readUTF();
            job = patch.readByte();
            ID = patch.readInt();
            goodsCount = patch.readShort();
            tempArr = [];
            tempArr.push(name,job,ID,goodsCount);
            arr.push(tempArr);
            i++;
         }
         var startTime:String = patch.readUTF();
         var endTime:String = patch.readUTF();
         BlueDiamondHandler.GC_BLUE_REQUEST_INITDATA(arr,shengYu,curYuanBao,maxYuanBao,isOver,startTime,endTime,UIManager.blueDiamondND);
      }
      
      private function GC_BLUE_CHAT(patch:IDataInput) : void
      {
         var job:int = patch.readByte();
         var name:String = patch.readUTF();
         var id:int = patch.readInt();
         var goodsCount:int = patch.readShort();
         var str:String = "<font color=\'#" + Enum_job.JOBCOLOR[job] + "\'>" + name + "</font>获得 " + Enum_BroadCastTool.instance.getColorStr(Data_lib.item[id][Enum_lib_item.STR_NAME],Data_lib.item[id][Enum_lib_item.COLOR]) + " " + goodsCount.toString() + "件";
         UIManager.triggleBroadcast.addMsg(str);
      }
      
      private function GC_QQGAMEXF_SHOWPAN(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var result:int = patch.readByte();
         BlueDiamondHandler.GC_QQGAMEXF_SHOWPAN(type,result);
      }
   }
}

