package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.net.message.cg.MarriageCGMessage;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import com.yiTian.view.modules.marriage.MarriageConfig;
   import com.yiTian.view.modules.marriage.MarriageVo;
   import com.yiTian.view.modules.marriage.Model_Marriage;
   import com.yiTian.view.modules.marriage.Model_SendMarriageBless;
   import com.yiTian.view.modules.marriage.View_GetMarriageBlessPlane;
   import com.yiTian.view.modules.marriage.View_MarriageBlessTip;
   import com.yiTian.view.modules.newRolePan.View_rolePan;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class MarriageGCMessage
   {
      
      public function MarriageGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_MARRIAGE_MAINMESSAGE] = GC_MARRIAGE_MAINMESSAGE;
         index[MessageType.GC_MARRIAGE_INITIATE] = GC_MARRIAGE_INITIATE;
         index[MessageType.GC_MARRIAGE_EFFECT_INSCENE] = GC_MARRIAGE_EFFECT_INSCENE;
         index[MessageType.GC_MARRIAGE_BROADCAST] = GC_MARRIAGE_BROADCAST;
         index[MessageType.GC_MARRIAGE_HONGBAO] = GC_MARRIAGE_HONGBAO;
         index[MessageType.GC_MARRIAGE_HONGBAO_BROADCAST] = GC_MARRIAGE_HONGBAO_BROADCAST;
         index[MessageType.GC_MARRIAGE_COLLECT_END] = GC_MARRIAGE_COLLECT_END;
         index[MessageType.GC_MARRIAGE_BREAK] = GC_MARRIAGE_BREAK;
         index[MessageType.GC_MARRIAGE_BLESS_ADD] = GC_MARRIAGE_BLESS_ADD;
         index[MessageType.GC_MARRIAGE_BLESS_RESULT] = GC_MARRIAGE_BLESS_RESULT;
         index[MessageType.GC_MARRIAGE_INFO] = GC_MARRIAGE_INFO;
         index[MessageType.GC_MARRIAGE_BLESS_EFFECT] = GC_MARRIAGE_BLESS_EFFECT;
         index[MessageType.GC_MARRIAGE_BLESS_OPEN] = GC_MARRIAGE_BLESS_OPEN;
         index[MessageType.GC_MARRIAGE_BLESS_RESEND] = GC_MARRIAGE_BLESS_RESEND;
         index[MessageType.GC_MARRIAGE_BLESS_RESEND_BROADCAST] = GC_MARRIAGE_BLESS_RESEND_BROADCAST;
         index[MessageType.GC_GETQIXIREWARD] = GC_GETQIXIREWARD;
         index[MessageType.GC_MARRIAGE_SHOWNPC] = GC_MARRIAGE_SHOWNPC;
         index[MessageType.GC_GETLITANGREWARD] = GC_GETLITANGREWARD;
         index[MessageType.GC_MARRIAGE_ADD] = GC_MARRIAGE_ADD;
         index[MessageType.GC_GET_QIXI_GIFT] = GC_GET_QIXI_GIFT;
      }
      
      public static function GC_MARRIAGE_MAINMESSAGE(patch:IDataInput) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         var type:int = patch.readByte();
         Model_Marriage.showAlert(type);
      }
      
      public static function GC_MARRIAGE_INITIATE(patch:IDataInput) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         var ringID:int = patch.readInt();
         var id:Number = LongUtil.readLong(patch);
         var name:String = Model_heFu.repNameByHero(patch.readUTF());
         Model_Marriage.getMarriageInfo(ringID,id,name);
      }
      
      public static function GC_MARRIAGE_EFFECT_INSCENE(patch:IDataInput) : void
      {
      }
      
      public static function GC_MARRIAGE_BROADCAST(patch:IDataInput) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         var type:int = patch.readInt() - MarriageConfig.RING_PLATINUM;
         var maleID:int = patch.readByte();
         var maleName:String = Model_heFu.repNameByHero(patch.readUTF());
         var femaleID:int = patch.readByte();
         var femaleName:String = Model_heFu.repNameByHero(patch.readUTF());
         var num:int = patch.readInt();
         var triMsg:String = LangConfig.getWord("1041",0,maleName,femaleName,num);
         UIManager.actBroadcast.addMsg(triMsg);
         if(Global.sceneID != 12304)
         {
            Model_Marriage.showEffects(type,15000);
         }
         else
         {
            Model_Marriage.showEffects(type,0);
         }
      }
      
      public static function GC_MARRIAGE_HONGBAO_BROADCAST(patch:IDataInput) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         var sender:String = Model_heFu.repNameByHero(patch.readUTF());
         var num:String = patch.readInt().toString();
         var triMsg:String = LangConfig.getWord("1037",0,sender,num);
         var chatMsg:String = LangConfig.getWord("1038",0,sender,num);
         UIManager.triggleBroadcast.addMsg(triMsg);
         UIManager.chatPanel.addMessage(7,chatMsg,"",0,0,0,0);
      }
      
      public static function GC_MARRIAGE_HONGBAO(patch:IDataInput) : void
      {
      }
      
      public static function GC_MARRIAGE_COLLECT_END(patch:IDataInput) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         var type:int = patch.readInt();
         if(type == 2)
         {
            Model_Marriage.showAlert(99999,"recive collection callBack");
         }
      }
      
      public static function GC_MARRIAGE_BREAK(patch:IDataInput) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            pan.updateRing(0,0,"");
         });
         GameUnitManager.hero.marriageID = 0;
         GameUnitManager.hero.marriageRing = 0;
         GameUnitManager.hero.marriageName = "";
         Model_Marriage.showAlert(101);
      }
      
      public static function GC_MARRIAGE_BLESS_ADD(patch:IDataInput) : void
      {
         var type:Number;
         var marriageType:int;
         var obj:Object;
         var fun:Function;
         var str:String = null;
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         type = LongUtil.readLong(patch);
         marriageType = patch.readByte();
         obj = new Object();
         obj.marriageType = marriageType;
         obj["maleID"] = LongUtil.readLong(patch);
         obj["maleName"] = Model_heFu.repNameByHero(patch.readUTF());
         obj["femaleID"] = LongUtil.readLong(patch);
         obj["femaleName"] = Model_heFu.repNameByHero(patch.readUTF());
         Model_Marriage.curMarriageInfo = obj;
         if(Boolean(GameUnitManager.hero.id == obj.maleID) || Boolean(GameUnitManager.hero.id) || Boolean(obj.femaleID))
         {
            Model_Marriage.updateViewer();
         }
         if(GameUnitManager.hero.level >= 35 && GameUnitManager.hero.id != obj.maleID && GameUnitManager.hero.id != obj.femaleID)
         {
            fun = function(event:MouseEvent):void
            {
               ModalUIManager.fxqPromty.show(str,View_Alert.OK_CANCAL,function(event:MouseEvent):void
               {
                  GameUnitManager.hero.autoMoveLocation(12304);
               });
            };
            if(type == 1)
            {
               Model_SendMarriageBless.data = obj;
            }
            if(Global.sceneID == 12304)
            {
               Model_Marriage.updateViewer();
            }
            if(!Model_Marriage.hlTipBtnInstance)
            {
               Model_Marriage.hlTipBtnInstance = new BitmapBtn();
               Model_Marriage.hlTipBtnInstance.init(4,4,46,46);
               Model_Marriage.hlTipBtnInstance.setBgDir(Model_Marriage.hlTipBMUrl);
               Model_Marriage.hlTipBtnInstance.buttonMode = true;
               if(!Model_Marriage.hlTipBtnEff)
               {
                  Model_Marriage.hlTipBtnEff = EffectManager.addEffect("35343",Model_Marriage.hlTipBtnInstance,1000,32,29,true);
               }
               UIManager.mainUiBtnContainer.addBTN(Model_Marriage.hlTipBtnInstance);
            }
            str = LangConfig.getWord("29280",2,"<font color=\'#00aa00\'> " + obj.maleName + "</font> ","<font color=\'#00aa00\'> " + obj.femaleName + "</font> ");
            Model_Marriage.hlTipBtnInstance.clickCallBack = fun;
         }
      }
      
      public static function GC_MARRIAGE_BLESS_RESULT(patch:IDataInput) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         var beishu:int = patch.readByte();
         var exp:int = patch.readInt();
         var message:String = LangConfig.getWord("1077",0,beishu,exp);
         UIManager.centerBroadcast.addMsg(message);
      }
      
      public static function GC_MARRIAGE_INFO(patch:IDataInput) : void
      {
         var id:Number;
         var ringID:int = 0;
         var name:String = null;
         var qinmidu:int = 0;
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         ringID = patch.readInt();
         id = LongUtil.readLong(patch);
         name = Model_heFu.repNameByHero(patch.readUTF());
         qinmidu = patch.readInt();
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            pan.updateRing(ringID,qinmidu,name);
         });
         GameUnitManager.hero.marriageID = id;
         GameUnitManager.hero.marriageRing = ringID;
         GameUnitManager.hero.marriageName = name;
      }
      
      public static function GC_MARRIAGE_BLESS_EFFECT(patch:IDataInput) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         var type:int = patch.readByte();
         var senderID:int = patch.readByte();
         var sender:String = Model_heFu.repNameByHero(patch.readUTF());
         var getterID:int = patch.readByte();
         var getter:String = Model_heFu.repNameByHero(patch.readUTF());
         var getter2ID:int = patch.readByte();
         var getter2:String = Model_heFu.repNameByHero(patch.readUTF());
         var itemName:String = type == 2 ? Enum_BroadCastTool.instance.getItemText(46445) : Enum_BroadCastTool.instance.getItemText(46446);
         var triMsg:String = LangConfig.getWord("1039",0,sender,getter,getter2,itemName);
         var chatMsg:String = LangConfig.getWord("1040",0,sender,getter,getter2,itemName);
         UIManager.triggleBroadcast.addMsg(triMsg);
         UIManager.chatPanel.addMessage(7,chatMsg,"",0,0,0,0);
         if(Global.sceneID != 12304)
         {
            Model_Marriage.showEffects(type,15000);
         }
         else
         {
            Model_Marriage.showEffects(type,0);
         }
      }
      
      public static function GC_MARRIAGE_BLESS_OPEN(patch:IDataInput) : void
      {
         var vo:MarriageVo = null;
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         var length:int = patch.readInt();
         UIManager.getMarriageBlessPlane.delAllInfo();
         var i:int = 0;
         while(i < length)
         {
            vo = new MarriageVo();
            vo.targetType = patch.readByte();
            vo.targetId = LongUtil.readLong(patch);
            vo.targetName = patch.readUTF();
            UIManager.getMarriageBlessPlane.addInfo(vo);
            i++;
         }
         if(length > 0)
         {
            if(!UIManager.mainUiBtnContainer.hasBTN(View_MarriageBlessTip.instance))
            {
               UIManager.mainUiBtnContainer.addBTN(View_MarriageBlessTip.instance);
            }
            UIManager.getMarriageBlessPlane.visible = true;
         }
      }
      
      public static function GC_MARRIAGE_BLESS_RESEND(patch:IDataInput) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         var id:int = patch.readInt();
         if(id > 0)
         {
            Model_Marriage.showAlert(105);
         }
         var pnl:View_GetMarriageBlessPlane = UIManager.getMarriageBlessPlane;
         if(pnl.getLength() <= 1)
         {
            pnl.visible = false;
            pnl.delAllInfo();
            UIManager.mainUiBtnContainer.removeBTN(View_MarriageBlessTip.instance);
         }
         MarriageCGMessage.CG_MARRIAGE_BLESS_OPEN();
      }
      
      public static function GC_MARRIAGE_BLESS_RESEND_BROADCAST(patch:IDataInput) : void
      {
         if(!MarriageConfig.startUsing)
         {
            return;
         }
         var type:int = patch.readByte();
         var senderID:int = patch.readByte();
         var senderName:String = Model_heFu.repNameByHero(patch.readUTF());
         var getterID:int = patch.readByte();
         var getterName:String = Model_heFu.repNameByHero(patch.readUTF());
         var itemName:String = type == 2 ? Enum_BroadCastTool.instance.getItemText(46448) : Enum_BroadCastTool.instance.getItemText(46449);
         var triMsg:String = LangConfig.getWord("1084",0,senderName,getterName,itemName);
         var chatMsg:String = LangConfig.getWord("1085",0,senderName,getterName,itemName);
         UIManager.chatPanel.addMessage(7,chatMsg,"",0,0,0,0);
         UIManager.triggleBroadcast.addMsg(triMsg);
      }
      
      public static function GC_MARRIAGE_SHOWNPC(patch:IDataInput) : void
      {
         var ringType:int = 0;
         var maleId:Number = NaN;
         var maleName:String = null;
         var femaleId:Number = NaN;
         var femaleName:String = null;
         var s:Function = null;
         s = function():void
         {
            MarriageConfig.playMarriageScript(maleName,femaleName,maleId,femaleId);
            Model_Marriage.showEffects(ringType,-1);
            Model_Marriage.hideCharactor(maleId,femaleId);
            Global.control.removeCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,s);
         };
         ringType = patch.readByte();
         maleId = LongUtil.readLong(patch);
         maleName = Model_heFu.repNameByHero(patch.readUTF());
         femaleId = LongUtil.readLong(patch);
         femaleName = Model_heFu.repNameByHero(patch.readUTF());
         Model_Marriage.hideCharactor(maleId,femaleId);
         if(Global.sceneID == 12304)
         {
            s();
         }
      }
      
      public static function GC_GETQIXIREWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var arr:Array = [29271,29272,29273];
         var str:String = LangConfig.getWord(arr[result - 1].toString(),2);
         UIManager.centerBroadcast.addMsg(str);
      }
      
      public static function GC_GETLITANGREWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         Model_Marriage.GC_GETLITANGREWARD(result);
      }
      
      public static function GC_MARRIAGE_ADD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29447",2));
            return;
         }
         var name1:String = Model_heFu.repNameByHero(patch.readUTF());
         var name2:String = Model_heFu.repNameByHero(patch.readUTF());
         var name3:String = Model_heFu.repNameByHero(patch.readUTF());
         var st:String = LangConfig.getWord("1129",0,name1,name2,name3);
         UIManager.laba_panel.update("",st,1,0,0,0,0,0,0,0,0,0,1);
      }
      
      public static function GC_GET_QIXI_GIFT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 0:
               UIManager.centerBroadcast.addMsg("领取成功");
               break;
            case 1:
               UIManager.centerBroadcast.addMsg("不在活动时间内");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("您已领取过七夕礼包");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("只有结婚才能领取七夕礼包哦");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("背包空间不足");
         }
      }
   }
}

