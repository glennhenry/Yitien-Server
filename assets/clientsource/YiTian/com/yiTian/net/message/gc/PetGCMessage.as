package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.vo.Vo_petEquip;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.PetHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.cast.CastEffect;
   import com.yiTian.view.modules.pet.HuaXingJingXiuVO;
   import com.yiTian.view.modules.pet.LianHuaPanel;
   import com.yiTian.view.modules.pet.NeiDanPanel;
   import com.yiTian.view.modules.pet.NeiDanVO;
   import com.yiTian.view.modules.pet.PetEffect;
   import com.yiTian.view.modules.pet.PetPanel;
   import com.yiTian.view.modules.pet.PetVO;
   import com.yiTian.view.modules.pet.PetzbVO;
   import com.yiTian.view.modules.pet.ZDJingXiu;
   import com.yiTian.view.modules.pet.ZhuangBeiPanel;
   import flash.utils.IDataInput;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class PetGCMessage
   {
      
      private static var _level:int;
      
      private static var arr:Array = ["等级不足","材料不足","突破失败，增加下次成功率2%","突破成功!"];
      
      public function PetGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_PET] = GC_PET;
         index[MessageType.GC_PET_JIEDAN] = GC_PET_JIEDAN;
         index[MessageType.GC_PET_XIZI] = GC_PET_XIZI;
         index[MessageType.GC_PET_LIANHUA] = GC_PET_LIANHUA;
         index[MessageType.GC_PET_OTHER_INFO] = GC_PET_OTHER_INFO;
         index[MessageType.GC_PET_XILIAN] = GC_PET_XILIAN;
         index[MessageType.GC_PET_JINGNENG_XILIAN] = GC_PET_JINGNENG_XILIAN;
         index[MessageType.GC_PET_JINGNENG_CHANGE] = GC_PET_JINGNENG_CHANGE;
         index[MessageType.GC_PET_BIANSHENGKA] = GC_PET_BIANSHENGKA;
         index[MessageType.GC_PET_YELLOWDIAMOND] = GC_PET_YELLOWDIAMOND;
         index[MessageType.GC_PET_YELLOWDIAMOND_AWARD] = GC_PET_YELLOWDIAMOND_AWARD;
         index[MessageType.GC_PET_SHOW_FASHION] = GC_PET_SHOW_FASHION;
         index[MessageType.GC_OPEN_JINGXIU] = GC_OPEN_JINGXIU;
         index[MessageType.GC_BT_JINGXIU] = GC_BT_JINGXIU;
         index[MessageType.GC_BT_HUAXING] = GC_BT_HUAXING;
         index[MessageType.GC_PET_YUANXING] = GC_PET_YUANXING;
         index[MessageType.GC_PET_ZHUANGBEI] = GC_PET_ZHUANGBEI;
         index[MessageType.GC_PET_QIANGHUA] = GC_PET_QIANGHUA;
         index[MessageType.GC_PET_SHENGJIE] = GC_PET_SHENGJIE;
         index[MessageType.GC_ChongWuJinJie] = this.GC_ChongWuJinJie;
         index[MessageType.GC_PET_TYPE_SEND] = this.GC_PET_TYPE_SEND;
         index[MessageType.GC_PET_RATE_RESET] = this.GC_PET_RATE_RESET;
         index[MessageType.GC_PET_TUPO] = this.GC_PET_TUPO;
         index[MessageType.GC_XISUI_BACK] = this.GC_XISUI_BACK;
         index[MessageType.GC_PET_DANQI_ICON] = this.GC_PET_DANQI_ICON;
         index[MessageType.GC_PET_SURE_NEIDAN_JINJIE] = this.GC_PET_SURE_NEIDAN_JINJIE;
      }
      
      public static function GC_PET(patch:IDataInput) : void
      {
         var petVO:PetVO = null;
         var i:uint = 0;
         var neiDanVO:NeiDanVO = null;
         var temp:Array = null;
         var result:int = patch.readByte();
         if(result == 1)
         {
            petVO = new PetVO();
            petVO.id = LongUtil.readLong(patch);
            petVO.name = patch.readUTF();
            petVO.level = patch.readInt();
            _level = petVO.level;
            petVO.img = patch.readInt();
            petVO.curQiXue = patch.readInt();
            petVO.maxQiXue = patch.readInt();
            petVO.gongJi = patch.readInt();
            petVO.fangYu = patch.readInt();
            petVO.mingZhong = patch.readInt();
            petVO.shanBi = patch.readInt();
            petVO.baoJi = patch.readInt();
            petVO.suDu = patch.readInt();
            petVO.curJiangYan = patch.readUTF();
            petVO.maxJiangYan = LongUtil.readLong(patch);
            petVO.ziZhi = patch.readInt();
            petVO.chengZhang = patch.readInt();
            petVO.jiNengArr = [];
            i = 0;
            while(i < 8)
            {
               petVO.jiNengArr.push(patch.readInt());
               i++;
            }
            trace(petVO.jiNengArr);
            neiDanVO = new NeiDanVO();
            neiDanVO.listArr = [];
            i = 0;
            while(i < 4)
            {
               temp = [];
               temp[0] = patch.readInt();
               temp[1] = patch.readInt();
               neiDanVO.listArr.push(temp);
               i++;
            }
            neiDanVO.listArr.pop();
            neiDanVO.listArr.push(neiDanVO.listArr.shift());
            petVO.neiDanVO = neiDanVO;
            petVO.bianshenka = patch.readInt();
            petVO.CZLevel = patch.readByte();
            petVO.maxChengZhang = patch.readInt();
            petVO.zhanLi = patch.readInt();
            petVO.yuanXing = patch.readByte();
            petVO.hxjx = patch.readByte();
            petVO.jingNeng9 = patch.readInt();
            petVO.jingNeng10 = patch.readInt();
            petVO.isHzLz = patch.readByte();
            petVO.succRate = patch.readInt();
            petVO.isTuPo = patch.readByte();
            PetHandler.GC_PET(result,petVO);
            if(petVO.CZLevel >= 20 && petVO.isTuPo == 0)
            {
               LianHuaPanel.instance.tuPoShow();
            }
         }
         if(NeiDanVO.isTunShi)
         {
            PetHandler.GC_PET_JIEDAN(0);
            NeiDanVO.isTunShi = false;
         }
      }
      
      public static function GC_PET_JIEDAN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         PetHandler.GC_PET_JIEDAN(result);
      }
      
      public static function GC_PET_XIZI(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         PetHandler.GC_PET_XIZI(result);
      }
      
      public static function GC_PET_LIANHUA(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         PetHandler.GC_PET_LIANHUA(result);
      }
      
      public static function GC_PET_OTHER_INFO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var petVO:PetVO = new PetVO();
         petVO.id = LongUtil.readLong(patch);
         petVO.name = patch.readUTF();
         petVO.level = patch.readInt();
         petVO.img = patch.readInt();
         petVO.maxQiXue = patch.readInt();
         petVO.gongJi = patch.readInt();
         petVO.fangYu = patch.readInt();
         petVO.mingZhong = patch.readInt();
         petVO.shanBi = patch.readInt();
         petVO.baoJi = patch.readInt();
         petVO.suDu = patch.readInt();
         petVO.ziZhi = patch.readInt();
         petVO.CZLevel = patch.readByte();
         var jinengLen:int = patch.readInt();
         petVO.jiNengArr = [];
         var i:uint = 0;
         while(i < jinengLen)
         {
            petVO.jiNengArr.push(patch.readInt());
            i++;
         }
         petVO.zhanLi = patch.readInt();
         PetHandler.GC_PET_OTHER_INFO(result,petVO);
      }
      
      public static function GC_PET_XILIAN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var freeTimes:int = patch.readByte();
         var len:int = 6;
         var data:Array = [];
         while(Boolean(len--))
         {
            data.push(patch.readInt());
         }
         var index:int = patch.readByte();
         var tiems:int = patch.readInt();
         PetHandler.GC_PET_XILIAN(result,freeTimes,data,tiems,index);
      }
      
      public static function GC_PET_JINGNENG_XILIAN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var freeTimes:int = patch.readByte();
         var len:int = 6;
         var data:Array = [];
         while(Boolean(len--))
         {
            data.push(patch.readInt());
         }
         var index:int = patch.readByte();
         var times:int = patch.readInt();
         PetHandler.GC_PET_JINGNENG_XILIAN(result,data,freeTimes,index,times);
      }
      
      public static function GC_PET_JINGNENG_CHANGE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         PetHandler.GC_PET_JINGNENG_CHANGE(result);
      }
      
      public static function GC_PET_BIANSHENGKA(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         PetHandler.GC_PET_BIANSHENGKA(result);
      }
      
      public static function GC_PET_YELLOWDIAMOND(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         PetHandler.GC_PET_YELLOWDIAMOND(result);
      }
      
      public static function GC_PET_YELLOWDIAMOND_AWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         PetHandler.GC_PET_YELLOWDIAMOND_AWARD(result);
      }
      
      public static function GC_PET_SHOW_FASHION(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         PetHandler.GC_PET_SHOW_FASHION(result);
      }
      
      public static function GC_OPEN_JINGXIU(patch:IDataInput) : void
      {
         HuaXingJingXiuVO.jingjie = patch.readInt();
         HuaXingJingXiuVO.Jx_hp = patch.readInt();
         HuaXingJingXiuVO.Jx_att = patch.readInt();
         HuaXingJingXiuVO.Jx_def = patch.readInt();
         HuaXingJingXiuVO.Jx_hp_value = patch.readInt();
         HuaXingJingXiuVO.Jx_att_value = patch.readInt();
         HuaXingJingXiuVO.Jx_def_value = patch.readInt();
         HuaXingJingXiuVO.getHuaxing = patch.readByte();
         HuaXingJingXiuVO.index = patch.readByte();
         HuaXingJingXiuVO.isyellow = patch.readByte();
         UIManager.jingxiu.updata();
         UIManager.jingxiu.OpenJingXiu();
      }
      
      public static function GC_BT_JINGXIU(patch:IDataInput) : void
      {
         var index:int = 0;
         var index2:int = 0;
         HuaXingJingXiuVO.jingjie = patch.readInt();
         HuaXingJingXiuVO.Jx_hp = patch.readInt();
         HuaXingJingXiuVO.Jx_att = patch.readInt();
         HuaXingJingXiuVO.Jx_def = patch.readInt();
         HuaXingJingXiuVO.Jx_hp_value = patch.readInt();
         HuaXingJingXiuVO.Jx_att_value = patch.readInt();
         HuaXingJingXiuVO.Jx_def_value = patch.readInt();
         HuaXingJingXiuVO.type = patch.readInt();
         HuaXingJingXiuVO.iszidong = patch.readByte();
         --ZDJingXiu.input_num;
         if(HuaXingJingXiuVO.iszidong != 5)
         {
            UIManager.jingxiu.updata();
            UIManager.jingxiu.GCJingXiu();
         }
         else if(HuaXingJingXiuVO.iszidong == 5 && ZDJingXiu.input_num > 0)
         {
            index = int(setTimeout(function():void
            {
               ZDJingXiu.num.text = String(ZDJingXiu.input_num);
               UIManager.zdjx.cg();
               UIManager.jingxiu.updata();
               UIManager.jingxiu.GCJingXiu();
               clearTimeout(index);
            },300));
         }
         else if(HuaXingJingXiuVO.iszidong == 5 && ZDJingXiu.input_num == 0)
         {
            index2 = int(setTimeout(function():void
            {
               ZDJingXiu.iszdjx = false;
               ZDJingXiu.num.text = String(ZDJingXiu.input_num);
               UIManager.zdjx.BtnVisble();
               UIManager.jingxiu.updata();
               UIManager.jingxiu.GCJingXiu();
               clearTimeout(index2);
            },300));
         }
      }
      
      public static function GC_BT_HUAXING(patch:IDataInput) : void
      {
         UIManager.huaxing.remove();
      }
      
      public static function GC_PET_YUANXING(patch:IDataInput) : void
      {
         var reslut:int = patch.readByte();
         if(Boolean(reslut))
         {
            if(UIManager.bianShengKa.visible)
            {
               UIManager.bianShengKa.visible = true;
            }
         }
      }
      
      public static function GC_PET_ZHUANGBEI(patch:IDataInput) : void
      {
         var i:int = 0;
         var type:int = patch.readByte();
         var maxLevel:int = patch.readInt();
         var nowLevel:int = patch.readInt();
         var strength:int = patch.readInt();
         var nextstrength:int = patch.readInt();
         var vo:Vo_petEquip = new Vo_petEquip();
         vo.type = type;
         vo.maxLevel = maxLevel;
         vo.level = nowLevel;
         PetzbVO.voArr[type - 1] = vo;
         vo.init(nowLevel,type,maxLevel,strength,nextstrength);
         if(!PetzbVO.isover)
         {
            ++PetzbVO.index;
            if(PetzbVO.index == 4)
            {
               PetzbVO.isover = true;
            }
         }
         if(PetzbVO.isover)
         {
            PetzbVO.arr = [];
            i = 0;
            while(i < 4)
            {
               PetzbVO.arr.push(PetzbVO.voArr[i]);
               i++;
            }
         }
      }
      
      public static function GC_PET_QIANGHUA(patch:IDataInput) : void
      {
         var g:View_Grid = null;
         var type:int = patch.readByte();
         var result:int = patch.readByte();
         switch(result)
         {
            case 0:
               g = ZhuangBeiPanel.instance.GridVec[1];
               CastEffect.getEffect("insten_fail",g,ZhuangBeiPanel.instance);
               break;
            case 1:
               g = ZhuangBeiPanel.instance.GridVec[1];
               CastEffect.getEffect("instens",g,ZhuangBeiPanel.instance);
               UIManager.petPanel.setxx();
               ZhuangBeiPanel.instance.eff();
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("已达强化等级上限，请升级装备");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("强化材料不足");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("银子不足");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("宠物已达到最高级");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("元宝不足");
         }
      }
      
      public static function GC_PET_SHENGJIE(patch:IDataInput) : void
      {
         var g:View_Grid = null;
         var type:int = patch.readByte();
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               g = ZhuangBeiPanel.instance.GridVec[1];
               CastEffect.getEffect("shengji",g,ZhuangBeiPanel.instance);
               UIManager.petPanel.setxx();
               ZhuangBeiPanel.instance.eff();
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("宠物到达" + ((PetzbVO.voArr[type - 1] as Vo_petEquip).maxLevel + 10) + "级可升级装备");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("升级材料不足");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("元宝不足");
         }
      }
      
      public function GC_PET_TYPE_SEND(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var zz:int = UIManager.petPanel.petVO.ziZhi;
         if(result == 1)
         {
            if(zz == 100)
            {
               UIManager.centerBroadcast.addMsg("宠物等级要达到80级以上才能突破至灵宠");
            }
            else if(zz == 150)
            {
               UIManager.centerBroadcast.addMsg("宠物等级要达到90级以上才能突破至仙宠");
            }
            else if(zz == 200)
            {
               UIManager.centerBroadcast.addMsg("宠物等级要达到100级以上才能突破至圣宠");
            }
            else if(zz == 250)
            {
               UIManager.centerBroadcast.addMsg("宠物等级要达到110级以上才能突破至神宠");
            }
            else if(zz == 300)
            {
               UIManager.centerBroadcast.addMsg("宠物等级要达到120级以上才能突破至玄宠");
            }
         }
         else if(result == 4)
         {
            if(zz == 100 || zz == 101)
            {
               UIManager.centerBroadcast.addMsg("恭喜你，宠物突破至灵宠");
            }
            else if(zz == 150 || zz == 151)
            {
               UIManager.centerBroadcast.addMsg("恭喜你，宠物突破至仙宠");
            }
            else if(zz == 200 || zz == 201)
            {
               UIManager.centerBroadcast.addMsg("恭喜你，宠物突破至圣宠");
            }
            else if(zz == 250 || zz == 251)
            {
               UIManager.centerBroadcast.addMsg("恭喜你，宠物突破至神宠");
            }
            else if(zz == 300 || zz == 301)
            {
               UIManager.centerBroadcast.addMsg("恭喜你，宠物突破至玄宠");
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg(arr[result - 1]);
         }
         var succeRate:int = patch.readInt();
         var xiZiValue:int = patch.readInt();
         UIManager.petPanel.petVO.ziZhi = xiZiValue;
         UIManager.petPanel.petVO.succRate = succeRate;
         UIManager.petPanel.update(result);
      }
      
      public function GC_PET_RATE_RESET(patch:IDataInput) : void
      {
         var rate:int = patch.readInt();
         UIManager.petPanel.petVO.succRate = rate;
         if(UIManager.petPanel.visible)
         {
            UIManager.petPanel.update();
         }
      }
      
      public function GC_PET_TUPO(patch:IDataInput) : void
      {
         var n:int = 0;
         UIManager.petPanel.petVO.isTuPo = patch.readByte();
         LianHuaPanel.instance.addEffSuccess();
         n = int(setTimeout(function():void
         {
            clearTimeout(n);
            UIManager.petPanel.update();
            LianHuaPanel.instance.tuPoShow();
            LianHuaPanel.instance.tuPoEff();
            LianHuaPanel.instance.getPanIndex(UIManager.petPanel.petVO.CZLevel);
         },2000));
      }
      
      public function GC_XISUI_BACK(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         UIManager.petPanel.update();
         if(result == 1)
         {
            UIManager.petPanel.playEff(PetPanel.XIZI);
            PetEffect.getInstance().play(PetEffect.XSCG);
         }
         else if(result == 0)
         {
            PetEffect.getInstance().play(PetEffect.XSSB,-1);
         }
      }
      
      public function GC_PET_DANQI_ICON(patch:IDataInput) : void
      {
         var count:int = patch.readInt();
         var str:String = patch.readUTF();
         var _str:String = patch.readUTF();
         var arr:Array = str.split("_");
         var _arr:Array = _str.split("_");
         PetVO.jinJieLvArr = _arr;
         PetVO.arr = arr;
         PetVO.danQiCount = count;
         UIManager.petPanel.update();
      }
      
      public function GC_PET_SURE_NEIDAN_JINJIE(patch:IDataInput) : void
      {
         var level:int = 0;
         var result:int = patch.readByte();
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("所需丹气值不足，无法进阶");
         }
         else if(result == 2)
         {
            if(_level < 90)
            {
               level = 90;
            }
            else if(_level >= 90 && _level < 100)
            {
               level = 100;
            }
            else if(_level >= 100 && _level < 110)
            {
               level = 110;
            }
            else if(_level >= 110 && _level < 115)
            {
               level = 115;
            }
            else
            {
               level = (int(_level / 5) + 1) * 5;
            }
            UIManager.centerBroadcast.addMsg("所需宠物等级不足" + level.toString() + "级，无法进阶");
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("宠物进阶已满级");
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg("进阶成功");
            PetHandler.GC_PET_JIEDAN(0);
            NeiDanPanel.removeEff(NeiDanPanel.neiDan_Type);
         }
      }
      
      public function GC_ChongWuJinJie(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         PetHandler.GC_ChongWuJinJie(result);
      }
   }
}

