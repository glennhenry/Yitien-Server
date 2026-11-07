package com.yiTian.net.message.gc
{
   import com.ui.controls.CheckBox;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.net.message.cg.BabyCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.baby.babyIcon.BabyBtnBesideRole;
   import com.yiTian.view.modules.baby.babyIcon.BabyIcon;
   import com.yiTian.view.modules.baby.babyManager.Enum_baby;
   import com.yiTian.view.modules.baby.babyManager.Model_baby;
   import com.yiTian.view.modules.baby.babyPan.BabyChooseLY;
   import com.yiTian.view.modules.baby.babyPan.BabyInBattleRule;
   import com.yiTian.view.modules.baby.babyPan.Child_FM_WG;
   import com.yiTian.view.modules.baby.babyPan.Vo_WuGong;
   import flash.text.TextFormatAlign;
   import flash.utils.IDataInput;
   import mx.utils.StringUtil;
   
   public class BabyGCMessage
   {
      
      private static var temChooseType:uint;
      
      private static var msgArr:Array = ["没魅力瓶","已到最高级","崽崽魅力度增加10点"];
      
      private static var typeArr:Array = [["初级三字经","15"],["高级三字经","45"]];
      
      private static var typeName:Array = ["力量","智慧","体质"];
      
      private static var ssArr:Array = ["没有足够材料进行对应培养","崽崽已成年，不能培养","今日培养次数已满","崽崽{0}培养经验增加{1}"];
      
      private static var arrExp:Array = ["baby_strength_exp","baby_zhiHui_exp","baby_lucky_exp"];
      
      private static var arrLvl:Array = ["baby_strength_lvl","baby_zhiHui_lvl","baby_lucky_lvl"];
      
      private static var tisArrWG:Array = ["身上没有相应的技能书","您已经学过这个技能了","子女最多只能习得一种武功","成功"];
      
      private static var tsArrUpLoad:Array = ["您还没有习得此种武功","背包没有相应格子存放武功书籍了","成功"];
      
      private var isShowCheckBox:Boolean = false;
      
      public function BabyGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_SHOW_LY_ICON] = this.GC_SHOW_LY_ICON;
         index[MessageType.GC_START_TO_LY] = this.GC_START_TO_LY;
         index[MessageType.GC_HOME_SHOW_LY_TUO] = this.GC_HOME_SHOW_LY_TUO;
         index[MessageType.GC_CLICK_TO_TUOGUAN] = this.GC_CLICK_TO_TUOGUAN;
         index[MessageType.GC_BRING_BABY_OUT] = this.GC_BRING_BABY_OUT;
         index[MessageType.GC_OPEN_BABY_PAN] = this.GC_OPEN_BABY_PAN;
         index[MessageType.GC_USE_MEILI_BOTTLE] = this.GC_USE_MEILI_BOTTLE;
         index[MessageType.GC_BABY_PEIYANG_ISFIRST] = this.GC_BABY_PEIYANG_ISFIRST;
         index[MessageType.GC_PEIYANGBABY] = this.GC_PEIYANGBABY;
         index[MessageType.GC_ICON_BESIDE_ROLEBTN] = this.GC_ICON_BESIDE_ROLEBTN;
         index[MessageType.GC_BABYICON_PEIYANG] = this.GC_BABYICON_PEIYANG;
         index[MessageType.GC_BABY_STRENTHTIPS] = this.GC_BABY_STRENTHTIPS;
         index[MessageType.GC_BABY_ADD_WUGONG] = this.GC_BABY_ADD_WUGONG;
         index[MessageType.GC_UPLOAD_WUGONG] = this.GC_UPLOAD_WUGONG;
         index[MessageType.GC_BABY_TIPS_ADD] = this.GC_BABY_TIPS_ADD;
      }
      
      private function GC_SHOW_LY_ICON(patch:IDataInput) : void
      {
         BabyIcon.babyIconVisCtrl(patch.readByte())();
      }
      
      private function GC_ICON_BESIDE_ROLEBTN(patch:IDataInput) : void
      {
         var arr:Array = ["hide_besideRole_icon","show_besideRole_icon"];
         Model_baby[arr[patch.readByte()]]();
      }
      
      private function GC_START_TO_LY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         UIManager.centerBroadcast.addMsg(Enum_baby.adopt_tips[result - 1],1);
         if(result == 1)
         {
            BabyChooseLY.instance.visible = false;
            if(BabyIcon.hasIcon)
            {
               BabyIcon.hide();
            }
         }
      }
      
      private function GC_HOME_SHOW_LY_TUO(patch:IDataInput) : void
      {
         var info:String = patch.readUTF();
         Model_baby.dataExplain(info);
      }
      
      private function GC_CLICK_TO_TUOGUAN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 4)
         {
            Model_baby.baby_strength = 0;
         }
         UIManager.centerBroadcast.addMsg(Enum_baby.tuoGuan_tips[result - 1],1);
      }
      
      private function GC_BRING_BABY_OUT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         UIManager.centerBroadcast.addMsg(Enum_baby.bring_out_tips[result - 1],1);
         if(result == 3)
         {
            BabyInBattleRule.instance.hide();
            Model_baby.show_besideRole_icon(true);
         }
      }
      
      private function GC_OPEN_BABY_PAN(patch:IDataInput) : void
      {
         Model_baby.baby_strength = patch.readInt();
         Model_baby.baby_meiLi_lvl = patch.readByte();
         Model_baby.baby_meiLi_value = patch.readInt();
         Model_baby.baby_type_value = patch.readUTF();
         Model_baby.baby_wuGong_value = patch.readUTF();
         Vo_WuGong.instance.init(Model_baby.baby_wuGong_value.split("_"));
         Model_baby.sex = patch.readByte();
         Model_baby.isFuMo = patch.readByte();
         Model_baby.leftTimes = patch.readInt();
         Model_baby.babyName = patch.readUTF();
         Model_baby.is18 = patch.readByte() != 1;
         Global.control.sendNotification(BabyBtnBesideRole.BABYPAN_MSG_BACK,null);
      }
      
      private function GC_USE_MEILI_BOTTLE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         Model_baby.baby_meiLi_value = patch.readInt();
         Model_baby.baby_meiLi_lvl = patch.readByte();
         Model_baby.baby_strength = patch.readInt();
         UIManager.centerBroadcast.addMsg(msgArr[result - 1],1);
         Global.control.sendNotification(BabyBtnBesideRole.BABYPAN_MSG_BACK,null);
      }
      
      private function GC_BABY_PEIYANG_ISFIRST(patch:IDataInput) : void
      {
         var ss:String;
         var chooseType:uint = 0;
         var sss:String = null;
         var _type:int = patch.readByte();
         chooseType = uint(patch.readByte());
         temChooseType = chooseType;
         if(_type == 2)
         {
            Model_baby.is18 = true;
            UIManager.centerBroadcast.addMsg("已经成年,不能在培养了",1);
         }
         ss = HtmlUtil.font("是否消耗" + HtmlUtil.font(typeArr[chooseType - 1][0],"#f9ff00") + "增加" + HtmlUtil.font(typeArr[chooseType - 1][1] + "点" + typeName[Model_baby.baba_type_choose - 1],"#f9ff00") + "培养经验","#ffffff");
         if(_type == 1)
         {
            sss = ss + "\n" + "<font color=\"#cc9999\">" + "只有在出生后15内才能培养(每天10次)" + "</font>";
            View_Alert.show(sss,View_Alert.OK_CANCAL,function():void
            {
               BabyCGMessage.CG_PEIYANGBABY(Model_baby.baba_type_choose,chooseType);
            },null,null,null,330,"","",TextFormatAlign.CENTER,false);
         }
         else if(_type == 0)
         {
            if(this.isShowCheckBox)
            {
               BabyCGMessage.CG_PEIYANGBABY(Model_baby.baba_type_choose,chooseType);
            }
            else
            {
               View_Alert.show(ss,View_Alert.OK_CANCAL,function():void
               {
                  BabyCGMessage.CG_PEIYANGBABY(Model_baby.baba_type_choose,chooseType);
               },null,null,null,330,"","",TextFormatAlign.CENTER,true);
               View_Alert.instance.showCheckBox = function(e:CheckBox):void
               {
                  isShowCheckBox = e.selected;
               };
            }
         }
      }
      
      private function GC_PEIYANGBABY(patch:IDataInput) : void
      {
         var sD:String = null;
         var sd:String = null;
         var result:int = patch.readByte();
         var type:int = patch.readByte();
         Model_baby[arrExp[type - 1]] = patch.readInt();
         Model_baby[arrLvl[type - 1]] = patch.readByte();
         Model_baby.baby_strength = patch.readInt();
         Model_baby.leftTimes = patch.readInt();
         if(result == 4)
         {
            sD = ssArr[result - 1];
            sd = sD.replace("{0}",typeName[type - 1]).replace("{1}",temChooseType == 1 ? "15点" : "45点");
            UIManager.centerBroadcast.addMsg(sd,1);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(ssArr[result - 1],1);
         }
         if(result == 2)
         {
            Model_baby.is18 = true;
         }
         Global.control.sendNotification(BabyBtnBesideRole.BABYPAN_MSG_BACK,null);
      }
      
      private function GC_BABYICON_PEIYANG(patch:IDataInput) : void
      {
         var result:uint = uint(patch.readByte());
         if(result == 1)
         {
            Model_baby.showPeiYangTBtn();
         }
         else
         {
            Model_baby.removeTip();
         }
         Model_baby.days = patch.readInt();
         Model_baby.times = patch.readInt();
         Global.control.sendNotification(BabyBtnBesideRole.BABYPAN_MSG_BACK,null);
      }
      
      private function GC_BABY_STRENTHTIPS(patch:IDataInput) : void
      {
         Model_baby.strengthTip = "";
         Model_baby.strengthTip += StringUtil.substitute("<font color=\'#04ff00\'>战斗时附加宠物 气血:</font> <font color=\'#f9ff00\'>{0}</font> \n",patch.readInt());
         Model_baby.strengthTip += StringUtil.substitute("<font color=\'#04ff00\'>战斗时附加宠物 攻击:</font> <font color=\'#f9ff00\'>{0}</font> \n",patch.readInt());
         Model_baby.strengthTip += StringUtil.substitute("<font color=\'#04ff00\'>战斗时附加宠物 防御:</font> <font color=\'#f9ff00\'>{0}</font> \n",patch.readInt());
         Model_baby.strengthTip += StringUtil.substitute("<font color=\'#04ff00\'>战斗时附加宠物 命中:</font> <font color=\'#f9ff00\'>{0}</font> \n",patch.readInt());
         Model_baby.strengthTip += StringUtil.substitute("<font color=\'#04ff00\'>战斗时附加宠物 躲避:</font> <font color=\'#f9ff00\'>{0}</font> \n",patch.readInt());
         Model_baby.strengthTip += StringUtil.substitute("<font color=\'#04ff00\'>战斗时附加宠物 暴击:</font> <font color=\'#f9ff00\'>{0}</font> \n",patch.readInt());
         Model_baby.strengthTip += StringUtil.substitute("<font color=\'#04ff00\'>战斗时附加宠物 伤害:</font> <font color=\'#f9ff00\'>{0}%</font> \n",patch.readUTF());
         Model_baby.strengthTip += StringUtil.substitute("<font color=\'#04ff00\'>战斗时附加宠物 伤免:</font> <font color=\'#f9ff00\'>{0}%</font> \n",patch.readUTF());
         Model_baby.refreshTip();
      }
      
      private function GC_BABY_ADD_WUGONG(patch:IDataInput) : void
      {
         var index:int = 0;
         var arr:Array = null;
         var status:int = patch.readByte();
         var skillId:int = patch.readInt();
         if(status == 4)
         {
            index = Child_FM_WG.idArr.indexOf(skillId);
            arr = ["百发百中","至阴真经","意筋经"];
            UIManager.centerBroadcast.addMsg("恭喜！！您的子女习得" + HtmlUtil.font(HtmlUtil.bold(arr[index]),"#ff7700",14) + "技能!!",1);
            Vo_WuGong.instance[Child_FM_WG.wuGongVoArr[index]] = skillId;
            Child_FM_WG.updateWGBy(index);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(tisArrWG[status - 1],1);
         }
      }
      
      private function GC_UPLOAD_WUGONG(patch:IDataInput) : void
      {
         var index:int = 0;
         var arr:Array = null;
         var status:int = patch.readByte();
         var skillId:int = patch.readInt();
         if(status == 3)
         {
            index = Child_FM_WG.idArr.indexOf(skillId);
            arr = ["百发百中","至阴真经","意筋经"];
            UIManager.centerBroadcast.addMsg("您拆掉了" + HtmlUtil.font(HtmlUtil.bold(arr[index]),"#ff7700",14) + "技能!!");
            Vo_WuGong.instance[Child_FM_WG.wuGongVoArr[index]] = 0;
            Child_FM_WG.fly_to_bag(index);
            Child_FM_WG.updateWGBy(index);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(tsArrUpLoad[status - 1],1);
         }
      }
      
      private function GC_BABY_TIPS_ADD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("亲，您还没有子女哦");
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("亲，您还没带你的子女出行");
         }
      }
   }
}

