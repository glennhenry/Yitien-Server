package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_shuXingDan;
   import com.yiTian.data.model.Model_KuaFuFlower;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_TianMing;
   import com.yiTian.data.vo.Vo_shuXingDan;
   import com.yiTian.gameUnit.role.LZBmp;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.PaiHangHandler;
   import com.yiTian.net.handler.TianMingHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.newRolePan.ComparePan;
   import com.yiTian.view.modules.newRolePan.PaiHangRolePan;
   import com.yiTian.view.modules.newRolePan.RoleMter;
   import com.yiTian.view.modules.paihang.FlowerVO;
   import com.yiTian.view.modules.paihang.KuaFuMeiLiPanel;
   import com.yiTian.view.modules.paihang.PaiHangVO;
   import com.yiTian.view.modules.playerExtend.CGXTestPan;
   import com.yiTian.view.modules.shenBing.Vo_ShenBingAtb;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.utils.IDataInput;
   
   public class PaiHangGCMessage
   {
      
      public function PaiHangGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_PAIHANG_DENGJI] = GC_PAIHANG_DENGJI;
         index[MessageType.GC_PAIHANG_ZHANLI] = GC_PAIHANG_ZHANLI;
         index[MessageType.GC_PAIHANG_CAIFU] = GC_PAIHANG_CAIFU;
         index[MessageType.GC_PAIHANG_MY] = GC_PAIHANG_MY;
         index[MessageType.GC_CITY_DIAOXIANG] = GC_CITY_DIAOXIANG;
         index[MessageType.GC_PAIHANG_KUNLUN] = GC_PAIHANG_KUNLUN;
         index[MessageType.GC_PAIHANG_WULINDAHUI] = GC_PAIHANG_WULINDAHUI;
         index[MessageType.GC_PAIHANG_PET] = GC_PAIHANG_PET;
         index[MessageType.GC_PAIHANG_BANGHUI] = GC_PAIHANG_BANGHUI;
         index[MessageType.GC_PAIHANG_MEILI] = GC_PAIHANG_MEILI;
         index[MessageType.GC_PAIHANG_FLOWERS] = GC_PAIHANG_FLOWERS;
         index[MessageType.GC_KUAFU_FLOWERS] = GC_KUAFU_FLOWERS;
         index[MessageType.GC_OTHERROLE_SHENBINGINFO] = GC_OTHERROLE_SHENBINGINFO;
         index[MessageType.GC_ASK_SHUXINGDANINFO] = GC_ASK_SHUXINGDANINFO;
         index[MessageType.GC_ENOUGH_SHUXINGDSN] = GC_ENOUGH_SHUXINGDSN;
      }
      
      public static function GC_PAIHANG_DENGJI(patch:IDataInput) : void
      {
         var itemLength:int = 0;
         var itemI:uint = 0;
         var tempArr:Array = null;
         var shenBingVo:Vo_ShenBingAtb = null;
         var shuXingDanVo:Vo_shuXingDan = null;
         var isSpHuang:int = 0;
         var result:int = patch.readByte();
         var phVO:PaiHangVO = new PaiHangVO();
         itemLength = patch.readByte();
         phVO.curPage = patch.readByte();
         phVO.totalPage = patch.readByte();
         phVO.curZhiYeType = patch.readByte();
         phVO.paiHangItemArr = [];
         itemI = 0;
         while(itemI < itemLength)
         {
            tempArr = [];
            tempArr.push(patch.readByte());
            tempArr.push(Model_heFu.repNameByHero(patch.readUTF()));
            tempArr.push(patch.readByte());
            tempArr.push(patch.readUTF());
            tempArr.push(patch.readInt());
            tempArr.push(readEquipsData(patch));
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(readMarrAssis(patch));
            tempArr.push(readStoneLvl(patch));
            shenBingVo = readShenBing(patch);
            shuXingDanVo = readShuXingDan(patch);
            tempArr.push(getNewData(patch));
            tempArr.push(getRoleAttr(patch));
            isSpHuang = 0;
            if(LZBmp.isUsingSuperHuangZuan)
            {
               isSpHuang = patch.readByte();
            }
            tempArr.push(isSpHuang);
            tempArr.push(shenBingVo);
            tempArr.push(shuXingDanVo);
            phVO.paiHangItemArr.push(tempArr);
            itemI++;
         }
         CGXTestPan._objData = phVO;
         PaiHangHandler.GC_PAIHANG_DENGJI(result,phVO);
      }
      
      public static function getNewData(patch:IDataInput) : Array
      {
         var i:int = 0;
         var sId:int = 0;
         var sWorth:int = 0;
         var leiJiWorth:int = 0;
         var dataArr:Array = [];
         var isOnLine:int = patch.readByte();
         var voVec:Vector.<Array> = TianMingHandler.makeVoArray(patch);
         var _arrVec:Vector.<Vo_TianMing> = updateTianMingHd(voVec);
         var levelTen:int = patch.readByte();
         var levelSix:int = patch.readByte();
         var levelSixNums:int = patch.readByte();
         var level:int = patch.readByte();
         var nums:int = patch.readByte();
         if(levelTen == 0 && levelSix == 0)
         {
         }
         var vec:Vector.<int> = new Vector.<int>(6,true);
         i = 0;
         while(i < 6)
         {
            vec[i] = patch.readInt();
            i++;
         }
         var body:int = patch.readInt();
         var weapon:int = patch.readInt();
         var horse:int = patch.readInt();
         var wing:int = patch.readInt();
         var len:int = patch.readByte();
         var _dataArr:Array = [];
         i = 0;
         while(i < len)
         {
            sId = patch.readInt();
            sWorth = patch.readInt();
            leiJiWorth = patch.readInt();
            _dataArr.push([sId,sWorth,leiJiWorth]);
            i++;
         }
         var chengHao:int = patch.readByte();
         dataArr.push(isOnLine,_arrVec,levelTen,levelSix,levelSixNums,level,nums,vec,body,weapon,horse,_dataArr,chengHao,wing);
         return dataArr;
      }
      
      public static function updateTianMingHd(source:Vector.<Array>) : Vector.<Vo_TianMing>
      {
         var vo:Vo_TianMing = null;
         var arr:Array = null;
         var dataVec:Vector.<Vo_TianMing> = new Vector.<Vo_TianMing>();
         var i:int = 0;
         while(i < 5)
         {
            vo = new Vo_TianMing();
            vo.gridId = i;
            if(i < source.length)
            {
               arr = source[i];
               if(arr[0] != 0)
               {
                  vo.Init_sever_bag(arr);
               }
            }
            else
            {
               vo.lock = true;
               vo.str_name = "lock";
            }
            dataVec.push(vo);
            i++;
         }
         PaiHangRolePan.tianMingDataVec = dataVec;
         RoleMter.tianMingDataVecOther = dataVec;
         return dataVec;
      }
      
      public static function getRoleAttr(patch:IDataInput) : Array
      {
         var data:Array = [];
         var shengWang:int = patch.readInt();
         var vigor:int = patch.readInt();
         var hpMax:int = patch.readInt();
         var mpMax:int = patch.readInt();
         var att:int = patch.readInt();
         var def:int = patch.readInt();
         var shot:int = patch.readInt();
         var escap:int = patch.readInt();
         var baoJi:int = patch.readInt();
         var geDang:int = patch.readInt();
         var attSpeed:int = patch.readInt();
         var baoShang:int = patch.readInt();
         var strength:int = patch.readInt();
         var roleId:Number = LongUtil.readLong(patch);
         var bangName:String = patch.readUTF();
         data.push(shengWang,vigor,hpMax,mpMax,att,def,shot,escap,baoJi,geDang,attSpeed,baoShang,strength,roleId,bangName);
         return data;
      }
      
      public static function readShenBing(patch:IDataInput) : Vo_ShenBingAtb
      {
         var type:int = 0;
         var value:int = 0;
         var def:int = 0;
         var skillID:int = 0;
         var shenBingLevel:int = patch.readByte();
         var shenBingAtbs:Array = [];
         var shenBingAtbLen:int = patch.readByte();
         var i:int = 0;
         i = 0;
         while(i < shenBingAtbLen)
         {
            type = patch.readByte();
            value = patch.readInt();
            def = patch.readInt();
            shenBingAtbs.push(type,value,def);
            i += 1;
         }
         var shenBingSkills:Array = [];
         var shenBingSkillLen:int = patch.readByte();
         i = 0;
         while(i < shenBingSkillLen)
         {
            skillID = patch.readInt();
            shenBingSkills.push(skillID);
            i += 1;
         }
         var shenBingVo:Vo_ShenBingAtb = new Vo_ShenBingAtb();
         shenBingVo.type = shenBingLevel;
         shenBingVo.atbs = shenBingAtbs;
         shenBingVo.skills = shenBingSkills;
         return shenBingVo;
      }
      
      public static function readShuXingDan(patch:IDataInput) : Vo_shuXingDan
      {
         var id:int = 0;
         var used:int = 0;
         var count:int = 0;
         var arr:Array = null;
         var shuXing:int = 0;
         var value:int = 0;
         var tmpArr:Array = null;
         var shuXingDanVo:Vo_shuXingDan = new Vo_shuXingDan();
         var type:int = patch.readByte();
         if(type == 0)
         {
            return shuXingDanVo;
         }
         var shuXingDanCounts:Array = [];
         var shuXingDanCountLen:int = patch.readByte();
         var j:int = 0;
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
         var shuXingDanAtbs:Array = [];
         var shuXingDanAtbLen:int = patch.readByte();
         var i:int = 0;
         i = 0;
         while(i < shuXingDanAtbLen)
         {
            shuXing = patch.readInt();
            value = patch.readInt();
            tmpArr = [];
            tmpArr.push(shuXing,value);
            shuXingDanAtbs.push(tmpArr);
            i++;
         }
         shuXingDanVo.atbs = shuXingDanAtbs;
         shuXingDanVo.count = shuXingDanCounts;
         return shuXingDanVo;
      }
      
      public static function GC_PAIHANG_ZHANLI(patch:IDataInput) : void
      {
         var itemLength:int = 0;
         var itemI:uint = 0;
         var tempArr:Array = null;
         var shenBingVo:Vo_ShenBingAtb = null;
         var shuXingDanVo:Vo_shuXingDan = null;
         var isSpHuang:int = 0;
         var result:int = patch.readByte();
         var phVO:PaiHangVO = new PaiHangVO();
         itemLength = patch.readByte();
         phVO.curPage = patch.readByte();
         phVO.totalPage = patch.readByte();
         phVO.curZhiYeType = patch.readByte();
         phVO.paiHangItemArr = [];
         itemI = 0;
         while(itemI < itemLength)
         {
            tempArr = [];
            tempArr.push(patch.readByte());
            tempArr.push(Model_heFu.repNameByHero(patch.readUTF()));
            tempArr.push(patch.readByte());
            tempArr.push(patch.readUTF());
            tempArr.push(patch.readInt());
            tempArr.push(patch.readInt());
            tempArr.push(readEquipsData(patch));
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(readMarrAssis(patch));
            tempArr.push(readStoneLvl(patch));
            shenBingVo = readShenBing(patch);
            shuXingDanVo = readShuXingDan(patch);
            tempArr.push(getNewData(patch));
            tempArr.push(getRoleAttr(patch));
            isSpHuang = 0;
            if(LZBmp.isUsingSuperHuangZuan)
            {
               isSpHuang = patch.readByte();
            }
            tempArr.push(isSpHuang);
            tempArr.push(shenBingVo);
            tempArr.push(shuXingDanVo);
            phVO.paiHangItemArr.push(tempArr);
            itemI++;
         }
         CGXTestPan._objData = phVO;
         PaiHangHandler.GC_PAIHANG_ZHANLI(result,phVO);
      }
      
      public static function GC_PAIHANG_CAIFU(patch:IDataInput) : void
      {
         var itemLength:int = 0;
         var itemI:uint = 0;
         var tempArr:Array = null;
         var shenBingVo:Vo_ShenBingAtb = null;
         var shuXingDanVo:Vo_shuXingDan = null;
         var isSpHuang:int = 0;
         var result:int = patch.readByte();
         var phVO:PaiHangVO = new PaiHangVO();
         itemLength = patch.readByte();
         phVO.curPage = patch.readByte();
         phVO.totalPage = patch.readByte();
         phVO.paiHangItemArr = [];
         itemI = 0;
         while(itemI < itemLength)
         {
            tempArr = [];
            tempArr.push(patch.readByte());
            tempArr.push(Model_heFu.repNameByHero(patch.readUTF()));
            tempArr.push(patch.readByte());
            tempArr.push(patch.readUTF());
            tempArr.push(patch.readInt());
            tempArr.push(patch.readUTF());
            tempArr.push(readEquipsData(patch));
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(readMarrAssis(patch));
            tempArr.push(readStoneLvl(patch));
            shenBingVo = readShenBing(patch);
            shuXingDanVo = readShuXingDan(patch);
            tempArr.push(getNewData(patch));
            tempArr.push(getRoleAttr(patch));
            isSpHuang = 0;
            if(LZBmp.isUsingSuperHuangZuan)
            {
               isSpHuang = patch.readByte();
            }
            tempArr.push(isSpHuang);
            tempArr.push(shenBingVo);
            tempArr.push(shuXingDanVo);
            phVO.paiHangItemArr.push(tempArr);
            itemI++;
         }
         CGXTestPan._objData = phVO;
         PaiHangHandler.GC_PAIHANG_CAIFU(result,phVO);
      }
      
      public static function GC_PAIHANG_MY(patch:IDataInput) : void
      {
         var itemLength:int = 0;
         var itemI:uint = 0;
         var tempArr:Array = null;
         var isSpHuang:int = 0;
         var sbVo:Vo_ShenBingAtb = null;
         var shuXingDanVo:Vo_shuXingDan = null;
         var result:int = patch.readByte();
         var state:int = patch.readByte();
         if(state == -1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10595",1) + "</font>");
            return;
         }
         var phVO:PaiHangVO = new PaiHangVO();
         phVO.curPaiHangType = patch.readByte();
         itemLength = patch.readByte();
         phVO.curPage = patch.readByte();
         phVO.totalPage = patch.readByte();
         if(phVO.curPaiHangType != 3 && phVO.curPaiHangType != 6 && phVO.curPaiHangType != 7)
         {
            phVO.curZhiYeType = patch.readByte();
         }
         phVO.paiHangItemArr = [];
         itemI = 0;
         while(itemI < itemLength)
         {
            tempArr = [];
            if(phVO.curPaiHangType < 6)
            {
               tempArr.push(patch.readByte());
               tempArr.push(Model_heFu.repNameByHero(patch.readUTF()));
               tempArr.push(patch.readByte());
               tempArr.push(patch.readUTF());
            }
            else if(phVO.curPaiHangType == 6)
            {
               tempArr.push(patch.readByte());
               tempArr.push(Model_heFu.repNameByHero(patch.readUTF()));
               tempArr.push(patch.readShort());
               tempArr.push(patch.readShort());
               tempArr.push(patch.readInt());
            }
            else if(phVO.curPaiHangType == 7)
            {
               tempArr.push(patch.readByte());
               tempArr.push(Model_heFu.repNameByHero(patch.readUTF()));
               tempArr.push(patch.readUTF());
               tempArr.push(patch.readShort());
               tempArr.push(patch.readInt());
            }
            else if(phVO.curPaiHangType == 8 || phVO.curPaiHangType == 9)
            {
               tempArr.push(patch.readByte());
               tempArr.push(Model_heFu.repNameByHero(patch.readUTF()));
               tempArr.push(patch.readByte());
               tempArr.push(patch.readInt());
               tempArr.push(patch.readInt());
               tempArr.push(patch.readInt());
            }
            if(phVO.curPaiHangType == 1)
            {
               tempArr.push(patch.readInt());
            }
            else if(phVO.curPaiHangType == 2)
            {
               tempArr.push(patch.readInt());
               tempArr.push(patch.readInt());
            }
            else if(phVO.curPaiHangType == 3)
            {
               tempArr.push(patch.readInt());
               tempArr.push(patch.readUTF());
            }
            else if(phVO.curPaiHangType == 4)
            {
               tempArr.push(patch.readInt());
               tempArr.push(patch.readInt());
            }
            else if(phVO.curPaiHangType == 5)
            {
               tempArr.push(patch.readInt());
               tempArr.push(patch.readInt());
            }
            if(phVO.curPaiHangType != 6 && phVO.curPaiHangType != 7)
            {
               tempArr.push(readEquipsData(patch));
               tempArr.push(patch.readByte());
            }
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            if(phVO.curPaiHangType != 6 && phVO.curPaiHangType != 7)
            {
               tempArr.push(readMarrAssis(patch));
               tempArr.push(readStoneLvl(patch));
               sbVo = readShenBing(patch);
               shuXingDanVo = readShuXingDan(patch);
               tempArr.push(getNewData(patch));
               tempArr.push(getRoleAttr(patch));
            }
            isSpHuang = 0;
            if(LZBmp.isUsingSuperHuangZuan)
            {
               isSpHuang = patch.readByte();
            }
            tempArr.push(isSpHuang);
            tempArr.push(sbVo);
            tempArr.push(shuXingDanVo);
            phVO.paiHangItemArr.push(tempArr);
            itemI++;
         }
         CGXTestPan._objData = phVO;
         PaiHangHandler.GC_PAIHANG_MY(result,phVO);
      }
      
      public static function GC_CITY_DIAOXIANG(patch:IDataInput) : void
      {
         var a:Array = null;
         var result:int = patch.readByte();
         var itemLen:int = patch.readByte();
         var arr:Array = [];
         var i:uint = 0;
         while(i < itemLen)
         {
            a = [];
            a.push(patch.readByte());
            a.push(LongUtil.readLong(patch));
            a.push(patch.readUTF());
            a.push(patch.readInt());
            a.push(patch.readByte());
            a.push(patch.readByte());
            a.push(patch.readInt());
            a.push(patch.readInt());
            a.push(patch.readInt());
            a.push(patch.readInt());
            a.push(patch.readInt());
            a.push(patch.readUTF());
            a.push(patch.readByte());
            a.push(readEquipsData(patch));
            a.push(readStoneLvl(patch));
            a.push(readMarrAssis(patch));
            arr.push(a);
            i++;
         }
         PaiHangHandler.GC_CITY_DIAOXIANG(result,arr);
      }
      
      public static function GC_PAIHANG_KUNLUN(patch:IDataInput) : void
      {
         var itemLength:int = 0;
         var itemI:uint = 0;
         var tempArr:Array = null;
         var shenBingVo:Vo_ShenBingAtb = null;
         var shuXingDanVo:Vo_shuXingDan = null;
         var isSpHuang:int = 0;
         var result:int = patch.readByte();
         var phVO:PaiHangVO = new PaiHangVO();
         itemLength = patch.readByte();
         phVO.curPage = patch.readByte();
         phVO.totalPage = patch.readByte();
         phVO.curZhiYeType = patch.readByte();
         phVO.paiHangItemArr = [];
         itemI = 0;
         while(itemI < itemLength)
         {
            tempArr = [];
            tempArr.push(patch.readByte());
            tempArr.push(Model_heFu.repNameByHero(patch.readUTF()));
            tempArr.push(patch.readByte());
            tempArr.push(patch.readUTF());
            tempArr.push(patch.readInt());
            tempArr.push(patch.readInt());
            tempArr.push(readEquipsData(patch));
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(readMarrAssis(patch));
            tempArr.push(readStoneLvl(patch));
            shenBingVo = readShenBing(patch);
            shuXingDanVo = readShuXingDan(patch);
            tempArr.push(getNewData(patch));
            tempArr.push(getRoleAttr(patch));
            isSpHuang = 0;
            if(LZBmp.isUsingSuperHuangZuan)
            {
               isSpHuang = patch.readByte();
            }
            tempArr.push(isSpHuang);
            tempArr.push(shenBingVo);
            tempArr.push(shuXingDanVo);
            phVO.paiHangItemArr.push(tempArr);
            itemI++;
         }
         CGXTestPan._objData = phVO;
         PaiHangHandler.GC_PAIHANG_KUNLUN(result,phVO);
      }
      
      public static function GC_PAIHANG_WULINDAHUI(patch:IDataInput) : void
      {
         var itemLength:int = 0;
         var itemI:uint = 0;
         var tempArr:Array = null;
         var shenBingVo:Vo_ShenBingAtb = null;
         var isSpHuang:int = 0;
         var result:int = patch.readByte();
         var phVO:PaiHangVO = new PaiHangVO();
         itemLength = patch.readByte();
         phVO.curPage = patch.readByte();
         phVO.totalPage = patch.readByte();
         phVO.curZhiYeType = patch.readByte();
         phVO.paiHangItemArr = [];
         itemI = 0;
         while(itemI < itemLength)
         {
            tempArr = [];
            tempArr.push(patch.readByte());
            tempArr.push(Model_heFu.repNameByHero(patch.readUTF()));
            tempArr.push(patch.readByte());
            tempArr.push(patch.readUTF());
            tempArr.push(patch.readInt());
            tempArr.push(patch.readInt());
            tempArr.push(readEquipsData(patch));
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(readMarrAssis(patch));
            tempArr.push(readStoneLvl(patch));
            shenBingVo = readShenBing(patch);
            tempArr.push(getNewData(patch));
            tempArr.push(getRoleAttr(patch));
            isSpHuang = 0;
            if(LZBmp.isUsingSuperHuangZuan)
            {
               isSpHuang = patch.readByte();
            }
            tempArr.push(isSpHuang);
            tempArr.push(shenBingVo);
            phVO.paiHangItemArr.push(tempArr);
            itemI++;
         }
         CGXTestPan._objData = phVO;
         PaiHangHandler.GC_PAIHANG_WULINDAHUI(result,phVO);
      }
      
      public static function GC_PAIHANG_PET(patch:IDataInput) : void
      {
         var len:int = 0;
         var i:uint = 0;
         var tempArr:Array = null;
         var isSpHuang:int = 0;
         var result:int = patch.readByte();
         var phVO:PaiHangVO = new PaiHangVO();
         len = patch.readByte();
         phVO.curPage = patch.readByte();
         phVO.totalPage = patch.readByte();
         phVO.paiHangItemArr = [];
         i = 0;
         while(i < len)
         {
            tempArr = [];
            tempArr.push(patch.readByte());
            tempArr.push(Model_heFu.repNameByHero(patch.readUTF()));
            tempArr.push(patch.readShort());
            tempArr.push(patch.readShort());
            tempArr.push(patch.readInt());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            isSpHuang = 0;
            if(LZBmp.isUsingSuperHuangZuan)
            {
               isSpHuang = patch.readByte();
            }
            tempArr.push(isSpHuang);
            phVO.paiHangItemArr.push(tempArr);
            i++;
         }
         CGXTestPan._objData = phVO;
         PaiHangHandler.GC_PAIHANG_PET(result,phVO);
      }
      
      public static function GC_PAIHANG_BANGHUI(patch:IDataInput) : void
      {
         var len:int = 0;
         var i:uint = 0;
         var tempArr:Array = null;
         var isSpHuang:int = 0;
         var result:int = patch.readByte();
         var phVO:PaiHangVO = new PaiHangVO();
         len = patch.readByte();
         phVO.curPage = patch.readByte();
         phVO.totalPage = patch.readByte();
         phVO.paiHangItemArr = [];
         i = 0;
         while(i < len)
         {
            tempArr = [];
            tempArr.push(patch.readByte());
            tempArr.push(Model_heFu.repNameByHero(patch.readUTF()));
            tempArr.push(patch.readUTF());
            tempArr.push(patch.readShort());
            tempArr.push(patch.readInt());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            isSpHuang = 0;
            if(LZBmp.isUsingSuperHuangZuan)
            {
               isSpHuang = patch.readByte();
            }
            tempArr.push(isSpHuang);
            phVO.paiHangItemArr.push(tempArr);
            i++;
         }
         CGXTestPan._objData = phVO;
         PaiHangHandler.GC_PAIHANG_BANGHUI(result,phVO);
      }
      
      public static function GC_PAIHANG_MEILI(patch:IDataInput) : void
      {
         var itemLength:int = 0;
         var itemI:uint = 0;
         var tempArr:Array = null;
         var shenBingVo:Vo_ShenBingAtb = null;
         var shuXingDanVo:Vo_shuXingDan = null;
         var isSpHuang:int = 0;
         var result:int = patch.readByte();
         var phVO:PaiHangVO = new PaiHangVO();
         itemLength = patch.readByte();
         phVO.curPage = patch.readByte();
         phVO.totalPage = patch.readByte();
         phVO.curZhiYeType = patch.readByte();
         phVO.paiHangItemArr = [];
         itemI = 0;
         while(itemI < itemLength)
         {
            tempArr = [];
            tempArr.push(patch.readByte());
            tempArr.push(Model_heFu.repNameByHero(patch.readUTF()));
            tempArr.push(patch.readByte());
            tempArr.push(patch.readInt());
            tempArr.push(patch.readInt());
            tempArr.push(patch.readInt());
            tempArr.push(readEquipsData(patch));
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(readMarrAssis(patch));
            tempArr.push(readStoneLvl(patch));
            shenBingVo = readShenBing(patch);
            shuXingDanVo = readShuXingDan(patch);
            tempArr.push(getNewData(patch));
            tempArr.push(getRoleAttr(patch));
            isSpHuang = 0;
            if(LZBmp.isUsingSuperHuangZuan)
            {
               isSpHuang = patch.readByte();
            }
            tempArr.push(isSpHuang);
            tempArr.push(shenBingVo);
            tempArr.push(shuXingDanVo);
            phVO.paiHangItemArr.push(tempArr);
            itemI++;
         }
         CGXTestPan._objData = phVO;
         PaiHangHandler.GC_PAIHANG_MEILI(result,phVO);
      }
      
      public static function GC_PAIHANG_FLOWERS(patch:IDataInput) : void
      {
         var itemLength:int = 0;
         var itemI:uint = 0;
         var tempArr:Array = null;
         var shenBingVo:Vo_ShenBingAtb = null;
         var shuXingDanVo:Vo_shuXingDan = null;
         var isSpHuang:int = 0;
         var result:int = patch.readByte();
         var phVO:PaiHangVO = new PaiHangVO();
         itemLength = patch.readByte();
         phVO.curPage = patch.readByte();
         phVO.totalPage = patch.readByte();
         phVO.curZhiYeType = patch.readByte();
         phVO.paiHangItemArr = [];
         itemI = 0;
         while(itemI < itemLength)
         {
            tempArr = [];
            tempArr.push(patch.readByte());
            tempArr.push(Model_heFu.repNameByHero(patch.readUTF()));
            tempArr.push(patch.readByte());
            tempArr.push(patch.readInt());
            tempArr.push(patch.readInt());
            tempArr.push(patch.readInt());
            tempArr.push(readEquipsData(patch));
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(patch.readByte());
            tempArr.push(readMarrAssis(patch));
            tempArr.push(readStoneLvl(patch));
            shenBingVo = readShenBing(patch);
            shuXingDanVo = readShuXingDan(patch);
            tempArr.push(getNewData(patch));
            tempArr.push(getRoleAttr(patch));
            isSpHuang = 0;
            if(LZBmp.isUsingSuperHuangZuan)
            {
               isSpHuang = patch.readByte();
            }
            tempArr.push(isSpHuang);
            tempArr.push(shenBingVo);
            tempArr.push(shuXingDanVo);
            phVO.paiHangItemArr.push(tempArr);
            itemI++;
         }
         CGXTestPan._objData = phVO;
         PaiHangHandler.GC_PAIHANG_FLOWERS(result,phVO);
      }
      
      public static function GC_KUAFU_FLOWERS(patch:IDataInput) : void
      {
         var len:int;
         var i:int;
         var isLastWeek:int = 0;
         var vo:FlowerVO = null;
         Model_KuaFuFlower.manArr.length = 0;
         Model_KuaFuFlower.womanArr.length = 0;
         isLastWeek = patch.readByte();
         len = patch.readInt();
         i = 0;
         while(i < len)
         {
            vo = new FlowerVO();
            vo.index = patch.readByte();
            vo.Roleid = LongUtil.readLong(patch);
            vo.Rolename = Model_heFu.repNameByHero(patch.readUTF());
            vo.job = patch.readByte();
            vo.sex = patch.readByte();
            vo.num = patch.readInt();
            vo.model = patch.readInt();
            if(vo.sex == 1)
            {
               Model_KuaFuFlower.manArr.push(vo);
            }
            else if(vo.sex == 2)
            {
               Model_KuaFuFlower.womanArr.push(vo);
            }
            i++;
         }
         Model_KuaFuFlower.manArr.sort(function(a:FlowerVO, b:FlowerVO):Number
         {
            return a.index - b.index;
         });
         Model_KuaFuFlower.womanArr.sort(function(a:FlowerVO, b:FlowerVO):Number
         {
            return a.index - b.index;
         });
         Global.delegate.dosomething(KuaFuMeiLiPanel.instance,function():void
         {
            KuaFuMeiLiPanel.instance.isLastWeek = isLastWeek;
            KuaFuMeiLiPanel.instance.manWomenChoose = KuaFuMeiLiPanel.nowChooseSex;
         });
      }
      
      public static function GC_OTHERROLE_SHENBINGINFO(patch:IDataInput) : void
      {
         var shenBingVo:Vo_ShenBingAtb = null;
         shenBingVo = readShenBing(patch);
         var type:int = patch.readByte();
         if(type == 1)
         {
            WuXingMter.getPan(ComparePan,function(pan:ComparePan):void
            {
               pan.updateShenBing(shenBingVo);
            });
         }
      }
      
      public static function GC_ASK_SHUXINGDANINFO(patch:IDataInput) : void
      {
         var shuXingDanVo:Vo_shuXingDan = null;
         shuXingDanVo = readShuXingDan(patch);
         WuXingMter.getPan(ComparePan,function(pan:ComparePan):void
         {
            pan.updateShuXingDan(shuXingDanVo);
         });
      }
      
      public static function GC_ENOUGH_SHUXINGDSN(patch:IDataInput) : void
      {
         var id:int = patch.readInt();
         var str:String = "使用" + Data_lib.item[id][1] + "不能超过" + Data_lib.shuXingDan[1][Enum_shuXingDan.MAX_COUNST] + "个";
         UIManager.centerBroadcast.addMsg(str);
      }
      
      private static function readEquipsData(patch:IDataInput) : Array
      {
         var i:uint = 0;
         var j:uint = 0;
         var len:int = 0;
         var array_EQUIP:Array = null;
         var temp_basic:Array = null;
         var temp_intensify:Array = null;
         var temp_extra:Array = null;
         var temp_stoneId:Array = null;
         var extra_polish:String = null;
         var isGrey:int = 0;
         var skillId:int = 0;
         var skillGrade:int = 0;
         var jingLianCount:int = 0;
         var czLen:int = 0;
         var temp_jingLian_arr:Array = null;
         var len_equips:int = patch.readByte();
         var equips:Array = [];
         i = 0;
         while(i < len_equips)
         {
            array_EQUIP = [];
            array_EQUIP.push(LongUtil.readLong(patch));
            array_EQUIP.push(patch.readInt());
            array_EQUIP.push(patch.readShort());
            array_EQUIP.push(patch.readByte());
            array_EQUIP.push(patch.readByte());
            array_EQUIP.push(patch.readByte());
            array_EQUIP.push(patch.readByte());
            array_EQUIP.push(patch.readInt());
            array_EQUIP.push(patch.readByte());
            array_EQUIP.push(patch.readInt());
            array_EQUIP.push(patch.readShort());
            len = patch.readByte();
            temp_basic = [];
            j = 0;
            while(j < len)
            {
               temp_basic.push(patch.readByte());
               temp_basic.push(patch.readInt());
               temp_basic.push(patch.readInt());
               j++;
            }
            array_EQUIP.push(temp_basic);
            len = patch.readByte();
            temp_intensify = [];
            j = 0;
            while(j < len)
            {
               temp_intensify.push(patch.readByte());
               temp_intensify.push(patch.readInt());
               j++;
            }
            array_EQUIP.push(temp_intensify);
            len = patch.readByte();
            temp_extra = [];
            j = 0;
            while(j < len)
            {
               temp_extra.push(patch.readByte());
               temp_extra.push(patch.readInt());
               temp_extra.push(patch.readByte());
               temp_extra.push(patch.readInt());
               j++;
            }
            array_EQUIP.push(temp_extra);
            len = patch.readByte();
            temp_stoneId = [];
            j = 0;
            while(j < len)
            {
               temp_stoneId.push(patch.readInt());
               j++;
            }
            array_EQUIP.push(temp_stoneId);
            extra_polish = patch.readUTF();
            array_EQUIP.push(extra_polish);
            isGrey = patch.readByte();
            skillId = patch.readInt();
            skillGrade = patch.readByte();
            jingLianCount = patch.readByte();
            array_EQUIP.push(isGrey);
            array_EQUIP.push(skillId);
            array_EQUIP.push(skillGrade);
            array_EQUIP.push(jingLianCount);
            czLen = patch.readByte();
            temp_jingLian_arr = [];
            j = 0;
            while(j < czLen)
            {
               temp_jingLian_arr.push(patch.readByte());
               temp_jingLian_arr.push(patch.readInt());
               j++;
            }
            array_EQUIP.push(temp_jingLian_arr);
            array_EQUIP.push(patch.readInt());
            array_EQUIP.push(patch.readByte());
            array_EQUIP.push(patch.readByte());
            array_EQUIP.push(patch.readByte());
            array_EQUIP.push(patch.readByte());
            equips.push(array_EQUIP);
            i++;
         }
         return equips;
      }
      
      public static function readStoneLvl(patch:IDataInput) : int
      {
         return Boolean(patch.bytesAvailable) ? patch.readByte() : 1;
      }
      
      private static function readMarrAssis(patch:IDataInput) : Array
      {
         var arr:Array = [];
         arr.push(patch.readInt());
         arr.push(patch.readInt());
         arr.push(patch.readUTF());
         return arr;
      }
   }
}

