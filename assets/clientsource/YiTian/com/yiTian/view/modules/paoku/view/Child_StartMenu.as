package com.yiTian.view.modules.paoku.view
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KuPaoCGMessage;
   import com.yiTian.utils.BitmapTF;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class Child_StartMenu extends Sprite
   {
      
      private var cb:CheckBox;
      
      private var _tfHp:BitmapTF;
      
      private var hpBar:Child_KuPaoHpBar;
      
      private var btn_ccc:Button;
      
      private var btn_fff:Button;
      
      private var btn_jxc:Button;
      
      private var btn_ybp:Button;
      
      private var _btns:Array = [];
      
      private var btnTipReps:Array;
      
      private var _lastClickTime:int = -2000;
      
      public function Child_StartMenu()
      {
         super();
         this.init();
      }
      
      public static function get instance() : Child_StartMenu
      {
         return Singleton.getInstance(Child_StartMenu);
      }
      
      public function init() : void
      {
         var btn:Button = null;
         ComponentUtil.getButton("","Button_JFPH",this,{
            "x":900,
            "y":65,
            "callBack":this.rankClick
         },Global.MMKPdm);
         this._tfHp = new BitmapTF();
         this._tfHp.x = 285;
         this._tfHp.y = 56;
         this._tfHp.setGetBmdFunc(KuPaoUtil.yellowBmdFunc);
         addChild(this._tfHp);
         ComponentUtil.getBitmap("Icon_KongGeJian",this,{
            "x":436,
            "y":469
         },Global.MMKPdm);
         ComponentUtil.getTextField("猛敲                  跳跃（鼠标点击他也跳）",this,{
            "x":408,
            "y":472,
            "color":16775392
         });
         var tf:MyTextField = ComponentUtil.getTextField("空格键",this,{
            "x":449,
            "y":471,
            "color":1118481
         });
         tf.filters = null;
         this.btn_ccc = ComponentUtil.getButton("","Button_CCC",this,{
            "x":274,
            "y":217,
            "callBack":this.cccClickHandler
         },Global.MMKPdm);
         this.btn_fff = ComponentUtil.getButton("","Button_FFF",this,{
            "x":409,
            "y":217,
            "callBack":this.fffClickHandler
         },Global.MMKPdm);
         this.btn_jxc = ComponentUtil.getButton("","Button_JXC",this,{
            "x":544,
            "y":217,
            "callBack":this.jxcClickHandler
         },Global.MMKPdm);
         this.btn_ybp = ComponentUtil.getButton("","Button_YBP",this,{
            "x":679,
            "y":217,
            "callBack":this.ybpClickHandler
         },Global.MMKPdm);
         this._btns.push(this.btn_ccc,this.btn_fff,this.btn_jxc,this.btn_ybp);
         for each(btn in this._btns)
         {
            btn.addEventListener(MouseEvent.MOUSE_MOVE,this.btnMoveHd);
            btn.addEventListener(MouseEvent.ROLL_OUT,this.btnOutHd);
         }
         ComponentUtil.getButton("","Button_JCYB",this,{
            "x":462,
            "y":394,
            "callBack":this.startGameClickHander
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Text_KPYX",this,{
            "x":489,
            "y":407
         },Global.MMKPdm);
         this.hpBar = new Child_KuPaoHpBar();
         this.hpBar.x = 100;
         this.hpBar.y = 50;
         addChild(this.hpBar);
         this.btnTipReps = ["比赛开始后狂冲50米！","单局比赛中积分翻倍。","死亡又如何，最后一口气我也要在冲45米！","炸弹又如何，无视一次炸弹伤害！"];
      }
      
      private function btnMoveHd(e:MouseEvent) : void
      {
         if(Model_KuPao.itemTimes == null)
         {
            return;
         }
         var index:int = this._btns.indexOf(e.target);
         var times:int = int(Model_KuPao.itemTimes[index]);
         var str:String = "<font color=\'#ffff33\'>" + this.btnTipReps[index] + LangConfig.reTxt("\n今天已购买{0}次\n此次购买将花费{1}元宝",times - 1,KuPaoUtil.getItemPrice(index + 1,times)) + "</font>";
         TipManager.update(str);
      }
      
      private function btnOutHd(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      private function rankClick(e:MouseEvent) : void
      {
         KuPaoUtil.askOpenRankPanel();
      }
      
      private function startGameClickHander(e:MouseEvent) : void
      {
         if(Model_KuPao.hp <= 0)
         {
            UIManager.centerBroadcast.addMsg("您还没有体力，请稍等片刻",1);
            return;
         }
         var now:int = getTimer();
         if(now - this._lastClickTime > 2000)
         {
            this._lastClickTime = now;
            KuPaoCGMessage.CG_KP_STARTGAME1();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            this.updateHp();
            this.updateTool();
            Global.control.registerCallBack(Model_KuPao.HP_UPDATE,this.updateHp);
            Global.control.registerCallBack(Model_KuPao.ITEMS_UDATE,this.updateTool);
            Model_KuPao.checkHp();
            addEventListener(Event.ENTER_FRAME,this.onFrame);
         }
         else
         {
            Global.control.removeCallBack(Model_KuPao.HP_UPDATE,this.updateHp);
            Global.control.removeCallBack(Model_KuPao.ITEMS_UDATE,this.updateTool);
            removeEventListener(Event.ENTER_FRAME,this.onFrame);
         }
         super.visible = value;
      }
      
      private function onFrame(e:Event) : void
      {
         var remainTime:int = 0;
         if(Model_KuPao.hp < 0)
         {
            return;
         }
         if(Model_KuPao.hp < 5)
         {
            this._tfHp.visible = true;
            remainTime = Model_KuPao.getRemainTime();
            if(remainTime >= 0)
            {
               this._tfHp.text = DateUtil.getMSBySecond3(remainTime / 1000);
            }
         }
         else
         {
            this._tfHp.visible = false;
         }
      }
      
      private function updateTool(p:* = null) : void
      {
         var data:Array = Model_KuPao.itemsInfo;
         if(data != null)
         {
            this.btn_ccc.filters = Model_KuPao.getNumTool(0) > 0 ? Util.disabled : null;
            this.btn_fff.filters = Model_KuPao.getNumTool(1) > 0 ? Util.disabled : null;
            this.btn_jxc.filters = Model_KuPao.getNumTool(2) > 0 ? Util.disabled : null;
            this.btn_ybp.filters = Model_KuPao.getNumTool(3) > 0 ? Util.disabled : null;
         }
      }
      
      public function updateHp(value:int = -1) : void
      {
         var hp:int = Model_KuPao.hp;
         this.hpBar.setHp(hp);
      }
      
      public function cccClickHandler(e:MouseEvent) : void
      {
         KuPaoUtil.tryToBuyTool(1);
      }
      
      public function fffClickHandler(e:MouseEvent) : void
      {
         KuPaoUtil.tryToBuyTool(2);
      }
      
      public function jxcClickHandler(e:MouseEvent) : void
      {
         KuPaoUtil.tryToBuyTool(3);
      }
      
      public function ybpClickHandler(e:MouseEvent) : void
      {
         KuPaoUtil.tryToBuyTool(4);
      }
   }
}

