package com.yiTian.view.modules.paoku.view
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.KuPaoCGMessage;
   import com.yiTian.utils.BitmapTF;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_KuPaoGuide extends Panel123
   {
      
      private var _bg:DisplayObject;
      
      private var _tfTime:BitmapTF;
      
      private var _hpBar:Child_KuPaoHpBar;
      
      public function View_KuPaoGuide()
      {
         super();
         regResource("lang/ch/MMKP.swf",KuPaoUtil.mainDmName);
      }
      
      public static function get instance() : View_KuPaoGuide
      {
         return Singleton.getInstance(View_KuPaoGuide);
      }
      
      override protected function initUI2() : void
      {
         this._bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":682,
            "height":386
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":632,
            "height":336
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this._bg.width,38);
         ComponentUtil.getBitmap("Back_KPGZ",this,{
            "x":37,
            "y":50
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Back_CaoZuoGZ",this,{
            "x":258,
            "y":105
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Back_DaoJuGZ",this,{
            "x":470,
            "y":105
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Back_TiLiGZ",this,{
            "x":46,
            "y":105
         },Global.MMKPdm);
         var tf:MyTextField = ComponentUtil.getTextField("20",this,{
            "x":88,
            "y":144,
            "size":14
         });
         ComponentUtil.getBitmap("Title_MinMinKuPao",this,{
            "x":261,
            "y":5
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Icon_XYGCB",this,{
            "x":213,
            "y":196
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Icon_XYGCB",this,{
            "x":425,
            "y":196
         },Global.MMKPdm);
         this._hpBar = new Child_KuPaoHpBar();
         this._hpBar.x = 47;
         this._hpBar.y = 60;
         addChild(this._hpBar);
         this._tfTime = new BitmapTF();
         this._tfTime.setGetBmdFunc(KuPaoUtil.yellowBmdFunc);
         this._tfTime.x = 230;
         this._tfTime.y = 65;
         addChild(this._tfTime);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":647,
            "y":6,
            "callBack":this.hide
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_KaiShiYouXi",this,{
            "x":278,
            "y":328,
            "callBack":this.btnClickHandler
         },Global.MMKPdm);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            addEventListener(Event.ENTER_FRAME,this.onFrame);
            Global.control.registerCallBack(Model_KuPao.HP_UPDATE,this.updateHp);
            this.update();
            this.updateHp();
         }
         else
         {
            removeEventListener(Event.ENTER_FRAME,this.onFrame);
            Global.control.removeCallBack(Model_KuPao.HP_UPDATE,this.updateHp);
         }
         super.visible = value;
      }
      
      public function show(e:* = null) : void
      {
         KuPaoCGMessage.CG_KP_REQUESTBASICINFO();
         KuPaoCGMessage.CG_KP_GETITEMBUYTIMES();
         this.visible = true;
      }
      
      public function hide(e:* = null) : void
      {
         this.visible = false;
      }
      
      private function onFrame(e:Event) : void
      {
         this.update();
      }
      
      private function update(data:* = null) : void
      {
         var remainTime:int = 0;
         var hp:int = Model_KuPao.hp;
         if(Model_KuPao.hp < 5)
         {
            this._tfTime.visible = true;
            remainTime = Model_KuPao.getRemainTime();
            if(remainTime >= 0)
            {
               this._tfTime.text = DateUtil.getMSBySecond3(remainTime / 1000);
            }
         }
         else
         {
            this._tfTime.visible = false;
         }
      }
      
      private function updateHp() : void
      {
         var hp:int = Model_KuPao.hp;
         if(hp >= 0)
         {
            this._hpBar.setHp(hp);
         }
      }
      
      private function btnClickHandler(e:MouseEvent) : void
      {
         this.visible = false;
         KuPaoUtil.askOpenMainPanel();
      }
   }
}

