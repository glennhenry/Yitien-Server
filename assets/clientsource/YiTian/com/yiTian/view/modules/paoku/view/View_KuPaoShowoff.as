package com.yiTian.view.modules.paoku.view
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.KuPaoCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_KuPaoShowoff extends Panel123
   {
      
      private var _tfScore:MyTextField;
      
      private var _tfScoreRecord:MyTextField;
      
      private var _btnShowoff:Button;
      
      private var _spAward:Sprite;
      
      public function View_KuPaoShowoff()
      {
         super();
         bindParent = GameScene.sysLayer;
         regResource("lang/ch/MMKP.swf",KuPaoUtil.mainDmName);
      }
      
      public static function get instance() : View_KuPaoShowoff
      {
         return Singleton.getInstance(View_KuPaoShowoff);
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":446,
            "height":278
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":396,
            "height":228
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":411,
            "y":6,
            "callBack":this.hide
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WXPrompt",this,{
            "x":143,
            "y":5
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_KPXY",this,{
            "x":37,
            "y":52
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Text_HDFS",this,{
            "x":200,
            "y":66
         },Global.MMKPdm);
         this._tfScore = ComponentUtil.getTextField("",this,{
            "x":267,
            "y":101,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this._tfScoreRecord = ComponentUtil.getTextField("",this,{
            "x":336,
            "y":123,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("今日24点取最高积分发放奖励",this,{
            "x":200,
            "y":181,
            "color":10092288,
            "size":12,
            "leading":0
         });
         this._btnShowoff = ComponentUtil.getButton("","Button_XYYX",this,{
            "x":56,
            "y":210,
            "callBack":this.showoffClickHander
         },Global.MMKPdm);
         ComponentUtil.getButton("","Button_WZDL",this,{
            "x":263,
            "y":210,
            "callBack":this.hide
         },Global.MMKPdm);
         this._spAward = new Sprite();
         addChild(this._spAward);
         this._spAward.x = 338;
         this._spAward.y = 142;
         ComponentUtil.getBitmap("Grid_Open",this._spAward,null,Global.Img_Cdm);
         this._spAward.addChild(Utils.getLoadBitmap("resource/image/icon/46910.png",null,{
            "x":3,
            "y":3
         }));
         this._spAward.addEventListener(MouseEvent.ROLL_OVER,this.movehd);
         this._spAward.addEventListener(MouseEvent.ROLL_OUT,this.out);
         ComponentUtil.getBitmap(GameUnitManager.hero.sex == 1 ? "TouXiang" : "TouXiangN",this,{
            "x":51,
            "y":66
         },Global.MMKPdm);
      }
      
      private function movehd(e:MouseEvent) : void
      {
         var ar:Array = null;
         var str:String = null;
         var arr:Array = KuPaoUtil.getRewardArr(Model_KuPao.recordScore);
         var items:Array = Util.splicObj(arr[3] as String,",_") as Array;
         var tem:Array = [];
         for each(ar in items)
         {
            tem.push(Enum_BroadCastTool.instance.getEquipText(ar[1]) + "*" + ar[2]);
         }
         str = "<font color=\'#ffff55\'>当前积分可领取奖励为：</font>\n{0}\n<font color=\'#ff5555\'>注:奖励将在24:00发放</font>";
         TipManager.update(LangConfig.reTxt(str,tem.join("\n")));
      }
      
      private function out(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      public function update() : void
      {
         var score:int = Model_KuPao.score;
         var scoreRecord:int = Model_KuPao.recordScore;
         this._tfScore.text = score.toString();
         this._tfScoreRecord.text = scoreRecord.toString();
         this._btnShowoff.visible = score >= scoreRecord;
      }
      
      public function show(prm:* = null) : void
      {
         visible = true;
         pop();
         this.update();
         this._btnShowoff.enabled = true;
      }
      
      public function hide(prm:* = null) : void
      {
         visible = false;
      }
      
      private function showoffClickHander(e:MouseEvent) : void
      {
         KuPaoCGMessage.CG_KP_SHOWOFF(Model_KuPao.score);
         this._btnShowoff.enabled = false;
         this.hide();
      }
   }
}

