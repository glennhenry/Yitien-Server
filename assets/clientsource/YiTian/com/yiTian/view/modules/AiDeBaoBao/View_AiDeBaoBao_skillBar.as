package com.yiTian.view.modules.AiDeBaoBao
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_AiDeBaoBao;
   import com.yiTian.effects.CoolDown;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.AiDeBaoBaoCGMessage;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   
   public class View_AiDeBaoBao_skillBar extends Panel
   {
      
      private static var _instance:View_AiDeBaoBao_skillBar;
      
      private var btnArray:Array;
      
      private var CDArray:Array;
      
      private var timer1:Timer;
      
      private var timer2:Timer;
      
      private var timer3:Timer;
      
      private var timer4:Timer;
      
      private const cd1:int = 30;
      
      private const cd2:int = 10;
      
      private const cd3:int = 10;
      
      private const cd4:int = 10;
      
      private const explain1:String = "<font color=\'#ffff00\'>加速</font><br/>" + "<font color=\'#ffff00\'>效果：</font>自身移动速度提高<font color=\'#ffff00\'>50%</font><br/>" + "<font color=\'#ffff00\'>持续：</font>5秒<br/>" + "<font color=\'#ffff00\'>目标：</font>自身<br/>" + "<font color=\'#ffff00\'>操作：</font>点击施放/快捷键<font color=\'#ffff00\'>1</font>施放<br/>" + "<font color=\'#ff0000\'>仅限拥抱者使用</font><br/>" + "本次使用";
      
      private const explain2:String = "<font color=\'#ffff00\'>免疫</font><br/>" + "<font color=\'#ffff00\'>效果：</font>消除自身<font color=\'#ffff00\'>定身</font>效果，" + "并且在持续期间内<font color=\'#ffff00\'>免疫负面buff</font><br/>" + "<font color=\'#ffff00\'>持续：</font>3秒<br/>" + "<font color=\'#ffff00\'>目标：</font>自身<br/>" + "<font color=\'#ffff00\'>操作：</font>点击施放/快捷键<font color=\'#ffff00\'>2</font>施放<br/>" + "<font color=\'#ff0000\'>仅限拥抱者使用</font><br/>" + "本次使用";
      
      private const explain3:String = "<font color=\'#ffff00\'>定身</font><br/>" + "<font color=\'#ffff00\'>效果：</font>目标定身<font color=\'#ffff00\'>（目标可释放技能）</font><br/>" + "<font color=\'#ffff00\'>持续：</font>3秒<br/>" + "<font color=\'#ffff00\'>目标：</font>他人<br/>" + "<font color=\'#ffff00\'>操作：</font>点击目标后，点击技能施放/快捷键<font color=\'#ffff00\'>3</font>施放<br/>" + "<font color=\'#ff0000\'>仅限被拥抱者使用</font><br/>" + "本次使用";
      
      private const explain4:String = "<font color=\'#ffff00\'>眩晕</font><br/>" + "<font color=\'#ffff00\'>效果：</font>目标眩晕<font color=\'#ffff00\'>（目标不可释放技能）</font><br/>" + "<font color=\'#ffff00\'>持续：</font>3秒<br/>" + "<font color=\'#ffff00\'>目标：</font>他人<br/>" + "<font color=\'#ffff00\'>操作：</font>点击目标后，点击技能施放/快捷键<font color=\'#ffff00\'>4</font>施放<br/>" + "<font color=\'#ff0000\'>仅限被拥抱者使用</font><br/>" + "本次使用";
      
      private var tips:MyTextField;
      
      private var tips2:MyTextField;
      
      private var tips3:MyTextField;
      
      private var skillAllFrame:ScaleBitmap;
      
      public function View_AiDeBaoBao_skillBar()
      {
         super();
         super.init();
      }
      
      public static function get instance() : View_AiDeBaoBao_skillBar
      {
         if(!_instance)
         {
            _instance = new View_AiDeBaoBao_skillBar();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         var coolDown1:CoolDown = null;
         var coolDown2:CoolDown = null;
         var coolDown3:CoolDown = null;
         var coolDown4:CoolDown = null;
         ComponentUtil.getBitmap("Back_Skill",this,{
            "x":0,
            "y":0
         },Global.ADBB_Imgsdm);
         ComponentUtil.getBitmap("Grid_red",this,{
            "x":61,
            "y":22
         },Global.ADBB_Imgsdm);
         ComponentUtil.getBitmap("Grid_red",this,{
            "x":161,
            "y":22
         },Global.ADBB_Imgsdm);
         ComponentUtil.getBitmap("Grid_red",this,{
            "x":111,
            "y":22
         },Global.ADBB_Imgsdm);
         ComponentUtil.getBitmap("Grid_red",this,{
            "x":211,
            "y":22
         },Global.ADBB_Imgsdm);
         this.tips = ComponentUtil.getTextField("查看技能信息",this,{
            "x":153,
            "y":-58,
            "color":16776960,
            "size":14,
            "leading":4
         },"center");
         this.tips.visible = false;
         this.btnArray = [];
         this.CDArray = [];
         var btn1:Button = ComponentUtil.getButton("","Button_JiaSu",this,{
            "x":64,
            "y":25,
            "textColor":16184781
         },Global.ADBB_Imgsdm);
         btn1.labelSize = 22;
         TipManager.bind(btn1,this.explain1);
         btn1.callBack = this.skillBtn;
         this.btnArray.push(btn1);
         this.timer1 = new Timer(1000);
         this.timer1.addEventListener(TimerEvent.TIMER,this.onTimer);
         coolDown1 = new CoolDown(34);
         coolDown1.x = 64;
         coolDown1.y = 25;
         addChild(coolDown1);
         coolDown1.percent = 1;
         this.CDArray.push(coolDown1);
         var btn2:Button = ComponentUtil.getButton("","Button_MianYi",this,{
            "x":114,
            "y":25,
            "textColor":16184781
         },Global.ADBB_Imgsdm);
         btn2.labelSize = 22;
         TipManager.bind(btn2,this.explain2);
         btn2.callBack = this.skillBtn;
         this.btnArray.push(btn2);
         this.timer2 = new Timer(1000);
         this.timer2.addEventListener(TimerEvent.TIMER,this.onTimer);
         coolDown2 = new CoolDown(34);
         coolDown2.x = 114;
         coolDown2.y = 25;
         addChild(coolDown2);
         coolDown2.percent = 1;
         this.CDArray.push(coolDown2);
         var btn3:Button = ComponentUtil.getButton("","Button_DingShen",this,{
            "x":164,
            "y":25,
            "textColor":16184781
         },Global.ADBB_Imgsdm);
         btn3.labelSize = 22;
         TipManager.bind(btn3,this.explain3);
         btn3.callBack = this.skillBtn;
         this.btnArray.push(btn3);
         this.timer3 = new Timer(1000);
         this.timer3.addEventListener(TimerEvent.TIMER,this.onTimer);
         coolDown3 = new CoolDown(34);
         coolDown3.x = 164;
         coolDown3.y = 25;
         addChild(coolDown3);
         coolDown3.percent = 1;
         this.CDArray.push(coolDown3);
         var btn4:Button = ComponentUtil.getButton("","Button_XuanYun",this,{
            "x":214,
            "y":25,
            "textColor":16184781
         },Global.ADBB_Imgsdm);
         btn4.labelSize = 22;
         TipManager.bind(btn4,this.explain4);
         btn4.callBack = this.skillBtn;
         this.btnArray.push(btn4);
         this.timer4 = new Timer(1000);
         this.timer4.addEventListener(TimerEvent.TIMER,this.onTimer);
         coolDown4 = new CoolDown(34);
         coolDown4.x = 214;
         coolDown4.y = 25;
         addChild(coolDown4);
         coolDown4.percent = 1;
         this.CDArray.push(coolDown4);
         bAutoRemove = false;
         Global.control.registerCallBack(Enum_AiDeBaoBao.GUIDE_SKILL_TIPS,this.onSkillTips);
      }
      
      public function onPointToCheckSkill() : void
      {
         this.skillAllFrame = ComponentUtil.getScaleBitmap("Kuang",[20,10,10,10],this,{
            "x":29,
            "y":14,
            "width":255,
            "height":56
         },Global.ADBB_Imgsdm);
         this.skillAllFrame.transform.colorTransform = Util.blue;
         this.tips.visible = true;
         setTimeout(function():void
         {
            if(Boolean(skillAllFrame.parent))
            {
               skillAllFrame.parent.removeChild(skillAllFrame);
            }
            tips.visible = false;
         },Enum_AiDeBaoBao.GUIDE_SHOW_TIMES);
      }
      
      private function onSkillTips(e:int) : void
      {
         var tips1:MyTextField = null;
         var tips2:MyTextField = null;
         var tips3:MyTextField = null;
         switch(e)
         {
            case 1:
               tips1 = ComponentUtil.getTextField("你可以使用加速技能哦",this,{
                  "x":80,
                  "y":-80,
                  "color":16776960,
                  "size":12,
                  "leading":4
               },"center");
               setTimeout(function():void
               {
                  tips1.visible = false;
               },Enum_AiDeBaoBao.GUIDE_SHOW_TIMES);
               break;
            case 2:
               tips2 = ComponentUtil.getTextField("你可以使用免疫技能哦",this,{
                  "x":130,
                  "y":-60,
                  "color":16776960,
                  "size":12,
                  "leading":4
               },"center");
               setTimeout(function():void
               {
                  tips2.visible = false;
               },Enum_AiDeBaoBao.GUIDE_SHOW_TIMES);
               break;
            case 3:
               tips3 = ComponentUtil.getTextField("你可以尝试使用恶搞技能哦",this,{
                  "x":205,
                  "y":-70,
                  "color":16776960,
                  "size":12,
                  "leading":4
               },"center");
               setTimeout(function():void
               {
                  tips3.visible = false;
               },Enum_AiDeBaoBao.GUIDE_SHOW_TIMES);
         }
      }
      
      private function onTimer(e:TimerEvent) : void
      {
         var curTime:int = 0;
         switch(e.currentTarget)
         {
            case this.timer1:
               curTime = this.cd1 - this.timer1.currentCount;
               if(curTime > 0)
               {
                  this.btnArray[0].label = String(curTime);
                  this.CDArray[0].percent = this.timer1.currentCount / this.cd1;
                  break;
               }
               this.btnArray[0].label = "";
               this.CDArray[0].percent = 1;
               this.timer1.reset();
               break;
            case this.timer2:
               curTime = this.cd2 - this.timer2.currentCount;
               if(curTime > 0)
               {
                  this.btnArray[1].label = String(curTime);
                  this.CDArray[1].percent = this.timer2.currentCount / this.cd2;
                  break;
               }
               this.btnArray[1].label = "";
               this.CDArray[1].percent = 1;
               this.timer2.reset();
               break;
            case this.timer3:
               curTime = this.cd3 - this.timer3.currentCount;
               if(curTime > 0)
               {
                  this.btnArray[2].label = String(curTime);
                  this.CDArray[2].percent = this.timer3.currentCount / this.cd3;
                  break;
               }
               this.btnArray[2].label = "";
               this.CDArray[2].percent = 1;
               this.timer3.reset();
               break;
            case this.timer4:
               curTime = this.cd4 - this.timer4.currentCount;
               if(curTime > 0)
               {
                  this.btnArray[3].label = String(curTime);
                  this.CDArray[3].percent = this.timer4.currentCount / this.cd4;
                  break;
               }
               this.btnArray[3].label = "";
               this.CDArray[3].percent = 1;
               this.timer4.reset();
         }
      }
      
      private function skillBtn(e:MouseEvent) : void
      {
         var distanceX:int = 0;
         var distanceY:int = 0;
         if(e.currentTarget.label.length > 0)
         {
            UIManager.centerBroadcast.addMsg("技能冷却中");
            return;
         }
         if(View_AiDeBaoBao_findPartner.instance.totalTime > 1200)
         {
            UIManager.centerBroadcast.addMsg("活动还未开始，不能使用技能");
            return;
         }
         if(View_AiDeBaoBao_findPartner.instance.partner == 0)
         {
            UIManager.centerBroadcast.addMsg("拥抱/被拥抱后才能使用技能");
            return;
         }
         var limitDistanceX:int = Global.stage.stageWidth / 2;
         var limitDistanceY:int = Global.stage.stageHeight / 2;
         switch(e.currentTarget)
         {
            case this.btnArray[0]:
               if(GameUnitManager.hero.status != Status.AiDeBaoBao_Bao)
               {
                  UIManager.centerBroadcast.addMsg("你不可使用此技能");
                  break;
               }
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_SKILL_CAST(GameUnitManager.hero.id,1,GameUnitManager.hero.zoneId);
               break;
            case this.btnArray[1]:
               if(GameUnitManager.hero.status != Status.AiDeBaoBao_Bao)
               {
                  UIManager.centerBroadcast.addMsg("你不可使用此技能");
                  break;
               }
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_SKILL_CAST(GameUnitManager.hero.id,2,GameUnitManager.hero.zoneId);
               break;
            case this.btnArray[2]:
               if(GameUnitManager.hero.status != Status.AiDeBaoBao_BeiBao)
               {
                  UIManager.centerBroadcast.addMsg("你不可使用此技能");
                  break;
               }
               if(!AiDeBaoBao_control.target || !(AiDeBaoBao_control.target is Player))
               {
                  UIManager.centerBroadcast.addMsg("此技能需要选定一个目标");
                  break;
               }
               distanceX = Math.abs(AiDeBaoBao_control.target.global_x - GameUnitManager.hero.global_x);
               distanceY = Math.abs(AiDeBaoBao_control.target.global_y - GameUnitManager.hero.global_y);
               if(distanceX > limitDistanceX || distanceY > limitDistanceY)
               {
                  UIManager.centerBroadcast.addMsg("超出技能范围");
                  break;
               }
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_SKILL_CAST(AiDeBaoBao_control.target.id,3,AiDeBaoBao_control.target.zoneId);
               break;
            case this.btnArray[3]:
               if(GameUnitManager.hero.status != Status.AiDeBaoBao_BeiBao)
               {
                  UIManager.centerBroadcast.addMsg("你不可使用此技能");
                  break;
               }
               if(!AiDeBaoBao_control.target || !(AiDeBaoBao_control.target is Player))
               {
                  UIManager.centerBroadcast.addMsg("此技能需要选定一个目标");
                  break;
               }
               distanceX = Math.abs(AiDeBaoBao_control.target.global_x - GameUnitManager.hero.global_x);
               distanceY = Math.abs(AiDeBaoBao_control.target.global_y - GameUnitManager.hero.global_y);
               if(distanceX > limitDistanceX || distanceY > limitDistanceY)
               {
                  UIManager.centerBroadcast.addMsg("超出技能范围");
                  break;
               }
               AiDeBaoBaoCGMessage.CG_AiDeBaoBao_SKILL_CAST(AiDeBaoBao_control.target.id,4,AiDeBaoBao_control.target.zoneId);
         }
      }
      
      public function setSkillCD(id:int) : void
      {
         switch(id)
         {
            case 1:
               this.timer1.start();
               break;
            case 2:
               this.timer2.start();
               break;
            case 3:
               this.timer3.start();
               break;
            case 4:
               this.timer4.start();
         }
      }
      
      public function setSkillTimes(id:int, times:int) : void
      {
         var str:String = "<font color=\'#ffff00\'>免费</font>";
         if(times > 0)
         {
            str = "需花费<font color=\'#ffff00\'>20元宝</font>";
         }
         TipManager.bind(this.btnArray[id - 1],this["explain" + id] + str);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = Global.stage.stageHeight - 80 - 55;
      }
      
      public function get BtnArray() : Array
      {
         return this.btnArray;
      }
   }
}

