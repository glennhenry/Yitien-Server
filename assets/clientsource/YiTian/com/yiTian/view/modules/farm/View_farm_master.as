package com.yiTian.view.modules.farm
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.model.Model_farm;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_farm_master;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.handler.FarmHandler;
   import com.yiTian.net.message.cg.FarmCGMessage;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_farm_master extends Sprite
   {
      
      private var head:Bitmap;
      
      private var roleName:MyTextField;
      
      private var _cage:Bitmap;
      
      private var btnLookMaster:Button;
      
      private var btnRedeem:Button;
      
      private var btnSeedHelp:Button;
      
      private var btnResist:Button;
      
      private var _hotArea:Sprite;
      
      private var _vo:Vo_farm_master;
      
      public function View_farm_master()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.head = new Bitmap();
         this.head.x = 34 + 10;
         this.head.y = 24 + 7;
         this.addChild(this.head);
         this.roleName = ComponentUtil.getTextField("",this,{
            "x":20,
            "y":97,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.roleName.realWidth = 92;
         this.roleName.autoSize = "center";
         if(!this._cage)
         {
            this._cage = new Bitmap();
            this._cage.x = 30;
            this._cage.y = 28;
            this.addChild(this._cage);
         }
         this.drawHotArea();
         this.addBtn();
      }
      
      private function onOver(evt:MouseEvent) : void
      {
         if(Boolean(this._cage) && Boolean(this._cage.bitmapData) && Model_farm.instace.isDefeated(Model_farm.currentFarmId))
         {
            this._cage.filters = Util.glowFFFF00;
         }
      }
      
      private function onOut(evt:MouseEvent) : void
      {
         if(Boolean(this._cage) && Boolean(this._cage.bitmapData))
         {
            this._cage.filters = null;
         }
      }
      
      private function drawHotArea() : void
      {
         this._hotArea = new Sprite();
         this._hotArea.name = Model_farm.farm_master_hot_area;
         this.addChild(this._hotArea);
         this._hotArea.graphics.beginFill(65280,0);
         this._hotArea.graphics.drawRect(0,0,120,160);
         this._hotArea.graphics.endFill();
      }
      
      private function onClickHotArea(evt:MouseEvent) : void
      {
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            if(Boolean(Model_farm.instace.masterBasic_mine))
            {
               if(Boolean(Model_farm.instace.masterBasic_mine.captor))
               {
                  this.btnRedeem.visible = true;
                  this.btnResist.visible = true;
                  this.btnSeedHelp.visible = true;
                  this.btnLookMaster.visible = true;
               }
            }
         }
         else if(Boolean(Model_farm.instace.masterBasic_other.id))
         {
            if(Model_farm.instace.isDefeated(Model_farm.currentFarmId))
            {
               if(Boolean(Model_farm.instace.masterBasic_other.captor))
               {
                  if(Model_farm.isMine(Model_farm.instace.masterBasic_other.captor))
                  {
                  }
               }
               else if(Model_farm.instace.masterBasic_mine.captor != Model_farm.currentFarmId)
               {
               }
            }
         }
      }
      
      public function uqdate(vo:Vo_farm_master) : void
      {
         this._vo = vo;
         this.hideBtn();
         if(vo == null)
         {
            this.head.bitmapData = null;
            this.roleName.text = "";
            return;
         }
         var str:String = Const_strImg.getPlayerHead(vo.profession,vo.sex,1);
         this.head = Utils.getLoadBitmap(str,this.head);
         vo.name = Model_heFu.repNameByHero(vo.name);
         this.roleName.text = vo.name;
         if(vo.captor > 0)
         {
            this._cage.bitmapData = ComponentUtil.getBitmapData("LongZi",Global.ShanZhuang_Imgsdm);
         }
         else if(Boolean(this._cage))
         {
            this._cage.bitmapData = null;
         }
         this.showBtn();
      }
      
      public function onClickLook(evt:MouseEvent) : void
      {
         RoleCGMessage.CG_CHECK_OTHERROLE(Model_farm.currentFarmId);
      }
      
      public function onClickLookMaster(evt:MouseEvent) : void
      {
         RoleCGMessage.CG_CHECK_OTHERROLE(this._vo.captor);
      }
      
      private function onClickGrabLook(evt:MouseEvent) : void
      {
         RoleCGMessage.CG_CHECK_OTHERROLE(this._vo.captor);
      }
      
      public function onClickRelease(evt:MouseEvent) : void
      {
         var onRelease:Function = null;
         onRelease = function(evt:MouseEvent):void
         {
            var pos:uint = Model_farm.instace.getFarmerPos(Model_farm.currentFarmId);
            if(Boolean(pos))
            {
               FarmCGMessage.cg_farm_release(GameUnitManager.hero.id,Model_farm.currentFarmId,pos);
            }
         };
         var str:String = HtmlUtil.font(LangConfig.getWord("38",9),"#fefefe") + HtmlUtil.font(Model_farm.instace.masterBasic_other.name,ColorConstant.getColorStr(4));
         View_Alert.show(str,View_Alert.OK_CANCAL,onRelease);
      }
      
      public function onClickReward(evt:MouseEvent) : void
      {
         FarmCGMessage.cg_farm_reward(GameUnitManager.hero.id,Model_farm.currentFarmId);
      }
      
      public function onClickRedeem(evt:MouseEvent) : void
      {
         View_Alert.show(LangConfig.getWord("39",9),View_Alert.OK_CANCAL,function(evt:MouseEvent = null):void
         {
            FarmCGMessage.cg_farm_redeem(GameUnitManager.hero.id);
         });
      }
      
      public function onClickSeedHelp(evt:MouseEvent) : void
      {
         if(Model_farm.instace.masterBasic_mine.captor == 0)
         {
            return;
         }
         FarmHandler.openSeekHelpPanel(Model_farm.instace.masterBasic_mine.captor,Model_farm.instace.masterBasic_mine.captor_name);
      }
      
      public function onClickBtnCatch(evt:MouseEvent) : void
      {
      }
      
      public function onClickGrab(evt:MouseEvent) : void
      {
      }
      
      public function onClickResist(evt:MouseEvent) : void
      {
         FarmCGMessage.cg_farm_resist(GameUnitManager.hero.id,Model_farm.instace.masterBasic_mine.captor);
      }
      
      private function showBtn() : void
      {
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            if(Boolean(Model_farm.instace.masterBasic_mine))
            {
               if(Boolean(Model_farm.instace.masterBasic_mine.captor))
               {
                  this.btnRedeem.visible = true;
                  this.btnResist.visible = true;
                  this.btnSeedHelp.visible = true;
                  this.btnLookMaster.visible = true;
               }
            }
         }
      }
      
      public function hideBtn() : void
      {
         this.btnLookMaster.visible = false;
         this.btnRedeem.visible = false;
         this.btnSeedHelp.visible = false;
         this.btnResist.visible = false;
      }
      
      private function addBtn() : void
      {
         this.btnLookMaster = ComponentUtil.getButton("","Button_ChaR",this,{
            "x":108,
            "y":20,
            "textColor":16184781
         },Global.ShanZhuang_Imgsdm);
         this.addChild(this.btnLookMaster);
         this.btnLookMaster.visible = false;
         this.btnLookMaster.addEventListener(MouseEvent.CLICK,this.onClickLookMaster);
         TipManager.bind(this.btnLookMaster,LangConfig.getWord("164",9));
         this.btnRedeem = ComponentUtil.getButton("","Button_ShuR",this,{
            "x":108,
            "y":80,
            "textColor":16184781
         },Global.ShanZhuang_Imgsdm);
         this.addChild(this.btnRedeem);
         this.btnRedeem.visible = false;
         this.btnRedeem.addEventListener(MouseEvent.CLICK,this.onClickRedeem);
         TipManager.bind(this.btnRedeem,LangConfig.getWord("44",9));
         this.btnSeedHelp = ComponentUtil.getButton("","Button_ZhuR",this,{
            "x":108,
            "y":50,
            "textColor":16184781
         },Global.ShanZhuang_Imgsdm);
         this.addChild(this.btnSeedHelp);
         this.btnSeedHelp.visible = false;
         this.btnSeedHelp.addEventListener(MouseEvent.CLICK,this.onClickSeedHelp);
         TipManager.bind(this.btnSeedHelp,LangConfig.getWord("45",9));
         this.btnResist = ComponentUtil.getButton("","Button_FanR",this,{
            "x":108,
            "y":110,
            "textColor":16184781
         },Global.ShanZhuang_Imgsdm);
         this.addChild(this.btnResist);
         this.btnResist.visible = false;
         this.btnResist.addEventListener(MouseEvent.CLICK,this.onClickResist);
         TipManager.bind(this.btnResist,LangConfig.getWord("46",9));
      }
   }
}

