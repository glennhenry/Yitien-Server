package com.yiTian.view.modules.activity
{
   import com.ui.containers.Canvas;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.command.IBindViewer;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class Child_ActivityDaily extends Sprite implements IBindViewer
   {
      
      private var canvas:Canvas;
      
      private var _childVec:Vector.<Cla>;
      
      private var selectedMask:DisplayObject;
      
      private const OFFSET:Number = 32;
      
      private const X:Number = 0;
      
      private const Y:Number = 0;
      
      public function Child_ActivityDaily()
      {
         super();
         this.canvas = new Canvas(350,295);
         addChild(this.canvas);
         addEventListener(MouseEvent.CLICK,this.clickHd);
         this.selectedMask = ComponentUtil.getBitmap("RenWu_Select");
         Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.lvHd);
      }
      
      private function clickHd(event:MouseEvent) : void
      {
         var target:Cla = null;
         var panel:View_ActivityMainPanel = null;
         var arr1:Array = null;
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
            panel = UIManager.amPanel;
            target.addChild(this.selectedMask);
            panel.actDescript = target.descript;
            panel.timeDescript = target.timeDescript;
            arr1 = target.str_reward.split(",");
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
         dic = Data_lib.mrrw;
         this._childVec = new Vector.<Cla>();
         for(key in dic)
         {
            c = new Cla();
            c.id = int(key);
            c.y = this.Y + this.OFFSET * i;
            c.x = this.X;
            c.init(dic[key]);
            this._childVec.push(c);
            this.canvas.addChild(c);
            i += 1;
         }
         this.canvas.align();
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            DailyActCGMessage.CG_DAILYACT();
            this._childVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         super.visible = value;
      }
      
      private function lvHd(lv:int) : void
      {
         var c:Cla = null;
         for each(c in this._childVec)
         {
            c.lvHd(lv);
         }
      }
      
      public function update(obj:Object) : void
      {
         var arr:Array = obj as Array;
         var i:int = 0;
         while(i < arr.length)
         {
            this._childVec[i].update(arr[i]);
            i += 1;
         }
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.config.Enum_NPC_ID;
import com.yiTian.gameUnit.role.Hero;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.FeiXingQiCGMessage;
import com.yiTian.net.message.cg.LingQiWuHunCGMessage;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.view.modules.FeiXingQi.Model_FeiXingQi;
import com.yiTian.view.modules.activity.Model_actDaily;
import com.yiTian.view.modules.tianTi.Enum_ZhangMenRen;
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
   
   public var mTimesArr:Array;
   
   public var descript:String;
   
   public var timeDescript:String;
   
   public var str_reward:String;
   
   public var lvRequire:int;
   
   public var numFinish:int;
   
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
      this.tf_name = ComponentUtil.getTextField("sb",this,{
         "x":30 - 18,
         "y":5,
         "realWidth":48,
         "color":14013809
      });
      this.tf_name.autoSize = TextFieldAutoSize.CENTER;
      this.tf_lv = ComponentUtil.getTextField("3",this,{
         "x":123 - 18,
         "y":5,
         "realWidth":48,
         "color":14013809
      });
      this.tf_lv.autoSize = TextFieldAutoSize.CENTER;
      this.tf_info = ComponentUtil.getTextField("1",this,{
         "x":216 - 18,
         "y":5,
         "realWidth":48,
         "color":14013809
      });
      this.tf_info.autoSize = TextFieldAutoSize.CENTER;
      this.tf_join = ComponentUtil.getTextField("3",this,{
         "x":310 - 18,
         "y":5,
         "realWidth":48,
         "color":12874300
      });
      this.tf_join.autoSize = TextFieldAutoSize.CENTER;
      this.tf_join.mouseEnabled = true;
      this.tf_join.addEventListener(TextEvent.LINK,this.linkHd);
   }
   
   public function init(arr:Array) : void
   {
      var vip:int = 0;
      var count:int = 0;
      var hero:Hero = GameUnitManager.hero;
      var name:String = arr[0];
      this.mTimesArr = arr[2].toString().split("_");
      if(this.id == 10005)
      {
         count = Enum_ZhangMenRen.getCount(GameUnitManager.hero.level);
         this.tf_info.text = "0/" + count.toString();
      }
      else
      {
         this.tf_info.text = "0/" + this.mTimesArr[vip];
      }
      this.lvRequire = arr[1];
      var joinLink:String = arr[3];
      this.descript = arr[4];
      this.timeDescript = arr[5];
      this.str_reward = arr[6];
      this.tf_name.text = name;
      this.tf_lv.text = this.lvRequire.toString();
      vip = hero.vip;
      this.lvHd(hero.level);
      var str:String = joinLink.replace(/[\(\（][^]+[\)\）]/g,"");
      this.tf_join.htmlText = HtmlUtil.createLink(str);
   }
   
   public function update(i:int) : void
   {
      var times:int = 0;
      var count:int = 0;
      var vip:int = GameUnitManager.hero.vip;
      this.numFinish = i;
      var maxTime:int = int(this.mTimesArr[vip]);
      if(this.id == 10005)
      {
         times = Model_actDaily.getInstance().zmrTimes;
         count = Enum_ZhangMenRen.getCount(GameUnitManager.hero.level);
         this.tf_info.text = this.numFinish.toString() + "/" + count.toString();
         if(this.numFinish >= count)
         {
            if(times >= maxTime)
            {
               this.tf_info.htmlText = LangConfig.getWord("22401",2);
            }
            else
            {
               this.tf_info.htmlText = LangConfig.getWord("22402",2,(maxTime - times).toString());
            }
         }
         else
         {
            this.tf_info.htmlText = LangConfig.getWord("22403",2,this.numFinish.toString(),count.toString());
         }
         return;
      }
      if(i >= maxTime)
      {
         this.tf_info.htmlText = LangConfig.getWord("22401",2);
      }
      else
      {
         this.tf_info.htmlText = LangConfig.getWord("22403",2,i.toString(),maxTime.toString());
      }
   }
   
   public function lvHd(lv:int) : void
   {
      var count:int = 0;
      this.tf_lv.htmlText = lv >= this.lvRequire ? "<font color=\'#00ff00\'>" + this.lvRequire.toString() + "</font>" : "<font color=\'#BD3939\'>" + this.lvRequire.toString() + "</font>";
      if(this.id == 10005)
      {
         count = Enum_ZhangMenRen.getCount(GameUnitManager.hero.level);
         this.tf_info.text = this.numFinish.toString() + "/" + count.toString();
      }
   }
   
   private function linkHd(event:TextEvent) : void
   {
      var hero:Hero = GameUnitManager.hero;
      if(hero.level < this.lvRequire)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("22404",2));
         return;
      }
      var str:String = this.tf_name.text;
      switch(this.id)
      {
         case 10001:
            UIManager.jjc_panel.visible = !UIManager.jjc_panel.visible;
            break;
         case 10002:
            hero.autoMove(Enum_NPC_ID.YTF_WST);
            break;
         case 10003:
            if(!UIManager.lingQiWuHunPanel.visible)
            {
               LingQiWuHunCGMessage.CG_LINGQIWUHUN();
            }
            UIManager.lingQiWuHunPanel.visible = !UIManager.lingQiWuHunPanel.visible;
            break;
         case 10004:
            hero.autoMove(Enum_NPC_ID.YTF_TTSZ);
            break;
         case 10005:
            UIManager.tianTiPanel.visible = !UIManager.tianTiPanel.visible;
            break;
         case 10006:
            if(!UIManager.feiXingQiPanel.visible)
            {
               FeiXingQiCGMessage.CG_FXQINFO(Model_FeiXingQi.version);
            }
            break;
         case 10007:
            hero.autoMove(Enum_NPC_ID.YTF_LIBIAOTOU);
      }
   }
}
