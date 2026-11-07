package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.config.Enum_BytesReadTypes;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_TianMing;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.RoleHandler;
   import com.yiTian.net.handler.TianMingHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.PatchReader;
   import com.yiTian.view.modules.newRolePan.ComparePan;
   import com.yiTian.view.modules.newRolePan.RoleMter;
   import com.yiTian.view.modules.paihang.PaiHangPanel;
   import com.yiTian.view.modules.paihang.PaiHangVO;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.utils.IDataInput;
   
   public class RoleGCMessage
   {
      
      private static const COUNT_MERIDIAN:int = 6;
      
      private var i:int;
      
      private var j:int;
      
      public function RoleGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ROLE_PANEL_UPDATE] = this.GC_ROLE_PANEL_UPDATE;
         index[MessageType.GC_ROLE_PANEL_EMPTY] = this.GC_ROLE_PANEL_EMPTY;
         index[MessageType.GC_MERIDIAN_INIT] = this.GC_MERIDIAN_INIT;
         index[MessageType.GC_MERIDIAN_UP] = this.GC_MERIDIAN_UP;
         index[MessageType.GC_MERIDIAN_PILL] = this.GC_MERIDIAN_PILL;
         index[MessageType.GC_STRENGTHEN_SET] = GC_STRENGTHEN_SET;
         index[MessageType.GC_CHECK_OTHERROLE] = this.GC_CHECK_OTHERROLE;
         index[MessageType.GC_BUTTON_CBBS] = this.GC_BUTTON_CBBS;
         index[MessageType.GC_YES_CBBS] = this.GC_YES_CBBS;
         index[MessageType.GC_CB_VALUE] = this.GC_CB_VALUE;
         index[MessageType.GC_PAIHANG_CLICK] = this.GC_PAIHANG_CLICK;
         index[MessageType.GC_PAIHANG_VALUE] = this.GC_PAIHANG_VALUE;
         index[MessageType.GC_ROLE_FASHION] = GC_ROLE_FASHION;
         index[MessageType.GC_LIGHT_FASHION] = GC_LIGHT_FASHION;
         index[MessageType.GC_CHECK_OTHER_NEW] = this.GC_CHECK_OTHER_NEW;
      }
      
      public static function GC_STRENGTHEN_SET(patch:IDataInput) : void
      {
         var level:int = 0;
         var nums:int = 0;
         var levelTen:int = patch.readByte();
         var levelSix:int = patch.readByte();
         var levelSixNums:int = patch.readByte();
         if(levelTen == 0 && levelSix == 0)
         {
            level = patch.readByte();
            nums = patch.readByte();
            RoleHandler.GC_STRENGTHEN_SET(levelTen,levelSix,levelSixNums,level,nums);
         }
         else
         {
            RoleHandler.GC_STRENGTHEN_SET(levelTen,levelSix,levelSixNums,0,0);
         }
      }
      
      public static function GC_ROLE_FASHION(patch:IDataInput) : void
      {
         var l:int = patch.readByte();
         var enabledInfos:Array = [];
         var i:int = 0;
         while(i < l)
         {
            enabledInfos.push(patch.readByte());
            i += 1;
         }
         var atbs:Array = [];
         i = 0;
         while(i < 3)
         {
            atbs[i] = patch.readInt();
            i += 1;
         }
         RoleHandler.GC_ROLE_FASHION(enabledInfos,atbs);
      }
      
      public static function GC_LIGHT_FASHION(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var result:int = patch.readByte();
         RoleHandler.GC_LIGHT_FASHION(result,type);
      }
      
      public function GC_MERIDIAN_INIT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var vec:Vector.<int> = new Vector.<int>(COUNT_MERIDIAN,true);
         this.i = 0;
         while(this.i < COUNT_MERIDIAN)
         {
            vec[this.i] = patch.readInt();
            ++this.i;
         }
         RoleHandler.GC_MERIDIAN_INIT(result,vec);
      }
      
      public function GC_MERIDIAN_UP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var meridianID:int = patch.readInt();
         RoleHandler.GC_MERIDIAN_UP(result,meridianID);
      }
      
      public function GC_MERIDIAN_PILL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         RoleHandler.GC_MERIDIAN_PILL(result);
      }
      
      public function GC_ROLE_PANEL_EMPTY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var gridId:int = patch.readByte();
         RoleHandler.GC_ROLE_PANEL_EMPTY(result,gridId);
      }
      
      public function GC_ROLE_PANEL_UPDATE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var equips:Array = PatchReader.instance.readPatch(Enum_BytesReadTypes.ROLEEQUIPS2,patch)[0];
         RoleHandler.GC_ROLE_PANEL_UPDATE(result,equips);
      }
      
      public function GC_CHECK_OTHERROLE(patch:IDataInput) : void
      {
         var i:int = 0;
         var type:int = 0;
         var value:int = 0;
         var def:int = 0;
         var skillID:int = 0;
         var shuXingDanCountLen:int = 0;
         var j:int = 0;
         var shuXingDanAtbLen:int = 0;
         var ii:int = 0;
         var id:int = 0;
         var used:int = 0;
         var count:int = 0;
         var arr:Array = null;
         var shuXing:int = 0;
         var value1:int = 0;
         var tmpArr:Array = null;
         var sId:int = 0;
         var sWorth:int = 0;
         var leiJiWorth:int = 0;
         var result:int = patch.readByte();
         var roleId:Number = LongUtil.readLong(patch);
         var roleName:String = Model_heFu.repNameByHero(patch.readUTF());
         var roleLevel:int = patch.readShort();
         var roleJob:int = patch.readByte();
         var roleSex:int = patch.readByte();
         var rolePartyName:String = patch.readUTF();
         var roleShengWang:int = patch.readInt();
         var strength:int = patch.readInt();
         var physAtt:int = patch.readInt();
         var physDef:int = patch.readInt();
         var shot:int = patch.readInt();
         var escape:int = patch.readInt();
         var critical:int = patch.readInt();
         var critHeat:int = patch.readInt();
         var repel:int = patch.readInt();
         var attSpeed:int = patch.readInt();
         var vipLevel:int = patch.readByte();
         var hp:int = patch.readInt();
         var maxHp:int = patch.readInt();
         var mp:int = patch.readInt();
         var maxMp:int = patch.readInt();
         var tili:int = patch.readShort();
         var appellation:String = patch.readUTF();
         var equips:Array = PatchReader.instance.readPatch(Enum_BytesReadTypes.PATA_ROLEEQUIPS,patch)[0];
         var ringId:int = patch.readInt();
         var qinmiDu:int = patch.readInt();
         var cpl_otherName:String = patch.readUTF();
         var stoneLvl:int = patch.readByte();
         var shenBingLevel:int = patch.readByte();
         var shenBingAtbs:Array = [];
         var shenBingAtbLen:int = patch.readByte();
         i = 0;
         while(i < shenBingAtbLen)
         {
            type = patch.readByte();
            value = patch.readInt();
            def = patch.readInt();
            shenBingAtbs.push(type,value);
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
         var type1:int = patch.readByte();
         var shuXingDanAtbs:Array = [];
         var shuXingDanCounts:Array = [];
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
            ii = 0;
            ii = 0;
            while(ii < shuXingDanAtbLen)
            {
               shuXing = patch.readInt();
               value1 = patch.readInt();
               tmpArr = [];
               tmpArr.push(shuXing,value);
               shuXingDanAtbs.push(tmpArr);
               ii++;
            }
         }
         else if(type == 0)
         {
            trace("没有使用过属性丹");
         }
         var isOnLine:int = patch.readByte();
         var voVec:Vector.<Array> = TianMingHandler.makeVoArray(patch);
         this.updateTianMingHd(voVec);
         var levelTen:int = patch.readByte();
         var levelSix:int = patch.readByte();
         var levelSixNums:int = patch.readByte();
         var level:int = patch.readByte();
         var nums:int = patch.readByte();
         if(levelTen == 0 && levelSix == 0)
         {
         }
         var vec:Vector.<int> = new Vector.<int>(COUNT_MERIDIAN,true);
         i = 0;
         while(i < COUNT_MERIDIAN)
         {
            vec[i] = patch.readInt();
            i++;
         }
         var body:int = patch.readInt();
         var weapon:int = patch.readInt();
         var horse:int = patch.readInt();
         var wing:int = patch.readInt();
         var len:int = patch.readByte();
         var dataArr:Array = [];
         i = 0;
         while(i < len)
         {
            sId = patch.readInt();
            sWorth = patch.readInt();
            leiJiWorth = patch.readInt();
            dataArr.push([sId,sWorth,leiJiWorth]);
            i++;
         }
         var chengHao:int = patch.readByte();
         var extralData:Array = PaiHangGCMessage.getRoleAttr(patch);
         roleShengWang = int(extralData[0]);
         tili = int(extralData[1]);
         maxHp = int(extralData[2]);
         maxMp = int(extralData[3]);
         physAtt = int(extralData[4]);
         physDef = int(extralData[5]);
         shot = int(extralData[6]);
         escape = int(extralData[7]);
         critical = int(extralData[8]);
         repel = int(extralData[9]);
         attSpeed = int(extralData[10]);
         critHeat = int(extralData[11]);
         strength = int(extralData[12]);
         roleId = Number(extralData[13]);
         rolePartyName = extralData[14];
         RoleHandler.GC_CHECK_OTHERROLE(roleId,roleName,roleLevel,roleJob,roleSex,rolePartyName,roleShengWang,strength,physAtt,physDef,shot,escape,critical,critHeat,repel,attSpeed,vipLevel,hp,maxHp,mp,maxMp,tili,appellation,equips,ringId,qinmiDu,stoneLvl,isOnLine,voVec,levelTen,levelSix,levelSixNums,level,nums,vec,body,weapon,horse,dataArr,chengHao,shenBingLevel,shenBingAtbs,shenBingSkills,shuXingDanCounts,shuXingDanAtbs,cpl_otherName,wing);
      }
      
      private function updateTianMingHd(source:Vector.<Array>) : void
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
         RoleMter.tianMingDataVecOther = dataVec;
      }
      
      public function GC_BUTTON_CBBS(patch:IDataInput) : void
      {
         PaiHangVO.id = LongUtil.readLong(patch);
         PaiHangVO.CBvalue = patch.readInt();
         PaiHangVO.BSvalue = patch.readInt();
         PaiHangVO.isButton = patch.readByte();
         PaiHangVO.zhanLi = patch.readInt();
         PaiHangVO.bangPai = patch.readUTF();
         PaiHangVO.wuHun = patch.readByte();
         PaiHangVO.index = patch.readInt();
         WuXingMter.getPan(ComparePan,function(pan:ComparePan):void
         {
            pan.updateCBBS(PaiHangVO.CBvalue,PaiHangVO.BSvalue,PaiHangVO.isButton,PaiHangVO.index);
         });
      }
      
      public function GC_YES_CBBS(patch:IDataInput) : void
      {
         PaiHangVO.type = patch.readByte();
         UIManager.heroInfoPanel.open();
         UIManager.heroInfoPanel.update();
      }
      
      public function GC_CB_VALUE(patch:IDataInput) : void
      {
         var RoleId:Number = LongUtil.readLong(patch);
         var CBvalue:int = patch.readInt();
         var CBname:String = patch.readUTF();
         var CBorBS:int = patch.readByte();
         PaiHangPanel.GC_JIANGHU_CHUANWEN(CBvalue,CBname,RoleId,CBorBS);
      }
      
      public function GC_PAIHANG_CLICK(patch:IDataInput) : void
      {
         PaiHangVO.id = LongUtil.readLong(patch);
         PaiHangVO.CBvalue = patch.readInt();
         PaiHangVO.BSvalue = patch.readInt();
         PaiHangVO.isButton = patch.readByte();
         PaiHangVO.zhanLi = patch.readInt();
         PaiHangVO.bangPai = patch.readUTF();
         PaiHangVO.wuHun = patch.readByte();
         PaiHangVO.index = patch.readInt();
         UIManager.paiHangPanel.open();
      }
      
      public function GC_PAIHANG_VALUE(patch:IDataInput) : void
      {
         PaiHangVO.isButton = patch.readByte();
         UIManager.paiHangPanel.open();
         UIManager.paiHangPanel.isBtn();
      }
      
      public function GC_CHECK_OTHER_NEW(patch:IDataInput) : void
      {
         var _arr1:Array = null;
         var _arr2:Array = null;
         _arr1 = PaiHangGCMessage.getNewData(patch);
         _arr2 = PaiHangGCMessage.getRoleAttr(patch);
         WuXingMter.getPan(ComparePan,function(pan:ComparePan):void
         {
            pan.addMess(_arr1,_arr2);
         });
      }
   }
}

