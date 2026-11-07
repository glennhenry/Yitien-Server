package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.gameUnit.role.LZBmp;
   import com.yiTian.net.handler.HumanHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.map.Model_GM_KF;
   import flash.utils.IDataInput;
   
   public class HumanGCMessage
   {
      
      private static var i_index:int = 0;
      
      private static var ii_index:int = 0;
      
      public function HumanGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_HERO_INFO] = this.GC_HERO_INFO;
         index[MessageType.GC_UPDATE_AVATER] = this.GC_UPDATE_AVATER;
         index[MessageType.GC_DETAIL_INFO] = this.GC_DETAIL_INFO;
         index[MessageType.GC_GET_THING] = this.GC_GET_THING;
         index[MessageType.GC_LEVEL_UP] = this.GC_LEVEL_UP;
         index[MessageType.GC_LEVEL_UP_ABB] = this.GC_LEVEL_UP_ABB;
         index[MessageType.GC_SOUND] = this.GC_SOUND;
         index[MessageType.GC_CHENGHAO_UPGRADE] = this.GC_CHENGHAO_UPGRADE;
         index[MessageType.GC_BANG_QQGROUPBINDING_INFO] = this.GC_BANG_QQGROUPBINDING_INFO;
         index[MessageType.GC_BTN_EFF] = this.GC_BTN_EFF;
      }
      
      public function GC_HERO_INFO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var job:int = patch.readByte();
         var sex:int = patch.readByte();
         var level:int = patch.readShort();
         var mSpeed:int = patch.readShort();
         var hp:int = patch.readInt();
         var hpMax:int = patch.readInt();
         var mp:int = patch.readInt();
         var mpMax:int = patch.readInt();
         var id:Number = LongUtil.readLong(patch);
         var name:String = patch.readUTF();
         var direct:int = patch.readByte();
         var singned:String = patch.readUTF();
         var hasPlay:int = patch.readByte();
         var fubenInfo:String = patch.readUTF();
         var YLDiaLvl:int = patch.readByte();
         var isYearDia:int = patch.readByte();
         var huangZuanLvl:int = patch.readByte();
         var isHuangZuanYear:int = patch.readByte();
         var huiyuanLv:int = patch.readByte();
         var huiyuanYear:int = patch.readByte();
         var superLan:int = patch.readByte();
         var superLanYear:int = patch.readByte();
         var xinYueType:int = patch.readByte();
         var xinLvl:int = patch.readByte();
         var isShow:int = patch.readByte();
         var isSuperHuang:int = 0;
         if(LZBmp.isUsingSuperHuangZuan)
         {
            isSuperHuang = 0;
         }
         HumanHandler.GC_HERO_INFO(result,job,sex,level,mSpeed,hp,hpMax,mp,mpMax,id,name,direct,singned,hasPlay,fubenInfo,YLDiaLvl,isYearDia,huangZuanLvl,isHuangZuanYear,huiyuanLv,huiyuanYear,superLan,superLanYear,xinYueType,xinLvl,isShow,isSuperHuang);
      }
      
      public function GC_UPDATE_AVATER(patch:IDataInput) : void
      {
         var wulinChengHao:* = undefined;
         var id:Number = LongUtil.readLong(patch);
         var status:int = patch.readByte();
         var weapon:int = patch.readInt();
         var body:int = patch.readInt();
         var horse:int = patch.readInt();
         var speed:int = patch.readShort();
         var lqColor:int = patch.readByte();
         var qhtz:int = patch.readByte();
         var paoBiao:int = patch.readByte();
         var chengHao:int = patch.readByte();
         wulinChengHao = patch.readUTF();
         var sex:int = patch.readByte();
         var name:String = patch.readUTF();
         var job:int = patch.readByte();
         var isShow:int = patch.readByte();
         var xunZhangLvl:int = patch.readByte();
         var partner:Number = LongUtil.readLong(patch);
         var skillStr:String = patch.readUTF();
         var shenBing:int = patch.readByte();
         var zoneId:int = patch.readInt();
         var wing:int = Boolean(patch.bytesAvailable) ? patch.readInt() : 0;
         HumanHandler.GC_UPDATE_AVATER(id,status,weapon,body,horse,speed,lqColor,qhtz,paoBiao,chengHao,wulinChengHao,sex,name,isShow,job,xunZhangLvl,partner,skillStr,shenBing,zoneId,wing);
      }
      
      public function GC_DETAIL_INFO(patch:IDataInput) : void
      {
         var type:int = 0;
         var value:int = 0;
         var defs:int = 0;
         var skillID:int = 0;
         var shuXingDanCountLen:int = 0;
         var j:int = 0;
         var shuXingDanAtbLen:int = 0;
         var i:int = 0;
         var id:int = 0;
         var used:int = 0;
         var count:int = 0;
         var arr:Array = null;
         var shuXing:int = 0;
         var value1:int = 0;
         var tmpArr:Array = null;
         var result:int = patch.readByte();
         var level:int = patch.readShort();
         var hp:int = patch.readInt();
         var hpMax:int = patch.readInt();
         var mp:int = patch.readInt();
         var mpMax:int = patch.readInt();
         var vigor:int = patch.readInt();
         var maxvigor:int = patch.readInt();
         var exp:String = patch.readUTF();
         var nextexp:String = patch.readUTF();
         var bingSilver:int = patch.readInt();
         var money:int = patch.readInt();
         var silver:int = patch.readInt();
         var liquan:int = patch.readInt();
         var prestige:int = patch.readInt();
         var title_len:int = patch.readShort();
         var title:Array = [];
         i_index = 0;
         while(i_index < title_len)
         {
            title.push(patch.readInt());
            ++i_index;
         }
         var minAtt:int = patch.readInt();
         var def:int = patch.readInt();
         var attRate:int = patch.readInt();
         var dod:int = patch.readInt();
         var crit:int = patch.readInt();
         var repelv:int = patch.readInt();
         var attSpeed:int = patch.readInt();
         var strength:int = patch.readInt();
         var damgr:int = patch.readInt();
         var partId:Number = LongUtil.readLong(patch);
         var party:String = patch.readUTF();
         var vip:int = patch.readByte();
         var critv:int = patch.readInt();
         var battleTime:int = patch.readInt();
         var yeLi:int = patch.readInt();
         var christmasScore:uint = uint(patch.readInt());
         var huangZuan:int = patch.readByte();
         var blueZ:int = patch.readByte();
         var sanLiuLvl:int = patch.readByte();
         var shenBingLevel:int = patch.readByte();
         var shenBingAtbs:Array = [];
         var shenBingAtbLen:int = patch.readByte();
         i_index = 0;
         while(i_index < shenBingAtbLen)
         {
            type = patch.readByte();
            value = patch.readInt();
            defs = patch.readInt();
            shenBingAtbs.push(type,value,defs);
            i_index += 1;
         }
         var shenBingSkills:Array = [];
         var shenBingSkillLen:int = patch.readByte();
         i_index = 0;
         while(i_index < shenBingSkillLen)
         {
            skillID = patch.readInt();
            shenBingSkills.push(skillID);
            i_index += 1;
         }
         var type1:int = patch.readByte();
         var shuXingDanCounts:Array = [];
         var shuXingDanAtbs:Array = [];
         if(type1 == 1)
         {
            shuXingDanCountLen = patch.readByte();
            j = 0;
            j = 0;
            while(j < shuXingDanCountLen)
            {
               id = patch.readInt();
               used = patch.readInt();
               count = patch.readInt();
               arr = [];
               arr.push(id,used,count);
               shuXingDanCounts.push(arr);
               j++;
            }
            shuXingDanAtbLen = patch.readByte();
            i = 0;
            i = 0;
            while(i < shuXingDanAtbLen)
            {
               shuXing = patch.readInt();
               value1 = patch.readInt();
               tmpArr = [];
               tmpArr.push(shuXing,value1);
               shuXingDanAtbs.push(tmpArr);
               i++;
            }
         }
         else if(type1 == 0)
         {
            trace("没有使用属性丹");
         }
         HumanHandler.GC_DETAIL_INFO(result,level,hp,hpMax,mp,mpMax,vigor,maxvigor,exp,nextexp,bingSilver,money,silver,liquan,prestige,title,minAtt,def,attRate,dod,crit,repelv,attSpeed,strength,damgr,partId,party,vip,critv,battleTime,yeLi,christmasScore,huangZuan,blueZ,sanLiuLvl,shenBingLevel,shenBingAtbs,shenBingSkills,shuXingDanCounts,shuXingDanAtbs);
      }
      
      public function GC_GET_THING(patch:IDataInput) : void
      {
         var array_THING:Array = null;
         var type:int = patch.readByte();
         var thing_len:int = patch.readShort();
         var thing:Array = [];
         i_index = 0;
         while(i_index < thing_len)
         {
            array_THING = [];
            array_THING.push(patch.readByte());
            array_THING.push(patch.readInt());
            array_THING.push(patch.readInt());
            thing.push(array_THING);
            ++i_index;
         }
         HumanHandler.GC_GET_THING(type,thing);
      }
      
      public function GC_LEVEL_UP(patch:IDataInput) : void
      {
         var id:Number = LongUtil.readLong(patch);
         var level:int = patch.readShort();
         HumanHandler.GC_LEVEL_UP(id,level);
      }
      
      public function GC_LEVEL_UP_ABB(patch:IDataInput) : void
      {
         var id:Number = LongUtil.readLong(patch);
         var lv:int = patch.readShort();
         var power:int = patch.readInt();
         var att:int = patch.readInt();
         var def:int = patch.readInt();
         var maxHp:int = patch.readInt();
         var maxMp:int = patch.readInt();
         HumanHandler.GC_LEVEL_UP_ABB(id,lv,power,att,def,maxHp,maxMp);
      }
      
      public function GC_SOUND(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         HumanHandler.GC_SOUND(type);
      }
      
      public function GC_CHENGHAO_UPGRADE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         HumanHandler.GC_CHENGHAO_UPGRADE(result);
      }
      
      public function GC_BANG_QQGROUPBINDING_INFO(patch:IDataInput) : void
      {
         var uId:String = patch.readUTF();
         var gOId:String = patch.readUTF();
         Model_bang.bangQQGroupUnionId = uId;
         Model_bang.bangQQGroupOpenId = gOId;
      }
      
      private function GC_BTN_EFF(patch:IDataInput) : void
      {
         Model_GM_KF.showEff(true);
      }
   }
}

