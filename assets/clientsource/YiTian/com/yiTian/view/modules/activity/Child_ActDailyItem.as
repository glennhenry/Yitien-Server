package com.yiTian.view.modules.activity
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.command.IBindViewer;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.boatChall.EnterBtn;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class Child_ActDailyItem extends Sprite implements IBindViewer
   {
      
      private var canvas:Canvas;
      
      private var vec:Vector.<Cla>;
      
      private var selectedMask:DisplayObject;
      
      private const OFFSET:Number = 32;
      
      private const X:Number = 0;
      
      private const Y:Number = 0;
      
      private var _effDic:Object = {};
      
      public function Child_ActDailyItem()
      {
         super();
         this.canvas = new Canvas(350,295);
         this.canvas.scrollAutoType = ScrollAutoType.TO_TOP;
         this.vec = new Vector.<Cla>();
         addChild(this.canvas);
         addEventListener(MouseEvent.CLICK,this.clickHd);
         this.selectedMask = ComponentUtil.getBitmap("RenWu_Select");
         Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.lvHd);
      }
      
      private function clickHd(event:MouseEvent) : void
      {
         var target:Cla = null;
         var arr1:Array = null;
         var panel:View_ActivityMainPanel = null;
         var descrpit:String = null;
         var arr2:Array = null;
         var i:int = 0;
         var type:String = null;
         var id:String = null;
         var vo_item:Vo_item = null;
         var vo_equip:Vo_equip = null;
         if(event.target is Cla)
         {
            event.stopPropagation();
            target = event.target as Cla;
            arr1 = target.str_reward.split(",");
            panel = UIManager.amPanel;
            descrpit = target.descript;
            if(target.isHasDetailed == 1)
            {
               descrpit += HtmlUtil.createLink("<font color=\'#00aa00\'>" + LangConfig.getWord("21213",2) + "</font>",true,target.id.toString());
            }
            panel.actDescript = descrpit;
            panel.timeDescript = target.timeDescript;
            target.addChild(this.selectedMask);
            arr2 = [];
            i = 0;
            while(i < arr1.length)
            {
               type = arr1[i].substr(0,1);
               id = arr1[i].substr(2,arr1[i].length);
               if(type == "1")
               {
                  vo_item = new Vo_item();
                  vo_item.id = int(id);
                  vo_item.Init_lib();
                  arr2.push(vo_item);
               }
               else
               {
                  vo_equip = new Vo_equip();
                  vo_equip.id = int(id);
                  vo_equip.Init_lib();
                  arr2.push(vo_equip);
               }
               i += 1;
            }
            panel.gridVoArr = arr2;
         }
      }
      
      public function init() : void
      {
         var dic:Dictionary = null;
         var i:int = 0;
         var key:String = null;
         var c:Cla = null;
         dic = Data_lib.mrhd;
         for(key in dic)
         {
            c = new Cla();
            c.id = int(key);
            c.y = this.Y + this.OFFSET * i;
            c.x = this.X;
            c.init(dic[key]);
            this.canvas.addChild(c);
            this.vec.push(c);
            i += 1;
         }
         this.canvas.align();
      }
      
      public function actionClihd(_type:int) : void
      {
         this.vec[_type].public::linkHd();
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:int = 0;
         var arr:Array = null;
         var tempIndex:int = 0;
         var key:String = null;
         if(value)
         {
            this.update(Model_actDaily.getInstance().rchdArr.getData());
            if(Model_actDaily.getInstance().hasAct() || EnterBtn.isStarting)
            {
               arr = Model_actDaily.getInstance().rchdArr.getData() as Array;
               tempIndex = 0;
               while(i < arr.length)
               {
                  if(Boolean(arr[i]))
                  {
                     if(tempIndex == 0)
                     {
                        tempIndex = i;
                     }
                     this.vec[i].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                     if(!this._effDic[i])
                     {
                        this._effDic[i] = EffectManager.addEffect("35075",this.canvas,1000,306,this.OFFSET * i + 15,true);
                     }
                     if(!this.vec[i].isEnabed)
                     {
                        this.vec[i].isEnabed = true;
                     }
                  }
                  else
                  {
                     this.vec[i].isEnabed = false;
                     if(Boolean(this._effDic[i]))
                     {
                        EffectManager.removeEffect(this._effDic[i]);
                        delete this._effDic[i];
                     }
                  }
                  i += 1;
               }
               if(EnterBtn.isStarting)
               {
                  this.vec[12].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                  if(!this._effDic[12])
                  {
                     this._effDic[12] = EffectManager.addEffect("35075",this.canvas,1000,306,this.OFFSET * 12 + 15,true);
                  }
                  if(!this.vec[12].isEnabed)
                  {
                     this.vec[12].isEnabed = true;
                  }
               }
               else
               {
                  this.vec[12].isEnabed = false;
                  if(Boolean(this._effDic[12]))
                  {
                     EffectManager.removeEffect(this._effDic[12]);
                     delete this._effDic[12];
                  }
               }
               this.setBarPos(arr.length,tempIndex);
            }
            else
            {
               this.vec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
         }
         else
         {
            for(key in this._effDic)
            {
               this.vec[i].isEnabed = false;
               EffectManager.removeEffect(this._effDic[key]);
               delete this._effDic[key];
            }
         }
         super.visible = value;
      }
      
      public function setBarPos(maxLen:int, curLen:int) : void
      {
         if(curLen < 8)
         {
            this.canvas.align();
            return;
         }
         this.canvas.setScrollView(curLen / maxLen);
      }
      
      public function lvHd(lv:int) : void
      {
         var c:Cla = null;
         for each(c in this.vec)
         {
            c.lvHd(lv);
         }
      }
      
      public function start() : void
      {
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
      }
      
      public function stop() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
      }
      
      private function onFrame(interval:int) : void
      {
         var o:Cla = null;
         if(!visible)
         {
            return;
         }
         for each(o in this.vec)
         {
            o.onFrame(interval);
         }
      }
      
      public function update(obj:Object) : void
      {
         var arr:Array = obj as Array;
         var counter:int = 0;
         var i:int = 0;
         while(i < arr.length)
         {
            if(Boolean(arr[i]))
            {
               counter += 1;
            }
            this.vec[i].update(arr[i]);
            i += 1;
         }
         this.longZhouUpdate();
      }
      
      public function longZhouUpdate() : void
      {
         if(EnterBtn.isStarting)
         {
            this.vec[12].update(true);
            this.vec[12].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            if(!this._effDic[12])
            {
               this._effDic[12] = EffectManager.addEffect("35075",this.canvas,1000,306,this.OFFSET * 12 + 15,true);
            }
            if(!this.vec[12].isEnabed)
            {
               this.vec[12].isEnabed = true;
            }
         }
         else
         {
            this.vec[12].update(false);
            this.vec[12].isEnabed = false;
            if(Boolean(this._effDic[12]))
            {
               EffectManager.removeEffect(this._effDic[12]);
               delete this._effDic[12];
            }
         }
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.data.config.Enum_NPC_ID;
import com.yiTian.data.model.Model_team;
import com.yiTian.gameUnit.role.Hero;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.WulinPartyCGMessage;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.view.comp.View_Alert;
import com.yiTian.view.modules.KuaFuPaiDui.View_KuaFuPaiDui_rank;
import com.yiTian.view.modules.KuaFuPaiDui.View_KuaFuPaiDui_serverChoiceMenu;
import com.yiTian.view.modules.activity.Model_actDaily;
import com.yiTian.view.modules.boatChall.EnterBtn;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.TextEvent;
import flash.text.TextFieldAutoSize;

class Cla extends Sprite
{
   
   private var tf_name:MyTextField;
   
   private var tf_lv:MyTextField;
   
   private var tf_info:MyTextField;
   
   private var tf_join:MyTextField;
   
   private var line:DisplayObject;
   
   public var id:int;
   
   public var descript:String;
   
   public var timeDescript:String;
   
   public var str_reward:String;
   
   public var lvRequire:int;
   
   public var isHasDetailed:Boolean;
   
   public var isEnabed:Boolean = false;
   
   private var counter:int;
   
   private var step:int;
   
   private var _txtArr:Array;
   
   public function Cla()
   {
      super();
      graphics.beginFill(0,0);
      graphics.drawRect(1,0,348,30);
      graphics.endFill();
      this.line = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "x":0,
         "y":31,
         "width":350,
         "height":2
      },Global.Img_Cdm);
      this.tf_name = ComponentUtil.getTextField("2b",this,{
         "x":30 - 18,
         "y":6,
         "realWidth":48,
         "color":14013809
      });
      this.tf_name.autoSize = TextFieldAutoSize.CENTER;
      this.tf_lv = ComponentUtil.getTextField("3",this,{
         "x":123 - 18,
         "y":6,
         "realWidth":48,
         "color":14013809
      });
      this.tf_lv.autoSize = TextFieldAutoSize.CENTER;
      this.tf_info = ComponentUtil.getTextField("1",this,{
         "x":216 - 18,
         "y":6,
         "realWidth":48,
         "color":14013809
      });
      this.tf_info.autoSize = TextFieldAutoSize.CENTER;
      this.tf_join = ComponentUtil.getTextField("3",this,{
         "x":310 - 28,
         "y":6,
         "realWidth":48,
         "color":12874300
      });
      this.tf_join.autoSize = TextFieldAutoSize.CENTER;
      this.tf_join.mouseEnabled = true;
      this.tf_join.addEventListener(TextEvent.LINK,this.linkHd);
   }
   
   public function init(arr:Array) : void
   {
      var hero:Hero = GameUnitManager.hero;
      var name:String = arr[0];
      this.lvRequire = arr[1];
      var joinLink:String = arr[2];
      this.descript = arr[3];
      this.timeDescript = arr[4];
      this.str_reward = arr[5];
      this.isHasDetailed = arr[6] == 1 ? true : false;
      this.tf_name.text = name;
      this.tf_lv.text = this.lvRequire.toString();
      this.tf_info.text = LangConfig.getWord("29152",2);
      var str:String = joinLink.replace(/[\(\（][^]+[\)\）]/g,"");
      this.tf_join.htmlText = HtmlUtil.createLink(str);
      this.lvHd(hero.level);
   }
   
   public function lvHd(lv:int) : void
   {
      this.tf_lv.htmlText = "";
      this.tf_lv.htmlText = lv >= this.lvRequire ? "<font color=\'#00ff00\'>" + this.lvRequire.toString() + "</font>" : "<font color=\'#BD3939\'>" + this.lvRequire.toString() + "</font>";
   }
   
   public function update(b:Boolean) : void
   {
      this.tf_info.bold = b;
      this.isEnabed = b;
      this.tf_info.htmlText = b ? "<font size=\'14\' color=\'#33ccff\'>" + LangConfig.getWord("29153",2) + "</font>" : LangConfig.getWord("29152",2);
      var _temp_1:* = this;
      this.step = 0;
      _temp_1.counter = 0;
   }
   
   public function onFrame(interval:int) : void
   {
      var dot:String = null;
      var i:int = 0;
      if(!this.isEnabed)
      {
         return;
      }
      this.counter += interval;
      if(this.counter > 500)
      {
         this.step += 1;
         this.counter = 0;
         dot = "";
         i = 0;
         while(i < this.step % 5)
         {
            dot += ".";
            i += 1;
         }
         this.tf_info.htmlText = "<font size=\'14\' color=\'#33ccff\'>" + LangConfig.getWord("29153",2) + dot + "</font>";
      }
   }
   
   public function linkHd(event:TextEvent = null) : void
   {
      var hero:Hero = null;
      var tmpArr:Array = null;
      var lv:int = 0;
      var i:int = 0;
      hero = GameUnitManager.hero;
      if(hero.level < this.lvRequire)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("22404",2));
         return;
      }
      loop2:
      switch(this.id)
      {
         case 20001:
            tmpArr = [30,Enum_NPC_ID.YTF_BOX1,45,Enum_NPC_ID.YTF_BOX2,60,Enum_NPC_ID.YTF_BOX3];
            lv = hero.level;
            i = tmpArr.length - 2;
            while(true)
            {
               if(i < 0)
               {
                  break loop2;
               }
               if(lv >= tmpArr[i])
               {
                  break;
               }
               i -= 2;
            }
            hero.autoMove(tmpArr[i + 1]);
            return;
         case 20002:
            if(!this.isEnabed)
            {
               UIManager.centerBroadcast.addMsg(this.txtArr[0]);
               return;
            }
            if(Model_team.hasTeam())
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29154",2));
               return;
            }
            View_Alert.show(LangConfig.getWord("29155",2),View_Alert.OK_CANCAL,Model_actDaily.getInstance().toFish);
            break;
         case 20003:
            if(!this.isEnabed)
            {
               UIManager.centerBroadcast.addMsg(this.txtArr[0]);
               return;
            }
            UIManager.kunlun_prompt.visible = !UIManager.kunlun_prompt.visible;
            break;
         case 20004:
            if(!this.isEnabed)
            {
               UIManager.centerBroadcast.addMsg(this.txtArr[0]);
               return;
            }
            if(Model_team.hasTeam())
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29154",2));
               return;
            }
            View_Alert.show(LangConfig.getWord("29157",2),View_Alert.OK_CANCAL,Model_actDaily.getInstance().toBangBattle);
            break;
         case 20005:
            if(!this.isEnabed)
            {
               UIManager.centerBroadcast.addMsg(this.txtArr[0]);
               return;
            }
            WulinPartyCGMessage.CG_WULIN_ENTER_RESULT_HANDLE();
            break;
         case 20006:
            if(!this.isEnabed)
            {
               UIManager.centerBroadcast.addMsg(this.txtArr[0]);
               return;
            }
            hero.autoMove(Enum_NPC_ID.YTF_LIBIAOTOU);
            break;
         case 20007:
            Global.control.sendNotification(Enum_MsgType.MSG_GUAJIA,null);
            break;
         case 20008:
            if(!this.isEnabed)
            {
               UIManager.centerBroadcast.addMsg(this.txtArr[0]);
               return;
            }
            UIManager.bangPlant.visible = !UIManager.bangPlant.visible;
            break;
         case 20009:
            if(!this.isEnabed)
            {
               UIManager.centerBroadcast.addMsg(this.txtArr[0]);
               return;
            }
            Model_actDaily.getInstance().joinWorldBoss();
            break;
         case 20009:
            if(!this.isEnabed)
            {
               UIManager.centerBroadcast.addMsg(this.txtArr[0]);
               return;
            }
            Model_actDaily.getInstance().joinWorldBoss();
            break;
         case 20010:
            if(!this.isEnabed)
            {
               UIManager.centerBroadcast.addMsg(this.txtArr[0]);
               return;
            }
            Model_actDaily.getInstance().joinLoveHug();
            break;
         case 20011:
            if(!this.isEnabed)
            {
               UIManager.centerBroadcast.addMsg(this.txtArr[0]);
               return;
            }
            Model_actDaily.getInstance().joinKeJuTest();
            break;
         case 20012:
            if(!this.isEnabed)
            {
               UIManager.centerBroadcast.addMsg(this.txtArr[0]);
               return;
            }
            Global.delegate.dosomething(View_KuaFuPaiDui_rank.instance,function():void
            {
               View_KuaFuPaiDui_serverChoiceMenu.instance.visible = true;
            });
            break;
         case 20013:
            if(EnterBtn.isStarting)
            {
               if(GameUnitManager.hero.level < 55)
               {
                  UIManager.centerBroadcast.addMsg("龙舟比赛要求等级是55级",1);
                  break;
               }
               EnterBtn.instance.clickEvent();
               break;
            }
            UIManager.centerBroadcast.addMsg("该活动尚未开始");
      }
   }
   
   private function get txtArr() : Array
   {
      if(!this._txtArr)
      {
         this._txtArr = [LangConfig.getWord("29156",2)];
      }
      return this._txtArr;
   }
}
