package com.yiTian.view.modules.keJu
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_KeJu;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_KeJu;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KejuCGMessage;
   import com.yiTian.view.NpcPanel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class View_Keju extends NpcPanel
   {
      
      private static var _instance:View_Keju;
      
      private const READTIME:int = 5;
      
      private const WRITETIME:int = 10;
      
      private var eff:Effect;
      
      private var effSp:Sprite;
      
      public var hideFun:Function;
      
      private var countTime:int;
      
      private var startTime2:Number;
      
      private var readTime:int;
      
      private var writeTime:int;
      
      private var startTime:Number;
      
      private var isChoose:Boolean;
      
      private var back:Sprite;
      
      private var titleBg:Bitmap;
      
      private var endBitmap:Bitmap;
      
      private var typeTF:MyTextField;
      
      private var titleTF:MyTextField;
      
      private var leftTimeTF:MyTextField;
      
      private var leftQuestionTF:MyTextField;
      
      private var countTF:MyTextField;
      
      private var numTF:MyTextField;
      
      private var countTimeTF:MyTextField;
      
      public var luckyStar:KeJuStarContainer;
      
      public var caishenStar:KeJuStarContainer;
      
      private var answerArr:Vector.<Answer_Item>;
      
      private var rankArr:Vector.<RankItem>;
      
      private var isFirst:Boolean = true;
      
      public function View_Keju()
      {
         super();
         init();
      }
      
      public static function get instance() : View_Keju
      {
         if(!_instance)
         {
            _instance = new View_Keju();
         }
         return _instance;
      }
      
      public function playEff(type:int) : void
      {
         if(!this.effSp)
         {
            this.effSp = new Sprite();
            addChild(this.effSp);
         }
         var str:String = type == 1 ? "35106" : "35107";
         this.eff = EffectManager.addEffect(str,this.effSp,3000,265,300,false,3,this.playComFun);
      }
      
      private function playComFun() : void
      {
         if(this.hideFun != null)
         {
            this.hideFun();
            this.hideFun = null;
         }
      }
      
      public function endKeju() : void
      {
         if(this.endBitmap != null)
         {
            this.endBitmap.visible = true;
         }
         this.hideAnswer();
         this.titleTF.visible = this.leftQuestionTF.visible = this.leftTimeTF.visible = false;
         this.caishenStar.dispose(false);
         this.luckyStar.dispose(false);
         if(Global.control.hasCallBack(Enum_MsgType.MSG_ENTERFRAME,this.loopHandler))
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.loopHandler);
         }
         if(Global.control.hasCallBack(Enum_MsgType.MSG_ENTERFRAME,this.changTime))
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.changTime);
         }
      }
      
      public function addScoresFly() : void
      {
         if(!visible)
         {
            return;
         }
         var startPoint:Point = new Point(Global.stage.stageWidth / 2,Global.stage.stageHeight / 2);
         var endPoint:Point = localToGlobal(new Point(this.countTF.x + 95,this.countTF.y + 75));
         EffectManager.flyEff(startPoint,endPoint);
      }
      
      public function changTools(caishenNum:int, luckyNum:int) : void
      {
         this.caishenStar.updata(caishenNum);
         this.luckyStar.updata(luckyNum);
      }
      
      public function disAnswer(lock:Boolean) : void
      {
         var item:Answer_Item = null;
         var num:int = Model_KeJu.answernum - 1;
         var i:int = 0;
         while(i < this.answerArr.length)
         {
            item = this.answerArr[i];
            item.dispose(lock);
            i++;
         }
      }
      
      public function getAnswer(answer:int) : void
      {
         var answerItem:Answer_Item = this.answerArr[answer - 1];
         answerItem.checkBox.selected = true;
         answerItem.chooseAnswer();
         Model_KeJu.isCaishen = 1;
      }
      
      public function changQuestion(id:int, num:int, status:int, answer:int, leftTime:int) : void
      {
         var answerItem:Answer_Item = null;
         if(Boolean(this.endBitmap) && this.endBitmap.visible)
         {
            this.endBitmap.visible = false;
            this.titleTF.visible = this.leftTimeTF.visible = this.leftQuestionTF.visible = true;
         }
         Model_KeJu.questID = id;
         var type:int = int(Data_lib.ExamQuestion[id][0]);
         this.typeTF.text = Data_lib.Examtype[type][0];
         this.titleTF.text = num + "、" + Data_lib.ExamQuestion[id][1];
         this.leftQuestionTF.htmlText = LangConfig.getWord("60180",6) + "<font color=\'#FFFF00\'>" + (Enum_KeJu.MAXNUM - num) + "</font>";
         this.updataAnswer();
         this.startTime = getTimer();
         if(status != 1)
         {
            this.readTime = 0;
            this.writeTime = leftTime;
            this.leftTimeTF.text = LangConfig.getWord("60183",6) + this.writeTime;
            if(answer != 0)
            {
               answerItem = this.answerArr[answer - 1];
               answerItem.checkBox.selected = true;
               answerItem.chooseAnswer();
               this.caishenStar.dispose(false);
               this.luckyStar.dispose(false);
            }
            else
            {
               this.isChoose = false;
               this.canChoose();
            }
         }
         else
         {
            this.readTime = this.READTIME;
            this.leftTimeTF.htmlText = LangConfig.getWord("60184",6) + "<font color=\'#009900\'>" + this.readTime + "</font>";
            this.writeTime = this.WRITETIME + 1;
            Model_KeJu.answernum = 0;
            Model_KeJu.isLucky = 0;
            Model_KeJu.isCaishen = 0;
            this.isChoose = false;
            this.caishenStar.dispose(false);
            this.luckyStar.dispose(false);
         }
         if(!visible)
         {
            return;
         }
         if(Global.control.hasCallBack(Enum_MsgType.MSG_ENTERFRAME,this.loopHandler))
         {
            return;
         }
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.loopHandler);
      }
      
      public function stopChangQuestion() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.loopHandler);
      }
      
      public function updataRank() : void
      {
         var item:RankItem = null;
         var vo:RankVO = null;
         var i:int = 0;
         while(i < 10)
         {
            item = this.rankArr[i];
            if(i <= Model_KeJu.rankArr.length - 1)
            {
               vo = Model_KeJu.rankArr[i];
               item.updata(vo,i + 1);
            }
            else
            {
               item.dispose();
            }
            i++;
         }
      }
      
      public function updatMyInfo(vo:MyInfoVO) : void
      {
         this.countTF.text = LangConfig.getWord("60181",6) + vo.count;
         this.numTF.text = LangConfig.getWord("80041",8) + vo.num;
         this.countTimeTF.text = LangConfig.getWord("60182",6) + DateUtil.getMSBySecond3(vo.time);
         this.countTime = vo.time;
         this.startTime2 = getTimer();
         if(Global.control.hasCallBack(Enum_MsgType.MSG_ENTERFRAME,this.changTime))
         {
            return;
         }
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.changTime);
      }
      
      private function changTime() : void
      {
         if(Boolean(this.endBitmap) && this.endBitmap.visible)
         {
            if(Global.control.hasCallBack(Enum_MsgType.MSG_ENTERFRAME,this.changTime))
            {
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.changTime);
            }
         }
         if(getTimer() - this.startTime2 > 1000)
         {
            this.countTimeTF.text = LangConfig.getWord("60182",6) + DateUtil.getMSBySecond3(++this.countTime);
            if(this.countTime == 0)
            {
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.changTime);
            }
            this.startTime2 = getTimer();
         }
      }
      
      private function hideAnswer() : void
      {
         var item:Answer_Item = null;
         for each(item in this.answerArr)
         {
            item.hide();
         }
      }
      
      private function updataAnswer() : void
      {
         var item:Answer_Item = null;
         var i:int = 0;
         while(i < 4)
         {
            item = this.answerArr[i];
            item.upData(i,Model_KeJu.questID);
            i++;
         }
      }
      
      public function getWriteTime() : int
      {
         return this.writeTime;
      }
      
      private function loopHandler() : void
      {
         if(Boolean(this.endBitmap) && this.endBitmap.visible)
         {
            this.endBitmap.visible = false;
            this.titleTF.visible = this.leftTimeTF.visible = this.leftQuestionTF.visible = true;
         }
         if(getTimer() - this.startTime >= 1000)
         {
            if(this.readTime > 0)
            {
               this.leftTimeTF.htmlText = LangConfig.getWord("60184",6) + "<font color=\'#009900\'>" + --this.readTime + "</font>";
            }
            if(this.readTime == 0)
            {
               this.canChoose();
               if(this.writeTime <= 6)
               {
                  this.leftTimeTF.htmlText = LangConfig.getWord("60183",6) + "<font color=\'#FF0000\'>" + --this.writeTime + "</font>";
               }
               else
               {
                  this.leftTimeTF.text = LangConfig.getWord("60183",6) + --this.writeTime;
               }
               if(this.writeTime == this.WRITETIME)
               {
                  KejuCGMessage.CG_READTIMEOUT(2);
               }
               if(this.writeTime == 0)
               {
                  KejuCGMessage.CG_ANSWERTIMEOUT(Model_KeJu.questID,Model_KeJu.answernum,Model_KeJu.isLucky,Model_KeJu.isCaishen);
                  Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.loopHandler);
               }
            }
            this.startTime = getTimer();
         }
      }
      
      private function canChoose() : void
      {
         if(!this.isChoose)
         {
            this.luckyStar.dispose(true);
            this.caishenStar.dispose(true);
            this.disAnswer(true);
            this.isChoose = true;
         }
      }
      
      override protected function initStaticView() : void
      {
         this.back = new Sprite();
         addChild(this.back);
         this.back.addEventListener(MouseEvent.MOUSE_DOWN,this.downEvent);
         this.back.addEventListener(MouseEvent.MOUSE_UP,upEvent);
         ComponentUtil.getTextField(LangConfig.getWord("60185",6),this,{
            "x":455,
            "y":100,
            "color":16764206,
            "size":14,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60001",6),this,{
            "x":350,
            "y":123,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60186",6),this,{
            "x":471,
            "y":123,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60187",6),this,{
            "x":399,
            "y":123,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60007",6),this,{
            "x":560,
            "y":123,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60189",6),this,{
            "x":80,
            "y":394,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60190",6),this,{
            "x":265,
            "y":394,
            "color":16777215,
            "size":12,
            "leading":0,
            "realWidth":178,
            "wordWrap":true
         });
      }
      
      override protected function initDynamicView() : void
      {
         var broadcast:View_KejuBroadcast = null;
         super.initDynamicView();
         this.typeTF = ComponentUtil.getTextField("",this,{
            "x":80,
            "y":100,
            "color":16764206,
            "size":15,
            "leading":0,
            "realWidth":200
         });
         this.typeTF.align = "center";
         this.titleTF = ComponentUtil.getTextField("",this,{
            "x":80,
            "y":123,
            "color":0,
            "size":12,
            "leading":3,
            "realWidth":200
         });
         this.titleTF.filters = [];
         this.titleTF.wordWrap = true;
         this.leftTimeTF = ComponentUtil.getTextField("",this,{
            "x":80,
            "y":300,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.leftQuestionTF = ComponentUtil.getTextField("",this,{
            "x":200,
            "y":300,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.countTF = ComponentUtil.getTextField("",this,{
            "x":475,
            "y":395 - 46,
            "color":14662240,
            "size":12,
            "leading":6
         });
         this.numTF = ComponentUtil.getTextField("",this,{
            "x":475,
            "y":415 - 46,
            "color":14662240,
            "size":12,
            "leading":6
         });
         this.countTimeTF = ComponentUtil.getTextField("",this,{
            "x":475,
            "y":435 - 46,
            "color":14662240,
            "size":12,
            "leading":6
         });
         this.creatAnswer();
         this.creatRank();
         this.creatStar();
         broadcast = View_KejuBroadcast.instance;
         addChild(broadcast);
         broadcast.x = 265;
         broadcast.y = 290;
      }
      
      private function creatStar() : void
      {
         this.luckyStar = new KeJuStarContainer();
         this.luckyStar.init(KeJuStarContainer.TYPE_1,5);
         addChild(this.luckyStar);
         this.luckyStar.x = 83;
         this.luckyStar.y = 343;
         this.caishenStar = new KeJuStarContainer();
         this.caishenStar.init(KeJuStarContainer.TYPE_2,5);
         addChild(this.caishenStar);
         this.caishenStar.x = 292;
         this.caishenStar.y = 343;
      }
      
      private function creatAnswer() : void
      {
         var posY:Number = NaN;
         var answerItem:Answer_Item = null;
         var i:int = 0;
         this.answerArr = new Vector.<Answer_Item>();
         posY = 200;
         i = 0;
         while(i < 4)
         {
            answerItem = new Answer_Item();
            addChild(answerItem);
            answerItem.x = 80;
            answerItem.y = posY + 25 * i;
            this.answerArr.push(answerItem);
            i++;
         }
      }
      
      private function creatRank() : void
      {
         var rangY:Number = NaN;
         var rankItem:RankItem = null;
         var i:int = 0;
         this.rankArr = new Vector.<RankItem>();
         rangY = 19;
         i = 0;
         while(i < 10)
         {
            rankItem = new RankItem();
            addChild(rankItem);
            rankItem.x = 355;
            rankItem.y = 142 + rangY * i;
            this.rankArr.push(rankItem);
            i++;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.KeJu_Imgsdm)
            {
               this.load();
            }
            else if(this.isFirst)
            {
               this.sourceComplete();
            }
            KejuCGMessage.CG_ASKQUESTION();
         }
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push([Enum_KeJu.KEJUSOURCE,this.sourceComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function sourceComplete(info:Object = null) : void
      {
         var item:Answer_Item = null;
         if(Boolean(info))
         {
            Global.KeJu_Imgsdm = info.applicationDomain;
         }
         ComponentUtil.getBitmap("Back_XiangShi",this.back,{
            "x":0,
            "y":0
         },Global.KeJu_Imgsdm);
         CloseButton = ComponentUtil.getButton("","Button_XSClose",this,{
            "x":616,
            "y":74,
            "textColor":16184781
         },Global.KeJu_Imgsdm);
         CloseButton.callBack = function():void
         {
            visible = false;
         };
         this.endBitmap = ComponentUtil.getBitmap("XSEnd",this,{
            "x":120,
            "y":170
         },Global.KeJu_Imgsdm);
         for each(item in this.answerArr)
         {
            item.sourceComplete();
         }
         this.resetPosition();
         this.isFirst = false;
      }
      
      private function downEvent(e:MouseEvent) : void
      {
         UIManager.isDragPanel = true;
         UIManager.curDragPanel = this;
         startDrag();
      }
   }
}

