package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_equip;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.manager.DailyRemainManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FeiXingQiCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.FeiXingQi.Child_FeiXingQi;
   import com.yiTian.view.modules.FeiXingQi.Child_FeiXingQiUnit;
   import com.yiTian.view.modules.FeiXingQi.Enum_FeiXingQi;
   import com.yiTian.view.modules.FeiXingQi.Model_FeiXingQi;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class FeiXingQiHandle
   {
      
      private static var INFOS:Array;
      
      public function FeiXingQiHandle()
      {
         super();
      }
      
      public static function GC_FXQ(version:int, type:int) : void
      {
         var txtId:String = (20230 + type).toString();
         var str:String = LangConfig.getWord(txtId,2);
         UIManager.centerBroadcast.addMsg(str);
      }
      
      public static function GC_FXQINFO(version:int, isRefreshIm:int, unitArr:Array, repArr:Array, rollCDRemain:int, roomId:int) : void
      {
         var i:int = 0;
         var infos:Array = null;
         var id:Number = NaN;
         var u:Child_FeiXingQiUnit = null;
         var name:String = null;
         var sex:int = 0;
         var job:int = 0;
         var index:int = 0;
         if(Model_FeiXingQi.isTween)
         {
            UIManager.feiXingQiPanel.visible = true;
            return;
         }
         Model_FeiXingQi.version = version;
         if(isRefreshIm == 2)
         {
            UIManager.feiXingQiPanel.feiXingQi.refreshIm();
         }
         UIManager.feiXingQiPanel.clearZB();
         UIManager.feiXingQiPanel.visible = true;
         i = 0;
         while(i < unitArr.length)
         {
            infos = unitArr[i];
            id = Number(infos[0]);
            u = Model_FeiXingQi.findUnit(id,"id");
            if(!u)
            {
               u = Model_FeiXingQi.getUnit();
            }
            name = infos[1];
            sex = int(infos[2]);
            job = int(infos[3]);
            index = int(infos[4]);
            u.state = index == 0 ? Action.RUN : Action.STAND;
            if(id == GameUnitManager.hero.id)
            {
               Model_FeiXingQi.myUnit = u;
            }
            u.id = id;
            u.uName = name;
            u.sex = sex;
            u.job = job;
            u.modelId = Enum_FeiXingQi.caculateModelId(job,sex);
            UIManager.feiXingQiPanel.feiXingQi.addUnitAtIndex(u,index);
            u.StartAni();
            UIManager.feiXingQiPanel.feiXingQi.align();
            i += 1;
         }
         UIManager.feiXingQiPanel.updatePlayerLabel();
         i = 0;
         while(i < repArr.length)
         {
            UIManager.feiXingQiPanel.addZB(repArr[i]);
            i += 1;
         }
         UIManager.feiXingQiPanel.touCDRemain = rollCDRemain;
         UIManager.feiXingQiPanel.setRoomID(roomId);
      }
      
      public static function GC_FXQROLL(version:int, resultPoint:int, rollCDRemain:int) : void
      {
         Model_FeiXingQi.version = version;
         UIManager.feiXingQiPanel.tou.roll(resultPoint);
         UIManager.feiXingQiPanel.touCDRemain = rollCDRemain;
      }
      
      public static function GC_FXQTODIS(version:int, id:Number, curIndex:int, numStep:int, endIndex:int) : void
      {
         Model_FeiXingQi.version = version;
         var u:Child_FeiXingQiUnit = Model_FeiXingQi.findUnit(id);
         var fxq:Child_FeiXingQi = UIManager.feiXingQiPanel.feiXingQi;
         if(Boolean(u))
         {
            u.StartAni();
            fxq.addUnitAtIndex(u,curIndex);
            u.targetIndex = endIndex;
            fxq.unitTween(u,numStep);
            if(id == GameUnitManager.hero.id)
            {
               Model_FeiXingQi.disIndex = endIndex;
               Model_FeiXingQi.isTween = true;
            }
         }
         UIManager.feiXingQiPanel.feiXingQi.align();
      }
      
      public static function GC_FXQACCELERATE(version:int, result:int) : void
      {
         Model_FeiXingQi.version = version;
         switch(result)
         {
            case 1:
               UIManager.feiXingQiPanel.touCDRemain = 0;
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("20241",2));
         }
      }
      
      private static function BATTLECALL(bId:int, func:Function) : void
      {
         if(bId > 0)
         {
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,function b_e():void
            {
               func();
               Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,b_e);
            });
         }
         else
         {
            func();
         }
      }
      
      public static function GC_FXQEVENT(version:int, type:int, bId:int, patch:IDataInput) : void
      {
         var id:int = 0;
         var str:String = null;
         id = 20100 + type;
         BATTLECALL(bId,function():void
         {
            var remain:int = 0;
            switch(type)
            {
               case 1:
                  str = LangConfig.getWord(id.toString(),2);
                  ModalUIManager.fxqPromty.show(str,View_Alert.OK_CANCAL,function():void
                  {
                     FeiXingQiCGMessage.CG_FXQGETBOX(Model_FeiXingQi.version);
                  });
                  break;
               case 2:
                  str = LangConfig.getWord(id.toString(),2);
                  ModalUIManager.fxqPromty.show(str,View_Alert.OK_CANCAL,function():void
                  {
                     FeiXingQiCGMessage.CG_FXQMONSTER(Model_FeiXingQi.version);
                  });
                  break;
               case 3:
                  str = LangConfig.getWord(id.toString(),2);
                  ModalUIManager.fxqPromty.show(str,View_Alert.OK_CANCAL,function():void
                  {
                     ModalUIManager.POPUP(ModalUIManager.fxqGuessingPanel);
                  });
                  break;
               case 5:
                  remain = patch.readByte();
                  str = LangConfig.getWord(id.toString(),2);
                  UIManager.centerBroadcast.addMsg(str);
                  UIManager.feiXingQiPanel.feiXingQi.refreshIm();
                  if(UIManager.feiXingQiPanel.visible)
                  {
                     UIManager.feiXingQiPanel.visible = false;
                  }
                  UIManager.feiXingQiPanel.touCDRemain = 0;
                  (Singleton.getInstance(Delegate123) as Delegate123).dosomething(ModalUIManager.fxqReward,ModalUIManager.fxqReward.show);
                  DailyRemainManager.setCount(DailyRemainManager.CG,remain);
                  Model_FeiXingQi.countTimes(remain);
            }
         });
      }
      
      public static function GC_GUESSING(version:int, npcPoint:int, myPoint:int, isWin:int) : void
      {
         Model_FeiXingQi.version = version;
         ModalUIManager.fxqGuessingPanel.setResult(npcPoint,myPoint,isWin);
      }
      
      public static function GC_FXQISJOIN(version:int, remainTimes:int) : void
      {
         var str:String = null;
         if(remainTimes > 0)
         {
            str = LangConfig.getWord("20100",2,remainTimes.toString());
            ModalUIManager.fxqPromty.show(str,View_Alert.OK_CANCAL,function():void
            {
               FeiXingQiCGMessage.CG_FXQJOIN(Model_FeiXingQi.version);
            });
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("20110",2));
         }
      }
      
      public static function GC_FXQPLAYERJOIN(version:int, infos:Array) : void
      {
         Model_FeiXingQi.version = version;
         var id:Number = Number(infos[0]);
         var u:Child_FeiXingQiUnit = Model_FeiXingQi.findUnit(id);
         if(!u)
         {
            u = Model_FeiXingQi.getUnit();
            u.id = id;
         }
         var name:String = infos[1];
         var sex:int = int(infos[2]);
         var job:int = int(infos[3]);
         var index:int = int(infos[4]);
         u.state = index == 0 ? Action.RUN : Action.STAND;
         u.uName = name;
         u.sex = sex;
         u.job = job;
         u.modelId = Enum_FeiXingQi.caculateModelId(job,sex);
         UIManager.feiXingQiPanel.feiXingQi.addUnitAtIndex(u,index);
         u.StartAni();
         UIManager.feiXingQiPanel.updatePlayerLabel();
         UIManager.feiXingQiPanel.feiXingQi.align();
      }
      
      public static function GC_DELPLAYER(version:int, id:Number, reason:int) : void
      {
         Model_FeiXingQi.version = version;
         var u:Child_FeiXingQiUnit = Model_FeiXingQi.findUnit(id);
         if(Boolean(u))
         {
            UIManager.feiXingQiPanel.feiXingQi.removeUnit(u);
            Model_FeiXingQi.unitArr.splice(Model_FeiXingQi.unitArr.indexOf(u),1);
            u.dispose();
         }
         UIManager.feiXingQiPanel.updatePlayerLabel();
      }
      
      public static function GC_FXQZBINFO(version:int, infos:Array) : void
      {
         Model_FeiXingQi.version = version;
         UIManager.feiXingQiPanel.addZB(infos);
      }
      
      public static function GC_RESTART(version:int, roleId:Number, reason:int) : void
      {
         Model_FeiXingQi.version = version;
         var u:Child_FeiXingQiUnit = Model_FeiXingQi.findUnit(roleId);
         if(Boolean(u))
         {
            u.state = Action.RUN;
            UIManager.feiXingQiPanel.feiXingQi.addUnitAtIndex(u,0);
         }
         UIManager.feiXingQiPanel.feiXingQi.align();
      }
      
      public static function GC_ROLLREWARD(version:int, num:int, itemId:int) : void
      {
         Model_FeiXingQi.version = version;
         var tmp:String = num.toString();
         var arr:Array = [];
         while(Boolean(tmp.length))
         {
            arr.push(int(tmp.substr(0,1)));
            tmp = tmp.substr(1);
         }
         ModalUIManager.fxqReward.roll(arr);
         ModalUIManager.fxqReward.roll11(itemId);
      }
      
      public static function GC_FXQGETITEM(reason:int, arr:Array) : void
      {
         var me:Child_FeiXingQiUnit = null;
         var i:int = 0;
         var type:int = 0;
         var id:int = 0;
         var num:int = 0;
         var head:ComboTweenStep = null;
         var imgDir:String = null;
         var bm:Bitmap = null;
         INFOS = arr;
         if(reason == 1)
         {
            me = Model_FeiXingQi.myUnit;
            if(Boolean(me))
            {
               i = 0;
               while(i < arr.length)
               {
                  type = int(arr[i * 3]);
                  id = int(arr[i * 3 + 1]);
                  num = int(arr[i * 3 + 2]);
                  head = ComboTweenStep.getUpAndToBag(me,700,1000,-100,-20);
                  switch(type)
                  {
                     case 1:
                        imgDir = Data_lib.item[id][Enum_lib_item.STR_ICON];
                        break;
                     case 2:
                        imgDir = Data_lib.item[id][Enum_lib_equip.STR_ICON];
                  }
                  imgDir = "resource/image/icon/" + imgDir + ".png";
                  bm = Utils.getLoadBitmap(imgDir);
                  bm.x = me.localToGlobal(new Point(0,0)).x - 20;
                  GameScene.popupLayer.addChild(bm);
                  Tween.playComboStep(bm,head);
                  head.next.endFun = function():void
                  {
                     GameScene.popupLayer.removeChild(bm);
                  };
                  i += 3;
               }
            }
            SHOWAWARD();
         }
         else if(reason == 2)
         {
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,function tempFun():void
            {
               SHOWAWARD();
               Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,tempFun);
            });
         }
      }
      
      public static function SHOWAWARD() : void
      {
         var arr1:Array = null;
         if(!INFOS)
         {
            return;
         }
         var arr:Array = [];
         var i:int = 0;
         while(i < INFOS.length)
         {
            arr.push([INFOS[i],INFOS[i + 1],INFOS[i + 2]]);
            i += 3;
         }
         for each(arr1 in arr)
         {
            UIManager.selfBroadcast.showGetItemGC(arr1,true);
         }
         INFOS = null;
      }
      
      public static function GC_TIMEON() : void
      {
         Model_FeiXingQi.version = -1;
         DailyRemainManager.setCount(DailyRemainManager.CG,2);
         Model_FeiXingQi.countTimes(2);
         UIManager.feiXingQiPanel.feiXingQi.refreshIm();
         UIManager.feiXingQiPanel.visible = false;
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("20242",2));
      }
      
      public static function GC_FXQACCINFO(cost:int) : void
      {
         var str:String = LangConfig.getWord("20243",2,cost.toString());
         ModalUIManager.fxqPromty.show(str,View_Alert.OK_CANCAL,function(evt:MouseEvent):void
         {
            FeiXingQiCGMessage.CG_FXQACCELERATE(Model_FeiXingQi.version);
         });
      }
      
      public static function GC_TOUREMAIN(remain:int) : void
      {
         UIManager.feiXingQiPanel.touCDRemain = remain;
      }
   }
}

