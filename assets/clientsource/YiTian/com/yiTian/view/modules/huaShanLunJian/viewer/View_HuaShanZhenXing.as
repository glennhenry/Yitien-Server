package com.yiTian.view.modules.huaShanLunJian.viewer
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_jingJiChang;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.net.message.cg.HuaShanCGMessage;
   import com.yiTian.net.message.cg.JingJiChangCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.UIBase123;
   import com.yiTian.view.modules.huaShanLunJian.model.Model_HuaShan;
   import com.yiTian.view.modules.huaShanLunJian.util.Child_HuaShanZhenXing;
   import com.yiTian.view.modules.huaShanLunJian.util.Child_HuaShanZhenXingRole;
   import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class View_HuaShanZhenXing extends UIBase123
   {
      
      private var zf:Child_HuaShanZhenXing;
      
      private var bg:DisplayObject;
      
      private var bm_bg:Bitmap;
      
      private var btn_close:Button;
      
      private var btn_ok:Button;
      
      public var _openType:int = 1;
      
      private var tf_huashan:MyTextField;
      
      private var arrInfo:Array;
      
      public function View_HuaShanZhenXing()
      {
         super();
         regResource("lang/ch/kuafuzhan_Imgs.swf","kuafuzhan_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":504,
            "height":334
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":456,
            "height":284
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Cross_Shezhi_bg",this,{
            "x":26,
            "y":42
         },Global.kuafuzhan_Imgsdm);
         ComponentUtil.getBitmap("Cross_zhengxing",this,{
            "x":118,
            "y":125
         },Global.kuafuzhan_Imgsdm);
         ComponentUtil.getBitmap("Cross_Shezhi_bg",this,{
            "x":26,
            "y":42
         },Global.kuafuzhan_Imgsdm);
         ComponentUtil.getBitmap("Cross_zhengxing",this,{
            "x":113,
            "y":125
         },Global.kuafuzhan_Imgsdm);
         ComponentUtil.getBitmap("Cross_shezhi",this,{
            "x":172,
            "y":5
         },Global.kuafuzhan_Imgsdm);
         this.tf_huashan = ComponentUtil.getTextField("",this,{
            "x":34,
            "y":50,
            "color":11904647
         });
         this.btn_close = ComponentUtil.getButton("","Button_Close",this,{
            "x":this.bg.width - 30,
            "y":5
         },Global.Img_Cdm);
         this.btn_close.callBack = this.closeClickHd;
         this.btn_ok = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Orange",this,{
            "x":372,
            "y":284,
            "callBack":this.okClickHd
         },Global.Img_Cdm);
         this.zf = new Child_HuaShanZhenXing();
         this.zf.x = HuaShanUtil.TEAMVOFFSET;
         this.zf.y = HuaShanUtil.TEAMHOFFSET;
         addChild(this.zf);
         bindParent = GameScene.modalLayer;
      }
      
      public function update(openType:int = 1) : void
      {
         this._openType = openType;
         if(openType == 1)
         {
            this.tf_huashan.text = LangConfig.getWord("29382",2);
         }
         else
         {
            this.tf_huashan.text = "提示：此阵型为非组队状态下战斗阵型";
         }
         this.zf.data = (Singleton.getInstance(Model_HuaShan) as Model_HuaShan).teamInfo;
         this.zf.refresh();
         this.zf.run();
      }
      
      private function closeClickHd(event:MouseEvent) : void
      {
         if(event == null && Singleton.hasInstance(View_HuaShanBaoMing))
         {
            (Singleton.getInstance(View_HuaShanBaoMing) as View_HuaShanBaoMing).visible = false;
         }
         ModalUIManager.UNPOP();
         this.zf.align();
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
         model.freeDragRole();
      }
      
      private function okClickHd(event:MouseEvent) : void
      {
         var timeInt:int = 0;
         var mdl:Model_HuaShan = null;
         var len:int = 0;
         var heropos:int = 0;
         var petpos:int = 0;
         var pnl:View_HuaShanStrengthTip = null;
         var i:int = 0;
         var role:Child_HuaShanZhenXingRole = null;
         var __x:int = 0;
         var __y:int = 0;
         var posIndex:int = 0;
         switch(this._openType)
         {
            case 1:
               this.btn_ok.enabled = false;
               timeInt = int(setTimeout(function():void
               {
                  clearTimeout(timeInt);
                  btn_ok.enabled = true;
               },4000));
               this.arrInfo = this.zf.getTeamArr();
               HuaShanCGMessage.CG_HS_TEAM(this.arrInfo);
               this.closeClickHd(null);
               mdl = Singleton.getInstance(Model_HuaShan) as Model_HuaShan;
               if(mdl.btnBaoMingClickTime != -1 && getTimer() - mdl.btnBaoMingClickTime <= 3600000)
               {
                  pnl = Singleton.getInstance(View_HuaShanStrengthTip);
                  (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
                  {
                     pnl.show();
                  });
               }
               break;
            case 2:
               this.arrInfo = this.zf.getTeamArr();
               len = int(this.arrInfo.length);
               i = 0;
               while(i < len)
               {
                  role = this.arrInfo[i];
                  __x = role.xIndex + 1;
                  __y = role.yIndex + 1;
                  posIndex = __x + __y * 10;
                  if(role.type == 1)
                  {
                     heropos = posIndex;
                  }
                  else if(role.type == 2)
                  {
                     petpos = posIndex;
                  }
                  i += 1;
               }
               Model_jingJiChang.heropos = heropos;
               Model_jingJiChang.petpos = petpos;
               JingJiChangCGMessage.CG_SET_POSITION(heropos,petpos);
               this.closeClickHd(null);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.bg.width) / 2;
         y = (Global.stage.stageHeight - this.bg.height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
   }
}

