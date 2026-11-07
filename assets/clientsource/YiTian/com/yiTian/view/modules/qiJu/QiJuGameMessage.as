package com.yiTian.view.modules.qiJu
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_QiJu;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.QiJuHandler;
   import com.yiTian.net.message.cg.QiJuCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.getTimer;
   
   public class QiJuGameMessage extends Panel123
   {
      
      private static var _instance:QiJuGameMessage;
      
      private var time:Number;
      
      private var vo:QiJu_KillVo;
      
      private var titleTF:MyTextField;
      
      private var timeTF:MyTextField;
      
      private var bgTF:MyTextField;
      
      private var msgTF:MyTextField;
      
      private var back:Sprite;
      
      private var wuState:Sprite;
      
      private var zhanState:Sprite;
      
      public function QiJuGameMessage()
      {
         super();
         init();
      }
      
      public static function get instance() : QiJuGameMessage
      {
         if(!_instance)
         {
            _instance = new QiJuGameMessage();
         }
         return _instance;
      }
      
      public function show(type:int) : void
      {
         var typeStr:String = Enum_QiJu.qiju_type[type].substr(0,1);
         var str:String = LangConfig.getWord("80116",8,typeStr,typeStr);
         this.bgTF.htmlText = str;
         this.titleTF.text = LangConfig.getWord("80142",8) + Enum_QiJu.qiju_type[type];
         this.visible = true;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.enterScene);
      }
      
      private function enterScene() : void
      {
         if(UIManager.mainUiBtnContainer.curFuBenType != SceneConfig.QIJU)
         {
            QiJuHandler.disposeGame();
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.enterScene);
         }
      }
      
      public function upData(vo:QiJu_KillVo) : void
      {
         this.vo = null;
         this.vo = vo;
         var targetChess:String = vo.targetChessNum + "/" + vo.targetChessCount;
         var targetBoss:String = vo.targetBossNum + "/" + vo.targetBossCount;
         var naviaChess:String = vo.naviaChessNum + "/" + vo.naviaChessCount;
         var unKnowChess:String = vo.unKnowChessNum + "/" + vo.unKnowChessCount;
         var unKnowBoss:String = vo.unKnowBossNum + "/" + vo.unKnowBossCount;
         this.timeTF.text = DateUtil.getMSBySecond3(vo.left_time);
         this.msgTF.htmlText = targetChess + "<br>" + targetBoss + "<br><br>" + naviaChess + "<br>" + unKnowChess + "<br>" + unKnowBoss;
         this.time = getTimer();
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.upTime);
         this.wuState.filters = vo.wuState == 0 ? Util.disabled : [];
         this.zhanState.filters = vo.zhanState == 1 ? Util.disabled : [];
         TipManager.bind(this.wuState,LangConfig.getWord("80143",8) + this.getValue(vo.wuState,true));
         TipManager.bind(this.zhanState,LangConfig.getWord("80214",8,this.getValue(vo.zhanState)));
      }
      
      private function getValue(num:int, symbol:Boolean = false) : String
      {
         var color:String = num >= 0 ? "#33CC00" : "#FF0000";
         var value:String = symbol ? (num >= 0 ? "+" + num : num + "") : num + "";
         return "<font color=\'" + color + "\'>" + value + "</font>";
      }
      
      private function upTime() : void
      {
         if(getTimer() - this.time >= 1000)
         {
            this.timeTF.text = DateUtil.getMSBySecond3(--this.vo.left_time);
            if(this.vo.left_time == 0)
            {
               QiJuCGMessage.CG_EXIT_QIJUGAME(2);
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80145",8));
               QiJuHandler.disposeGame();
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.upTime);
            }
            this.time = getTimer();
         }
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":0,
            "y":0,
            "width":287 - 25,
            "height":164 + 70
         },Global.Img_Cdm);
         this.back = new Sprite();
         addChild(this.back);
         bAutoRemove = false;
         this.titleTF = ComponentUtil.getTextField("",this,{
            "x":0,
            "y":4,
            "color":13287831,
            "size":12,
            "leading":0,
            "realWidth":287 - 25
         });
         this.titleTF.align = "center";
         this.bgTF = ComponentUtil.getTextField("",this,{
            "x":10,
            "y":31,
            "color":13281280,
            "size":12,
            "leading":5
         });
         this.bgTF.multiline = true;
         this.timeTF = ComponentUtil.getTextField("20:00",this,{
            "x":76,
            "y":30,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.msgTF = ComponentUtil.getTextField("5/10",this,{
            "x":95,
            "y":68,
            "color":16777215,
            "size":12,
            "leading":5
         });
         this.msgTF.multiline = true;
         this.wuState = new Sprite();
         addChild(this.wuState);
         ComponentUtil.setPropertie(this.wuState,{
            "x":68,
            "y":205
         });
         this.zhanState = new Sprite();
         addChild(this.zhanState);
         ComponentUtil.setPropertie(this.zhanState,{
            "x":98,
            "y":205
         });
         var wuBitmap:Bitmap = new Bitmap();
         this.wuState.addChild(wuBitmap);
         var zhanBitmap:Bitmap = new Bitmap();
         this.zhanState.addChild(zhanBitmap);
         Utils.getLoadBitmap("resource/image/qiJu/wu_state.png",wuBitmap);
         Utils.getLoadBitmap("resource/image/qiJu/zhan_state.png",zhanBitmap);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.ZLQiJundm)
            {
               regResource(Enum_QiJu.QIJUSOURCE,"ZLQiJundm");
               preFun();
            }
            else
            {
               this.initUI2();
            }
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.upTime);
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.enterScene);
         }
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getBitmap("BG_Di",this.back,{
            "x":1,
            "y":1,
            "width":287 - 25
         },Global.ZLQiJundm);
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - width;
         y = 230;
      }
   }
}

