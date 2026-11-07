package com.yiTian.net.message.gc
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.model.Model_shenshou;
   import com.yiTian.data.vo.Vo_shenshou;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.ShenShouHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.banhui.shenshou.Model_ShenShou_PaiHang;
   import com.yiTian.view.modules.tianMing.View_TianMing;
   import flash.utils.IDataInput;
   
   public class ShenshouGCMessage
   {
      
      public function ShenshouGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_SHEN_SHOU] = this.GC_SHEN_SHOU;
         index[MessageType.GC_TIAO_ZHAN] = this.GC_TIAO_ZHAN;
         index[MessageType.GC_TIP_BATTLE] = this.GC_TIP_BATTLE;
         index[MessageType.GC_ENTER_BEAST] = this.GC_ENTER_BEAST;
         index[MessageType.GC_BEAST_RANK] = this.GC_BEAST_RANK;
         index[MessageType.GC_FEED_BEAST] = this.GC_FEED_BEAST;
         index[MessageType.GC_FEED_LEVEL] = this.GC_FEED_LEVEL;
         index[MessageType.GC_SSBX_BEGIN_COLLECT] = this.GC_SSBX_BEGIN_COLLECT;
         index[MessageType.GC_UPDATE_SHEN_SHOU_HP] = this.GC_UPDATE_SHEN_SHOU_HP;
         index[MessageType.GC_BANG_HUI_PING_DAO] = this.GC_BANG_HUI_PING_DAO;
         index[MessageType.GC_GONG_JI_SHENSHOU] = this.GC_GONG_JI_SHENSHOU;
         index[MessageType.GC_FEED_GIFT] = this.GC_FEED_GIFT;
         index[MessageType.GC_FIRST_DESTINY] = this.GC_FIRST_DESTINY;
      }
      
      public function GC_SHEN_SHOU(patch:IDataInput) : void
      {
         var state:int = patch.readByte();
         var growNum:int = patch.readInt();
         var challBoo:int = patch.readByte();
         var challTime:int = challTime = patch.readInt();
         var feedState:int = patch.readByte();
         var voData:Vo_shenshou = new Vo_shenshou();
         voData.state = state;
         voData.grawNum = growNum;
         voData.challBoo = challBoo;
         voData.challTime = challTime;
         voData.feedState = feedState;
         Model_shenshou.getVoData(voData);
         UIManager.shenShouPaiHang.challBeastTime = challTime;
         ShenShouHandle.GC_SHEN_SHOU(voData);
      }
      
      public function GC_TIAO_ZHAN(patch:IDataInput) : void
      {
         var state:int = patch.readByte();
         ShenShouHandle.GC_TIAO_ZHAN(state);
      }
      
      public function GC_TIP_BATTLE(patch:IDataInput) : void
      {
         ShenShouHandle.GC_TIP_BATTLE();
      }
      
      public function GC_ENTER_BEAST(patch:IDataInput) : void
      {
         var enterType:int = patch.readByte();
         ShenShouHandle.GC_ENTER_BEAST(enterType);
      }
      
      public function GC_BEAST_RANK(patch:IDataInput) : void
      {
         var a:Array = null;
         Model_ShenShou_PaiHang.myPaiHang = patch.readByte();
         Model_ShenShou_PaiHang.myPower = patch.readUTF();
         Model_ShenShou_PaiHang.titleType = patch.readByte();
         var len:int = patch.readByte();
         var d:Array = [];
         var i:int = 0;
         while(i < len)
         {
            a = [];
            a.push(patch.readUTF());
            a.push(patch.readUTF());
            d.push(a);
            i++;
         }
         Model_ShenShou_PaiHang.arrItem = d;
         ShenShouHandle.GC_BEAST_RANK();
      }
      
      public function GC_FEED_BEAST(patch:IDataInput) : void
      {
         var feedSty:int = patch.readByte();
         var starNum:int = patch.readByte();
         var refreshCost:int = patch.readInt();
         var exFeedCost:int = patch.readInt();
         var remainNum:int = patch.readByte();
         ShenShouHandle.GC_FEED_BEAST(feedSty,starNum,refreshCost,exFeedCost,remainNum);
      }
      
      public function GC_FEED_LEVEL(patch:IDataInput) : void
      {
         var refresh:int = patch.readByte();
         var starNum:int = patch.readByte();
         var reCost:int = patch.readInt();
         ShenShouHandle.GC_FEED_LEVEL(refresh,starNum,reCost);
      }
      
      public function GC_SSBX_BEGIN_COLLECT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var id:int = patch.readInt();
         ShenShouHandle.GC_SSBX_BEGIN_COLLECT(result,id);
      }
      
      public function GC_UPDATE_SHEN_SHOU_HP(patch:IDataInput) : void
      {
         var curHP:String = patch.readUTF();
         var maxHP:String = patch.readUTF();
         ShenShouHandle.GC_UPDATE_SHEN_SHOU_HP(curHP,maxHP);
      }
      
      public function GC_BANG_HUI_PING_DAO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var name:String = patch.readUTF();
         if(result == 1)
         {
            UIManager.chatPanel.addBangHuiPinDao(LangConfig.getWord("30057",3));
         }
         else if(result == 2)
         {
            UIManager.chatPanel.addBangHuiPinDao(LangConfig.getWord("30058",3));
         }
         else if(result == 3)
         {
            UIManager.chatPanel.addBangHuiPinDao(LangConfig.getWord("30059",3));
         }
         else if(result == 4)
         {
            UIManager.chatPanel.addBangHuiPinDao(LangConfig.getWord("30087",3,name));
         }
      }
      
      public function GC_GONG_JI_SHENSHOU(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var time:int = patch.readByte();
         ShenShouHandle.GC_GONG_JI_SHENSHOU(result,time);
      }
      
      public function GC_FEED_GIFT(patch:IDataInput) : void
      {
         var name:String = patch.readUTF();
         var level:int = patch.readByte();
         var propId:int = patch.readInt();
         var num:int = patch.readByte();
         var growNum:int = patch.readByte();
         var propName:String = Data_lib.item[propId][Enum_lib_item.STR_NAME];
         if(propId == 46568)
         {
            propName = "<font color=\'#33CCFF\'>" + propName + "</font>";
         }
         else if(propId == 46569)
         {
            propName = "<font color=\'#de45c7\'>" + propName + "</font>";
         }
         else if(propId == 46570)
         {
            propName = "<font color=\'#ff7700\'>" + propName + "</font>";
         }
         UIManager.chatPanel.addBangHuiPinDao(LangConfig.getWord("30056",3,name,level,propName,num,growNum));
      }
      
      public function GC_FIRST_DESTINY(patch:IDataInput) : void
      {
         var sureHandle:Function = null;
         sureHandle = function():void
         {
            View_TianMing.instance.visible = true;
         };
         View_Alert.show(LangConfig.getWord("30075",3),View_Alert.OK_CANCAL,sureHandle);
      }
   }
}

