package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_jingJiChang;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.JingJiChangHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.jingJiChang.Vo_jjc;
   import flash.utils.IDataInput;
   
   public class JingJiChangGCMessage
   {
      
      private var i_index:int;
      
      private var ii_index:int;
      
      public function JingJiChangGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_GET_PAIMING] = this.GC_GET_PAIMING;
         index[MessageType.GC_GET_WAR_INFO] = this.GC_GET_WAR_INFO;
         index[MessageType.GC_DEKARON] = this.GC_DEKARON;
         index[MessageType.GC_DEKARON_RANDOM] = this.GC_DEKARON_RANDOM;
         index[MessageType.GC_CANCEL_COOLTIME] = this.GC_CANCEL_COOLTIME;
         index[MessageType.GC_PAIHANG] = this.GC_PAIHANG;
         index[MessageType.GC_PAIHANG_CHECK] = this.GC_PAIHANG_CHECK;
         index[MessageType.GC_UPDATA_TIPS] = this.GC_UPDATA_TIPS;
         index[MessageType.GC_RANDOM_RESULT] = this.GC_RANDOM_RESULT;
         index[MessageType.GC_JING_ADD] = this.GC_JING_ADD;
         index[MessageType.GC_JING_WAR_MY_DATA] = this.GC_JING_WAR_MY_DATA;
         index[MessageType.GC_JING_RESULT] = this.GC_JING_RESULT;
         index[MessageType.GC_SPEED] = this.GC_SPEED;
         index[MessageType.GC_SNOWMAN_SHOW] = this.GC_SNOWMAN_SHOW;
         index[MessageType.GC_CHALLENGE_SNOWMAN] = this.GC_CHALLENGE_SNOWMAN;
         index[MessageType.GC_JINGJI_LUCKYNUM] = GC_JINGJI_LUCKTNUM;
      }
      
      public static function GC_JINGJI_LUCKTNUM(patch:IDataInput) : void
      {
         var result:int = patch.readInt();
         UIManager.jjc_panel.updateLuckNum(result);
      }
      
      public function GC_CHALLENGE_SNOWMAN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 0:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80206",8));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80207",8));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80209",8));
         }
      }
      
      public function GC_SNOWMAN_SHOW(patch:IDataInput) : void
      {
         Model_jingJiChang.isSnowManTime = patch.readByte();
         Model_jingJiChang.canWarSnowMan = patch.readByte();
         UIManager.jjc_panel.showSnowMan();
      }
      
      public function GC_GET_PAIMING(patch:IDataInput) : void
      {
         var array_TZITEM:Array = null;
         var len:int = patch.readShort();
         var tiaoZhanItem:Array = [];
         this.i_index = 0;
         while(this.i_index < len)
         {
            array_TZITEM = [];
            array_TZITEM.push(LongUtil.readLong(patch));
            array_TZITEM.push(patch.readUTF());
            array_TZITEM.push(patch.readInt());
            array_TZITEM.push(patch.readInt());
            array_TZITEM.push(patch.readByte());
            array_TZITEM.push(patch.readByte());
            array_TZITEM.push(LongUtil.readLong(patch));
            array_TZITEM.push(patch.readByte());
            array_TZITEM.push(patch.readByte());
            array_TZITEM.push(patch.readInt());
            array_TZITEM.push(patch.readInt());
            tiaoZhanItem.push(array_TZITEM);
            ++this.i_index;
         }
         var shengRate:int = patch.readByte();
         var canWar:int = patch.readByte();
         var curPosition:int = patch.readInt();
         var lfTime:int = patch.readInt();
         var jjc_jf:int = patch.readInt();
         var self_vx:int = patch.readByte();
         var pet_vx:int = patch.readByte();
         var xuanYaoTimes:int = patch.readInt();
         JingJiChangHandle.GC_JINGJICHANG(len,tiaoZhanItem,shengRate,canWar,curPosition,lfTime,jjc_jf,self_vx,pet_vx,xuanYaoTimes);
      }
      
      public function GC_GET_WAR_INFO(patch:IDataInput) : void
      {
         var array_TZITEM:Array = null;
         var zhuDong:String = null;
         var beiDong:String = null;
         var len:int = patch.readShort();
         var tz_item:Array = [];
         var _nickName:String = GameUnitManager.hero.nickName;
         this.i_index = 0;
         while(this.i_index < len)
         {
            array_TZITEM = [];
            zhuDong = patch.readUTF();
            array_TZITEM.push(Model_heFu.repNameByHero(zhuDong));
            array_TZITEM.push(patch.readByte());
            beiDong = patch.readUTF();
            array_TZITEM.push(Model_heFu.repNameByHero(beiDong));
            array_TZITEM.push(patch.readByte());
            array_TZITEM.push(patch.readByte());
            array_TZITEM.push(patch.readByte());
            tz_item.push(array_TZITEM);
            ++this.i_index;
         }
         JingJiChangHandle.GC_GET_WAR_INFO(len,tz_item);
      }
      
      public function GC_DEKARON(patch:IDataInput) : void
      {
         var _price:int = patch.readShort();
         JingJiChangHandle.CG_DEKARON(_price);
      }
      
      public function GC_DEKARON_RANDOM(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var time:int = patch.readInt();
         var win_rate:int = patch.readByte();
         var canWar_Num:int = patch.readByte();
         var jjc_jifen:int = patch.readInt();
         JingJiChangHandle.GC_DEKARON_RANDOM(result,time,win_rate,canWar_Num,jjc_jifen);
      }
      
      public function GC_CANCEL_COOLTIME(patch:IDataInput) : void
      {
         var jjc_jifen:int = patch.readInt();
         JingJiChangHandle.GC_CANCEL_COOLTIME(jjc_jifen);
      }
      
      public function GC_PAIHANG(patch:IDataInput) : void
      {
         var array_TZITEM:Array = null;
         var len:int = patch.readShort();
         var tiaoZhanItem:Array = [];
         this.i_index = 0;
         while(this.i_index < len)
         {
            array_TZITEM = [];
            array_TZITEM.push(LongUtil.readLong(patch));
            array_TZITEM.push(patch.readUTF());
            array_TZITEM.push(patch.readInt());
            array_TZITEM.push(patch.readInt());
            array_TZITEM.push(patch.readByte());
            array_TZITEM.push(patch.readByte());
            array_TZITEM.push(LongUtil.readLong(patch));
            array_TZITEM.push(patch.readByte());
            array_TZITEM.push(patch.readByte());
            array_TZITEM.push(patch.readInt());
            tiaoZhanItem.push(array_TZITEM);
            ++this.i_index;
         }
         JingJiChangHandle.GC_PAIHANG(len,tiaoZhanItem);
      }
      
      public function GC_PAIHANG_CHECK(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         JingJiChangHandle.GC_PAIHANG_CHECK(result);
      }
      
      public function GC_UPDATA_TIPS(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         JingJiChangHandle.GC_UPDATA_TIPS(result);
      }
      
      public function GC_RANDOM_RESULT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         JingJiChangHandle.GC_RANDOM_RESULT(result);
      }
      
      public function GC_JING_ADD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         JingJiChangHandle.GC_JING_ADD(result);
      }
      
      public function GC_JING_WAR_MY_DATA(patch:IDataInput) : void
      {
         var vo_jjc:Vo_jjc = null;
         var result:int = patch.readByte();
         var len:int = patch.readByte();
         var dataArr:Array = [];
         var _nickName:String = GameUnitManager.hero.nickName;
         var i:int = 0;
         while(i < len)
         {
            vo_jjc = new Vo_jjc();
            vo_jjc.war_id = LongUtil.readLong(patch);
            vo_jjc.zhuDong_id = LongUtil.readLong(patch);
            vo_jjc.z_name = Model_heFu.repNameByHero(patch.readUTF());
            vo_jjc.z_job = patch.readByte();
            vo_jjc.beiDong_id = LongUtil.readLong(patch);
            vo_jjc.b_name = Model_heFu.repNameByHero(patch.readUTF());
            vo_jjc.b_job = patch.readByte();
            vo_jjc.result = patch.readByte();
            vo_jjc.changed = patch.readByte();
            vo_jjc.time = patch.readInt();
            dataArr.push(vo_jjc);
            i++;
         }
         JingJiChangHandle.GC_JING_WAR_MY_DATA(dataArr);
      }
      
      public function GC_JING_RESULT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var bId:int = patch.readInt();
         var gain:int = patch.readByte();
         var battleResult:int = patch.readByte();
         var otherRoleName:String = patch.readUTF();
         JingJiChangHandle.GC_JING_RESULT(bId,gain,otherRoleName,battleResult);
      }
      
      public function GC_SPEED(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         JingJiChangHandle.GC_SPEED(result);
      }
   }
}

